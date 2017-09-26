create multiset table rtl_amr.T_TouSumm_StrSumm1 as
(select         a.purch_day as purchase_date,
                a.retail_store_id as store_number,
                store_name || ' (' || trim(store_number) || ')' as store,
                b.store_metro_name,
                case when in_metro = 'Y' then 'In-Metro' || ' (' || trim(b.store_metro_name) || ')' 
                    else a.metro_name end as destination,
                a.hero_product,
                case when metro_code = store_metro_code then 'Y' else 'N' end as in_metro,
                case when out_country_flag = 0 then 'N' else 'Y' end as out_country,
                a.nomad_flag,
                sum(scaled_units) as units,
                sum(scaled_sales) as sales,
                sum(scaled_transactions) as transactions
from            rtl_amr.P_GP3_Retail a
inner join      rtl_amr.d_storeattr b on a.retail_store_id = b.retail_store_id
where           a.purch_day >= '2013-09-29'
group by        1,2,3,4,5,6,7,8,9) with data primary index (purchase_date, store_number, store, store_metro_name, destination, hero_product, in_metro, out_country, nomad_flag, units, sales, transactions);