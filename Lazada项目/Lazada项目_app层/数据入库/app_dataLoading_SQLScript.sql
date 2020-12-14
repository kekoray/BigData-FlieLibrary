

/*==============================================================*/
/*   Description :  app层的数据加载sql                            */
/*   FileName :  app_dataLoading_SQLScript.sql                  */
/*   Version  :  1.0                                            */
/*   Author   :  Koray                                          */
/*   Date     :  2020-11-25                                     */
/*   Company  :  menglar                                        */
/*==============================================================*/





-------------------------- 调度时间脚本 -------------------------------------------

#一级分区的日期,格式:yyyy-MM-dd
if [ $# -lt 1 ];then
    #不传参
    date=$(date -d -0day +%Y-%m-%d)
else
    #传参
    DT=$1
    date=`date -d "-0 day ${DT}" +%Y-%m-%d`
fi

echo " 一级分区的日期: [ $date ] "
echo "          "


#日期选择
for ((i= 1;i<=60;i++))
do
DT[$i]=$(date -d "${date} -$i days" "+%Y-%m-%d")
done


${DT[0]}
${DT[1]}
${DT[0]} - ${DT[6]}
${DT[7]} - ${DT[13]}
${DT[0]} - ${DT[29]}
${DT[30]} - ${DT[59]}





------------------------------------------------------------------------------------------------------------------------







/*==============================================================*/
/* Table:   app_rpt_sku_reviews_star                            */
/*==============================================================*/

insert overwrite table `lazada_dw.app_rpt_sku_reviews_star` PARTITION(dt='${DT[0]}')
select
null as id,
site_id,
sku_id,
review_count,
skuStar_avg,
one_star,
two_star,
three_star,
four_star,
five_star,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
(
select
site_id,
sku_id,
count(review_id) as `review_count`,
sum(star)/count(sku_id) as skuStar_avg,
sum(case star when '1' then 1 else 0 end) as one_star,
sum(case star when '2' then 1 else 0 end) as two_star,
sum(case star when '3' then 1 else 0 end) as three_star,
sum(case star when '4' then 1 else 0 end) as four_star,
sum(case star when '5' then 1 else 0 end) as five_star
from
dwd_review_info
where
dt = '${DT[0]}'
group by
site_id,
sku_id
) t








/*==============================================================*/
/* Table: app_rpt_sku_trend                                      */
/*==============================================================*/


insert overwrite table `lazada_dw.app_rpt_sku_trend` PARTITION(dt='${DT[0]}')
select
null as id,
site_id,
sku_id,
sku_original_price,
sku_sale_price,
review_count,
inventory_count,
inventory_add_1day,
inventory_add_7day,
inventory_add_30day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
(
select
site_id,
sku_id,
inventory_count,
inventory_add_1day,
sum(case when dt<='${DT[0]}' and dt>='${DT[6]}' then inventory_add_1day end) as inventory_add_7day,
sum(case when  dt<='${DT[0]}' and dt>='${DT[29]}' then inventory_add_1day end) as inventory_add_30day
from
dwm_sku_day
where
dt = '${DT[0]}'
group by
site_id,
sku_id,
inventory_count,
inventory_add_1day
) t;






/*==============================================================*/
/* Table: app_rpt_sku_sell_top5                                 */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_sku_sell_top5` PARTITION(dt='${DT[0]}')
select
null as id,
t1.item_id,
t1.site_id,
t1.sku_key_name,
t1.sku_value_name,
COUNT(t2.review_id) as review_count,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
lazada_dw.dwd_sku_pattern t1
left join
lazada_dw.dwd_review_info t2
on t1.site_id = t2.site_id
and t1.sku_id = t2.sku_id
and t2.dt = '${DT[0]}'
where
t1.dt = '${DT[0]}'
group by
t1.site_id,
t1.item_id,
t1.sku_key_name,
t1.sku_value_name













/*==============================================================*/
/* Table: app_rpt_item_s1                                        */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_item_s1` PARTITION(dt='${DT[0]}')
select
null as id,
item_id,
cat_1d_id,
cat_2d_id,
cat_3d_id,
cat_4d_id,
cat_5d_id,
cat_6d_id,
shop_id,
shop_name,
shop_address,
shop_type,
brand_name,
review_add_1day,
reviewAdd_addRate_1day,
review_add_7day,
reviewAdd_avg_7day,
reviewAdd_addRate_7day,
review_add_30day,
reviewAdd_addRate_30day,
review_count,
original_price_avg,
sale_price_avg,
carriage,
item_score,
itemScore_add_1day,
reviewAdd_quiteAdd_1day,
sku_add_1day,
skuAdd_quiteAdd_1day,
salePriceAvg_add_1day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_siteDim_itemInfo
where
site_id = 1
and
dt ='${DT[0]}';







/*==============================================================*/
/* Table: app_rpt_item_s2                                        */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_item_s2` PARTITION(dt='${DT[0]}')
select
null as id,
item_id,
cat_1d_id,
cat_2d_id,
cat_3d_id,
cat_4d_id,
cat_5d_id,
cat_6d_id,
shop_id,
shop_name,
shop_address,
shop_type,
brand_name,
review_add_1day,
reviewAdd_addRate_1day,
review_add_7day,
reviewAdd_avg_7day,
reviewAdd_addRate_7day,
review_add_30day,
reviewAdd_addRate_30day,
review_count,
original_price_avg,
sale_price_avg,
carriage,
item_score,
itemScore_add_1day,
reviewAdd_quiteAdd_1day,
sku_add_1day,
skuAdd_quiteAdd_1day,
salePriceAvg_add_1day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_siteDim_itemInfo
where
site_id = 2
and
dt ='${DT[0]}';






/*==============================================================*/
/* Table: app_rpt_item_s3                                        */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_item_s3` PARTITION(dt='${DT[0]}')
select
null as id,
item_id,
cat_1d_id,
cat_2d_id,
cat_3d_id,
cat_4d_id,
cat_5d_id,
cat_6d_id,
shop_id,
shop_name,
shop_address,
shop_type,
brand_name,
review_add_1day,
reviewAdd_addRate_1day,
review_add_7day,
reviewAdd_avg_7day,
reviewAdd_addRate_7day,
review_add_30day,
reviewAdd_addRate_30day,
review_count,
original_price_avg,
sale_price_avg,
carriage,
item_score,
itemScore_add_1day,
reviewAdd_quiteAdd_1day,
sku_add_1day,
skuAdd_quiteAdd_1day,
salePriceAvg_add_1day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_siteDim_itemInfo
where
site_id = 3
and
dt ='${DT[0]}';







/*==============================================================*/
/* Table: app_rpt_item_s4                                        */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_item_s4` PARTITION(dt='${DT[0]}')
select
null as id,
item_id,
cat_1d_id,
cat_2d_id,
cat_3d_id,
cat_4d_id,
cat_5d_id,
cat_6d_id,
shop_id,
shop_name,
shop_address,
shop_type,
brand_name,
review_add_1day,
reviewAdd_addRate_1day,
review_add_7day,
reviewAdd_avg_7day,
reviewAdd_addRate_7day,
review_add_30day,
reviewAdd_addRate_30day,
review_count,
original_price_avg,
sale_price_avg,
carriage,
item_score,
itemScore_add_1day,
reviewAdd_quiteAdd_1day,
sku_add_1day,
skuAdd_quiteAdd_1day,
salePriceAvg_add_1day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_siteDim_itemInfo
where
site_id = 4
and
dt ='${DT[0]}';







/*==============================================================*/
/* Table: app_rpt_item_s5                                        */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_item_s5` PARTITION(dt='${DT[0]}')
select
null as id,
item_id,
cat_1d_id,
cat_2d_id,
cat_3d_id,
cat_4d_id,
cat_5d_id,
cat_6d_id,
shop_id,
shop_name,
shop_address,
shop_type,
brand_name,
review_add_1day,
reviewAdd_addRate_1day,
review_add_7day,
reviewAdd_avg_7day,
reviewAdd_addRate_7day,
review_add_30day,
reviewAdd_addRate_30day,
review_count,
original_price_avg,
sale_price_avg,
carriage,
item_score,
itemScore_add_1day,
reviewAdd_quiteAdd_1day,
sku_add_1day,
skuAdd_quiteAdd_1day,
salePriceAvg_add_1day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_siteDim_itemInfo
where
site_id = 5
and
dt ='${DT[0]}';







/*==============================================================*/
/* Table: app_rpt_item_s6                                        */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_item_s6` PARTITION(dt='${DT[0]}')
select
null as id,
item_id,
cat_1d_id,
cat_2d_id,
cat_3d_id,
cat_4d_id,
cat_5d_id,
cat_6d_id,
shop_id,
shop_name,
shop_address,
shop_type,
brand_name,
review_add_1day,
reviewAdd_addRate_1day,
review_add_7day,
reviewAdd_avg_7day,
reviewAdd_addRate_7day,
review_add_30day,
reviewAdd_addRate_30day,
review_count,
original_price_avg,
sale_price_avg,
carriage,
item_score,
itemScore_add_1day,
reviewAdd_quiteAdd_1day,
sku_add_1day,
skuAdd_quiteAdd_1day,
salePriceAvg_add_1day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_siteDim_itemInfo
where
site_id = 6
and
dt ='${DT[0]}';








/*==============================================================*/
/* Table: app_rpt_site_item_reviews_pct                      */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_site_item_reviews_pct` PARTITION(dt='${DT[0]}')
select
null as id,
site_id,
review_count,
review_acco,
review_add_1day,
reviewAdd_acco_1day,
review_add_7day,
reviewAdd_acco_7day,
review_add_30day,
reviewAdd_acco_30day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_AllSiteDim_itemAndReviewNum
where
dt ='${DT[0]}';







/*==============================================================*/
/* Table: app_rpt_site_item_percent                              */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_site_item_percent` PARTITION(dt='${DT[0]}')
select
null as id,
site_id,
item_count,
item_acco,
item_add_1day,
itemAdd_acco_1day,
item_add_7day,
itemAdd_acco_7day,
item_add_30day,
itemAdd_acco_30day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_AllSiteDim_itemAndReviewNum
where
dt ='${DT[0]}';








/*==============================================================*/
/* Table: app_rpt_site_item_and_reviews                       */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_site_item_and_reviews` PARTITION(dt='${DT[0]}')
select
null as id,
site_id,
item_count,
item_add_1day,
review_count,
review_add_1day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_AllSiteDim_itemAndReviewNum
where
dt ='${DT[0]}'
union all
select
null as id,
0 as site_id,
sum(item_count),
sum(item_add_1day),
sum(review_count),
sum(review_add_1day),
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dws_itemTopic_AllSiteDim_itemAndReviewNum
where
dt ='${DT[0]}';









/*==============================================================*/
/* Table: app_rpt_site_item_total                                */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_site_item_total` PARTITION(dt='${DT[0]}')

select
null as id,
site_id,
1 as shop_type,
sum(case when shop_type = 1 then item_count end) as item_count,
sum(case when shop_type = 1 then item_count end) / sum(item_count) as item_acco,
sum(case when shop_type = 1 then itemAdd_addRate_1day end) as itemAdd_addRate_1day,
sum(case when shop_type = 1 then itemReviewType_count end) as itemReviewType_count,
sum(case when shop_type = 1 then itemReviewType_count end) / sum(itemReviewType_count) as itemReviewType_acco,
sum(case when shop_type = 1 then itemAddReviewType_addRate_1day end) as itemAddReviewType_addRate_1day,
sum(case when shop_type = 1 then item_add_7day end) as item_add_7day,
sum(case when shop_type = 1 then item_add_7day end) / sum(item_add_7day) as itemAdd_acco_7day,
sum(case when shop_type = 1 then itemAdd_addRate_7day end) as itemAdd_addRate_7day,
sum(case when shop_type = 1 then item_add_30day end) as item_add_30day,
sum(case when shop_type = 1 then item_add_30day end) / sum(item_add_30day) as itemAdd_acco_30day,
sum(case when shop_type = 1 then itemAdd_addRate_30day end) as itemAdd_addRate_30day,
sum(case when shop_type = 1 then itemReviewType_add_7day end) as itemReviewType_add_7day,
sum(case when shop_type = 1 then itemAddReviewType_acco_7day end) / sum(itemAddReviewType_acco_7day) as itemAddReviewType_acco_7day,
sum(case when shop_type = 1 then itemAddReviewType_addRate_7day end) as itemAddReviewType_addRate_7day,
sum(case when shop_type = 1 then itemReviewType_add_30day end) as itemReviewType_add_30day,
sum(case when shop_type = 1 then itemReviewType_add_30day end) sum(itemReviewType_add_30day) as itemAddReviewType_acco_30day,
sum(case when shop_type = 1 then itemAddReviewType_addRate_30day end) as itemAddReviewType_addRate_30day,
sum(case when shop_type = 1 then review_add_7day end) as review_add_7day,
sum(case when shop_type = 1 then review_add_7day end) / sum(review_add_7day) as reviewAdd_acco_7day,
sum(case when shop_type = 1 then reviewAdd_addRate_7day end) as reviewAdd_addRate_7day,
sum(case when shop_type = 1 then review_add_30day end) as review_add_30day,
sum(case when shop_type = 1 then review_add_30day end) / sum(review_add_30day) as reviewAdd_acco_30day,
sum(case when shop_type = 1 then reviewAdd_addRate_30day end) as reviewAdd_addRate_30day,
sum(case when shop_type = 1 then reviewAdd_avg_7day end) as reviewAdd_avg_7day,
sum(case when shop_type = 1 then reviewAdd_avg_7day end) / sum(reviewAdd_avg_7day) as reviewAdd_avg_acco_7day,
sum(case when shop_type = 1 then reviewAdd_avg_addRate_7day end) as reviewAdd_avg_addRate_7day,
sum(case when shop_type = 1 then item_avgReviewRate_7day end) as item_avgReviewRate_7day,
sum(case when shop_type = 1 then item_avgReviewRate_7day end) / sum(item_avgReviewRate_7day) as item_avgReviewRate_acco_7day,
sum(case when shop_type = 1 then item_avgReviewRate_addRate_7day end) as item_avgReviewRate_addRate_7day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dwm_shop_30day
where
dt ='${DT[0]}'
group by
site_id
union all
select
null as id,
site_id,
2 as shop_type,
sum(case when shop_type = 2 then item_count end) as item_count,
sum(case when shop_type = 2 then item_count end) / sum(item_count) as item_acco,
sum(case when shop_type = 2 then itemAdd_addRate_1day end) as itemAdd_addRate_1day,
sum(case when shop_type = 2 then itemReviewType_count end) as itemReviewType_count,
sum(case when shop_type = 2 then itemReviewType_count end) / sum(itemReviewType_count) as itemReviewType_acco,
sum(case when shop_type = 2 then itemAddReviewType_addRate_1day end) as itemAddReviewType_addRate_1day,
sum(case when shop_type = 2 then item_add_7day end) as item_add_7day,
sum(case when shop_type = 2 then item_add_7day end) / sum(item_add_7day) as itemAdd_acco_7day,
sum(case when shop_type = 2 then itemAdd_addRate_7day end) as itemAdd_addRate_7day,
sum(case when shop_type = 2 then item_add_30day end) as item_add_30day,
sum(case when shop_type = 2 then item_add_30day end) / sum(item_add_30day) as itemAdd_acco_30day,
sum(case when shop_type = 2 then itemAdd_addRate_30day end) as itemAdd_addRate_30day,
sum(case when shop_type = 2 then itemReviewType_add_7day end) as itemReviewType_add_7day,
sum(case when shop_type = 2 then itemAddReviewType_acco_7day end) / sum(itemAddReviewType_acco_7day) as itemAddReviewType_acco_7day,
sum(case when shop_type = 2 then itemAddReviewType_addRate_7day end) as itemAddReviewType_addRate_7day,
sum(case when shop_type = 2 then itemReviewType_add_30day end) as itemReviewType_add_30day,
sum(case when shop_type = 2 then itemReviewType_add_30day end) sum(itemReviewType_add_30day) as itemAddReviewType_acco_30day,
sum(case when shop_type = 2 then itemAddReviewType_addRate_30day end) as itemAddReviewType_addRate_30day,
sum(case when shop_type = 2 then review_add_7day end) as review_add_7day,
sum(case when shop_type = 2 then review_add_7day end) / sum(review_add_7day) as reviewAdd_acco_7day,
sum(case when shop_type = 2 then reviewAdd_addRate_7day end) as reviewAdd_addRate_7day,
sum(case when shop_type = 2 then review_add_30day end) as review_add_30day,
sum(case when shop_type = 2 then review_add_30day end) / sum(review_add_30day) as reviewAdd_acco_30day,
sum(case when shop_type = 2 then reviewAdd_addRate_30day end) as reviewAdd_addRate_30day,
sum(case when shop_type = 2 then reviewAdd_avg_7day end) as reviewAdd_avg_7day,
sum(case when shop_type = 2 then reviewAdd_avg_7day end) / sum(reviewAdd_avg_7day) as reviewAdd_avg_acco_7day,
sum(case when shop_type = 2 then reviewAdd_avg_addRate_7day end) as reviewAdd_avg_addRate_7day,
sum(case when shop_type = 2 then item_avgReviewRate_7day end) as item_avgReviewRate_7day,
sum(case when shop_type = 2 then item_avgReviewRate_7day end) / sum(item_avgReviewRate_7day) as item_avgReviewRate_acco_7day,
sum(case when shop_type = 2 then item_avgReviewRate_addRate_7day end) as item_avgReviewRate_addRate_7day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dwm_shop_30day
where
dt ='${DT[0]}'
group by
site_id
union all
select
null as id,
site_id,
3 as shop_type,
sum(case when shop_type = 3 then item_count end) as item_count,
sum(case when shop_type = 3 then item_count end) / sum(item_count) as item_acco,
sum(case when shop_type = 3 then itemAdd_addRate_1day end) as itemAdd_addRate_1day,
sum(case when shop_type = 3 then itemReviewType_count end) as itemReviewType_count,
sum(case when shop_type = 3 then itemReviewType_count end) / sum(itemReviewType_count) as itemReviewType_acco,
sum(case when shop_type = 3 then itemAddReviewType_addRate_1day end) as itemAddReviewType_addRate_1day,
sum(case when shop_type = 3 then item_add_7day end) as item_add_7day,
sum(case when shop_type = 3 then item_add_7day end) / sum(item_add_7day) as itemAdd_acco_7day,
sum(case when shop_type = 3 then itemAdd_addRate_7day end) as itemAdd_addRate_7day,
sum(case when shop_type = 3 then item_add_30day end) as item_add_30day,
sum(case when shop_type = 3 then item_add_30day end) / sum(item_add_30day) as itemAdd_acco_30day,
sum(case when shop_type = 3 then itemAdd_addRate_30day end) as itemAdd_addRate_30day,
sum(case when shop_type = 3 then itemReviewType_add_7day end) as itemReviewType_add_7day,
sum(case when shop_type = 3 then itemAddReviewType_acco_7day end) / sum(itemAddReviewType_acco_7day) as itemAddReviewType_acco_7day,
sum(case when shop_type = 3 then itemAddReviewType_addRate_7day end) as itemAddReviewType_addRate_7day,
sum(case when shop_type = 3 then itemReviewType_add_30day end) as itemReviewType_add_30day,
sum(case when shop_type = 3 then itemReviewType_add_30day end) sum(itemReviewType_add_30day) as itemAddReviewType_acco_30day,
sum(case when shop_type = 3 then itemAddReviewType_addRate_30day end) as itemAddReviewType_addRate_30day,
sum(case when shop_type = 3 then review_add_7day end) as review_add_7day,
sum(case when shop_type = 3 then review_add_7day end) / sum(review_add_7day) as reviewAdd_acco_7day,
sum(case when shop_type = 3 then reviewAdd_addRate_7day end) as reviewAdd_addRate_7day,
sum(case when shop_type = 3 then review_add_30day end) as review_add_30day,
sum(case when shop_type = 3 then review_add_30day end) / sum(review_add_30day) as reviewAdd_acco_30day,
sum(case when shop_type = 3 then reviewAdd_addRate_30day end) as reviewAdd_addRate_30day,
sum(case when shop_type = 3 then reviewAdd_avg_7day end) as reviewAdd_avg_7day,
sum(case when shop_type = 3 then reviewAdd_avg_7day end) / sum(reviewAdd_avg_7day) as reviewAdd_avg_acco_7day,
sum(case when shop_type = 3 then reviewAdd_avg_addRate_7day end) as reviewAdd_avg_addRate_7day,
sum(case when shop_type = 3 then item_avgReviewRate_7day end) as item_avgReviewRate_7day,
sum(case when shop_type = 3 then item_avgReviewRate_7day end) / sum(item_avgReviewRate_7day) as item_avgReviewRate_acco_7day,
sum(case when shop_type = 3 then item_avgReviewRate_addRate_7day end) as item_avgReviewRate_addRate_7day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dwm_shop_30day
where
dt ='${DT[0]}'
group by
site_id
union all
-- 全站维度
select
null as id,
0 as site_id,
0 as shop_type,
sum(item_count) as item_count,
1 as item_acco,
sum(itemAdd_addRate_1day) as itemAdd_addRate_1day,
sum(itemReviewType_count) as itemReviewType_count,
1 as itemReviewType_acco,
sum(itemAddReviewType_addRate_1day) as itemAddReviewType_addRate_1day,
sum(item_add_7day) as item_add_7day,
1 as itemAdd_acco_7day,
sum(itemAdd_addRate_7day) as itemAdd_addRate_7day,
sum(item_add_30day) as item_add_30day,
1 as itemAdd_acco_30day,
sum(itemAdd_addRate_30day) as itemAdd_addRate_30day,
sum(itemReviewType_add_7day) as itemReviewType_add_7day,
1 as itemAddReviewType_acco_7day,
sum(itemAddReviewType_addRate_7day) as itemAddReviewType_addRate_7day,
sum(itemReviewType_add_30day) as itemReviewType_add_30day,
1 as itemAddReviewType_acco_30day,
sum(itemAddReviewType_addRate_30day) as itemAddReviewType_addRate_30day,
sum(review_add_7day) as review_add_7day,
1 as reviewAdd_acco_7day,
sum(reviewAdd_addRate_7day) as reviewAdd_addRate_7day,
sum(review_add_30day) as review_add_30day,
1 as reviewAdd_acco_30day,
sum(reviewAdd_addRate_30day) as reviewAdd_addRate_30day,
sum(reviewAdd_avg_7day) as reviewAdd_avg_7day,
1 as reviewAdd_avg_acco_7day,
sum(reviewAdd_avg_addRate_7day) as reviewAdd_avg_addRate_7day,
sum(item_avgReviewRate_7day) as item_avgReviewRate_7day,
1 as item_avgReviewRate_acco_7day,
sum(item_avgReviewRate_addRate_7day) as item_avgReviewRate_addRate_7day,
${DT[1]} as timest,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss") as create_time
from
dwm_shop_30day
where
dt ='${DT[0]}'







































/*==============================================================*/
/* Table: app_rpt_monitor_item                                  */
/**
 * @author: koray
 * @create: 2020/12/07 15:48
 * TODO : 不用
 *
 */
/*==============================================================*/
insert overwrite table `lazada_dw.app_rpt_monitor_item` PARTITION(dt='${DT[0]}')
select
null as id,
t2.site_id,
t1.user_id,
t2.item_id,
t2.cat_1d_id,
t2.cat_2d_id,
t2.cat_3d_id,
t2.cat_4d_id,
t2.cat_5d_id,
t2.cat_6d_id,
t2.shop_id,
t2.shop_name,
t2.shop_address,
t2.shop_type,
t2.brand_name,
t2.review_add_1day,
t2.reviewAdd_addRate_1day,
t2.review_add_7day,
t2.reviewAdd_avg_7day,
t2.reviewAdd_addRate_7day,
t2.review_add_30day,
t2.reviewAdd_addRate_30day,
t2.review_count,
t2.original_price_avg,
t2.sale_price_avg,
t2.carriage,
t2.item_score,
t2.itemScore_add_1day,
t2.reviewAdd_quiteAdd_1day,
t2.sku_add_1day,
t2.skuAdd_quiteAdd_1day,
t2.salePriceAvg_add_1day,
t2.create_time,
${DT[1]} as timest
from
dwd_monitor_item t1
join
dws_itemTopic_siteDim_itemInfo t2
on (t1.site_id = t2.site_id
and  t1.item_id = t2.item_id
and t2.dt ='${DT[0]}')
where t1.dt ='${DT[0]}'




















