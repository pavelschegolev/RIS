select name, surname, tariff_plan.phone_num, sum_ from report_over_limit join tariff_plan join subscriber
where report_over_limit.phone_id = tariff_plan.phone_num
and tariff_plan.sub_id = subscriber.id_subscriber
and report_over_limit.year_ = "$year_"