select limit_table.phone_num, excess_amount,limit_year,limit_month, sign_of_payment from limit_table join tariff_plan on limit_table.phone_num = tariff_plan.phone_num where tariff_plan.sub_id= '$id_subscriber'