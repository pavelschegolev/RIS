import json
from flask import Flask, render_template,session
from query.route import blueprint_query
from access import login_required
from auth.routes import blueprint_auth
from report.route import blueprint_report
from user_editor.route import blueprint_user_editor

app = Flask(__name__,template_folder='template')# Создание объекта Flask
# Регистрация Blueprint'ов с указанием URL-префиксов
app.register_blueprint(blueprint_query, url_prefix='/query')
app.register_blueprint(blueprint_report, url_prefix='/report')
app.register_blueprint(blueprint_auth, url_prefix='/auth')
app.register_blueprint(blueprint_user_editor, url_prefix='/user_editor')
# Загрузка конфигураций базы данных и настроек доступа из JSON-файлов
with open('datafiles/db_config.json','r') as f:
    app.config['db_config']=json.load(f)
with open('datafiles/access_config.json','r') as f:
    app.config['access_config']=json.load(f)

app.secret_key = 'BBQ s@use'
# Маршрут для отображения главного меню после успешного входа в систему
@app.route('/')
@login_required
def menu_choice():
    if session.get('user_group', None):
        if session.get('user_group') == 'admin':
            return render_template('internal_admin_user_menu.html')
        else:
            return render_template('internal_manager_user_menu.html')
    return render_template('external_user_menu.html')

@app.route('/exit')
@login_required
def exit_func():
    session.clear()
    return render_template('exit.html')

if __name__== '__main__' :
    app.run(host='127.0.0.1' ,port=5001, debug=True)

