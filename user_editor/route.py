import os

from flask import Blueprint, render_template, request, current_app
from database.sql_provider import SQLProvider
from database.operations import select_dict, execute
from access import group_required

blueprint_user_editor = Blueprint('bp_user_editor', __name__, template_folder='templates')
provider = SQLProvider(os.path.join(os.path.dirname(__file__),'sql'))


@blueprint_user_editor.route('/', methods=['GET'])
@group_required
def show_all_numbers():
    _sql = provider.get('all_users.sql')
    users = select_dict(current_app.config['db_config'], _sql)
    _sql = provider.get('all_numbers.sql')
    numbers = select_dict(current_app.config['db_config'], _sql)
    return render_template('all_users.html', users=users, numbers=numbers)


@blueprint_user_editor.route('/', methods=['POST'])
def handler():
    action = request.form.get('action')
    user_id = request.form.get('out_emp_id')
    phone_num = request.form.get('out_phone_id')

    if action == 'edit_phone':
        _sql = provider.get('phone_by_id.sql', phone_id=phone_num)
        phone = select_dict(current_app.config['db_config'], _sql)[0]
        return render_template('edit_phone_form.html', number=phone)
    if action == 'update_phone':
        limit_ = request.form.get('phone_limit')
        period_year = request.form.get('period_year')
        period_month = request.form.get('period_month')
        _sql = provider.get('update_phone_limit.sql', limit_=limit_, phone_id=phone_num,period_month=period_month,period_year=period_year)
        execute(current_app.config['db_config'], _sql)
        return render_template('update_ok.html')
    if action == 'del_phone':
        _sql = provider.get('delete_phone_by_id.sql', phone_id=phone_num)
        execute(current_app.config['db_config'], _sql)
        return render_template('update_ok.html', user_id=user_id)
    if action == 'add_phone':
        return render_template('add_phone_form.html', user_id=user_id)
    if action == 'add_phone_for_sql':
        user_id = request.form.get('out_emp_id')
        phone = request.form.get('phone')
        phone_limit = request.form.get('phone_limit')

        if check_phone_format(phone) and phone_limit:
            _sql = provider.get('check_for_free.sql', phone=phone)
            check = select_dict(current_app.config['db_config'], _sql)[0]
            if check['c'] == 0:
                _sql = provider.get('check_for_exist_not_active.sql', phone=phone, user_id=user_id)
                check = select_dict(current_app.config['db_config'], _sql)[0]
                if check['c'] == 0:
                    period_year = request.form.get('period_year')
                    period_month = request.form.get('period_month')
                    _sql = provider.get('add_phone.sql', phone=phone, phone_limit=phone_limit,period_month=period_month,period_year=period_year,user_id=user_id)
                    execute(current_app.config['db_config'], _sql)
                    return render_template('update_ok.html')
    if action == 'add_user':
        return render_template('add_user_form.html')
    if action == 'add_user_for_sql':
        first_name = request.form.get('first_name')
        last_name = request.form.get('last_name')
        birthday = request.form.get('birthday')
        adress = request.form.get('adress')
        department = request.form.get('department')
        _sql = provider.get('add_user.sql', first_name=first_name, last_name=last_name,birthday=birthday,adress=adress,department=department)
        execute(current_app.config['db_config'], _sql)
        return render_template('update_ok.html')


    return render_template('update_error.html')



nums = '0123456789'
def check_phone_format(phone: str):
    if len(phone) < 12:
        return 0
    
    if phone[0] != '+' or phone[1] != '7':
        return 0

    for i in range(2, 12):
        if not phone[i] in nums:
            return 0

    return 1