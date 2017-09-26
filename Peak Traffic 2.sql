select      * 
from        (select     store_id,
            ('FY'||trim(b.fiscal_year)||' WEEK '||trim(b.fiscal_week)) as fiscal_week_str,
            b.day_name,
            case
                when extract(hour from start_ts) = 11 then '12PM'
                when extract(hour from start_ts) = 13 then '1PM'
                when extract(hour from start_ts) = 14 then '2PM'
                when extract(hour from start_ts) = 15 then '3PM'
                when extract(hour from start_ts) = 16 then '4PM'
                when extract(hour from start_ts) = 17 then '5PM'
                when extract(hour from start_ts) = 18 then '6PM'
                when extract(hour from start_ts) = 19 then '7PM'
                when extract(hour from start_ts) = 20 then '8PM'
                when extract(hour from start_ts) = 21 then '9PM'
                when extract(hour from start_ts) = 22 then '10PM'
                when extract(hour from start_ts) = 23 then '11PM'
                when extract(hour from start_ts) = 24 then '12AM'
                else trim(trim(extract(hour from start_ts)) || 'AM')
            end as hour_formatted,
            sum(out_cnt) as sum_out_cnt
from        gca.shoppertrak_detail a
join        gca.finref_fiscal_day b
on          cast(a.start_ts as date) = b.fiscal_dt
where       store_id in ('R595', 'R596', 'R583', 'R588', 'R092', 'R163', 'R226', 'R245', 'R410', 'R276', 'R277', 'R608', 'R238', 'R254', 'R064', 'R161', 'R219', 'R650', 'R594', 'R654', 'R032', 'R095', 'R250', 'R251', 'R415', 'R582', 'R287', 'R058', 'R164', 'R321', 'R437', 'R149', 'R075')
and         b.fiscal_year = 2017
and         b.fiscal_week in (46, 47, 48, 49)
group by    1,2,3,4) z
qualify rank() over (partition by store_id, fiscal_week_str order by store_id, fiscal_week_str, sum_out_cnt desc) = 1
order by store_id, fiscal_week_str