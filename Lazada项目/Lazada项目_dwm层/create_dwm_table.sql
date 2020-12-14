

/*==============================================================*/
/*   Description :  dwm层的建表语句 (主题表)                     */
/*   FileName :  create_dwm_table.sql                           */
/*   Version  :  1.0                                            */
/*   Author   :  Koray                                          */
/*   Date     :  2020-11-26                                     */
/*   Company  :  menglar                                        */
/*==============================================================*/





/*==============================================================*/
/* Table: dwm_sku_day                                      */
/*==============================================================*/
create external table if not exists `lazada_dw.dwm_sku_day`
(
`sku_id`                     string                 comment 'sku_id',
`item_id`                    string                 comment '产品id',
`site_id`                    string                 comment '站点id',
`cat_id`                     string                 comment '最小的类目id',
`brand_id`                   string                 comment '品牌id',
`shop_id`                    string                 comment '店铺id',
`inventory_count`            bigint                 comment '库存总数(即每个sku下的商品总数)',
`inventory_add_1day`         bigint                 comment '近1天新增库存总数',
`sku_original_price`         decimal(15,2)          comment 'SKU原价',
`sku_sale_price`             decimal(15,2)          comment 'SKU折扣价',
`discount`                   string                 comment '折扣',
`carriage`                   decimal(15,2)          comment '运费(固定标准运费,0为包邮)',
`create_time`                string                 comment '创建时间'
)comment 'sku的近1天统计数据'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwm/dwm_sku_day/'
tblproperties("orc.compress"="SNAPPY");




/**
 * @author: koray
 * @create: 2020/12/04 11:55
 * TODO : 先暂时留着,只是单纯的商品表做计算
 *
 */
