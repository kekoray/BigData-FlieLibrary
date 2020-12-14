

/*==============================================================*/
/*   Description :  osd层的建表语句(cos/mysql)                   */
/*   FileName :  create_ods_table.sql                           */
/*   Version  :  3.0                                            */
/*   Author   :  Koray                                          */
/*   Date     :  2020-11-30                                     */
/*   Company  :  menglar                                        */
/*==============================================================*/



/*==============================================================*/
/* Database:  lazada_dw                               */
/*==============================================================*/
create database if not exists `lazada_dw` COMMENT 'Lazada Data Warehouse Project'
WITH DBPROPERTIES ('creater'='koray','date'='20201123');


--查看库结构
desc database extended lazada_dw;

--使用库
use lazada_dw;



/*==============================================================*/
/* Table:  ods_cos_item                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_item`
(
`item_id`                        string       comment '产品id',
`item_name`                      string       comment '产品名称',
`shop_id`                        string       comment '店铺id',
`shop_name`                      string       comment '店铺名称',
`site_id`                        string       comment '站点id',
`cat_id`                         string       comment '最小的类目id',
`brand_id`                       string       comment '品牌id',
`sku_id`                         string       comment 'sku_id',
`original_price`                 string       comment '产品原价',
`original_price_currency`        string       comment '带货币字符的产品原价',
`sale_price`                     string       comment '产品折扣价',
`sale_price_currency`            string       comment '带货币字符的产品折扣价',
`discount`                       string       comment '折扣',
`review_count`                   string       comment '评价总数/总销售额',
`item_score`                     string       comment '产品评分(平均星级)',
`location`                       string       comment '生产地',
`sku_code`                       string       comment '库存编码',
`cheapest_sku`                   string       comment '最便宜的型号',
`restricted_age`                 string       comment '年龄限制,如成人用品显示18',
`inventory`                      string       comment '是否有库存,true-有,false-无',
`installment`                    string       comment '分期付款',
`description`                    string       comment '产品描述',
`product_url`                    string       comment '详情页链接',
`image_url`                      string       comment '产品主图链接',
`seller_id`                      string       comment '卖家id',
`main_seller_id`                 string       comment '',
`nid`                            string       comment '',
`promotion_id`                   string       comment '促销id',
`isad`                           string       comment '',
`click_trace`                    string       comment '点击追踪',
`create_time`                     string       comment '创建时间'
 ) comment '爬虫日志映射的产品信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_item/';





/*==============================================================*/
/* Table:  ods_cos_item_detail                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_item_detail`
(
  `item_id`               string             comment '产品id',
  `item_name`             string             comment '产品名称',
  `site_id`               string             comment '站点id',
  `cat_1d_name`           string             comment '1级类目名称',
  `cat_2d_name`           string             comment '2级类目名称',
  `cat_3d_name`           string             comment '3级类目名称',
  `cat_4d_name`           string             comment '4级类目名称',
  `cat_5d_name`           string             comment '5级类目名称',
  `cat_6d_name`           string             comment '6级类目名称',
  `cat_set`               string             comment '该产品类目集合',
  `review_count`          string             comment '评论总条数',
  `textReview_count`      string             comment '有文本评论数',
  `carriage_currency`     string             comment '带货币字符的运费(固定标准运费)',
  `carriage`              string             comment '运费(固定标准运费)',
  `description`           string             comment '产品详细描述',
  `image_url`             string             comment '产品详情图',
  `item_score`            string             comment '产品评分(平均星级)',
  `one_star`              string             comment '一星',
  `two_star`              string             comment '二星',
  `three_star`            string             comment '三星',
  `four_star`             string             comment '四星',
  `five_star`             string             comment '五星',
  `sku_count`             string             comment 'sku数量',
  `create_time`           string             comment '创建时间'
 ) comment '爬虫日志映射的产品详情表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_item_detail/';





/*==============================================================*/
/* Table:  ods_cos_shop                                         */
/* FIXME:  由于爬虫原因,拆分个别字段组成店铺详细表                 */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_shop`
(
  `shop_id`                   string           comment '店铺id',
  `site_id`                   string           comment '站点id',
  `shop_name`                 string           comment '店铺名称',
  `cat_1d_name`               string           comment '主营类目(一级类目)',
  `sales_cat`                 string           comment '店铺销售类别,逗号隔开',
  `follower_num`              string           comment '用户关注数/收藏数',
  `shop_type`                 string           comment '店铺类型(旗舰-official,认证-certified,普通-seller,淘宝-tbc)',
  `official_label`            string           comment '官方标签',
  `praise_rate`               string           comment '好评率',
  `cancel_rate`               string           comment '卖家取消率',
  `onTimeDelivery_rate`       string           comment '准时送达率',
  `chatResp_rate`             string           comment '聊天回复率',
  `onTimeDelivery_AddRate`    string           comment '准时送达增长率',
  `seller_id`                 string           comment '卖家id',
  `join_date`                 string           comment '加入时间',
  `shop_logo`                 string           comment '店铺主图链接',
  `seller_key`                string           comment '店铺key,用于拼接url',
  `shop_center_domain`        string           comment '请求路径',
  `app_domain`                string           comment '请求路径',
  `shop_url`                  string           comment '店铺url=请求路径+店铺key',
  `page_id`                   string           comment '',
  `page_name`                 string           comment '',
  `join_time`                 string           comment '加入时间的数值',
  `join_unit`                 string           comment '加入时间对应的单位',
  `rate_level`                string           comment '评分等级',
  `create_time`               string           comment '创建时间'
 ) comment '爬虫日志映射的店铺信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_shop/';






/*==============================================================*/
/* Table:  ods_cos_shop_detail                                 */
/* FIXME:  由于爬虫原因,拆分个别字段组成店铺详细表                 */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_shop_detail`
(
   `shop_id`                   string          comment '店铺id',
   `site_id`                   string          comment '站点id',
   `shop_name`                 string          comment '店铺名称',
   `item_count`                string          comment '产品总数量',
   `review_count`              string          comment '累计评价数',
   `negate_num`                string          comment '差评数量',
   `average_num`               string          comment '中评数量',
   `praise_num`                string          comment '好评数量',
   `create_time`               string          comment '创建时间'
 ) comment '爬虫日志映射的店铺信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_shop_detail/';






