select              fiscal_week,      
                    fiscal_year,
                    c.store,    
                    c.store_number,
                    sum(out_country_txn) as total_out_country_txn,
                    sum(d_txn) as total_domestic_txn,
                    sum(transactions) as total_txn
from              (select store,    
                    store_number,
                    purchase_date,
                    transactions,
                    case when out_country = 'Y' then transactions end as out_country_txn,
                    case when out_country = 'N' then transactions end as d_txn
        from                rtl_amr.T_TouSumm_StrSumm1
        where               store_number in('R075','R095','R079','R238','R409','R428','R499','R672','R092','R596','R597','R669','R713') 
        and                 purchase_date >= '2016/03/26') c
join                gca.finref_fiscal_week
on                  purchase_date=week_begin_dt
group by            1,2,3,4