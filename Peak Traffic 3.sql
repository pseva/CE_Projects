select      * 
from        (select     store_id, store_name,
            ('FY'||trim(b.fiscal_year)||' WEEK '||trim(b.fiscal_week)) as fiscal_week_str,
            b.day_name as peak_day,
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
            end as peak_hour,
            sum(out_cnt) as sum_out_cnt
from        gca.shoppertrak_detail a
join        gca.finref_fiscal_day b
on          cast(a.start_ts as date) = b.fiscal_dt
join        rtl_amr.D_storeAttr c
on          a.Store_Id = c.retail_store_id
and         b.fiscal_year = 2017
and         b.fiscal_week in (46,47,48,49)
group by    1,2,3,4,5) z
qualify rank() over (partition by store_id, store_name, fiscal_week_str order by store_id, fiscal_week_str, sum_out_cnt desc) = 1
order by store_id, fiscal_week_str