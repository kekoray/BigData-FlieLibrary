


-----------------------------   店铺计算-天维度
insert overwrite table dwm_shop_day PARTITION(dt='${DT[0]}')
select
t1.shop_id,
t1.site_id,
t1.shop_name,
t1.cat_1d_name,
t1.sales_cat,
t1.follower_num,
case when nvl(t1.follower_num,0)>0 and nvl(t2.follower_num,0)>0 then t1.follower_num-t2.follower_num else 0 end  as followerNum_add_1day,
t1.shop_type,
t1.shop_rating,
t1.item_count,
case when nvl(t1.item_count,0)>0 and nvl(t2.item_count,0)>0 then t1.item_count-t2.item_count else 0 end  as item_add_1day,
t1.review_count,
case when nvl(t1.review_count,0)>0 and nvl(t2.review_count,0)>0 then t1.review_count-t2.review_count else 0 end  as review_add_1day,
t1.negate_num,
case when nvl(t1.negate_num,0)>0 and nvl(t2.negate_num,0)>0 then t1.negate_num-t2.negate_num else 0 end  as negateNum_add_1day,
t1.average_num,
case when nvl(t1.average_num,0)>0 and nvl(t2.average_num,0)>0 then t1.average_num-t2.average_num else 0 end  as averageNum_add_1day,
t1.praise_num,
case when nvl(t1.praise_num,0)>0 and nvl(t2.praise_num,0)>0 then t1.praise_num-t2.praise_num else 0 end  as praiseNum_add_1day,
t1.praise_rate,
t1.cancel_rate,
case when nvl(t1.cancel_rate,0)>0 and nvl(t2.cancel_rate,0)>0 then t1.cancel_rate-t2.cancel_rate else 0 end  as cancelRate_add_1day,
t1.onTimeDelivery_rate,
case when nvl(t1.onTimeDelivery_rate,0)>0 and nvl(t2.onTimeDelivery_rate,0)>0 then t1.onTimeDelivery_rate-t2.onTimeDelivery_rate else 0 end  as onTimeDeliveryRate_add_1day,
t1.chatResp_rate,
t1.onTimeDelivery_AddRate,
case when nvl(t1.onTimeDelivery_AddRate,0)>0 and nvl(t2.onTimeDelivery_AddRate,0)>0 then t1.onTimeDelivery_AddRate-t2.onTimeDelivery_AddRate else 0 end  as onTimeDeliveryAddRate_add_1day,
t1.rate_level,
t1.create_time
from
dwd_shop_info as t1
left join
dwd_snap_shop_info as t2
on t1.site_id=t2.site_id
and t1.shop_id=t2.shop_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}'





-----------------------------   sku计算-天维度


insert overwrite table dwm_sku_day PARTITION(dt='${DT[0]}')
select
t1.sku_id,
t1.item_id,
t1.site_id,
t1.cat_id,
t1.brand_id,
t1.shop_id,
t1.inventory_count,
case when nvl(t1.inventory_count,0)>0 and nvl(t2.inventory_count,0)>0 then t1.inventory_count-t2.inventory_count else 0 end  as inventory_add_1day,
t1.original_price as sku_original_price,
t1.sale_price as sku_sale_price,
t1.discount,
t1.carriage,
t1.create_time
from
dwd_sku_info as t1
left join
dwd_snap_sku_info as t2
on t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t1.sku_id=t2.sku_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}'







-----------------------------   产品计算-天维度


