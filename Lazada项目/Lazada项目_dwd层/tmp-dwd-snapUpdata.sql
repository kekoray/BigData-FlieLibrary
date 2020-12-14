


---------------------  维护商品全量表



--插入2表都有的

insert overwrite table dwd_snap_item_info PARTITION(dt='${DT[0]}')
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
t1.discount,
t1.review_count,
t1.textReview_count,
t1.sku_count,
t1.carriage,
t1.item_score,
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
t1.cat_6d_name,
t1.cat_set,
t1.is_inventory,
t1.create_time
from
dwd_item_info t1
join
dwd_snap_item_info t2
on t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}';






-- 左关联
insert into table dwd_snap_item_info PARTITION(dt='${DT[0]}')
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
t1.discount,
t1.review_count,
t1.textReview_count,
t1.sku_count,
t1.carriage,
t1.item_score,
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
t1.cat_6d_name,
t1.cat_set,
t1.is_inventory,
t1.create_time
from
dwd_item_info t1
left join
dwd_snap_item_info t2
on t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}'
and t2.site_id is null
and t2.item_id is null;






-- 左关联
insert into table dwd_snap_item_info PARTITION(dt='${DT[0]}')
select
t2.item_id,
t2.item_name,
t2.shop_id,
t2.shop_name,
t2.site_id,
t2.cat_id,
t2.brand_id,
t2.sku_id,
t2.original_price,
t2.sale_price,
t2.discount,
t2.review_count,
t2.textReview_count,
t2.sku_count,
t2.carriage,
t2.item_score,
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
dwd_item_info t1
right join
dwd_snap_item_info t2
on (t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t1.dt='${DT[0]}')
where t2.dt='${DT[1]}'
and t1.site_id is null
and t1.item_id is null;







-------------------- 维护sku全量表


--历史表和新表join
insert overwrite table dwd_snap_sku_info PARTITION(dt='${DT[0]}')
select
t1.sku_id,
t1.item_id,
t1.site_id,
t1.cat_id,
t1.brand_id,
t1.shop_id,
t1.inventory_count,
t1.original_price,
t1.sale_price,
t1.discount,
t1.carriage,
t1.create_time
from
dwd_sku_info t1
join
dwd_snap_sku_info t2
on t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t1.sku_id=t2.sku_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}';



--left join
insert into table dwd_snap_sku_info PARTITION(dt='${DT[0]}')
select
t1.sku_id,
t1.item_id,
t1.site_id,
t1.cat_id,
t1.brand_id,
t1.shop_id,
t1.inventory_count,
t1.original_price,
t1.sale_price,
t1.discount,
t1.carriage,
t1.create_time
from
dwd_sku_info t1
left join
dwd_snap_sku_info t2
on t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t1.sku_id=t2.sku_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}'
and t2.site_id is null
and t2.item_id is null
and t2.sku_id is null;


--right join
insert into table dwd_snap_sku_info PARTITION(dt='${DT[0]}')
select
t2.sku_id,
t2.item_id,
t2.site_id,
t2.cat_id,
t2.brand_id,
t2.shop_id,
t2.inventory_count,
t2.original_price,
t2.sale_price,
t2.discount,
t2.carriage,
t2.create_time
from
dwd_sku_info t1
right join
dwd_snap_sku_info t2
on (t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t1.sku_id=t2.sku_id
and t1.dt='${DT[0]}')
where t2.dt='${DT[1]}'
and t1.site_id is null
and t1.item_id is null
and t1.sku_id is null;







---------------------  维护店铺全量表


--历史表和新表join
insert overwrite table dwd_snap_shop_info PARTITION(dt='${DT[0]}')
select
t1.shop_id,
t1.site_id,
t1.shop_name,
t1.cat_1d_name,
t1.sales_cat,
t1.follower_num,
t1.shop_type,
t1.shop_rating,
t1.item_count,
t1.review_count,
t1.negate_num,
t1.average_num,
t1.praise_num,
t1.praise_rate,
t1.cancel_rate,
t1.onTimeDelivery_rate,
t1.chatResp_rate,
t1.onTimeDelivery_AddRate,
t1.rate_level,
t1.create_time
from
dwd_shop_info t1
join
dwd_snap_shop_info t2
on t1.site_id=t2.site_id
and t1.shop_id=t2.shop_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}';



--left join
insert into table dwd_snap_shop_info PARTITION(dt='${DT[0]}')
select
t1.shop_id,
t1.site_id,
t1.shop_name,
t1.cat_1d_name,
t1.sales_cat,
t1.follower_num,
t1.shop_type,
t1.shop_rating,
t1.item_count,
t1.review_count,
t1.negate_num,
t1.average_num,
t1.praise_num,
t1.praise_rate,
t1.cancel_rate,
t1.onTimeDelivery_rate,
t1.chatResp_rate,
t1.onTimeDelivery_AddRate,
t1.rate_level,
t1.create_time
from
dwd_shop_info t1
left join
dwd_snap_shop_info t2
on t1.site_id=t2.site_id
and t1.shop_id=t2.shop_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}'
and t2.site_id is null
and t2.shop_id is null;



--right join
insert into table dwd_snap_shop_info PARTITION(dt='${DT[0]}')
select
t2.shop_id,
t2.site_id,
t2.shop_name,
t2.cat_1d_name,
t2.sales_cat,
t2.follower_num,
t2.shop_type,
t2.shop_rating,
t2.item_count,
t2.review_count,
t2.negate_num,
t2.average_num,
t2.praise_num,
t2.praise_rate,
t2.cancel_rate,
t2.onTimeDelivery_rate,
t2.chatResp_rate,
t2.onTimeDelivery_AddRate,
t2.rate_level,
t2.create_time
from
dwd_shop_info t1
right join
dwd_snap_shop_info t2
on (t1.site_id=t2.site_id
and t1.shop_id=t2.shop_id
and t1.dt='${DT[0]}')
where t2.dt='${DT[1]}'
and t1.site_id is null
and t1.shop_id is null;






---------------------------------   维护评论全量表




--历史表和新表join
insert overwrite table dwd_snap_review_info PARTITION(dt='${DT[0]}')
select
t1.review_id,
t1.sku_id,
t1.item_id,
t1.site_id,
t1.shop_id,
t1.star,
t1.like_count,
t1.sku_info,
t1.create_time
from
dwd_review_info t1
join
dwd_snap_review_info t2
on t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t1.review_id=t2.review_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}';



--left join
insert into table dwd_snap_review_info PARTITION(dt='${DT[0]}')
select
t1.review_id,
t1.sku_id,
t1.item_id,
t1.site_id,
t1.shop_id,
t1.star,
t1.like_count,
t1.sku_info,
t1.create_time
from
dwd_review_info t1
left  join
dwd_snap_review_info t2
on t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t1.review_id=t2.review_id
and t2.dt='${DT[1]}'
where t1.dt='${DT[0]}'
and t2.site_id is null
and t2.item_id is null
and t2.review_id is null;


--right join
insert into table dwd_snap_review_info PARTITION(dt='${DT[0]}')
select
t2.review_id,
t2.sku_id,
t2.item_id,
t2.site_id,
t2.shop_id,
t2.star,
t2.like_count,
t2.sku_info,
t2.create_time
from
dwd_review_info t1
right join
dwd_snap_review_info t2
on (t1.site_id=t2.site_id
and t1.item_id=t2.item_id
and t1.review_id=t2.review_id
and t1.dt='${DT[0]}')
where t2.dt='${DT[1]}'
and t1.site_id is null
and t1.item_id is null
and t1.review_id is null;




