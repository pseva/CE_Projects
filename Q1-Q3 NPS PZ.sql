select 
Store_Number,
store_name as Store_Name,
store_country_name as Country,
Detractors, 
Passives, 
Promoters, 
Total_Responses, 
100 * Promoters / Total_Responses as Promoter_Pct,
100 * Detractors / Total_Responses as Detractor_Pct,
Promoter_Pct-Detractor_Pct as NPS_Score
from 
(select retail_store_id as Store_Number,
sum(case when score_recomm < 4 then 1 end) as Detractors,
sum(case when score_recomm = 4 then 1 end) as Passives,
sum(case when score_recomm > 4 then 1 end) as Promoters,
count(*) as Total_Responses
from rtl_amr.p_productzoneNPSfusion
where score_recomm is not null
and visit_date between '2016/09/25' and '2017/07/01'
group by retail_store_id)A 
join rtl_amr.d_storeattr 
on (A.Store_Number = rtl_amr.d_storeattr.retail_store_id);