insert overwrite table dwm_item_day PARTITION(dt='${DT[0]}')
select
t3.item_id,
t3.item_name,
t3.shop_id,
t3.shop_name,
t3.site_id,
t3.cat_id,
t3.brand_id,
t3.sku_id,
t3.original_price_avg,
t3.sale_price_avg,
case when nvl(t3.original_price_avg,0)>0 and nvl(t4.original_price_avg,0)>0 then t3.original_price_avg-t4.original_price_avg else 0 end as originalPriceAvg_add_1day,
case when nvl(t3.sale_price_avg,0)>0 and nvl(t4.sale_price_avg,0)>0 then t3.sale_price_avg-t4.sale_price_avg else 0 end as salePriceAvg_add_1day,
t3.discount,
t3.review_count,
case when nvl(t3.review_count,0)>0 and nvl(t4.review_count,0)>0 then t3.review_count-t4.review_count else 0 end  as review_add_1day,
t3.textReview_count,
case when nvl(t3.textReview_count,0)>0 and nvl(t4.textReview_count,0)>0 then t3.textReview_count-t4.textReview_count else 0 end  as textReview_add_1day,
t3.sku_count,
case when nvl(t3.sku_count,0)>0 and nvl(t4.sku_count,0)>0 then t3.sku_count-t4.sku_count else 0 end as sku_add_1day,
t3.carriage,
t3.item_score,
case when nvl(t3.item_score,0)>0 and nvl(t4.item_score,0)>0 then t3.item_score-t4.item_score else 0 end as itemScore_add_1day,
t3.shop_address,
t3.one_star,
t3.two_star,
t3.three_star,
t3.four_star,
t3.five_star,
t3.cat_1d_name,
t3.cat_2d_name,
t3.cat_3d_name,
t3.cat_4d_name,
t3.cat_5d_name,
t3.cat_6d_name,
t3.cat_set,
t3.is_inventory,
t3.create_time
from
(
select
t2.item_id,
t2.item_name,
t2.shop_id,
t2.shop_name,
t2.site_id,
t2.cat_id,
t2.brand_id,
t2.sku_id,
case when nvl(t1.original_price,0)>0 then t1.original_price else 0 end as original_price_avg,
case when nvl(t1.sale_price,0)>0 then t1.sale_price else 0 end as sale_price_avg,
t2.discount,
t2.review_count,
t2.textReview_count,
t2.sku_count,
t2.carriage,
t2.item_score,
t2.shop_address,
t2.one_star,
t2.two_star,
t2.three_star,
t2.four_star,
t2.five_star,
t2.cat_1d_name,
t2.cat_2d_name,
t2.cat_3d_name,
t2.cat_4d_name,
t2.cat_5d_name,
t2.cat_6d_name,
t2.cat_set,
t2.is_inventory,
t2.create_time,
t2.dt
from
(select
site_id,
item_id,
sum(original_price) / count(sku_id) as original_price,
sum(sale_price) / count(sku_id) as sale_price
from
lazada_dw.dwd_sku_info
where
dt='${DT[0]}'
group by
site_id,
item_id) t1
right join
lazada_dw.dwd_item_info as t2
on t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t2.dt='${DT[0]}'
) t3
left join
dwd_snap_item_info t4
on t3.site_id=t4.site_id
and t3.item_id=t4.item_id
and t3.sku_id=t4.sku_id
and t4.dt='${DT[1]}'
where t3.dt='${DT[0]}'








-----------------------------  整合产品,6级类目,店铺类型

insert overwrite table dwm_itemWithCat_day PARTITION(dt='${DT[0]}')
select
t1.item_id,
t1.item_name,
t1.shop_id,
t1.shop_name,
t1.site_id,
t1.shop_type,
t1.cat_id,
t2.cat_1d_id,
t2.cat_2d_id,
t2.cat_3d_id,
t2.cat_4d_id,
t2.cat_5d_id,
t2.cat_6d_id,
t2.parent_id,
t2.cat_level,
t1.brand_id,
t1.sku_id,
t1.original_price,
t1.sale_price,
t1.originalPriceAvg_add_1day,
t1.salePriceAvg_add_1day,
t1.discount,
t1.review_count,
t1.review_add_1day,
t1.textReview_count,
t1.textReview_add_1day,
t1.sku_count,
t1.sku_add_1day,
t1.carriage,
t1.item_score,
t1.itemScore_add_1day,
t1.shop_address,
t1.one_star,
t1.two_star,
t1.three_star,
t1.four_star,
t1.five_star,
t1.cat_1d_name,
t1.cat_2d_name,
t1.cat_3d_name,
t1.cat_4d_name,
t1.cat_5d_name,
t1.cat_6d_namet,
t1.cat_set,
t1.is_inventory,
t1.create_time
from
dwd_category_info t2
right join
(
select
t1.item_id,
t1.item_name,
t1.shop_id,
t1.shop_name,
t1.site_id,
t1.cat_id,
t1.brand_id,
t1.sku_id,
t1.original_price,
t1.sale_price,
t1.originalPriceAvg_add_1day,
t1.salePriceAvg_add_1day,
t1.discount,
t1.review_count,
t1.review_add_1day,
t1.textReview_count,
t1.textReview_add_1day,
t1.sku_count,
t1.sku_add_1day,
t1.carriage,
t1.item_score,
t1.itemScore_add_1day,
t1.shop_address,
t1.one_star,
t1.two_star,
t1.three_star,
t1.four_star,
t1.five_star,
t1.cat_1d_name,
t1.cat_2d_name,
t1.cat_3d_name,
t1.cat_4d_name,
t1.cat_5d_name,
t1.cat_6d_namet,
t1.cat_set,
t1.is_inventory,
t1.create_time,
nvl(t2.shop_type,-1) as shop_type,
t2.dt
from
dwm_item_day t1
left join
dwd_shop_info t2
on t1.site_id = t2.site_id
and t1.shop_id = t2.shop_id
and t2.dt ='${DT[0]}'
where t1.dt ='${DT[0]}'
) t1
on t1.site_id=t2.site_id
and t1.cat_id=t2.cat_id
and t1.dt='${curdate}'
where
t2.dt='${curdate}'








-----------------------------   产品计算- 1. 7. 30.天维度

