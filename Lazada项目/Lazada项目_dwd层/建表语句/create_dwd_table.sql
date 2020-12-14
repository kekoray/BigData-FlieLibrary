

/*==============================================================*/
/*   Description :  dwd层的建表语句 (主题表)                     */
/*   FileName :  create_dwd_table.sql                           */
/*   Version  :  2.0                                            */
/*   Author   :  Koray                                          */
/*   Date     :  2020-11-28                                     */
/*   Company  :  menglar                                        */
/*==============================================================*/





/*==============================================================*/
/* Table:  tmp_etl_ods_item                                    */
/*==============================================================*/
create external table if not exists `lazada_dw.tmp_etl_ods_item`
(
`item_id`                        string            comment '产品id',
`item_name`                      string            comment '产品名称',
`shop_id`                        string            comment '店铺id',
`shop_name`                      string            comment '店铺名称',
`site_id`                        string            comment '站点id',
`cat_id`                         string            comment '最小级类目id',
`brand_id`                       string            comment '品牌id',
`sku_id`                         string            comment 'sku_id',
`original_price`                 decimal(15,2)     comment '产品原价',
`sale_price`                     decimal(15,2)     comment '产品折扣价',
`discount`                       string            comment '折扣',
`review_count`                   bigint            comment '评价总数/总销售额',
`item_score`                     decimal(3,2)      comment '产品评分(平均星级)',
`shop_address`                   string            comment '店铺地址(即产品表的location字段)',
`is_inventory`                   string            comment '是否有库存,true-有,false-无',
`create_time`                    string            comment '创建时间'
 ) comment '产品信息-去重中间表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/tmp_etl_ods_item/'
tblproperties("orc.compress"="SNAPPY");







/*==============================================================*/
/* Table:  tmp_etl_ods_item_detail                                */
/*==============================================================*/
create external table if not exists `lazada_dw.tmp_etl_ods_item_detail`
(
`item_id`                 string             comment '产品id',
`item_name`               string             comment '产品名称',
`site_id`                 string             comment '站点id',
`cat_1d_name`             string             comment '1级类目名称',
`cat_2d_name`             string             comment '2级类目名称',
`cat_3d_name`             string             comment '3级类目名称',
`cat_4d_name`             string             comment '4级类目名称',
`cat_5d_name`             string             comment '5级类目名称',
`cat_6d_name`             string             comment '6级类目名称',
`cat_set`                 string             comment '该产品类目集合',
`review_count`            string             comment '评论总条数',
`textReview_count`        string             comment '有文本评论数',
`carriage`                string             comment '运费(固定标准运费)',
`item_score`              string             comment '产品评分(平均星级)',
`one_star`                string             comment '一星',
`two_star`                string             comment '二星',
`three_star`              string             comment '三星',
`four_star`               string             comment '四星',
`five_star`               string             comment '五星',
`sku_count`               string             comment 'sku数量',
`create_time`             string             comment '创建时间'
 ) comment '产品详情-去重中间表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/tmp_etl_ods_item_detail/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table:  dwd_item_info                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_item_info`