/*==============================================================*/
/* Table:  ods_cos_sku                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_sku`
(
  `sku_id`                  string        comment 'sku_id',
  `item_id`                 string        comment '产品id',
  `site_id`                 string        comment '站点id',
  `brand_id`                string        comment '品牌id',
  `shop_id`                 string        comment '店铺id',
  `inventory_count`         string        comment '库存',
  `original_price`          string        comment '产品原价',
  `sale_price`              string        comment '产品折扣价',
  `discount`                string        comment '折扣',
  `prop_path`               string        comment '规格列表',
  `carriage`                string        comment '运费(固定标准运费,0为包邮)',
  `photo`                   string        comment '产品图片',
  `seller_id`               string        comment '卖家id',
  `inner_skuid`             string        comment 'sku名称和id的组合',
  `request_params`          string        comment '请求参数',
  `supplierId`              string        comment '供应商ID',
  `carriage_currency`       string        comment '带货币字符的运费(固定标准运费)',
  `sellerName`              string        comment '商家名称',
  `cat_id`                  string        comment '最小的类目id',
  `create_time`             string        comment '创建时间'
 ) comment '爬虫日志映射的sku表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_sku/';









/*==============================================================*/
/* Table:  ods_cos_review                                     */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_review`
(
   `review_id`             string    comment  '评价id',
   `sku_id`                string    comment  'skuid',
   `item_id`               string    comment  '商品id',
   `site_id`               string    comment  '站点id',
   `shop_id`               string    comment  '店铺id',
   `star`                  string    comment  '星级',
   `like_count`            string    comment  '点赞数',
   `review_type`           string    comment  '评价类型(未知含义)',
   `client_type`           string    comment  '评论客户端,手机或者PC',
   `review_contents`       string    comment  '评论内容',
   `review_time`           string    comment  '评价日期',
   `buyer_id`              string    comment  '买家id',
   `buyer_name`            string    comment  '买家名称',
   `bought_date`           string    comment  '购买日期',
   `sku_info`              string    comment  'suk信息(规格列表),NULL即官方也没有信息',
   `review_pic`            string    comment  '评论图片',
   `item_url`              string    comment  '商品详情页',
   `create_time`           string    comment  '创建时间'
 ) comment '爬虫日志映射的评论表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_review/';






/*==============================================================*/
/* Table:  ods_sku_pattern                                      */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_sku_pattern`
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
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_sku_pattern/';







--------------------------  从mysql中获取数据   -------------------------------------------------



/*==============================================================*/
/* Table:  ods_mysql_station                                   */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_mysql_station`
(
`site_id`             string              comment '站点id',
`site_name`           string              comment '站点名称',
`site_name_en`        string              comment '站点名称(英文)',
`language`            string              comment '语言代码',
`currency`            string              comment '货币符号',
`exchange_rate`       decimal(12,4)       comment '兑换美元的汇率',
`domains`             string              comment '域名',
`status`              string              comment '状态(0-正常,1-停用)',
`create_time`         string              comment '创建时间',
`modified_time`       string              comment '修改时间'
 ) comment 'mysql导入的站点信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_mysql_station/';




/*==============================================================*/
/* Table:  ods_mysql_brand                                     */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_mysql_brand`
(
  `brand_id`                   string         comment '品牌id',
  `site_id`                    string         comment '站点id',
  `brand_name`                 string         comment '品牌名称(原始)',
  `brand_name_cn`              string         comment '品牌名称(中文)',
  `brand_name_en`              string         comment '品牌名称(英文)',
  `global_identifier`          string         comment '跨不同系统品牌唯一标识符,如apple',
  `create_time`                string         comment '创建时间',
  `modified_time`              string         comment '修改时间'
 ) comment 'mysql导入的品牌表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_mysql_brand/';






/*==============================================================*/
/* Table:  ods_cos_category                                     */
/* TS:  新增多级类目和中英字段                                      */
/*==============================================================*/
/*create external table if not exists `lazada_dw.ods_cos_category`
(
   `cat_id`            string       comment '类目id',
   `cat_level`         string       comment '类目级别',
   `cat_name`          string       comment '分类名称(原始)',
   `parent_id`         string       comment '父级id',
   `site_id`           string       comment '站点id',
   `create_time`       string       comment '创建时间'
 ) comment '爬虫日志映射的类目表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_category/';*/



/*==============================================================*/
/* Table:  ods_mysql_category                                     */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_mysql_category`
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
   `parent_id`         string       comment '父级id',
   `cat_level`         string       comment '类目级别',
   `create_time`       string       comment '创建时间',
   `modified_time`     string       comment '修改时间'
 ) comment 'mysql导入的类目表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_mysql_category/';







/*==============================================================*/
/* Table:  ods_mysql_monitor_relation                           */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_mysql_monitor_relation`
(
`site_id`             string              comment '站点id',
`user_id`             string              comment '用户id',
`group_id`            string              comment '分组id',
`target_type`         string              comment '目标类型(1.产品,2.店铺)',
`target_id`           string              comment '目标id',
`create_time`         string              comment '创建时间',
`modified_time`       string              comment '修改时间'
 ) comment 'mysql导入的用户监控关联表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_mysql_monitor_relation/';