use shopee;
set io.sort.factor=100;
set io.sort.mb=10;
set hive.map.aggr=true;
set hive.exec.reducers.max=14;
set hive.merge.mapfiles=true;
set hive.merge.mapredfiles=true;
set mapreduce.map.output.compress=true;
set mapreduce.output.fileoutputformat.compress.type=BLOCK;
set mapreduce.map.output.compress.codec="org.apache.hadoop.io.compress.SnappyCodec";

--
insert overwrite table dwm_itemWithCat_30day PARTITION(dt='${DT[0]}')
select
t2.item_id,
t2.item_name,
t2.shop_id,
t2.shop_name,
t2.site_id,
t2.shop_type,
t2.cat_id,
t2.cat_1d_id,
t2.cat_2d_id,
t2.cat_3d_id,
t2.cat_4d_id,
t2.cat_5d_id,
t2.cat_6d_id,
t2.parent_id,
t2.cat_level,
t2.brand_id,
t2.sku_id,
t2.original_price_avg,
t2.sale_price_avg,
t2.originalPriceAvg_add_1day,
t2.salePriceAvg_add_1day,
t2.discount,
t1.review_count,
t1.textReview_count,
t1.textReview_add_1day,
t1.sku_count,
t1.sku_add_1day,
t1.skuAdd_quiteAdd_1day,
t1.review_add_1day,
t1.reviewAdd_quiteAdd_1day,
t1.review_add_7day,
t1.review_add_30day,
t1.reviewAdd_addRate_1day,
t1.reviewAdd_addRate_7day,
t1.reviewAdd_addRate_30day,
t1.reviewAdd_avg_7day,
t1.reviewAdd_avg_30day,
t1.reviewAdd_avg_addRate_7day,
t2.carriage,
t2.item_score,
t2.itemScore_add_1day,
t2.shop_address,
t2.one_star,
t2.two_star,
t2.three_star,
t2.four_star,
t2.five_star,
t2.cat_1d_name,
t2.cat_2d_name,
t2.cat_3d_name,
t2.cat_4d_name,
t2.cat_5d_name,
t2.cat_6d_name,
t2.cat_set,
t2.is_inventory,
t2.create_time
from
(
select
item_id,
shop_id,
site_id,
sum(case when dt='${DTS[0]}' then review_count end) as review_count,
sum(case when dt='${DTS[0]}' then textReview_count end) as textReview_count,
sum(case when dt='${DTS[0]}' then textReview_add_1day end) as textReview_add_1day,
sum(case when dt='${DTS[0]}' then sku_count end) as sku_count,
sum(case when dt='${DTS[0]}' then sku_add_1day end) as sku_add_1day,
(case when dt='${DTS[0]}' then sku_add_1day end) - (case when dt='${DTS[1]}' then sku_add_1day end) as skuAdd_quiteAdd_1day,
-- 增量评论数
sum(case when dt='${DTS[0]}' then review_add_1day end) as review_add_1day,
(case when dt='${DTS[0]}' then review_add_1day end) - (case when dt='${DTS[1]}' then review_add_1day end) as reviewAdd_quiteAdd_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) as review_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) as review_add_30day,
--（该行业昨日的评价数-该行业前日的评价数）/ 该行业前日的评价数
((sum(case when dt='${DTS[0]}' then review_add_1day end) - sum(case when dt='${DTS[1]}' then review_add_1day end)) / sum(case when dt='${DTS[1]}' then review_add_1day end))
as reviewAdd_addRate_1day,
--（该行业近7天的评价数-上7天该行业的评价数）/上7天该行业的评价数
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end))
as reviewAdd_addRate_7day,
--（该行业近30日的评价数-该行业的上30日的评价数）/该行业上30日的评价数
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then review_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then review_add_1day end))
as reviewAdd_addRate_30day,
-- 近7天平均新增评论数
(sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) / 7)
as reviewAdd_avg_7day,
-- 近30天平均新增评论数
(sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) / 30)
as reviewAdd_avg_30day,
-- 近7天平均新增评论数增长率 （全站普通店铺的这7日日均评价量-全站普通店铺的上7日日均评价量）/全站普通店铺的上7日日均评价量
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end / 7) - (sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end) / 7)) / (sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end) / 7))
as reviewAdd_avg_addRate_7day
from
dwm_itemWithCat_day
where
dt<='${DTS[0]}' and dt>='${DTS[29]}'
and
item_id is not null
and
shop_id is not null
and
site_id is not null
group by
item_id,
shop_id,
site_id
) t1
join
dwm_itemWithCat_day t2
on t1.shop_id=t2.shop_id
and t1.item_id=t2.item_id
and t1.site_id=t2.site_id
and t2.dt='${DTS[0]}'
/**
 * @author: koray
 * @create: 2020/12/06 23:49
 * TODO : t1.dt分区字段没有指定时间,输出结果-是否为1行数据还是多行数据????
 *
 */





--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


-----------------------------   店铺的基础表