(
`item_id`                        string              comment '产品id',
`item_name`                      string              comment '产品名称',
`shop_id`                        string              comment '店铺id',
`shop_name`                      string              comment '店铺名称',
`site_id`                        string              comment '站点id',
`cat_id`                         string              comment '最小级类目id',
`brand_id`                       string              comment '品牌id',
`sku_id`                         string              comment 'sku_id',
`original_price`                 decimal(15,2)       comment '产品原价',
`sale_price`                     decimal(15,2)       comment '产品折扣价',
`discount`                       string              comment '折扣',
`review_count`                   bigint              comment '评价总数/总销售额',
`textReview_count`               bigint              comment '有文本评论数',
`sku_count`                      bigint              comment 'sku数量',
`carriage`                       string              comment '运费(计算用这个)',
`item_score`                     decimal(3,2)        comment '产品评分(平均星级)',
`shop_address`                   string              comment '店铺地址(即产品表的location字段)',
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
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_item_info/'
tblproperties("orc.compress"="SNAPPY");







/*==============================================================*/
/* Table:  dwd_snap_item_info                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_snap_item_info`
(
`item_id`                        string              comment '产品id',
`item_name`                      string              comment '产品名称',
`shop_id`                        string              comment '店铺id',
`shop_name`                      string              comment '店铺名称',
`site_id`                        string              comment '站点id',
`cat_id`                         string              comment '最小级类目id',
`brand_id`                       string              comment '品牌id',
`sku_id`                         string              comment 'sku_id',
`original_price`                 decimal(15,2)       comment '产品原价',
`sale_price`                     decimal(15,2)       comment '产品折扣价',
`discount`                       string              comment '折扣',
`review_count`                   bigint              comment '评价总数/总销售额',
`textReview_count`               bigint              comment '有文本评论数',
`sku_count`                      bigint              comment 'sku数量',
`carriage`                       string              comment '运费(计算用这个)',
`item_score`                     decimal(3,2)        comment '产品评分(平均星级)',
`shop_address`                   string              comment '店铺地址(即产品表的location字段)',
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
 ) comment '产品信息的历史快照表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_snap_item_info/'
tblproperties("orc.compress"="SNAPPY");








/*==============================================================*/
/* Table:  tmp_etl_ods_shop                                         */
/*==============================================================*/
create external table if not exists `lazada_dw.tmp_etl_ods_shop`
(
  `shop_id`                   string           comment '店铺id',
  `site_id`                   string           comment '站点id',
  `shop_name`                 string           comment '店铺名称',
  `cat_1d_name`               string           comment '主营类目(一级类目)',
  `sales_cat`                 string           comment '店铺销售类别,逗号隔开',
  `follower_num`              bigint           comment '用户关注数/收藏数',
  `shop_type`                 string           comment '店铺类型(旗舰-official,认证-certified,普通-seller,淘宝-tbc)',
  `praise_rate`               string           comment '好评率',
  `cancel_rate`               decimal(5,2)     comment '卖家取消率',
  `onTimeDelivery_rate`       decimal(5,2)     comment '准时送达率',
  `chatResp_rate`             string           comment '聊天回复率',
  `onTimeDelivery_AddRate`    decimal(5,2)     comment '准时送达增长率',
  `rate_level`                bigint           comment '评分等级',
  `create_time`               string           comment '创建时间'
 ) comment '店铺信息-去重中间表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/tmp_etl_ods_shop/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table:  tmp_etl_ods_shop_detail                                 */
/*==============================================================*/
create external table if not exists `lazada_dw.tmp_etl_ods_shop_detail`
(
   `shop_id`                   string           comment '店铺id',
   `site_id`                   string           comment '站点id',
   `shop_name`                 string           comment '店铺名称',
   `item_count`                bigint           comment '产品总数量',
   `review_count`              bigint           comment '累计评价数',
   `negate_num`                bigint           comment '差评数量',
   `average_num`               bigint           comment '中评数量',
   `praise_num`                bigint           comment '好评数量',
   `create_time`               string           comment '创建时间'
 ) comment '店铺详情-去重中间表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/tmp_etl_ods_shop_detail/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table:  dwd_shop_info                                 */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_shop_info`
(
`shop_id`                   string           comment '店铺id',
`site_id`                   string           comment '站点id',
`shop_name`                 string           comment '店铺名称',
`cat_1d_name`               string           comment '主营类目(一级类目)',
`sales_cat`                 string           comment '店铺销售类别,逗号隔开',
`follower_num`              bigint           comment '用户关注数/收藏数',
`shop_type`                 string           comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
`praise_rate`               string           comment '好评率',
`item_count`                bigint           comment '产品总数量',
`review_count`              bigint           comment '累计评价数',
`negate_num`                bigint           comment '差评数量',
`average_num`               bigint           comment '中评数量',
`praise_num`                bigint           comment '好评数量',
`cancel_rate`               decimal(5,2)     comment '卖家取消率',
`onTimeDelivery_rate`       decimal(5,2)     comment '准时送达率',
`chatResp_rate`             string           comment '聊天回复率',
`onTimeDelivery_AddRate`    decimal(5,2)     comment '准时送达增长率',
`rate_level`                bigint           comment '评分等级',
`create_time`               string           comment '创建时间'
 ) comment '店铺信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_shop_info/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table:  dwd_snap_shop_info                                 */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_snap_shop_info`
(
`shop_id`                   string           comment '店铺id',
`site_id`                   string           comment '站点id',
`shop_name`                 string           comment '店铺名称',
`cat_1d_name`               string           comment '主营类目(一级类目)',
`sales_cat`                 string           comment '店铺销售类别,逗号隔开',
`follower_num`              bigint           comment '用户关注数/收藏数',
`shop_type`                 string           comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
`praise_rate`               string           comment '好评率',
`item_count`                bigint           comment '产品总数量',
`review_count`              bigint           comment '累计评价数',
`negate_num`                bigint           comment '差评数量',
`average_num`               bigint           comment '中评数量',
`praise_num`                bigint           comment '好评数量',
`cancel_rate`               decimal(5,2)     comment '卖家取消率',
`onTimeDelivery_rate`       decimal(5,2)     comment '准时送达率',
`chatResp_rate`             string           comment '聊天回复率',
`onTimeDelivery_AddRate`    decimal(5,2)     comment '准时送达增长率',
`rate_level`                bigint           comment '评分等级',
`create_time`               string           comment '创建时间'
 ) comment '店铺信息的历史快照表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_snap_shop_info/'
tblproperties("orc.compress"="SNAPPY");








/*==============================================================*/
/* Table:  dwd_sku_info                                         */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_sku_info`
(
  `sku_id`                  string            comment 'sku_id',
  `item_id`                 string            comment '产品id',
  `site_id`                 string            comment '站点id',
  `cat_id`                  string            comment '最小的类目id',
  `brand_id`                string            comment '品牌id',
  `shop_id`                 string            comment '店铺id',
  `inventory_count`         bigint            comment '库存',
  `original_price`          decimal(15,2)     comment '产品原价',
  `sale_price`              decimal(15,2)     comment '产品折扣价',
  `discount`                string            comment '折扣',
  `carriage`                decimal(6,2)      comment '运费(固定标准运费,0为包邮)',
  `create_time`             string            comment '创建时间'
 ) comment 'sku信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_sku_info/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table:  dwd_snap_sku_info                                         */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_snap_sku_info`
(
  `sku_id`                  string            comment 'sku_id',
  `item_id`                 string            comment '产品id',
  `site_id`                 string            comment '站点id',
  `cat_id`                  string            comment '最小的类目id',
  `brand_id`                string            comment '品牌id',
  `shop_id`                 string            comment '店铺id',
  `inventory_count`         bigint            comment '库存',
  `original_price`          decimal(15,2)     comment '产品原价',
  `sale_price`              decimal(15,2)     comment '产品折扣价',
  `discount`                string            comment '折扣',
  `carriage`                decimal(6,2)      comment '运费(固定标准运费,0为包邮)',
  `create_time`             string            comment '创建时间'
 ) comment 'sku信息的历史快照表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_snap_sku_info/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table:  dwd_review_info                                     */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_review_info`
(
   `review_id`             string    comment  '评价id',
   `sku_id`                string    comment  'skuid',
   `item_id`               string    comment  '商品id',
   `site_id`               string    comment  '站点id',
   `shop_id`               string    comment  '店铺id',
   `star`                  bigint    comment  '星级',
   `like_count`            bigint    comment  '点赞数',
   `sku_info`              string    comment  'suk信息(规格列表)',
   `create_time`           string    comment  '创建时间'
 ) comment '评论表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_review_info/'
tblproperties("orc.compress"="SNAPPY");



/*==============================================================*/
/* Table:  dwd_snap_review_info                                     */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_snap_review_info`
(
   `review_id`             string    comment  '评价id',
   `sku_id`                string    comment  'skuid',
   `item_id`               string    comment  '商品id',
   `site_id`               string    comment  '站点id',
   `shop_id`               string    comment  '店铺id',
   `star`                  bigint    comment  '星级',
   `like_count`            bigint    comment  '点赞数',
   `sku_info`              string    comment  'suk信息(规格列表)',
   `create_time`           string    comment  '创建时间'
 ) comment '评论的历史快照表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_snap_review_info/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table:  dwd_sku_pattern                                      */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_sku_pattern`
(
`item_id`             string     comment '产品ID',
`site_id`             string     comment '站点ID',
`sku_id`              string     comment 'skuid',
`sku_key_id`          string     comment 'SKU的keyID',
`sku_key_name`        string     comment 'SKU的key名称',
`sku_value_id`        string     comment 'SKU的valueID',
`sku_value_name`      string     comment 'SKU的value名称',
`create_time`         string     comment '创建时间'
 ) comment 'sku的规格信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_sku_pattern/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table:  dwd_snap_sku_pattern                                 */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_snap_sku_pattern`
(
`item_id`             string     comment '产品ID',
`site_id`             string     comment '站点ID',
`sku_id`              string     comment 'skuid',
`sku_key_id`          string     comment 'SKU的keyID',
`sku_key_name`        string     comment 'SKU的key名称',
`sku_value_id`        string     comment 'SKU的valueID',
`sku_value_name`      string     comment 'SKU的value名称',
`create_time`         string     comment '创建时间'
 ) comment 'sku规格信息的历史快照表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_snap_sku_pattern/'
tblproperties("orc.compress"="SNAPPY");









/*==============================================================*/
/* Table:  dwd_shop                                            */
-- TS:  基于 dwm_itemWithCat_day 进行计算
/*==============================================================*/
create external table if not exists `lazada_dw.dwm_shop`
(
`site_id`                            string              comment '站点ID',
`shop_id`                            string              comment '店铺ID',
`shop_type`                          string              comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
`item_count`                         bigint              comment '产品总数',
`review_count`                       bigint              comment '评论总数',
`itemReviewType_count`               bigint              comment '有评论产品总数',
`sale_price_avg`                     decimal(15,2)       comment '折扣均价 [折扣价总数/折扣产品总数]',
`original_price_avg`                 decimal(15,2)       comment '原价均价 [所有原价之和/原价产品总数] ',
`itemReviewType_salePrice_avg`       decimal(15,2)       comment '有评论产品折扣均价',
`itemReviewType_origPrice_avg`       decimal(15,2)       comment '有评论产品原价均价',
`negate_num`                         bigint              comment '差评数量',
`average_num`                        bigint              comment '中评数量',
`praise_num`                         bigint              comment '好评数量',
`praise_rate`                        string              comment '好评率',
`onTimeDelivery_rate`                decimal(5,2)        comment '准时送达率',
`chatResp_rate`                      string              comment '聊天回复率',
`cat_1d_name`                        string              comment '主营类目(一级类目)',
`shop_score`                         decimal(3,2)        comment '店铺评分',
`oneStar_reviewNum`                  bigint              comment '一星的评论数',
`twoStar_reviewNum`                  bigint              comment '二星的评论数',
`threeStar_reviewNum`                bigint              comment '三星的评论数',
`fourStar_reviewNum`                 bigint              comment '四星的评论数',
`fiveStar_reviewNum`                 bigint              comment '五星的评论数',
`create_time`                        string              comment '创建时间'
 ) comment '店铺基础表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table:  dwd_snap_shop                                            */
-- TS:  基于 dwm_itemWithCat_day 进行计算
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_snap_shop`
(
`site_id`                            string              comment '站点ID',
`shop_id`                            string              comment '店铺ID',
`shop_type`                          string              comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
`item_count`                         bigint              comment '产品总数',
`review_count`                       bigint              comment '评论总数',
`itemReviewType_count`               bigint              comment '有评论产品总数',
`sale_price_avg`                     decimal(15,2)       comment '折扣均价 [折扣价总数/折扣产品总数]',
`original_price_avg`                 decimal(15,2)       comment '原价均价 [所有原价之和/原价产品总数] ',
`itemReviewType_salePrice_avg`       decimal(15,2)       comment '有评论产品折扣均价',
`itemReviewType_origPrice_avg`       decimal(15,2)       comment '有评论产品原价均价',
`negate_num`                         bigint              comment '差评数量',
`average_num`                        bigint              comment '中评数量',
`praise_num`                         bigint              comment '好评数量',
`praise_rate`                        string              comment '好评率',
`onTimeDelivery_rate`                decimal(5,2)        comment '准时送达率',
`chatResp_rate`                      string              comment '聊天回复率',
`cat_1d_name`                        string              comment '主营类目(一级类目)',
`shop_score`                         decimal(3,2)        comment '店铺评分',
`oneStar_reviewNum`                  bigint              comment '一星的评论数',
`twoStar_reviewNum`                  bigint              comment '二星的评论数',
`threeStar_reviewNum`                bigint              comment '三星的评论数',
`fourStar_reviewNum`                 bigint              comment '四星的评论数',
`fiveStar_reviewNum`                 bigint              comment '五星的评论数',
`create_time`                        string              comment '创建时间'
 ) comment '店铺基础表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/'
tblproperties("orc.compress"="SNAPPY");













-------------------------------   更新慢,不用每天全量更新  ------------------------------------------------------------------------------









/*==============================================================*/
/* Table:  dwd_brand_info                                       */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_brand_info`
(
  `brand_id`                   string         comment '品牌id',
  `site_id`                    string         comment '站点id',
  `brand_name`                 string         comment '品牌名称(原始)',
  `brand_name_cn`              string         comment '品牌名称(中文)',
  `brand_name_en`              string         comment '品牌名称(英文)',
  `create_time`                string         comment '创建时间',
  `modified_time`              string         comment '修改时间'
 ) comment '品牌表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_brand_info/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table:  dwd_category_info                                       */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_category_info`
(
   `cat_id`            string       comment '多级类目id',
   `site_id`           string       comment '站点id',
   `cat_1d_id`         string       comment '1级类目ID',
   `cat_2d_id`         string       comment '2级类目ID',
   `cat_3d_id`         string       comment '3级类目ID',
   `cat_4d_id`         string       comment '4级类目ID',
   `cat_5d_id`         string       comment '5级类目ID',
   `cat_6d_id`         string       comment '6级类目ID',
   `cat_name`          string       comment '分类名称(原始)',
   `cat_name_cn`       string       comment '分类名称(中文)',
   `cat_name_en`       string       comment '分类名称(英文)',
   `parent_id`         string       comment '多级类目id的父级id',
   `cat_level`         string       comment '类目级别',
   `create_time`       string       comment '创建时间',
   `modified_time`     string       comment '修改时间'
 ) comment '类目表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_category_info/'
tblproperties("orc.compress"="SNAPPY");








/*==============================================================*/
/* Table:  dwd_shopTypeDiw                               */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_shopTypeDiw`
(
`site_id`                   string              comment '站点ID ',
`shop_type`                 string              comment '店铺类型(1.普通,2.官方(旗舰+认证),3.淘宝)',
`item_count`                bigint              comment '产品总数',
`review_count`              bigint              comment '评论总数',
`itemReviewType_count`      bigint              comment '有评论产品总数',
`shop_count`                bigint              comment '店铺总数',
`shopReviewType_count`      bigint              comment '有评论店铺总数',
`create_time`               string              comment '创建时间'
 ) comment ' '
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_shopTypeDiw/';





/*==============================================================*/
/* Table:  dwd_snap_shopTypeDiw                               */
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_snap_shopTypeDiw`
(
`site_id`                   string              comment '站点ID ',
`shop_type`                 string              comment '店铺类型(1.普通,2.官方(旗舰+认证),3.淘宝)',
`item_count`                bigint              comment '产品总数',
`review_count`              bigint              comment '评论总数',
`itemReviewType_count`      bigint              comment '有评论产品总数',
`shop_count`                bigint              comment '店铺总数',
`shopReviewType_count`      bigint              comment '有评论店铺总数',
`create_time`               string              comment '创建时间'
 ) comment ' '
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_snap_shopTypeDiw/';































/* ------------------------------------------------------------------------


/*==============================================================*/
/* Table:  dwd_monitor_item                               */
-- ts: 不用了
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_monitor_item`
(
`site_id`             string              comment '站点id',
`user_id`             string              comment '用户id',
`item_id`             string              comment '产品id',
`create_time`         string              comment '创建时间',
`modified_time`       string              comment '修改时间'
 ) comment ' 用户监控关联表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_monitor_item/';





/*==============================================================*/
/* Table:  dwd_monitor_shop                           */
-- ts: 不用了
/*==============================================================*/
create external table if not exists `lazada_dw.dwd_monitor_shop`
(
`site_id`             string              comment '站点id',
`user_id`             string              comment '用户id',
`shop_id`             string              comment '店铺id',
`create_time`         string              comment '创建时间',
`modified_time`       string              comment '修改时间'
 ) comment ' 用户监控关联表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/dwd/dwd_monitor_shop/';






















