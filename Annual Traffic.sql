select      store_id,
            store_name,
            sum_out_cnt as annual_traffic,
            (sum_out_cnt / 365) / 12 as avg_hourly_traffic
from        (select store_id,
                    store_name,
            sum(out_cnt) as sum_out_cnt
from        gca.shoppertrak_detail a
join        gca.finref_fiscal_day b
on          cast(a.start_ts as date) = b.fiscal_dt
join        rtl_amr.D_storeAttr c
on          a.Store_Id = c.retail_store_id
and         fiscal_dt between '2016/09/10' and '2017/09/09'
group by    1,2) z
order by 1,2,3