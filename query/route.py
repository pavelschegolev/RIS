import os
from flask import Blueprint, render_template, request, current_app,session
from database.operations import select_dict
from database.sql_provider import SQLProvider
from access import group_required



blueprint_query = Blueprint('bp_query', __name__, template_folder='template')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

@blueprint_query.route('/internal_query_menu')
@group_required
def internal_query_menu():
    return render_template('internal_query_menu.html')

@blueprint_query.route('/external_query_menu')
def external_query_menu():
    return render_template('external_query_menu.html')

@blueprint_query.route('/about_sub', methods=['GET', 'POST'])
@group_required
def about_sub():
    if request.method == 'POST':
        phone_num = request.form.get('phone_num')
        _sql = provider.get('about_user_on_phone_num.sql', phone_num = phone_num )
        result = select_dict(current_app.config['db_config'], _sql)
        if result:
            info_title = 'Вот результат из БД'
            return render_template('about_sub.html', info_title=info_title, result=result)
        else:
            return render_template('error_page.html')
    return render_template('input_param(phone).html')

@blueprint_query.route('/duty_sub', methods=['GET', 'POST'])
@group_required
def duty_sub():
    if request.method == 'POST':
        phone_num = request.form.get('phone_num')
        _sql = provider.get('Duty.sql', phone_num = phone_num)
        result = select_dict(current_app.config['db_config'], _sql)
        if result:
            info_title = 'Вот результат из БД'
            return render_template('phone_duty.html', info_title=info_title, result=result)
        else:
            return render_template('error_page.html')
    return render_template('input_param(phone).html')

@blueprint_query.route('/tariff_plan', methods=['GET', 'POST'])
@group_required
def tariff_plan():
    if request.method == 'POST':
        phone_num = request.form.get('phone_num')
        _sql = provider.get('tariff_plan.sql', phone_num = phone_num )
        result = select_dict(current_app.config['db_config'], _sql)
        if result:
            info_title = 'Вот результат из БД'
            return render_template('tariff_plan_page.html', info_title=info_title, result=result)
        else:
            return render_template('error_page.html')
    return render_template('input_param(phone).html')

@blueprint_query.route('/about_me', methods=['GET', 'POST'])
def about_me():
    if request.method == 'GET':
        id_subscriber = session.get('user_id')
        _sql = provider.get('about_me.sql', id_subscriber = id_subscriber )
        result = select_dict(current_app.config['db_config'], _sql)
        if result:
            info_title = 'Информация о вас'
            return render_template('about_me.html', info_title=info_title, result=result)
        else:
            return render_template('error_page.html')

@blueprint_query.route('/my_duty', methods=['GET', 'POST'])
def my_duty():
    if request.method == 'GET':
        id_subscriber = session.get('user_id')
        _sql = provider.get('my_duty.sql', id_subscriber = id_subscriber )
        result = select_dict(current_app.config['db_config'], _sql)
        if result:
            info_title = 'Ваши задолженности'
            return render_template('my_duty.html', info_title=info_title, result=result)
        else:
            return render_template('error_page.html')

@blueprint_query.route('/my_tariff_plan', methods=['GET', 'POST'])
def my_tariff_plan():
    if request.method == 'GET':
        id_subscriber = session.get('user_id')
        _sql = provider.get('my_tariff_plan.sql', id_subscriber = id_subscriber )
        result = select_dict(current_app.config['db_config'], _sql)
        if result:
            info_title = 'Информация о вашем тарифном плане'
            return render_template('my_tariff_plan.html', info_title=info_title, result=result)
        else:
            return render_template('error_page.html')