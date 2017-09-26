select 
purchase_date,
metro_name,
out_of_country,
hero_product,
store_number,
store_name,
store_metro_name,
store_country_name as store_country,
stores_in_metro,
destination_country,
metro_code,
Postal_code,
store_lat,
store_long,
sales,
units,
sso,
nomad,
pos_invoice_id
from(select retail_store_id as store_number,
count(*) as Total_Responses,
--sum(case when out_country_flag = 0 then 1 end) as total_sales,
purch_day as purchase_date,
hero_product,
nomad_flag as nomad,
postal_cd as Postal_code,
metro_code,
metro_name,
out_country_flag as out_of_country,
destination_country,
scaled_units as units,
scaled_sales as sales,
pos_invoice_id,
sso_flag as sso
from rtl_amr.P_GP3_Retail
where retail_store_id = 'R437'
and purch_day between '2016/09/24' and '2017/06/24') z
inner join rtl_amr.d_storeattr
on(z.store_number = rtl_amr.d_storeattr.retail_store_id)
;