insert overwrite table dwm_shop PARTITION(dt='${DT[0]}')
select
t1.site_id,
t1.shop_id,
t1.shop_type,
t1.item_count,
t1.review_count,
t1.itemReviewType_count,
t1.sale_price_avg,
t1.original_price_avg,
t1.itemReviewType_salePrice_avg,
t1.itemReviewType_origPrice_avg,
t2.praise_rate,
t2.praise_count,
t2.average_count,
t2.negative_count,
t2.onTimeDelivery_rate,
t2.cat_1d_name,
t2.chatResp_rate,
t1.shop_score,
t1.oneStar_reviewNum,
t1.twoStar_reviewNum,
t1.threeStar_reviewNum,
t1.fourStar_reviewNum,
t1.fiveStar_reviewNum,
t1.create_time
from
dwd_shop_info t2
right join
(
select
site_id,
shop_id,
shop_type,
count(item_id) as item_count,
sum(review_count) as review_count,
sum(case when review_count > 0 then 1 else 0 end) as itemReviewType_count,
sum(sale_price_avg) / count(item_id) as sale_price_avg,
sum(original_price_avg) / count(item_id) as original_price_avg,
sum(case when review_count > 0 then sale_price_avg else 0 end) / sum(case when review_count > 0 then 1 else 0 end) as itemReviewType_salePrice_avg,
sum(case when review_count > 0 then sale_price_avg else 0 end) / sum(case when review_count > 0 then 1 else 0 end) as itemReviewType_origPrice_avg,
sum(one_star) as oneStar_reviewNum,
sum(two_star) as twoStar_reviewNum,
sum(three_star) as threeStar_reviewNum,
sum(four_star) as fourStar_reviewNum,
sum(five_star) as fiveStar_reviewNum,
(sum(one_star)*1 + sum(two_star)*2 + sum(three_star)*3 + sum(four_star)*4  + sum(five_star)*5 ) / (sum(one_star) + sum(two_star) + sum(three_star) + sum(four_star) +sum(five_star) )
as shop_score,
create_time
from
dwm_itemWithCat_day
where
dt='${DTS[0]}'
group by
site_id,
shop_id,
shop_type,
create_time
) t1
on (t1.site_id = t2.site_id
and t1.shop_id = t2.shop_id)
where
t2.dt='${DTS[0]}'






-----------------------------   店铺的 天统计表

insert overwrite table dwm_shop_day PARTITION(dt='${DT[0]}')
select
t1.site_id,
t1.shop_id,
t1.shop_type,
t1.item_count,
case when nvl(t1.item_count,0)>0 and nvl(t2.item_count,0)>0 then t1.item_count-t2.item_count else 0 end  as item_add_1day,
t1.review_count,
case when nvl(t1.review_count,0)>0 and nvl(t2.review_count,0)>0 then t1.review_count-t2.review_count else 0 end  as review_add_1day,
t1.itemReviewType_count,
case when nvl(t1.itemReviewType_count,0)>0 and nvl(t2.itemReviewType_count,0)>0 then t1.itemReviewType_count-t2.itemReviewType_count else 0 end  as itemReviewType_add_1day,
t1.sale_price_avg,
t1.original_price_avg,
case when nvl(t1.sale_price_avg,0)>0 and nvl(t2.sale_price_avg,0)>0 then t1.sale_price_avg-t2.sale_price_avg else 0 end  as originalPriceAvg_add_1day,
case when nvl(t1.original_price_avg,0)>0 and nvl(t2.original_price_avg,0)>0 then t1.original_price_avg-t2.original_price_avg else 0 end  as salePriceAvg_add_1day,
t1.itemReviewType_salePrice_avg,
t1.itemReviewType_origPrice_avg,
case when nvl(t1.itemReviewType_salePrice_avg,0)>0 and nvl(t2.itemReviewType_salePrice_avg,0)>0 then t1.itemReviewType_salePrice_avg-t2.itemReviewType_salePrice_avg else 0 end  as itemReviewOriginalPriceAvg_add_1day,
case when nvl(t1.itemReviewType_origPrice_avg,0)>0 and nvl(t2.itemReviewType_origPrice_avg,0)>0 then t1.itemReviewType_origPrice_avg-t2.itemReviewType_origPrice_avg else 0 end  as itemReviewSalePriceAvg_add_1day,
t1.negate_num,
case when nvl(t1.negate_num,0)>0 and nvl(t2.negate_num,0)>0 then t1.negate_num-t2.negate_num else 0 end  as negateNum_add_1day,
t1.average_num,
case when nvl(t1.average_num,0)>0 and nvl(t2.average_num,0)>0 then t1.average_num-t2.average_num else 0 end  as averageNum_add_1day,
t1.praise_num,
case when nvl(t1.praise_num,0)>0 and nvl(t2.praise_num,0)>0 then t1.praise_num-t2.praise_num else 0 end  as praiseNum_add_1day,
t1.praise_rate,
t1.onTimeDelivery_rate,
case when nvl(t1.onTimeDelivery_rate,0)>0 and nvl(t2.onTimeDelivery_rate,0)>0 then t1.onTimeDelivery_rate-t2.onTimeDelivery_rate else 0 end  as onTimeDeliveryRate_add_1day,
t1.chatResp_rate,
t1.cat_1d_name,
t1.shop_score,
case when nvl(t1.shop_score,0)>0 and nvl(t2.shop_score,0)>0 then t1.shop_score-t2.shop_score else 0 end  as shopScore_add_1day,
t1.oneStar_reviewNum,
t1.twoStar_reviewNum,
t1.threeStar_reviewNum,
t1.fourStar_reviewNum,
t1.fiveStar_reviewNum,
case when nvl(t1.oneStar_reviewNum ,0) > 0 and nvl(t2.oneStar_reviewNum ,0) > 0 then t1.oneStar_reviewNum-t2.oneStar_reviewNum else 0 end as oneStarReviewNum_add_1day,
case when nvl(t1.twoStar_reviewNum ,0) > 0 and nvl(t2.twoStar_reviewNum ,0) > 0 then t1.twoStar_reviewNum-t2.twoStar_reviewNum else 0 end as twoStarReviewNum_add_1day,
case when nvl(t1.threeStar_reviewNum ,0) > 0 and nvl(t2.threeStar_reviewNum ,0) > 0 then t1.threeStar_reviewNum-t2.threeStar_reviewNum else 0 end as threeStarReviewNum_add_1day,
case when nvl(t1.fourStar_reviewNum ,0) > 0 and nvl(t2.fourStar_reviewNum ,0) > 0 then t1.fourStar_reviewNum-t2.fourStar_reviewNum else 0 end as fourStarReviewNum_add_1day,
case when nvl(t1.fiveStar_reviewNum ,0) > 0 and nvl(t2.fiveStar_reviewNum ,0) > 0 then t1.fiveStar_reviewNum-t2.fiveStar_reviewNum else 0 end as fiveStarReviewNum_add_1day,
t1.create_time
from
dwd_shop t1
left join
dwd_snap_shop t2
on ( t1.site_id=t2.site_id
and t1.shop_id=t2.shop_id
and t2.dt='${DT[1]}')
where
t1.dt='${DT[0]}';








