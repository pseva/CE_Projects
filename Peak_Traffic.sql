select  store_id,
        start_date,
        hour_formatted,
        day_name,
        fiscal_week,
        max(sum_out_cnt) as max_out_cnt

from  (select store_id,
            cast(start_ts as date) as start_date,
        case
            when extract(hour from start_ts) = 12 then '12PM'
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
            day_name,
            fiscal_week,
            sum(out_cnt) as sum_out_cnt
        from        gca.shoppertrak_detail
        join        gca.finref_fiscal_day
        on          start_date = fiscal_dt
        where       store_id = 'R001'
        and         cast(start_ts as date) = '2017-09-01'
        group by    1,2,3,4,5) a

group by 1,2,3,4,5