select sub_id, count(*) as c from tariff_plan
where (period_year = YEAR(CURRENT_DATE)  and period_month < MONTH(CURRENT_DATE) or(period_year < YEAR(CURRENT_DATE)) ) and sub_id='$user_id'