-----------------------------   店铺的 30天统计表
set io.sort.factor=300;
set io.sort.mb=100;
set hive.map.aggr=true;
set hive.groupby.skewindata=false;
set mapreduce.map.output.compress=true;
set mapreduce.output.fileoutputformat.compress.type=BLOCK;
set mapreduce.map.output.compress.codec="org.apache.hadoop.io.compress.SnappyCodec";
set hive.exec.reducers.max=14;
set dfs.block.size=134217728;

--
insert overwrite table dwm_shop_30day PARTITION(dt='${DT[0]}')
select
t1.site_id,
t1.shop_id,
t1.shop_type,
t1.item_count,
t1.item_add_1day,
t1.item_add_7day,
t1.item_add_30day,
t1.item_addRate_1day,
t1.item_addRate_7day,
t1.item_addRate_30day,
t1.itemAdd_avg_1day,
t1.itemAdd_avg_7day,
t1.itemAdd_avg_30day,
t1.review_count,
t1.review_add_1day,
t1.review_add_7day,
t1.review_add_30day,
t1.reviewAdd_addRate_1day,
t1.reviewAdd_addRate_7day,
t1.reviewAdd_addRate_30day,
t1.itemReviewType_count,
t1.itemReviewType_add_1day,
t1.itemReviewType_add_7day,
t1.itemReviewType_add_30day,
t1.itemReviewType_addRate_1day,
t1.itemReviewType_addRate_7day,
t1.itemReviewType_addRate_30day,
t1.item_reviewRate_1day,
t1.item_reviewRate_7day,
t1.item_reviewRate_30ay,
t1.sale_price_avg,
t1.original_price_avg,
t1.originalPriceAvg_add_1day,
t1.salePriceAvg_add_1day,
t1.itemReviewType_salePrice_avg,
t1.itemReviewType_origPrice_avg,
t1.itemReviewOriginalPriceAvg_add_1day,
t1.itemReviewSalePriceAvg_add_1day,
t1.negate_num,
t1.negateNum_add_1day,
t1.average_num,
t1.averageNum_add_1day,
t1.praise_num,
t1.praiseNum_add_1day,
t1.praise_rate,
t1.onTimeDelivery_rate,
t1.onTimeDeliveryRate_add_1day,
t1.chatResp_rate,
t1.cat_1d_name,
t1.shop_score,
t1.shopScore_add_1day,
t1.oneStar_reviewNum,
t1.twoStar_reviewNum,
t1.threeStar_reviewNum,
t1.fourStar_reviewNum,
t1.fiveStar_reviewNum,
t1.oneStarReviewNum_add_1day,
t1.twoStarReviewNum_add_1day,
t1.threeStarReviewNum_add_1day,
t1.fourStarReviewNum_add_1day,
t1.fiveStarReviewNum_add_1day,
t1.create_time
from
(
select
site_id,
shop_id,
-- 产品数
sum(case when dt='${DTS[0]}' then item_count end) as item_count,
sum(case when dt='${DTS[0]}' then item_add_1day end) as item_add_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then item_add_1day end) as item_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then item_add_1day end) as item_add_30day,
((sum(case when dt='${DTS[0]}' then item_add_1day end) - sum(case when dt='${DTS[1]}' then item_add_1day end)) / sum(case when dt='${DTS[1]}' then item_add_1day end))
as item_addRate_1day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then item_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then item_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then item_add_1day end))
as item_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then item_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then item_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then item_add_1day end))
as item_addRate_30day,
(sum(case when dt<='${DTS[0]}' then item_add_1day end) / 1)
as itemAdd_avg_1day,
(sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then item_add_1day end) / 7)
as itemAdd_avg_7day,
(sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then item_add_1day end) / 30)
as itemAdd_avg_30day,