/*==============================================================*/
/* Table:  dwm_shop_day                                 */
/*==============================================================*/
-- create external table if not exists `lazada_dw.dwm_shop_day`
-- (
-- `shop_id`                            string           comment '店铺id',
-- `site_id`                            string           comment '站点id',
-- `shop_name`                          string           comment '店铺名称',
-- `cat_1d_name`                        string           comment '主营类目(一级类目)',
-- `sales_cat`                          string           comment '店铺销售类别,逗号隔开',
-- `follower_num`                       bigint           comment '用户关注数/收藏数',
-- `followerNum_add_1day`               bigint           comment '近1天的新增用户关注数',
-- `shop_type`                          string           comment '店铺类型(0.全站,1.普通,2.官方(旗舰+认证),3.淘宝)',
-- `shop_rating`                        string           comment '店铺评分',
-- `item_count`                         bigint           comment '产品总数量',
-- `item_add_1day`                      bigint           comment '近1天的新增产品总数量',
-- `review_count`                       bigint           comment '累计评价数',
-- `review_add_1day`                    bigint           comment '近1天的新增累计评价数',
-- `negate_num`                         bigint           comment '差评数量',
-- `negateNum_add_1day`                 bigint           comment '近1天的新增差评数量',
-- `average_num`                        bigint           comment '中评数量',
-- `averageNum_add_1day`                bigint           comment '近1天的新增中评数量',
-- `praise_num`                         bigint           comment '好评数量',
-- `praiseNum_add_1day`                 bigint           comment '近1天的新增好评数量',
-- `praise_rate`                        string           comment '好评率',
-- `cancel_rate`                        decimal(5,2)     comment '卖家取消率',
-- `cancelRate_add_1day`                decimal(5,2)     comment '近1天的新增卖家取消率',
-- `onTimeDelivery_rate`                decimal(5,2)     comment '准时送达率',
-- `onTimeDeliveryRate_add_1day`        decimal(5,2)     comment '近1天的新增准时送达率',
-- `chatResp_rate`                      string           comment '聊天回复率',
-- `onTimeDelivery_AddRate`             decimal(5,2)     comment '准时送达增长率',
-- `onTimeDeliveryAddRate_add_1day`     decimal(5,2)     comment '近1天的新增准时送达增长率',
-- `rate_level`                         bigint           comment '评分等级',
-- `create_time`                        string           comment '创建时间'
--  ) comment '店铺信息表'
-- partitioned by (
--     `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
-- row format delimited
--     fields terminated by '\t'
--     lines terminated by '\n'
-- stored as ORC
-- location 'cosn://emr-1254463213/lazada_dw/dwm/dwm_shop_day/'
-- tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table:  dwm_item_day                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.dwm_item_day`
(
`item_id`                        string              comment '产品id',
`item_name`                      string              comment '产品名称',
`shop_id`                        string              comment '店铺id',
`shop_name`                      string              comment '店铺名称',
`site_id`                        string              comment '站点id',
`cat_id`                         string              comment '最小级类目id',
`brand_id`                       string              comment '品牌id',
`sku_id`                         string              comment 'sku_id',
`original_price_avg`             decimal(15,2)       comment '产品原价均价',
`sale_price_avg`                 decimal(15,2)       comment '产品折扣均价',
`originalPriceAvg_add_1day`      decimal(15,2)       comment '近1天的新增原价均价',
`salePriceAvg_add_1day`          decimal(15,2)       comment '近1天的新增折扣均价',
`discount`                       string              comment '折扣',
`review_count`                   bigint              comment '评价总数/总销售额',
`review_add_1day`                bigint              comment '近1天的新增评价总数',
`textReview_count`               bigint              comment '有文本评论数',
`textReview_add_1day`            bigint              comment '近1天的新增有文本评论数',
`sku_count`                      bigint              comment 'sku数量',
`sku_add_1day`                   bigint              comment '近1天的新增sku数量',
`carriage`                       decimal(15,2)       comment '运费(计算用这个)',
`item_score`                     decimal(3,2)        comment '产品评分(平均星级)',
`itemScore_add_1day`             decimal(3,2)        comment '近1天的新增产品评分(平均星级)',
`shop_address`                   string              comment '店铺地址',
`one_star`                       bigint              comment '一星',
`two_star`                       bigint              comment '二星',
`three_star`                     bigint              comment '三星',
`four_star`                      bigint              comment '四星',
`five_star`                      bigint              comment '五星',
`cat_1d_name`                    string              comment '1级类目名称',
`cat_2d_name`                    string              comment '2级类目名称',
`cat_3d_name`                    string              comment '3级类目名称',
`cat_4d_name`                    string              comment '4级类目名称',
`cat_5d_name`                    string              comment '5级类目名称',
`cat_6d_name`                    string              comment '6级类目名称',
`cat_set`                        string              comment '该产品类目集合',
`is_inventory`                   string              comment '是否有库存,true-有,false-无',
`create_time`                    string              comment '创建时间'
 ) comment '产品信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwm/dwm_item_day/'
tblproperties("orc.compress"="SNAPPY");









/*==============================================================*/
/* Table:  dwm_itemWithCat_day                               */
/*==============================================================*/
create external table if not exists `lazada_dw.dwm_itemWithCat_day`
(
`item_id`                        string              comment '产品id',
`item_name`                      string              comment '产品名称',
`shop_id`                        string              comment '店铺id',
`shop_name`                      string              comment '店铺名称',
`site_id`                        string              comment '站点id',
`shop_type`                      string              comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
`cat_id`                         string              comment '最小级类目id',
`cat_1d_id`                      string              comment '1级类目ID',
`cat_2d_id`                      string              comment '2级类目ID',
`cat_3d_id`                      string              comment '3级类目ID',
`cat_4d_id`                      string              comment '4级类目ID',
`cat_5d_id`                      string              comment '5级类目ID',
`cat_6d_id`                      string              comment '6级类目ID',
`parent_id`                      string              comment '多级类目id的父级id',
`cat_level`                      string              comment '类目级别',
`brand_id`                       string              comment '品牌id',
`sku_id`                         string              comment 'sku_id',
`original_price_avg`             decimal(15,2)       comment '产品原价均价',
`sale_price_avg`                 decimal(15,2)       comment '产品折扣均价',
`originalPriceAvg_add_1day`      decimal(15,2)       comment '近1天的新增原价均价',
`salePriceAvg_add_1day`          decimal(15,2)       comment '近1天的新增折扣均价',
`discount`                       string              comment '折扣',
`review_count`                   bigint              comment '评价总数/总销售额',
`review_add_1day`                bigint              comment '近1天的新增评价总数',
`textReview_count`               bigint              comment '有文本评论数',
`textReview_add_1day`            bigint              comment '近1天的新增有文本评论数',
`sku_count`                      bigint              comment 'sku数量',
`sku_add_1day`                   bigint              comment '近1天的新增sku数量',
`carriage`                       decimal(15,2)       comment '运费(计算用这个)',
`item_score`                     decimal(3,2)        comment '产品评分(平均星级)',
`itemScore_add_1day`             decimal(3,2)        comment '近1天的新增产品评分(平均星级)',
`shop_address`                   string              comment '店铺地址',
`one_star`                       bigint              comment '一星',
`two_star`                       bigint              comment '二星',
`three_star`                     bigint              comment '三星',
`four_star`                      bigint              comment '四星',
`five_star`                      bigint              comment '五星',
`cat_1d_name`                    string              comment '1级类目名称',
`cat_2d_name`                    string              comment '2级类目名称',
`cat_3d_name`                    string              comment '3级类目名称',
`cat_4d_name`                    string              comment '4级类目名称',
`cat_5d_name`                    string              comment '5级类目名称',
`cat_6d_name`                    string              comment '6级类目名称',
`cat_set`                        string              comment '该产品类目集合',
`is_inventory`                   string              comment '是否有库存,true-有,false-无',
`create_time`                    string              comment '创建时间'
 ) comment '整合产品和6级类目的天统计表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table:  dwm_itemWithCat_30day                            */
/*==============================================================*/
create external table if not exists `lazada_dw.dwm_itemWithCat_30day`
(
`item_id`                        string              comment '产品id',
`item_name`                      string              comment '产品名称',
`shop_id`                        string              comment '店铺id',
`shop_name`                      string              comment '店铺名称',
`site_id`                        string              comment '站点id',
`shop_type`                      string              comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
`cat_id`                         string              comment '最小级类目id',
`cat_1d_id`                      string              comment '1级类目ID',
`cat_2d_id`                      string              comment '2级类目ID',
`cat_3d_id`                      string              comment '3级类目ID',
`cat_4d_id`                      string              comment '4级类目ID',
`cat_5d_id`                      string              comment '5级类目ID',
`cat_6d_id`                      string              comment '6级类目ID',
`parent_id`                      string              comment '多级类目id的父级id',
`cat_level`                      string              comment '类目级别',
`brand_id`                       string              comment '品牌id',
`sku_id`                         string              comment 'sku_id',
`original_price_avg`             decimal(15,2)       comment '产品原价均价',
`sale_price_avg`                 decimal(15,2)       comment '产品折扣均价',
`originalPriceAvg_add_1day`      decimal(15,2)       comment '原价均价较昨日增长',
`salePriceAvg_add_1day`          decimal(15,2)       comment '折扣均价较昨日增长',
`discount`                       string              comment '折扣',
`review_count`                   bigint              comment '评价总数/总销售额',
`textReview_count`               bigint              comment '有文本评论数',
`textReview_add_1day`            bigint              comment '近1天的新增有文本评论数',
`sku_count`                      bigint              comment 'sku数量',
`sku_add_1day`                   bigint              comment '近1天的新增sku数量',
`skuAdd_quiteAdd_1day`           bigint              comment '新增SKU数较昨日增长 [今新增数-昨新增数]',
`review_add_1day`                bigint              comment '近1天的新增评价总数',
`reviewAdd_quiteAdd_1day`        bigint              comment '新增评价数较昨日增长 [今新增数-昨新增数]',
`review_add_7day`                bigint              comment '近7天新增评论数',
`review_add_30day`               bigint              comment '近30天新增评论数',
`reviewAdd_addRate_1day`         decimal(10,2)       comment '近1天新增评论增长率',
`reviewAdd_addRate_7day`         decimal(10,2)       comment '近7天新增评论增长率',
`reviewAdd_addRate_30day`        decimal(10,2)       comment '近30天新增评论增长率',
`reviewAdd_avg_7day`             bigint              comment '近7天平均新增评论数',
`reviewAdd_avg_30day`            bigint              comment '近30天平均新增评论数',
`reviewAdd_avg_addRate_7day`     decimal(10,2)       comment '近7天平均新增评论数增长率',
`carriage`                       decimal(15,2)       comment '运费(计算用这个)',
`item_score`                     decimal(3,2)        comment '产品评分(平均星级)',
`itemScore_add_1day`             decimal(3,2)        comment '产品评分较昨日增长 [今新增数-昨新增数]',
`shop_address`                   string              comment '店铺地址',
`one_star`                       bigint              comment '一星',
`two_star`                       bigint              comment '二星',
`three_star`                     bigint              comment '三星',
`four_star`                      bigint              comment '四星',
`five_star`                      bigint              comment '五星',
`cat_1d_name`                    string              comment '1级类目名称',
`cat_2d_name`                    string              comment '2级类目名称',
`cat_3d_name`                    string              comment '3级类目名称',
`cat_4d_name`                    string              comment '4级类目名称',
`cat_5d_name`                    string              comment '5级类目名称',
`cat_6d_name`                    string              comment '6级类目名称',
`cat_set`                        string              comment '该产品类目集合',
`is_inventory`                   string              comment '是否有库存,true-有,false-无',
`create_time`                    string              comment '创建时间'
 ) comment '整合产品和6级类目的30天统计表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/'
tblproperties("orc.compress"="SNAPPY");









/*==============================================================*/
/* Table:  dwm_shop_day                             */
/*==============================================================*/
create external table if not exists `lazada_dw.dwm_shop_day`
(
`site_id`                                     string              comment '站点ID',
`shop_id`                                     string              comment '店铺ID',
`shop_type`                                   string              comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
`item_count`                                  bigint              comment '产品总数',
`item_add_1day`                               bigint              comment '近1天新增产品数',
`review_count`                                bigint              comment '评论总数',
`review_add_1day`                             bigint              comment '近1天新增评论数',
`itemReviewType_count`                        bigint              comment '有评论产品总数',
`itemReviewType_add_1day`                     bigint              comment '近1天新增有评论产品数',
`sale_price_avg`                              decimal(15,2)       comment '折扣均价 [折扣价总数/折扣产品总数]',
`original_price_avg`                          decimal(15,2)       comment '原价均价 [所有原价之和/原价产品总数] ',
`originalPriceAvg_add_1day`                   decimal(15,2)       comment '近1天的新增原价均价',
`salePriceAvg_add_1day`                       decimal(15,2)       comment '近1天的新增折扣均价',
`itemReviewType_salePrice_avg`                decimal(15,2)       comment '有评论产品折扣均价',
`itemReviewType_origPrice_avg`                decimal(15,2)       comment '有评论产品原价均价',
`itemReviewOriginalPriceAvg_add_1day`         decimal(15,2)       comment '近1天的新增有评论产品折扣均价',
`itemReviewSalePriceAvg_add_1day`             decimal(15,2)       comment '近1天的新增有评论产品原价均价',
`negate_num`                                  bigint              comment '差评数量',
`negateNum_add_1day`                          bigint              comment '近1天的新增差评数量',
`average_num`                                 bigint              comment '中评数量',
`averageNum_add_1day`                         bigint              comment '近1天的新增中评数量',
`praise_num`                                  bigint              comment '好评数量',
`praiseNum_add_1day`                          bigint              comment '近1天的新增好评数量',
`praise_rate`                                 string              comment '好评率',
`onTimeDelivery_rate`                         decimal(5,2)        comment '准时送达率',
`onTimeDeliveryRate_add_1day`                 decimal(5,2)        comment '近1天的新增准时送达率',
`chatResp_rate`                               string              comment '聊天回复率',
`cat_1d_name`                                 string              comment '主营类目(一级类目)',
`shop_score`                                  decimal(3,2)        comment '店铺评分',
`shopScore_add_1day`                          decimal(3,2)        comment '店铺评分较昨日增长',
`oneStar_reviewNum`                           bigint              comment '一星的评论数',
`twoStar_reviewNum`                           bigint              comment '二星的评论数',
`threeStar_reviewNum`                         bigint              comment '三星的评论数',
`fourStar_reviewNum`                          bigint              comment '四星的评论数',
`fiveStar_reviewNum`                          bigint              comment '五星的评论数',
`oneStarReviewNum_add_1day`                   bigint              comment '近1天的新增一星的评论数',
`twoStarReviewNum_add_1day`                   bigint              comment '近1天的新增二星的评论数',
`threeStarReviewNum_add_1day`                 bigint              comment '近1天的新增三星的评论数',
`fourStarReviewNum_add_1day`                  bigint              comment '近1天的新增四星的评论数',
`fiveStarReviewNum_add_1day`                  bigint              comment '近1天的新增五星的评论数',
`create_time`                                 string              comment '创建时间'
 ) comment '店铺的天统计表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/'
tblproperties("orc.compress"="SNAPPY");








/*==============================================================*/
/* Table:  dwm_shop_30day                                */
/*==============================================================*/
create external table if not exists `lazada_dw.dwm_shop_30day`
(
`site_id`                                     string                   comment '站点ID',
`shop_id`                                     string                   comment '店铺ID',
`shop_type`                                   string                   comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
--
`item_count`                                  bigint                   comment '产品总数',
`item_add_1day`                               bigint                   comment '近1天新增产品数',
`item_add_7day`                               bigint                   comment '近7天新增产品数',
`item_add_30day`                              bigint                   comment '近30天新增产品数',
-- `item_addRate_1day`	                          decimal(10,2)            comment '近1天产品增长率',
-- `item_addRate_7day`	                          decimal(10,2)            comment '近7天产品增长率',
-- `item_addRate_30day`	                      decimal(10,2)            comment '近30天产品增长率',
`itemAdd_avg_1day`	                          bigint                   comment '近1天平均新增产品数 [新增产品数之和/总时间]',
`itemAdd_avg_7day`	                          bigint                   comment '近7天平均新增产品数 [新增产品数之和/总时间]',
`itemAdd_avg_30day`	                          bigint                   comment '近30天平均新增产品数 [新增产品数之和/总时间]',
--
`review_count`                                bigint                   comment '评论总数',
`review_add_1day`                             bigint                   comment '近1天新增评论数',
`review_add_7day`                             bigint                   comment '近7天新增评论数',
`review_add_30day`                            bigint                   comment '近30天新增评论数',
-- `reviewAdd_addRate_1day`                      decimal(10,2)            comment '近1天评论增长率',
-- `reviewAdd_addRate_7day`                      decimal(10,2)            comment '近7天评论增长率',
-- `reviewAdd_addRate_30day`                     decimal(10,2)            comment '近30天评论增长率',
--
`itemReviewType_count`                        bigint                   comment '有评论产品总数',
`itemReviewType_add_1day`                     bigint                   comment '近1天新增有评论产品数',
`itemReviewType_add_7day`                     bigint                   comment '近7天新增有评论产品数',
`itemReviewType_add_30day`                    bigint                   comment '近30天新增有评论产品数',
-- `itemReviewType_addRate_1day`                 decimal(10,2)            comment '近1天有评论产品增长率 [(T期该店类品总数-(T-1)期该店类品总数)/(T-1)期该店类品总数]',
-- `itemReviewType_addRate_7day`                 decimal(10,2)            comment '近7天有评论产品增长率 [(T期该店类品总数-(T-1)期该店类品总数)/(T-1)期该店类品总数]',
-- `itemReviewType_addRate_30day`                decimal(10,2)            comment '近30天有评论产品增长率 [(T期该店类品总数-(T-1)期该店类品总数)/(T-1)期该店类品总数]',
`item_reviewRate_1day`                        decimal(10,2)            comment '近1天产品评论率 [有评论的产品数/总产品数]',
`item_reviewRate_7day`                        decimal(10,2)            comment '近7天产品评论率 [有评论的产品数/总产品数]',
`item_reviewRate_30ay`                        decimal(10,2)            comment '近30天产品评论率 [有评论的产品数/总产品数]',
`sale_price_avg`                              decimal(15,2)            comment '折扣均价 [折扣价总数/折扣产品总数]',
`original_price_avg`                          decimal(15,2)            comment '原价均价 [所有原价之和/原价产品总数] ',
`originalPriceAvg_add_1day`                   decimal(15,2)            comment '近1天的新增原价均价',
`salePriceAvg_add_1day`                       decimal(15,2)            comment '近1天的新增折扣均价',
`itemReviewType_salePrice_avg`                decimal(15,2)            comment '有评论产品折扣均价',
`itemReviewType_origPrice_avg`                decimal(15,2)            comment '有评论产品原价均价',
`itemReviewOriginalPriceAvg_add_1day`         decimal(15,2)            comment '近1天的新增有评论产品折扣均价',
`itemReviewSalePriceAvg_add_1day`             decimal(15,2)            comment '近1天的新增有评论产品原价均价',
`negate_num`                                  bigint                   comment '差评数量',
`negateNum_add_1day`                          bigint                   comment '近1天的新增差评数量',
`average_num`                                 bigint                   comment '中评数量',
`averageNum_add_1day`                         bigint                   comment '近1天的新增中评数量',
`praise_num`                                  bigint                   comment '好评数量',
`praiseNum_add_1day`                          bigint                   comment '近1天的新增好评数量',
`praise_rate`                                 string                   comment '好评率',
`onTimeDelivery_rate`                         decimal(5,2)             comment '准时送达率',
`onTimeDeliveryRate_add_1day`                 decimal(5,2)             comment '近1天的新增准时送达率',
`chatResp_rate`                               string                   comment '聊天回复率',
`cat_1d_name`                                 string                   comment '主营类目(一级类目)',
`shop_score`                                  decimal(3,2)             comment '店铺评分',
`shopScore_add_1day`                          decimal(3,2)             comment '店铺评分较昨日增长',
`oneStar_reviewNum`                           bigint                   comment '一星的评论数',
`twoStar_reviewNum`                           bigint                   comment '二星的评论数',
`threeStar_reviewNum`                         bigint                   comment '三星的评论数',
`fourStar_reviewNum`                          bigint                   comment '四星的评论数',
`fiveStar_reviewNum`                          bigint                   comment '五星的评论数',
`oneStarReviewNum_add_1day`                   bigint                   comment '近1天的新增一星的评论数',
`twoStarReviewNum_add_1day`                   bigint                   comment '近1天的新增二星的评论数',
`threeStarReviewNum_add_1day`                 bigint                   comment '近1天的新增三星的评论数',
`fourStarReviewNum_add_1day`                  bigint                   comment '近1天的新增四星的评论数',
`fiveStarReviewNum_add_1day`                  bigint                   comment '近1天的新增五星的评论数',
`create_time`                                 string                   comment '创建时间'
 ) comment '店铺的30天统计表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/'
tblproperties("orc.compress"="SNAPPY");







/*==============================================================*/
/* Table:  dwd_shopTypeDiw_day                               */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_shopTypeDiw_day`
(
`site_id`                             string              comment '站点ID ',
`shop_type`                           string              comment '店铺类型(1.普通,2.官方(旗舰+认证),3.淘宝)',
`item_count`                          bigint              comment '产品总数',
`item_add_1day`                       bigint              comment '近1天新增产品数',
`review_count`                        bigint              comment '评论总数',
`review_add_1day`                     bigint              comment '近1天新增评论数',
`itemReviewType_count`                bigint              comment '有评论产品总数',
`itemReviewType_add_1day`             bigint              comment '近1天新增有评论产品数',
`shop_count`                          bigint              comment '店铺总数',
`shop_add_1day`                       bigint              comment '近1天新增店铺数',
`shopReviewType_count`                bigint              comment '有评论店铺总数',
`shopReviewType_add_1day`             bigint              comment '近1天新增有评论店铺总数',
`create_time`                         string              comment '创建时间'
 ) comment '店铺类型维度的天统计表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/'
tblproperties("orc.compress"="SNAPPY");







/*==============================================================*/
/* Table:  dwd_shopTypeDiw_30day                               */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_shopTypeDiw_30day`
(
`site_id`                             string              comment '站点ID ',
`shop_type`                           string              comment '店铺类型(1.普通,2.官方(旗舰+认证),3.淘宝)',

-----
`item_count`                          bigint              comment '产品总数',
`item_add_1day`                       bigint              comment '近1天新增产品数',
-- `item_add_7day`                       bigint                  comment '近7天新增产品数',
-- `item_add_30day`                      bigint                  comment '近30天新增产品数',
-- `itemAdd_addRate_1day`	                 decimal(10,2)           comment '近1天新增产品增长率',
-- `itemAdd_addRate_7day`	                 decimal(10,2)           comment '近7天新增产品增长率',
-- `itemAdd_addRate_30day`	                 decimal(10,2)           comment '近30天新增产品增长率',

-----
`review_count`                        bigint              comment '评论总数',
`review_add_1day`                     bigint              comment '近1天新增评论数',
-- `review_add_7day`                      bigint              comment '近7天新增评论数',
-- `review_add_30day`                     bigint              comment '近30天新增评论数',
-- `reviewAdd_addRate_1day`               decimal(10,2)       comment '近1天评论增长率',
-- `reviewAdd_addRate_7day`               decimal(10,2)       comment '近7天评论增长率',
-- `reviewAdd_addRate_30day`              decimal(10,2)       comment '近30天评论增长率',
-- `reviewAdd_avg_7day`                   bigint              comment '近7天平均新增评论数',
-- `reviewAdd_avg_30day`                  bigint              comment '近30天平均新增评论数',
-- `reviewAdd_avg_addRate_7day`           decimal(10,2)       comment '近7天平均新增评论数增长率',
-- `reviewAdd_avg_addRate_30day`          decimal(10,2)       comment '近30天平均新增评论数增长率',

-----
`itemReviewType_count`                bigint              comment '有评论产品总数',
`itemReviewType_add_1day`             bigint              comment '近1天新增有评论产品数',
-- `itemReviewType_add_7day`               bigint              comment '近7天新增有评论产品数',
-- `itemReviewType_add_30day`              bigint              comment '近30天新增有评论产品数',
-- `itemAddReviewType_addRate_1day`        decimal(10,2)       comment '近1天新增有评论产品增长率 [(T期该店类品总数-(T-1)期该店类品总数)/(T-1)期该店类品总数]',
-- `itemAddReviewType_addRate_7day`        decimal(10,2)       comment '近7天新增有评论产品增长率',
-- `itemAddReviewType_addRate_30day`       decimal(10,2)       comment '近30天新增有评论产品增长率',
-- `item_avgReviewRate_1day`                decimal(10,2)      comment '近1天平均产品评论率(动销率) [7天有评论的产品数/7天总产品数/7]',
-- `item_avgReviewRate_7day`                decimal(10,2)      comment '近7天平均产品评论率(动销率) [7天有评论的产品数/7天总产品数/7]',
-- `item_avgReviewRate_30day`                decimal(10,2)      comment '近30天平均产品评论率(动销率) [7天有评论的产品数/7天总产品数/7]',
-- `item_avgReviewRate_addRate_7day`        decimal(10,2)      comment '近7天平均产品评论率的增长率 [(T期该店类总率-(T-1)期该店类总率)/(T-1)期该店类总率]',

------
`shop_count`                          bigint              comment '店铺总数',
`shop_add_1day`                       bigint              comment '近1天新增店铺数',
-- `shop_add_7day`                     bigint              comment '近7天新增店铺数',
-- `shop_add_30day`                    bigint              comment '近30天新增店铺数',
-- `shopAdd_addRate_1day`              decimal(10,2)       comment '近1天新增店铺增长率',
-- `shopAdd_addRate_7day`              decimal(10,2)       comment '近7天新增店铺增长率',
-- `shopAdd_addRate_30day`             decimal(10,2)       comment '近30天新增店铺增长率',

-----
`shopReviewType_count`                bigint              comment '有评论店铺总数',
`shopReviewType_add_1day`             bigint              comment '近1天新增有评论店铺总数',
-- `shopReviewType_add_7day`             bigint              comment '近7天新增有评论店铺总数',
-- `shopReviewType_add_30day`            bigint              comment '近30天新增有评论店铺总数',
-- `shopReviewType_addRate_1day`         decimal(10,2)       comment '近1天有评论店铺增长率',
-- `shopReviewType_addRate_7day`         decimal(10,2)       comment '近7天有评论店铺增长率',
-- `shopReviewType_addRate_30day`        decimal(10,2)       comment '近30天有评论店铺增长率',

`create_time`                         string              comment '创建时间'
 ) comment '店铺类型维度的30天统计表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/'
tblproperties("orc.compress"="SNAPPY");






















































/*==============================================================*/
/* Table:  dwm_station_info                                     */
/*==============================================================*/
create external table if not exists `lazada_dw.dwm_station_info`
(
`site_id`             string       comment '站点id',
`site_name`           string       comment '站点名称',
`site_name_en`        string       comment '站点名称(英语)',
`currency`            string       comment '货币符号',
`exchange_rate`       string       comment '兑换美元的汇率',
`status`              string       comment '状态(0-正常,1-停用)',
`create_time`         string       comment '创建时间',
`modified_time`       string       comment '修改时间'
 ) comment '站点信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwm/dwm_station_info/'
tblproperties("orc.compress"="SNAPPY");









