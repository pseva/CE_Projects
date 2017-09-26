select          a.purch_day as purchase_date,
                b.store_metro_name as store_metro,
                case when in_metro = 'Y' then 'In-Metro' || ' (' || trim(b.store_metro_name) || ')' else a.metro_name end as destination,
                case when a.hero_product = 'iphone' then 'iPhone'
                     when a.hero_product = 'ipad' then 'iPad'
                     when a.hero_product = 'appletv' then 'Apple TV'
                     when a.hero_product = 'applewatch' then 'Apple Watch'
                     when a.hero_product = 'ipod' then 'iPod'
                     when a.hero_product = 'cpu' then 'Mac'
                     when a.hero_product = 'other' then 'Accessories' end as product,
                case when metro_code = store_metro_code then 'Y' else 'N' end as in_metro,
                case when out_country_flag = 0 then 'N' else 'Y' end as out_country,
                a.nomad_flag as nomad,
                sum(scaled_units) as units,
                sum(scaled_sales) as sales,
                sum(scaled_transactions) as transactions
from            rtl_amr.P_GP3_Retail a
inner join      rtl_amr.d_storeattr b 
on              a.retail_store_id = b.retail_store_id
                where a.retail_store_id = 'R437'
                and a.purch_day = '2016/09/25'
group by        1,2,3,4,5,6,7
;