-- 评论数
sum(case when dt='${DTS[0]}' then review_count end) as review_count,
sum(case when dt='${DTS[0]}' then review_add_1day end) as review_add_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) as review_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) as review_add_30day,
((sum(case when dt='${DTS[0]}' then review_add_1day end) - sum(case when dt='${DTS[1]}' then review_add_1day end)) / sum(case when dt='${DTS[1]}' then review_add_1day end))
as reviewAdd_addRate_1day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end))
as reviewAdd_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then review_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then review_add_1day end))
as reviewAdd_addRate_30day,

-- 有评论产品
sum(case when dt='${DTS[0]}' then itemReviewType_count end) as itemReviewType_count,
sum(case when dt='${DTS[0]}' then itemReviewType_add_1day end) as itemReviewType_add_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then itemReviewType_add_1day end) as itemReviewType_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then itemReviewType_add_1day end) as itemReviewType_add_30day,
((sum(case when dt='${DTS[0]}' then itemReviewType_add_1day end) - sum(case when dt='${DTS[1]}' then itemReviewType_add_1day end)) / sum(case when dt='${DTS[1]}' then itemReviewType_add_1day end))
as itemReviewType_addRate_1day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then itemReviewType_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then itemReviewType_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then itemReviewType_add_1day end))
as itemReviewType_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then itemReviewType_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then itemReviewType_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then itemReviewType_add_1day end))
as itemReviewType_addRate_30day,


-- 产品评论率
sum(case when dt='${DTS[0]}' then itemReviewType_count end) / sum(case when dt='${DTS[0]}' then item_count end)  as item_reviewRate_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then itemReviewType_count end) / sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then item_count end)  as item_reviewRate_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then itemReviewType_count end) / sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then item_count end)  as item_reviewRate_30ay,


/**
 * @author: koray
 * @create: 2020/12/06 23:57
 * TODO :  待校验:  先子查询中判断字段时间(case when dt='${DTS[0]}') ???  还是在外查询中限定时间条件(where dt='${DTS[0]}')时间字段???
 *         然后对以下字段做处理...
 */
