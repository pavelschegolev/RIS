select name, surname, debt_amount from subscriber join report_debt
where employee_id = subscriber.id_subscriber
and report_debt.year_ = "$year_" and report_debt.month_ = "$month_"