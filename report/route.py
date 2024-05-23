from flask import *
from database.operations import select, call_proc, execute
from access import group_required, login_required
from database.sql_provider import SQLProvider
import os

blueprint_report = Blueprint('bp_report', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__), 'sql'))

report_url = os.listdir(os.path.join(os.path.dirname(__file__),'report_configs'))
report_list = []
for url in report_url:
    with open(os.path.join(os.path.dirname(__file__),'report_configs/'+url), encoding='utf-8') as f:
        report_list.append(json.load(f))
        

@blueprint_report.route('/', methods=['GET', 'POST'])
@login_required
def reports():
    if request.method == 'GET':
        return render_template('menu_report.html', report_list=report_list, len=len(report_list))
    else:
        rep_id = int(request.form.get('rep_id'))
        session['rep_id'] = rep_id
        if request.form.get('create_rep'):
            url_rep = 'bp_report.create_rep'
        else:
            url_rep = 'bp_report.view_rep'
        
        return redirect(url_for(url_rep))


@blueprint_report.route('/create_rep', methods=['GET', 'POST'])
@login_required
def create_rep():
    rep_id = session['rep_id']
    if not session['user_group'] in report_list[rep_id]['group_required']:
        return render_template('acces_error.html')
    inputs = report_list[rep_id]['inputs']
    if request.method == 'GET':
        return render_template('report_create.html', month_='month_' in inputs, year_='year_' in inputs)
    else:
        rep_year = request.form.get('input_year')
        rep_month = request.form.get('input_month')
        if (rep_year or not 'year_' in inputs) and (rep_month or not 'month_' in inputs):
            _sql = report_list[rep_id]['report_sql_exist']
            _sql = provider.get(_sql, year_=rep_year, month_=rep_month)
            exist = select(current_app.config['db_config'], _sql)
            if exist[0][0][0] != 0:
                return render_template('report_not_created.html')
            else:
                _sql = report_list[rep_id]['report_sql_call']
                _sql = provider.get(_sql, year_=rep_year, month_=rep_month)
                execute(current_app.config['db_config'], _sql)
                return render_template('report_created.html')
        else:
            return render_template('error_page.html')


@blueprint_report.route('/view_rep', methods=['GET', 'POST'])
@login_required
def view_rep():
    rep_id = session['rep_id']
    if not session['user_group'] in report_list[rep_id]['group_required']:
        return render_template('acces_error.html')
    inputs = report_list[rep_id]['inputs']
    if request.method == 'GET':
        return render_template('view_rep.html', month_='month_' in inputs, year_='year_' in inputs)
    else:
        rep_year = request.form.get('input_year')
        rep_month = request.form.get('input_month')
        if (rep_year or not 'year_' in inputs) and (rep_month or not 'month_' in inputs):
            _sql = report_list[rep_id]['report_sql_exist']
            _sql = provider.get(_sql, year_=rep_year, month_=rep_month)
            exist = select(current_app.config['db_config'], _sql)
            if exist[0][0][0] == 0:
                return render_template('report_was_not_found.html')
            else:
                _sql = report_list[rep_id]['report_sql_watch']
                _sql = provider.get(_sql, year_=rep_year, month_=rep_month)
                result, schema = select(current_app.config['db_config'], _sql)
                return render_template('result.html', schema=report_list[rep_id]['schema'], result=result, report=report_list[rep_id])
        else:
            return render_template('error_page.html')