sum(case when dt='${DTS[0]}' then sale_price_avg end) as sale_price_avg,
sum(case when dt='${DTS[0]}' then original_price_avg end) as original_price_avg,
sum(case when dt='${DTS[0]}' then originalPriceAvg_add_1day end) as originalPriceAvg_add_1day,
sum(case when dt='${DTS[0]}' then salePriceAvg_add_1day end) as salePriceAvg_add_1day,
sum(case when dt='${DTS[0]}' then itemReviewType_salePrice_avg end) as itemReviewType_salePrice_avg,
sum(case when dt='${DTS[0]}' then itemReviewType_origPrice_avg end) as itemReviewType_origPrice_avg,
sum(case when dt='${DTS[0]}' then itemReviewOriginalPriceAvg_add_1day end) as itemReviewOriginalPriceAvg_add_1day,
sum(case when dt='${DTS[0]}' then itemReviewSalePriceAvg_add_1day end) as itemReviewSalePriceAvg_add_1day,
sum(case when dt='${DTS[0]}' then negate_num end) as negate_num,
sum(case when dt='${DTS[0]}' then negateNum_add_1day end) as negateNum_add_1day,
sum(case when dt='${DTS[0]}' then average_num end) as average_num,
sum(case when dt='${DTS[0]}' then averageNum_add_1day end) as averageNum_add_1day,
sum(case when dt='${DTS[0]}' then praise_num end) as praise_num,
sum(case when dt='${DTS[0]}' then praiseNum_add_1day end) as praiseNum_add_1day,
sum(case when dt='${DTS[0]}' then onTimeDelivery_rate end) as onTimeDelivery_rate,
sum(case when dt='${DTS[0]}' then onTimeDeliveryRate_add_1day end) as onTimeDeliveryRate_add_1day,
sum(case when dt='${DTS[0]}' then shop_score end) as shop_score,
sum(case when dt='${DTS[0]}' then shopScore_add_1day end) as shopScore_add_1day,
sum(case when dt='${DTS[0]}' then oneStar_reviewNum end) as oneStar_reviewNum,
sum(case when dt='${DTS[0]}' then twoStar_reviewNum end) as twoStar_reviewNum,
sum(case when dt='${DTS[0]}' then threeStar_reviewNum end) as threeStar_reviewNum,
sum(case when dt='${DTS[0]}' then fourStar_reviewNum end) as fourStar_reviewNum,
sum(case when dt='${DTS[0]}' then fiveStar_reviewNum end) as fiveStar_reviewNum,
sum(case when dt='${DTS[0]}' then oneStarReviewNum_add_1day end) as oneStarReviewNum_add_1day,
sum(case when dt='${DTS[0]}' then twoStarReviewNum_add_1day end) as twoStarReviewNum_add_1day,
sum(case when dt='${DTS[0]}' then threeStarReviewNum_add_1day end) as threeStarReviewNum_add_1day,
sum(case when dt='${DTS[0]}' then fourStarReviewNum_add_1day end) as fourStarReviewNum_add_1day,
sum(case when dt='${DTS[0]}' then fiveStarReviewNum_add_1day end) as fiveStarReviewNum_add_1day
from
dwm_shop_day
where
dt<='${DTS[0]}' and dt>='${DTS[59]}'
and
site_id is not null
and
shop_id is not null
group by
site_id,
shop_id
) t1
join
dwm_shop_day t2
on t1.site_id=t2.site_id
and t1.shop_id=t2.shop_id
and t2.dt='${DTS[0]}';















-----------------------------   店铺类型维度的基础表      dwd_shopTypeDiw

insert overwrite table `lazada_dw.dwd_shopTypeDiw` PARTITION(dt='${DT[0]}')

select
site_id,
shop_type,
sum(item_count)as item_count,
sum(review_count) as review_count,
sum(itemReviewType_count) as itemReviewType_count,
count(shop_id) as shop_count,
sum(case when review_count > 0 then 1 else 0 end) as shopReviewType_count
from
dwm_shop_day
where
dt='${DTS[0]}'
group by
site_id,
shop_type
;







-----------------------------   店铺类型维度的天表      dwd_shopTypeDiw_day


insert overwrite table `lazada_dw.dwd_shopTypeDiw_day` PARTITION(dt='${DT[0]}')

select
t1.site_id,
t1.shop_type,
t1.item_count,
case when nvl(t1.item_count,0)>0 and nvl(t2.item_count,0)>0 then t1.item_count-t2.item_count else 0 end
as item_count,
t1.review_count,
case when nvl(t1.review_count,0)>0 and nvl(t2.review_count,0)>0 then t1.review_count-t2.review_count else 0 end
as review_count,
t1.itemReviewType_count,
case when nvl(t1.itemReviewType_count,0)>0 and nvl(t2.itemReviewType_count,0)>0 then t1.itemReviewType_count-t2.itemReviewType_count else 0 end
as itemReviewType_count,
t1.shop_count,
case when nvl(t1.shop_count,0)>0 and nvl(t2.shop_count,0)>0 then t1.shop_count-t2.shop_count else 0 end
as shop_count,
t1.shopReviewType_count,
case when nvl(t1.shopReviewType_count,0)>0 and nvl(t2.shopReviewType_count,0)>0 then t1.shopReviewType_count-t2.shopReviewType_count else 0 end
as shopReviewType_count,
t1.create_time
from
dwd_shopTypeDiw t1
left join
dwd_snap_shopTypeDiw t2
on (t1.site_id = t2.site_id
and t1.shop_type = t2.shop_type
and t2.dt='${DTS[1]}')
where
t1.dt='${DTS[0]}'










-----------------------------   店铺类型维度的   30天表   dwd_shopTypeDiw_30day


insert overwrite table `lazada_dw.dwd_shopTypeDiw_30day` PARTITION(dt='${DT[0]}')
select
site_id,
shop_type,

-- 产品数
sum(case when dt='${DTS[0]}' then item_count end) as item_count,
sum(case when dt='${DTS[0]}' then item_add_1day end) as item_add_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then item_add_1day end) as item_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then item_add_1day end) as item_add_30day,
((sum(case when dt='${DTS[0]}' then item_add_1day end) - sum(case when dt='${DTS[1]}' then item_add_1day end)) / sum(case when dt='${DTS[1]}' then item_add_1day end))
as itemAdd_addRate_1day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then item_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then item_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then item_add_1day end))
as itemAdd_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then item_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then item_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then item_add_1day end))
as itemAdd_addRate_30day,

