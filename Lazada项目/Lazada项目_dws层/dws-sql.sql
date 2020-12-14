




/*==============================================================*/
/* Table: dws_itemTopic_itemDim_itemInfo                        */
/*==============================================================*/
insert overwrite table `dws_itemTopic_itemDim_itemInfo` PARTITION(dt='${DT[0]}')
select
t1.site_id,
t1.item_id,
t1.cat_1d_id,
t1.cat_2d_id,
t1.cat_3d_id,
t1.cat_4d_id,
t1.cat_5d_id,
t1.cat_6d_id,
t1.shop_id,
t1.shop_name,
t1.shop_address,
t1.shop_type,
t2.brand_name,
t1.review_add_1day,
t1.reviewAdd_addRate_1day,
t1.review_add_7day,
t1.reviewAdd_avg_7day,
t1.reviewAdd_addRate_7day,
t1.review_add_30day,
t1.reviewAdd_addRate_30day,
t1.review_count,
t1.original_price_avg,
t1.sale_price_avg,
t1.carriage,
t1.item_score,
t1.itemScore_add_1day,
t1.reviewAdd_quiteAdd_1day,
t1.sku_add_1day,
t1.skuAdd_quiteAdd_1day,
t1.salePriceAvg_add_1day,
t1.create_time
from
dwd_brand_info t2
right join
dwm_itemWithCat_30day t1
on (t1.site_id = t2.site_id
and t1.brand_id = t2.brand_id
and t1.dt ='${DT[0]}')
where
t2.dt = '${DT[0]}'













-- from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss")   as create_time
/**
 * @author: koray
 * @create: 2020/12/07 15:07
 * TODO : 若 group by create_time 会造成数据错乱, 有待考证
 *
 */
/*==============================================================*/
/* Table: dws_itemTopic_siteDim_itemInfo                        */
/*==============================================================*/

