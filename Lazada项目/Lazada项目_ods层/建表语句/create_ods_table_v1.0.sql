

/*==============================================================*/
/*   Description :  osd层的建表语句(cos/mysql)                   */
/*   FileName :  create_ods_table.sql                           */
/*   Version  :  1.1                                            */
/*   Author   :  Koray                                          */
/*   Date     :  2020-11-14                                     */
/*   Company  :  menglar                                        */
/*==============================================================*/



/*==============================================================*/
/* Database:  lazada_dw                               */
/*==============================================================*/
create database if not exists `lazada_dw` COMMENT 'Lazada Data Warehouse Project'
WITH DBPROPERTIES ('creater'='koray','date'='20201105');


--查看库结构
desc database extended lazada_dw;

--使用库
use lazada_dw;



/*==============================================================*/
/* Table:  ods_cos_item                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_item`
(
`item_id`                        string       comment '商品id',
`item_name`                      string       comment '商品名称',
`shop_id`                        string       comment '店铺id',
`shop_name`                      string       comment '店铺名称',
`site_id`                        string       comment '站点id',
`cat_id`                         string       comment '三级类目id',
`brand_id`                       string       comment '品牌id',
`sku_id`                         string       comment 'sku_id',
`original_price`                 string       comment '商品原价',
`original_price_currency`        string       comment '带货币字符的商品原价',
`price`                          string       comment '商品折扣价',
`price_currency`                 string       comment '带货币字符的商品折扣价',
`discount`                       string       comment '折扣',
`review`                         string       comment '评价总数/总销售额',
`rating_score`                   string       comment '商品评分(平均星级)',
`location`                       string       comment '生产地',
`sku_code`                       string       comment '库存编码',
`cheapest_sku`                   string       comment '最便宜的型号',
`restricted_age`                 string       comment '年龄限制,如成人用品显示18',
`instock`                        string       comment '是否有库存,true-有,false-无',
`installment`                    string       comment '分期付款',
`description`                    string       comment '商品描述',
`product_url`                    string       comment '详情页链接',
`image_url`                      string       comment '商品主图链接',
`seller_id`                      string       comment '卖家id',
`main_seller_id`                 string       comment '',
`nid`                            string       comment '',
`promotion_id`                   string       comment '促销id',
`isad`                           string       comment '',
`click_trace`                    string       comment '点击追踪',
`creat_time`                     string       comment '创建时间'
 ) comment '爬虫日志映射的商品表'
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
  `item_id`               string             comment '商品id',
  `item_name`             string             comment '商品名称',
  `site_id`               string             comment '站点id',
  `cat_name_2`            string             comment '二级类目名称',
  `cat_name_3`            string             comment '三级类目名称',
  `rate_count`            string             comment '评论总条数',
  `review_count`          string             comment '有文本评论数',
  `carriage_currency`     string             comment '带货币字符的运费(固定标准运费)',
  `carriage`              string             comment '运费(固定标准运费)',
  `description`           string             comment '商品详细描述',
  `image_url`             string             comment '商品详情图',
  `rating_score`          string             comment '商品评分(平均星级)',
  `one_star`              string             comment '一星',
  `two_star`              string             comment '二星',
  `three_star`            string             comment '三星',
  `four_star`             string             comment '四星',
  `five_star`             string             comment '五星',
  `skus_num`              string             comment 'sku数量',
  `create_time`           string             comment '创建时间'
 ) comment '爬虫日志映射的商品详情表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_item_detail/';




/*==============================================================*/
/* Table:  ods_cos_shop                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_shop`
(
  `shop_id`                   string           comment '店铺id',
  `site_id`                   string           comment '站点id',
  `shop_name`                 string           comment '店铺名称',
  `main_cat`                  string           comment '主营类目(一级类目)',
  `sales_cat`                 string           comment '店铺销售类别,逗号隔开 (二级类目)',
  `total_results`             string           comment '商品总数量',
  `total_items`               string           comment '累计评价数',
  `follower_num`              string           comment '用户关注数/收藏数',
  `negative`                  string           comment '差评数量',
  `neutral`                   string           comment '中评数量',
  `positive`                  string           comment '好评数量',
  `shoprating`                string           comment '好评率',
  `identity`                  string           comment '店铺类型(旗舰-official,认证-certified,普通-seller)',
  `official_label`            string           comment '官方标签',
  `shop_rating`               string           comment '店铺评级',
  `cancel_rate`               string           comment '卖家取消率',
  `delivery_rate`             string           comment '准时送达',
  `responseratestr`           string           comment '聊天回复率',
  `increaserate`              string           comment '准时送达增长率',
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
 ) comment '爬虫日志映射的店铺表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_shop/';





/*==============================================================*/
/* Table:  ods_cos_sku                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_sku`
(
  `sku_id`                  string        comment 'sku_id',
  `item_id`                 string        comment '商品id',
  `site_id`                 string        comment '站点id',
  `brand_id`                string        comment '品牌id',
  `shop_id`                 string        comment '店铺id',
  `stock`                   string        comment '库存',
  `original_price`          string        comment '商品原价',
  `sale_price`              string        comment '商品折扣价',
  `discount`                string        comment '折扣',
  `prop_path`               string        comment '规格列表',
  `carriage`                string        comment '运费(固定标准运费)',
  `photo`                   string        comment '商品图片',
  `seller_id`               string        comment '卖家id',
  `inner_skuid`             string        comment 'sku名称和id的组合',
  `request_params`          string        comment '请求参数',
  `supplierId`              string        comment '供应商ID',
  `carriage_currency`       string        comment '带货币字符的运费(固定标准运费)',
  `sellerName`              string        comment '商家名称',
  `creat_time`              string        comment '创建时间'
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
/* Table:  ods_cos_brand                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_brand`
(
  `brand_id`               string     comment '品牌id',
  `site_id`                string     comment '站点id',
  `name`                   string     comment '品牌名称',
  `name_en`                string     comment '品牌名称(英文)',
  `global_identifier`      string     comment '跨不同系统品牌唯一标识符,如apple',
  `brand_id_temp`          string     comment '卖方中心分配该品牌的标识符',
  `create_time`            string     comment '创建时间'
 ) comment '爬虫日志映射的品牌表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_brand/';






/*==============================================================*/
/* Table:  ods_cos_category                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_cos_category`
(
  `cat_id`            string     comment '类目id',
  `cat_name`          string     comment '分类名称(英文)',
  `parent_id`         string     comment '父级id',
  `site_id`           string     comment '站点id',
  `create_time`       string     comment '创建时间'
 ) comment '爬虫日志映射的类目表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}',
    `hr` string  comment '小时分区字段{"format":"HH"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_cos_category/';






/*==============================================================*/
/* Table:  ods_mysql_station                                */
/*==============================================================*/
create external table if not exists `lazada_dw.ods_mysql_station`
(
`site_id`             string       comment '站点id',
`site_name`           string       comment '站点名称',
`site_name_en`        string       comment '站点名称(英语)',
`language`            string       comment '语言代码',
`currency`            string       comment '货币符号',
`exchange_rate`       string       comment '兑换美元的汇率',
`domains`             string       comment '域名',
`status`              string       comment '状态(0-正常,1-停用)',
`create_time`         string       comment '创建时间',
`modified_time`       string       comment '修改时间'
 ) comment 'mysql导入的站点信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as textfile
location 'cosn://emr-1254463213/lazada_dw/ods/ods_mysql_station/';