-- 评论数
sum(case when dt='${DTS[0]}' then review_count end) as review_count,
sum(case when dt='${DTS[0]}' then review_add_1day end) as review_add_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) as review_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) as review_add_30day,
((sum(case when dt='${DTS[0]}' then review_add_1day end) - sum(case when dt='${DTS[1]}' then review_add_1day end)) / sum(case when dt='${DTS[1]}' then review_add_1day end))
as reviewAdd_addRate_1day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end))
as reviewAdd_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then review_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then review_add_1day end))
as reviewAdd_addRate_30day,
(sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) / 7)
as reviewAdd_avg_7day,
(sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) / 30)
as reviewAdd_avg_30day,
-- 近7天平均新增评论数增长率（全站的近7日均评价量-全站上7日日均评价量）/全站上7日日均评价量
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then review_add_1day end) / 7) -
(sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end) / 7)) /
(sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then review_add_1day end) / 7)
as reviewAdd_avg_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then review_add_1day end) / 30) -
(sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then review_add_1day end) / 30)) /
(sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then review_add_1day end) / 30)
as reviewAdd_avg_addRate_30day,

-- 有评论产品
sum(case when dt='${DTS[0]}' then itemReviewType_count end) as itemReviewType_count,
sum(case when dt='${DTS[0]}' then itemReviewType_add_1day end) as itemReviewType_add_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then itemReviewType_add_1day end) as itemReviewType_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then itemReviewType_add_1day end) as itemReviewType_add_30day,
((sum(case when dt='${DTS[0]}' then itemReviewType_add_1day end) - sum(case when dt='${DTS[1]}' then itemReviewType_add_1day end)) / sum(case when dt='${DTS[1]}' then itemReviewType_add_1day end))
as itemReviewType_addRate_1day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then itemReviewType_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then itemReviewType_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then itemReviewType_add_1day end))
as itemReviewType_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then itemReviewType_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then itemReviewType_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then itemReviewType_add_1day end))
as itemReviewType_addRate_30day,


-- 全站的7日日均动销率 =（全站的近7日有评价数的产品数/全站的近7日的产品数）/7
sum(case when dt='${DTS[0]}' then itemReviewType_count end) /
sum(case when dt='${DTS[0]}' then item_count end)
as item_avgReviewRate_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then itemReviewType_count end) /
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then item_count end) / 7
as item_avgReviewRate_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then itemReviewType_count end) /
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then item_count end) / 30
as item_avgReviewRate_30day,

-- （全站的近7日均动销率-全站上7日日均动销率）/全站上7日日均动销率
( (sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then itemReviewType_count end) /
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then item_count end) / 7) -
(sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then itemReviewType_count end) /
sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then item_count end) / 7) ) /
(sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then itemReviewType_count end) /
sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then item_count end) / 7)
as item_avgReviewRate_addRate_7day,

-- 店铺数
sum(case when dt='${DTS[0]}' then shop_count end) as shop_count,
sum(case when dt='${DTS[0]}' then shop_add_1day end) as shop_add_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then shop_add_1day end) as shop_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then shop_add_1day end) as shop_add_30day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then shop_add_1day end) as itemReviewType_add_30day,
((sum(case when dt='${DTS[0]}' then shop_add_1day end) - sum(case when dt='${DTS[1]}' then shop_add_1day end)) / sum(case when dt='${DTS[1]}' then shop_add_1day end))
as shopAdd_addRate_1day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then shop_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then shop_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then shop_add_1day end))
as shopAdd_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then shop_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then shop_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then shop_add_1day end))
as shopAdd_addRate_30day,

-- 有评论店铺数
sum(case when dt='${DTS[0]}' then shopReviewType_count end) as shopReviewType_count,
sum(case when dt='${DTS[0]}' then shopReviewType_add_1day end) as shopReviewType_add_1day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then shopReviewType_add_1day end) as shopReviewType_add_7day,
sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then shopReviewType_add_1day end) as shopReviewType_add_30day,
((sum(case when dt='${DTS[0]}' then shopReviewType_add_1day end) - sum(case when dt='${DTS[1]}' then shopReviewType_add_1day end)) / sum(case when dt='${DTS[1]}' then shopReviewType_add_1day end))
as shopReviewType_addRate_1day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[6]}' then shopReviewType_add_1day end) - sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then shopReviewType_add_1day end)) / sum(case when dt<='${DTS[7]}' and dt>='${DTS[13]}' then shopReviewType_add_1day end))
as shopReviewType_addRate_7day,
((sum(case when dt<='${DTS[0]}' and dt>='${DTS[29]}' then shopReviewType_add_1day end) - sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then shopReviewType_add_1day end)) / sum(case when dt<='${DTS[30]}' and dt>='${DTS[59]}' then shopReviewType_add_1day end))
as shopReviewType_addRate_30day
from
dwd_shopTypeDiw_day
where
dt<='${DTS[0]}' and dt>='${DTS[59]}'
and
site_id is not null
and
shop_type is not null
group by
site_id,
shop_type


