insert overwrite table `dws_itemTopic_AllSiteDim_itemAndReviewNum` PARTITION(dt='${DT[0]}')
select
1 as site_id,
sum(case when site_id = 1 then review_count end) as review_count,
sum(case when site_id = 1 then review_add_1day end) as review_add_1day,
sum(case when site_id = 1 then review_add_7day end) as review_add_7day,
sum(case when site_id = 1 then review_add_30day end) as review_add_30day,
sum(case when site_id = 1 then review_count end) / sum(review_count)  as review_acco,
sum(case when site_id = 1 then reviewAdd_acco_1day end) / sum(reviewAdd_acco_1day)  as reviewAdd_acco_1day,
sum(case when site_id = 1 then reviewAdd_acco_7day end) / sum(reviewAdd_acco_7day)  as reviewAdd_acco_7day,
sum(case when site_id = 1 then reviewAdd_acco_30day end) / sum(reviewAdd_acco_30day)  as reviewAdd_acco_30day,
sum(case when site_id = 1 then item_count end) as item_count,
sum(case when site_id = 1 then item_add_1day end) as item_add_1day,
sum(case when site_id = 1 then item_add_7day end) as item_add_7day,
sum(case when site_id = 1 then item_add_30day end) as item_add_30day,
sum(case when site_id = 1 then item_acco end) / sum(item_acco)  as item_acco,
sum(case when site_id = 1 then itemAdd_acco_1day end) / sum(itemAdd_acco_1day)  as itemAdd_acco_1day,
sum(case when site_id = 1 then itemAdd_acco_7day end) / sum(itemAdd_acco_7day)  as itemAdd_acco_7day,
sum(case when site_id = 1 then itemAdd_acco_30day end) / sum(itemAdd_acco_30day)  as itemAdd_acco_30day,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss")  as create_time
from
dwm_shop_30day
where
dt = '${DT[0]}'
union
select
2 as site_id,
sum(case when site_id = 2 then review_count end) as review_count,
sum(case when site_id = 2 then review_add_1day end) as review_add_1day,
sum(case when site_id = 2 then review_add_7day end) as review_add_7day,
sum(case when site_id = 2 then review_add_30day end) as review_add_30day,
sum(case when site_id = 2 then review_count end) / sum(review_count)  as review_acco,
sum(case when site_id = 2 then reviewAdd_acco_1day end) / sum(reviewAdd_acco_1day)  as reviewAdd_acco_1day,
sum(case when site_id = 2 then reviewAdd_acco_7day end) / sum(reviewAdd_acco_7day)  as reviewAdd_acco_7day,
sum(case when site_id = 2 then reviewAdd_acco_30day end) / sum(reviewAdd_acco_30day)  as reviewAdd_acco_30day,
sum(case when site_id = 2 then item_count end) as item_count,
sum(case when site_id = 2 then item_add_1day end) as item_add_1day,
sum(case when site_id = 2 then item_add_7day end) as item_add_7day,
sum(case when site_id = 2 then item_add_30day end) as item_add_30day,
sum(case when site_id = 2 then item_acco end) / sum(item_acco)  as item_acco,
sum(case when site_id = 2 then itemAdd_acco_1day end) / sum(itemAdd_acco_1day)  as itemAdd_acco_1day,
sum(case when site_id = 2 then itemAdd_acco_7day end) / sum(itemAdd_acco_7day)  as itemAdd_acco_7day,
sum(case when site_id = 2 then itemAdd_acco_30day end) / sum(itemAdd_acco_30day)  as itemAdd_acco_30day,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss")  as create_time
from
dwm_shop_30day
where
dt = '${DT[0]}'
union
select
3 as site_id,
sum(case when site_id = 3 then review_count end) as review_count,
sum(case when site_id = 3 then review_add_1day end) as review_add_1day,
sum(case when site_id = 3 then review_add_7day end) as review_add_7day,
sum(case when site_id = 3 then review_add_30day end) as review_add_30day,
sum(case when site_id = 3 then review_count end) / sum(review_count)  as review_acco,
sum(case when site_id = 3 then reviewAdd_acco_1day end) / sum(reviewAdd_acco_1day)  as reviewAdd_acco_1day,
sum(case when site_id = 3 then reviewAdd_acco_7day end) / sum(reviewAdd_acco_7day)  as reviewAdd_acco_7day,
sum(case when site_id = 3 then reviewAdd_acco_30day end) / sum(reviewAdd_acco_30day)  as reviewAdd_acco_30day,
sum(case when site_id = 3 then item_count end) as item_count,
sum(case when site_id = 3 then item_add_1day end) as item_add_1day,
sum(case when site_id = 3 then item_add_7day end) as item_add_7day,
sum(case when site_id = 3 then item_add_30day end) as item_add_30day,
sum(case when site_id = 3 then item_acco end) / sum(item_acco)  as item_acco,
sum(case when site_id = 3 then itemAdd_acco_1day end) / sum(itemAdd_acco_1day)  as itemAdd_acco_1day,
sum(case when site_id = 3 then itemAdd_acco_7day end) / sum(itemAdd_acco_7day)  as itemAdd_acco_7day,
sum(case when site_id = 3 then itemAdd_acco_30day end) / sum(itemAdd_acco_30day)  as itemAdd_acco_30day,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss")  as create_time
from
dwm_shop_30day
where
dt = '${DT[0]}'
union
select
4 as site_id,
sum(case when site_id = 4 then review_count end) as review_count,
sum(case when site_id = 4 then review_add_1day end) as review_add_1day,
sum(case when site_id = 4 then review_add_7day end) as review_add_7day,
sum(case when site_id = 4 then review_add_30day end) as review_add_30day,
sum(case when site_id = 4 then review_count end) / sum(review_count)  as review_acco,
sum(case when site_id = 4 then reviewAdd_acco_1day end) / sum(reviewAdd_acco_1day)  as reviewAdd_acco_1day,
sum(case when site_id = 4 then reviewAdd_acco_7day end) / sum(reviewAdd_acco_7day)  as reviewAdd_acco_7day,
sum(case when site_id = 4 then reviewAdd_acco_30day end) / sum(reviewAdd_acco_30day)  as reviewAdd_acco_30day,
sum(case when site_id = 4 then item_count end) as item_count,
sum(case when site_id = 4 then item_add_1day end) as item_add_1day,
sum(case when site_id = 4 then item_add_7day end) as item_add_7day,
sum(case when site_id = 4 then item_add_30day end) as item_add_30day,
sum(case when site_id = 4 then item_acco end) / sum(item_acco)  as item_acco,
sum(case when site_id = 4 then itemAdd_acco_1day end) / sum(itemAdd_acco_1day)  as itemAdd_acco_1day,
sum(case when site_id = 4 then itemAdd_acco_7day end) / sum(itemAdd_acco_7day)  as itemAdd_acco_7day,
sum(case when site_id = 4 then itemAdd_acco_30day end) / sum(itemAdd_acco_30day)  as itemAdd_acco_30day,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss")  as create_time
from
dwm_shop_30day
where
dt = '${DT[0]}'
union
select
5 as site_id,
sum(case when site_id = 5 then review_count end) as review_count,
sum(case when site_id = 5 then review_add_1day end) as review_add_1day,
sum(case when site_id = 5 then review_add_7day end) as review_add_7day,
sum(case when site_id = 5 then review_add_30day end) as review_add_30day,
sum(case when site_id = 5 then review_count end) / sum(review_count)  as review_acco,
sum(case when site_id = 5 then reviewAdd_acco_1day end) / sum(reviewAdd_acco_1day)  as reviewAdd_acco_1day,
sum(case when site_id = 5 then reviewAdd_acco_7day end) / sum(reviewAdd_acco_7day)  as reviewAdd_acco_7day,
sum(case when site_id = 5 then reviewAdd_acco_30day end) / sum(reviewAdd_acco_30day)  as reviewAdd_acco_30day,
sum(case when site_id = 5 then item_count end) as item_count,
sum(case when site_id = 5 then item_add_1day end) as item_add_1day,
sum(case when site_id = 5 then item_add_7day end) as item_add_7day,
sum(case when site_id = 5 then item_add_30day end) as item_add_30day,
sum(case when site_id = 5 then item_acco end) / sum(item_acco)  as item_acco,
sum(case when site_id = 5 then itemAdd_acco_1day end) / sum(itemAdd_acco_1day)  as itemAdd_acco_1day,
sum(case when site_id = 5 then itemAdd_acco_7day end) / sum(itemAdd_acco_7day)  as itemAdd_acco_7day,
sum(case when site_id = 5 then itemAdd_acco_30day end) / sum(itemAdd_acco_30day)  as itemAdd_acco_30day,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss")  as create_time
from
dwm_shop_30day
where
dt = '${DT[0]}'
union
select
6 as site_id,
sum(case when site_id = 6 then review_count end) as review_count,
sum(case when site_id = 6 then review_add_1day end) as review_add_1day,
sum(case when site_id = 6 then review_add_7day end) as review_add_7day,
sum(case when site_id = 6 then review_add_30day end) as review_add_30day,
sum(case when site_id = 6 then review_count end) / sum(review_count)  as review_acco,
sum(case when site_id = 6 then reviewAdd_acco_1day end) / sum(reviewAdd_acco_1day)  as reviewAdd_acco_1day,
sum(case when site_id = 6 then reviewAdd_acco_7day end) / sum(reviewAdd_acco_7day)  as reviewAdd_acco_7day,
sum(case when site_id = 6 then reviewAdd_acco_30day end) / sum(reviewAdd_acco_30day)  as reviewAdd_acco_30day,
sum(case when site_id = 6 then item_count end) as item_count,
sum(case when site_id = 6 then item_add_1day end) as item_add_1day,
sum(case when site_id = 6 then item_add_7day end) as item_add_7day,
sum(case when site_id = 6 then item_add_30day end) as item_add_30day,
sum(case when site_id = 6 then item_acco end) / sum(item_acco)  as item_acco,
sum(case when site_id = 6 then itemAdd_acco_1day end) / sum(itemAdd_acco_1day)  as itemAdd_acco_1day,
sum(case when site_id = 6 then itemAdd_acco_7day end) / sum(itemAdd_acco_7day)  as itemAdd_acco_7day,
sum(case when site_id = 6 then itemAdd_acco_30day end) / sum(itemAdd_acco_30day)  as itemAdd_acco_30day,
from_unixtime(unix_timestamp(),"yyyy-MM-dd HH:mm:ss")  as create_time
from
dwm_shop_30day
where
dt = '${DT[0]}'













