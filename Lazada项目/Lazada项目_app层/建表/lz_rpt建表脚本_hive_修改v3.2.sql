

/*==============================================================*/
/*   Description :  app层的建表语句                              */
/*   FileName :   create_app_table.sql                          */
/*   Version  :   3.0                                           */
/*   Author   :   Koray                                         */
/*   Date     :   2020-11-19                                    */
/*   Company  :   menglar                                       */
/*==============================================================*/




/*==============================================================*/
/* Table:  app_rpt_site_item_reviews_count                               */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_reviews_count`
(
   `id`               string     comment '主键',
   `site_id`          string     comment '站点ID(默认为0表示全站）',
   `item_count`       bigint     comment '产品总数',
   `review_count`     bigint     comment '评论总数',
   `item_add_1day`         bigint     comment '近1天新增产品数',
   `review_add_1day`       bigint     comment '近1天新增评论数',
   `create_time`      string     comment '创建时间'
)comment '全站-行业分析-评论数和产品数趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_item_reviews_count/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_cat_contrast                                   */
/*==============================================================*/

create external table if not exists `lazada_dw.app_rpt_cat_contrast`
(
   `id`                          string             comment  '主键',
   `cat_id`                      string             comment  '行业ID',
   `site_id`                     string             comment  '站点ID',
   `shop_count`                 bigint              comment  '店铺总数',
   `item_count`                  bigint             comment  '产品总数',
   `review_count`                bigint             comment  '评论总数',

   `review_add_1day`          bigint             comment  '近1天新增评论数 [新增评论数之和]',
   `item_add_1day`            bigint             comment  '近1天新增产品数 [新增产品数之和]',
   `shop_add_1day`            bigint             comment  '近1天新增店铺数 [新增店铺数之和]',
   `orig_price_ave_1day`      decimal(10,2)      comment  '近1天原价均价 [原价的总销售额/总评论数]',
   `sale_price_ave_1day`      decimal(10,2)      comment  '近1天折扣均价 [折扣价的总销售额/总评论数]',
   `item_reviewRate_1day`     decimal(10,2)      comment  '近1天产品评论率 [有评论的产品数/总产品数]',
   `review_addRate_1day`     decimal(10,2)      comment  '近1天评论增长率 [(T周期总评论数-(T-1)周期评论数)/(T-1)周期总评论数]',
   `newItem_ave_1day`        bigint             comment  '近1天平均上新产品数 [上新产品数之和/总时间]',
   `review_avg_1day`          bigint             comment  '近1天平均评论数 [评论数之和/总时间]',

  `review_add_7day`           bigint             comment  '近7天新增评论数',
  `item_add_7day`             bigint             comment  '近7天新增产品数',
  `shop_add_7day`             bigint             comment  '近7天新增店铺数',
  `orig_price_ave_7day`       decimal(10,2)      comment  '近7天原价均价',
  `sale_price_ave_7day`       decimal(10,2)      comment  '近7天折扣均价',
  `item_reviewRate_7day`      decimal(10,2)      comment  '',
  `review_addRate_7day`      decimal(10,2)      comment  '近7天评论增长率',
  `newItem_ave_7day`         bigint             comment  '近7天平均上新产品数',
  `review_avg_7day`           bigint             comment  '近7天平均评论数',

   `review_add_30day`           bigint             comment  '近30天新增评论数',
   `item_add_30day`             bigint             comment  '近30天新增产品数',
   `shop_add_30day`             bigint             comment  '近30天新增店铺数',
   `orig_price_ave_30day`       decimal(10,2)      comment  '近30天原价均价',
   `sale_price_ave_30day`       decimal(10,2)      comment  '近30天折扣均价',
   `item_reviewRate_30day`      decimal(10,2)      comment  '近30天产品评论率',
   `review_addRate_30day`      decimal(10,2)      comment  '近30天评论增长率',
   `newItem_ave_30day`         bigint             comment  '近30天平均上新产品数',
   `review_avg_30day`           bigint             comment  '近30天平均评论数',

   `create_time`                 string             comment  '创建时间'
)comment '行业分析-行业对比'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_cat_contrast/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: app_rpt_cat                                           */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_cat`
(
   `id`                        string                comment '主键',
   `cat_id`                    string                comment '行业ID',
   `site_id`                   string                comment '站点ID',
   `shop_count`                  bigint                comment '店铺总数',
   `item_count`                  bigint                comment '产品总数',
   `review_count`                bigint                comment '评论总数',
   `review_add_1day`            bigint                comment '近1天新增评论数',
   `item_ave_price`            decimal(10,2)         comment '产品均价  [所有产品总价格/产品总数,或者所有suk总价/suk总数]',
   `item_add_1day`             bigint                comment '近1天新增产品数',
   `shop_add_7day`        bigint                comment '7天新增店铺数',
   `orig_price_ave_7day`       decimal(10,2)         comment '7天原价均价',
   `sale_price_ave_7day`           decimal(10,2)         comment '7天折扣均价',
   `item_reviewRate_7day`      decimal(10,2)         comment '7天产品评论率',
   `review_addRate_7day`       decimal(10,2)         comment '7天评论增长率',
   `newItem_ave_7day`    bigint                comment '7天平均上新产品数',
   `review_avg_7day`        bigint                comment '7天平均评论数',
   `orig_price_ave_30day`       decimal(10,2)         comment '30天原价均价',
   `sale_price_ave_30day`           decimal(10,2)         comment '30天折扣均价',
   `review_avg_30day`        bigint                comment '30天平均评论数',
   `review_addRate_1day`         decimal(10,2)         comment '近1天评论增长率',
   `review_addRate_30day`       decimal(10,2)         comment '近30天评论增长率',
   `create_time`                string                comment '创建时间'
)comment '行业分析-行业搜索/行业详情页(行业概况)'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_cat/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: app_rpt_cat_percent                                   */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_cat_percent`
(
   `id`                       string           comment '主键',
   `cat_id`                 string           comment '行业ID',
   `site_id`                  string           comment '站点ID',
   `review_count`            bigint           comment '评论总数',
   `review_acco`            decimal(5,2)     comment '评论总数占比 [子行业评论数/父行业评论总数]',
   `item_add_7day`          bigint           comment '近7天新增产品数',
   `item_add_30day`          bigint           comment '近30天新增产品数',
   `itemAdd_acco_7day`        decimal(5,2)     comment '近7天新增产品占比 [子行业新增产品数/父行业新增产品总数]',
   `itemAdd_acco_30day`         decimal(5,2)     comment '近30天新增产品占比',
   `create_time`               string           comment '创建时间'
)comment '行业分析-行业详情页-子行业概况-子行业占比图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_cat_percent/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_site_item_reviews_pct                             */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_reviews_pct`
(
   `id`                   string           comment '主键',
   `site_id`              string           comment '站点ID',
   `review_count`           bigint           comment '评论总数',
   `review_acco`            decimal(5,2)     comment '评论总数占比 [单站的评论总数/全站的评论总数]',

   `review_add_1day`        bigint           comment '近1天新增评论数',
   `review_acco_1day`        decimal(5,2)     comment '近1天新增评论占比',

   `review_add_7day`      bigint           comment '近7天新增评论数',
   `review_acco_7day`      decimal(5,2)     comment '近7天新增评论占比',

   `review_add_30day`      bigint           comment '近30天新增评论数',
   `review_acco_30day`      decimal(5,2)     comment '近30天新增评论占比',
   `create_time`           string           comment '创建时间'
)comment '全站-产品分析-各站点产品评论数占比图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_item_reviews_pct/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: app_rpt_site_item_reviews_trend                            */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_reviews_trend`
(
   `id`               string    comment '主键',
   `site_id`          string    comment '站点id(默认为0意思是全站）',
   `review_count`       bigint    comment '评论总数',
   `review_add_1day`         bigint    comment '近1天新增评论数',
   `create_time`       string    comment '创建时间'
)comment '全站-产品分析-产品评论数趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_item_reviews_trend/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_site_shop_item                                       */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_shop_item`
(
   `id`               string          comment '主键',
   `site_id`          string          comment '站点ID (默认为0意思是全站）',
   `item_set`         string          comment '产品数区间 (1.0~50,2.51~100,3.101~150,4.151~200,5.201~300,6.301~1000,7.1001~2000,8.2001+~)',
   `shop_count`       bigint          comment '每项区间对应的店铺总数',
   `shop_acco`        decimal(5,2)    comment '每项区间对应的店铺数占比 [每项区间的店铺数/总店铺数]',
   `hasEval_type`     string          comment '有无评论的产品 (1.总产品 2.有评论的产品 3.无评论的产品)',
   `create_time`      string          comment '创建时间'
)comment '全站/分站-店铺分析-产品数量分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_shop_item/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_site_item_percent                                  */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_percent`
(
   `id`                   string           comment '主键',
   `site_id`              string           comment '站点ID',

   `item_count`           bigint           comment '产品总数',
   `item_acco`            decimal(5,2)     comment '产品总数占比',

   `item_add_1day`        bigint           comment '近1天新增产品数',
   `itemAdd_acco_1day`        decimal(5,2)     comment '近1天新增产品占比',

   `item_add_7day`      bigint           comment '近7天新增产品数',
   `itemAdd_acco_7day`      decimal(5,2)     comment '近7天新增产品占比',

   `item_add_30day`      bigint           comment '近30天新增产品数',
   `itemAdd_acco_30day`      decimal(5,2)     comment '近30天新增产品占比',
   `create_time`           string           comment '创建时间'
)comment '全站-产品分析-各站点产品数占比图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_item_percent/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: app_rpt_site_item_trend                                 */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_trend`
(
   `id`               string      comment '主键',
   `site_id`          string      comment '站点ID(默认为0就是全站)',
   `item_count`       bigint      comment '产品总数',
   `review_add_1day`         bigint      comment '近1天新增评论数',
   `create_time`       string      comment '创建时间'
)comment '全站/分站-产品分析-产品数趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimiteds
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_item_trend/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_item_s1                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_item_s1`
(
   `id`                       string             comment '主键',
   `item_id`                  string             comment '产品ID',
   `cat_id`                  string             comment '行业ID',
   `shop_id`                  string             comment '店铺ID',
   `brand_name`               string             comment '所属品牌',

   `review_add_1day`             bigint             comment '近1天新增评论数',
   `review_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',

   `review_count_7day`           bigint             comment '近7天评论总数',
   `review_avg_7day`       bigint             comment '近7天平均评论数',
   `review_addRate_7day`      decimal(10,2)      comment '近7天评论增长率',

   `review_count_30day`           bigint             comment '近30天评论总数',
   `review_addRate_30day`      decimal(10,2)      comment '近30天评论增长率',

   `review_count`               bigint             comment '累计评论总数',
   `original_price`           decimal(10,2)      comment '原始价格',
   `sale_price`                    decimal(10,2)      comment '折扣价格',

   `carriage`                  decimal(6,2)       comment '运费',
   `item_score`               decimal(3,2)       comment '产品评分(平均星级)',

   `create_time`               string             comment '创建时间'
)comment '产品分析-马来西亚产品展示表（产品详细信息，销售数据明细，店铺商品列表，行业产品）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_item_s1/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_item_s2                                       */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_item_s2`
(
   `id`                       string             comment '主键',
   `item_id`                  string             comment '产品ID',
   `cat_id`                  string             comment '行业ID',
   `shop_id`                  string             comment '店铺ID',
   `brand_name`               string             comment '所属品牌',

   `review_add_1day`             bigint             comment '近1天新增评论数',
   `review_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',

   `review_count_7day`           bigint             comment '近7天评论总数',
   `review_avg_7day`       bigint             comment '近7天平均评论数',
   `review_addRate_7day`      decimal(10,2)      comment '近7天评论增长率',

   `review_count_30day`           bigint             comment '近30天评论总数',
   `review_addRate_30day`      decimal(10,2)      comment '近30天评论增长率',

   `review_count`               bigint             comment '累计评论总数',
   `original_price`           decimal(10,2)      comment '原始价格',
   `sale_price`                    decimal(10,2)      comment '折扣价格',

   `carriage`                  decimal(6,2)       comment '运费',
   `item_score`               decimal(3,2)       comment '产品评分(平均星级)',

   `create_time`               string             comment '创建时间'
)comment '产品分析-新加坡产品展示表（产品详细信息，销售数据明细，店铺商品列表，行业产品）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_item_s2/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_item_s3                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_item_s3`
(
    `id`                       string             comment '主键',
   `item_id`                  string             comment '产品ID',
   `cat_id`                  string             comment '行业ID',
   `shop_id`                  string             comment '店铺ID',
   `brand_name`               string             comment '所属品牌',

   `review_add_1day`             bigint             comment '近1天新增评论数',
   `review_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',

   `review_count_7day`           bigint             comment '近7天评论总数',
   `review_avg_7day`       bigint             comment '近7天平均评论数',
   `review_addRate_7day`      decimal(10,2)      comment '近7天评论增长率',

   `review_count_30day`           bigint             comment '近30天评论总数',
   `review_addRate_30day`      decimal(10,2)      comment '近30天评论增长率',

   `review_count`               bigint             comment '累计评论总数',
   `original_price`           decimal(10,2)      comment '原始价格',
   `sale_price`                    decimal(10,2)      comment '折扣价格',

   `carriage`                  decimal(6,2)       comment '运费',
   `item_score`               decimal(3,2)       comment '产品评分(平均星级)',

   `create_time`               string             comment '创建时间'
)comment '产品分析-菲律宾产品展示表（产品详细信息，销售数据明细，店铺商品列表，行业产品）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_item_s3/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_item_s4                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_item_s4`
(
   `id`                       string             comment '主键',
   `item_id`                  string             comment '产品ID',
   `cat_id`                  string             comment '行业ID',
   `shop_id`                  string             comment '店铺ID',
   `brand_name`               string             comment '所属品牌',

   `review_add_1day`             bigint             comment '近1天新增评论数',
   `review_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',

   `review_count_7day`           bigint             comment '近7天评论总数',
   `review_avg_7day`       bigint             comment '近7天平均评论数',
   `review_addRate_7day`      decimal(10,2)      comment '近7天评论增长率',

   `review_count_30day`           bigint             comment '近30天评论总数',
   `review_addRate_30day`      decimal(10,2)      comment '近30天评论增长率',

   `review_count`               bigint             comment '累计评论总数',
   `original_price`           decimal(10,2)      comment '原始价格',
   `sale_price`                    decimal(10,2)      comment '折扣价格',

   `carriage`                  decimal(6,2)       comment '运费',
   `item_score`               decimal(3,2)       comment '产品评分(平均星级)',

   `create_time`               string             comment '创建时间'
)comment '产品分析-泰国产品展示表（产品详细信息，销售数据明细，店铺商品列表，行业产品）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_item_s4/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_item_s5                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_item_s5`
(
   `id`                       string             comment '主键',
   `item_id`                  string             comment '产品ID',
   `cat_id`                  string             comment '行业ID',
   `shop_id`                  string             comment '店铺ID',
   `brand_name`               string             comment '所属品牌',

   `review_add_1day`             bigint             comment '近1天新增评论数',
   `review_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',

   `review_count_7day`           bigint             comment '近7天评论总数',
   `review_avg_7day`       bigint             comment '近7天平均评论数',
   `review_addRate_7day`      decimal(10,2)      comment '近7天评论增长率',

   `review_count_30day`           bigint             comment '近30天评论总数',
   `review_addRate_30day`      decimal(10,2)      comment '近30天评论增长率',

   `review_count`               bigint             comment '累计评论总数',
   `original_price`           decimal(10,2)      comment '原始价格',
   `sale_price`                    decimal(10,2)      comment '折扣价格',

   `carriage`                  decimal(6,2)       comment '运费',
   `item_score`               decimal(3,2)       comment '产品评分(平均星级)',

   `create_time`               string             comment '创建时间'
)comment '产品分析-越南产品展示表（产品详细信息，销售数据明细，店铺商品列表，行业产品）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_item_s5/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: app_rpt_item_s6                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_item_s6`
(
   `id`                       string             comment '主键',
   `item_id`                  string             comment '产品ID',
   `cat_id`                  string             comment '行业ID',
   `shop_id`                  string             comment '店铺ID',
   `brand_name`               string             comment '所属品牌',

   `review_add_1day`             bigint             comment '近1天新增评论数',
   `review_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',

   `review_count_7day`           bigint             comment '近7天评论总数',
   `review_avg_7day`       bigint             comment '近7天平均评论数',
   `review_addRate_7day`      decimal(10,2)      comment '近7天评论增长率',

   `review_count_30day`           bigint             comment '近30天评论总数',
   `review_addRate_30day`      decimal(10,2)      comment '近30天评论增长率',

   `review_count`               bigint             comment '累计评论总数',
   `original_price`           decimal(10,2)      comment '原始价格',
   `sale_price`                    decimal(10,2)      comment '折扣价格',

   `carriage`                  decimal(6,2)       comment '运费',
   `item_score`               decimal(3,2)       comment '产品评分(平均星级)',

   `create_time`               string             comment '创建时间'
)comment '产品分析-印度尼西亚产品展示表（产品详细信息，销售数据明细，店铺商品列表，行业产品）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_item_s6/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_site_item_total                                       */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_total`
(
   `id`                               string              comment '主键',
   `site_id`                          string              comment '站点ID(默认为0意思是全站）',  
   `shop_type`                        string              comment '店铺类型(0.全站,1.普通,2.官方(旗舰+认证),,3.淘宝)',

   `item_count`                       bigint              comment '产品总数',
   `item_acco`                decimal(5,2)        comment '产品总数占比 [各店铺类型/全站]',
   `item_addRate_1day`               decimal(10,2)       comment '近1天产品增长率 [(T期该店类品总数-(T-1)期该店类品总数)/(T-1)期该店类品总数]',

   `itemReviewType_count`                  bigint              comment '有评论产品总数',
   `itemReviewType_acco`                   decimal(5,2)        comment '有评论产品总数占比 [各店铺类型/全站]',
   `itemReviewType_addRate_1day`            decimal(10,2)       comment '近1天有评论产品增长率 [(T期该店类品总数-(T-1)期该店类品总数)/(T-1)期该店类品总数]',

   `newItem_count_7day`             bigint              comment '近7天上新产品总数',
   `newItem_acco_7day`              decimal(5,2)        comment '近7天上新产品总数占比',
   `newItem_addRate_7day`       decimal(10,2)       comment '近7天上新产品增长率',

   `newItem_count_30day`              bigint     comment '近30天上新产品总数',
   `newItem_acco_30day`              decimal(5,2)        comment '近30天上新产品总数占比',
   `newItem_addRate_30day`       decimal(10,2)       comment '近30天上新产品增长率',



   `newitemReviewType_count_7day`        bigint              comment '近7天上新有评论产品总数',
   `newitemReviewType_acco_7day`         decimal(5,2)        comment '近7天上新有评论产品总数占比',
   `newitemReviewType_addRate_7day`        decimal(10,2)       comment '近7天上新有评论产品增长率',

   `newitemReviewType_count_30day`        bigint              comment '近30天上新有评论产品总数',
   `newitemReviewType_acco_30day`         decimal(5,2)        comment '近30天上新有评论产品总数占比',
   `newitemReviewType_addRate_30day`        decimal(10,2)       comment '近30天上新有评论产品增长率',


   `review_count_7day`                 bigint              comment '近7天评论总数',
   `review_acco_7day`                  decimal(5,2)        comment '近7天评论总数占比',
   `review_addRate_7day`           decimal(10,2)       comment '近7天评论数增长率',

  `review_count_30day`                 bigint              comment '近30天评论数',
   `review_acco_30day`                  decimal(5,2)        comment '近30天评论数总数占比',
   `review_addRate_30day`           decimal(10,2)       comment '近30天评论数增长率',

   `review_avg_7day`                  bigint              comment '近7天平均评论数',
   `review_avg_acco_7day`              decimal(5,2)        comment '近7天平均评论数总数占比',
   `review_avg_addRate_7day`       decimal(10,2)       comment '近7天平均评论数增长率',



   `item_avgReviewRate_7day`               decimal(10,2)       comment '近7天平均产品评论率(动销率) [7天有评论的产品数/7天总产品数/7]',
   `item_avgReviewRate_acco_7day`          decimal(5,2)        comment '近7天平均产品评论率占比 [各店铺类型/全站]',
   `item_avgReviewRate_addRate_7day`         decimal(10,2)       comment '近7天平均产品评论率的增长率 [(T期该店类总率-(T-1)期该店类总率)/(T-1)期该店类总率]',


   `create_time`                       string              comment '创建时间'
)comment '全站/分站-产品分析-产品统计'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_item_total/'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: app_rpt_site_item_week_reviews                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_week_reviews`
(
   `id`                      string          comment '主键',
   `site_id`                 string          comment '站点ID(默认为0就是全站的意思）',
   `7dayReview_set`         string           comment '7天平均评论数区间(1.1-10,2.11-30,3.31-50,4.51-100,5.101-200,6.201-300,7.301+~ )',
  `item_count`             bigint            comment '区间对应的产品总数',
   `item_acco`                 decimal(5,2)     comment '区间对应的产品总数占比 [每项区间的产品总数/总产品数]',
   `shop_count`                bigint          comment '区间对应的店铺总数',
   `shop_acco`                    decimal(5,2)    comment '区间对应的店铺总数占比 [每项区间的店铺总数/总店铺数]',
   `create_time`              string          comment '创建时间'
)comment '全站/分站-店铺分析/产品分析-产品7日平均评论数分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_item_week_reviews/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_site_cat_overview                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_cat_overview`
(
   `id`                   string              comment '主键',
   `cat_id`          string              comment '行业ID',
   `site_id`              string              comment '站点ID',

   `item_count`           bigint              comment '产品总数',
   `review_count`           bigint              comment '评论总数',
   `item_acco`      decimal(5,2)     comment '产品总数占比 [各个子行业产品总数/父行业总产品数]',
   `review_acco`     decimal(5,2)     comment '评论总数占比 [各个子行业评论总数/父行业总评论数]',

   `item_add_1day`            bigint              comment '近1天新增产品数',
   `review_add_1day`            bigint              comment '近1天新增评论数',
   `itemAdd_acco_1day`            decimal(5,2)        comment '近1天新增产品占比 [各个子行业产品总增量/父行业总增量]',
   `review_acco_1day`            decimal(5,2)        comment '近1天新增评论占比',

   `item_add_7day`      bigint              comment '近7天新增产品数',
   `review_add_7day`      bigint              comment '近7天新增评论数',
   `itemAdd_acco_7day`      decimal(5,2)        comment '近7天新增产品占比',
   `review_acco_7day`      decimal(5,2)        comment '近7天新增评论占比',

   `item_add_30day`      bigint              comment '近30天新增产品数',
   `review_add_30ay`      bigint              comment '近30天新增评论数',
   `itemAdd_acco_30day`      decimal(5,2)        comment '近30天新增产品占比',
   `review_acco_30day`      decimal(5,2)        comment '近30天新增评论占比',

   `create_time`           string              comment '创建时间'
)comment '分站-行业分析-行业概况'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_cat_overview/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_cat_potential                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_cat_potential`
(
   `id`                      string    comment '主键',
   `cat_id`                  string    comment '行业ID',
   `site_id`                 string    comment '站点ID',

   `parent_cat_id`           string    comment '父行业ID',

   `cat_potential`           bigint    comment '行业潜力值 [该子类目总评论数/该子类目总产品数]',
   `create_time`             string    comment '创建时间'
)comment '行业分析-行业详情页-子行业概况-潜力行业'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_cat_potential/'
tblproperties("orc.compress"="SNAPPY");
 



--计算 app_rpt_site_cat_overview 中 group by cat_name ==> 全站的行业名
/*==============================================================*/
/* Table: app_rpt_site_cat_root                                    */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_cat_root`
(
   `id`                   string            comment '主键',
   `cat_name`        string            comment '行业名称',

   `item_count`           bigint              comment '产品总数',
   `review_count`           bigint              comment '评论总数',
   `item_acco`      decimal(5,2)     comment '产品总数占比 [各个子行业产品总数/父行业总产品数]',
   `review_acco`     decimal(5,2)     comment '评论总数占比 [各个子行业评论总数/父行业总评论数]',

   `item_add_1day`            bigint              comment '近1天新增产品数',
   `review_add_1day`            bigint              comment '近1天新增评论数',
   `itemAdd_acco_1day`            decimal(5,2)        comment '近1天新增产品占比 [各个子行业产品总增量/父行业总增量]',
   `review_acco_1day`            decimal(5,2)        comment '近1天新增评论占比',

   `item_add_7day`      bigint              comment '近7天新增产品数',
   `review_add_7day`      bigint              comment '近7天新增评论数',
   `itemAdd_acco_7day`      decimal(5,2)        comment '近7天新增产品占比',
   `review_acco_7day`      decimal(5,2)        comment '近7天新增评论占比',

   `item_add_30day`      bigint              comment '近30天新增产品数',
   `review_add_30ay`      bigint              comment '近30天新增评论数',
   `itemAdd_acco_30day`      decimal(5,2)        comment '近30天新增产品占比',
   `review_acco_30day`      decimal(5,2)        comment '近30天新增评论占比',

   `create_time`           string            comment '创建时间'
)comment '全站-行业分析-一级行业概况'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_cat_root/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_shop                                           */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_shop`
(
   `id`                          string            comment '主键',
   `site_id`                     string            comment '站点ID',
   `shop_id`                     string            comment '店铺ID',

   `item_count`                    bigint            comment '产品总数',
   `sale_price_avg`                   decimal(10,2)     comment '折扣均价 [折扣价总数/折扣产品总数]',
   `original_price_avg`               decimal(10,2)     comment '原价均价 [原价总数/原价产品总数]',

   `review_count`                  bigint            comment '评论总数',
   
   `praise_rate`                 decimal(5,2)        comment '好评率',
   `praise_count`                  bigint            comment '好评数',
   `average_count`                bigint            comment '中评数',
   `negative_count`               bigint            comment '差评数',

   `review_avg_7day`          bigint            comment '7天平均评论数 [7天评论总数/7]',

   
   `review_addRate_1day`          decimal(10,2)     comment '近1天评论增长率',
   `item_reviewRate_1day`              decimal(5,2)      comment '近1天产品评论率',

   `itemReviewType_salePrice_avg`         decimal(10,2)     comment '有评论产品折扣均价',
   `itemReviewType_origPrice_avg`     decimal(10,2)     comment '有评论产品原价均价',

   `item_add_1day`                 bigint            comment '近1天新增产品数',
   `itemReviewType_add_1day`       bigint            comment '近1天新增有评论产品数',
   `itemReviewType_count`          bigint            comment '有评论产品总数',

   `review_addRate_7day`     decimal(10,2)     comment '近7天评论增长率',
   `review_count`                bigint            comment '评论总数',

   `onTimeDelivery_rate`       decimal(5,2)      comment '准时送达率',
   `create_time`                  string            comment '创建时间'
)comment '店铺分析-店铺展示表（店铺搜索，行业店铺）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_shop/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_site_cat_name_reviews                             */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_cat_name_reviews`
(
   `id`                   string            comment '主键',
   `cat_name`           string            comment '行业名称',


   `shop_count`           bigint              comment '店铺总数',
   `review_count`           bigint              comment '评论总数',
   `shop_acco`      decimal(5,2)      comment '店铺总数占比 [各个子行业店铺总数/父行业总店铺数]',
   `review_acco`     decimal(5,2)     comment '评论总数占比 [各个子行业评论总数/父行业总评论数]',

   `shop_add_1day`            bigint              comment '近1天新增店铺数',
   `review_add_1day`            bigint              comment '近1天新增评论数',
   `shop_acco_1day`            decimal(5,2)        comment '近1天新增店铺占比 [各个子行业店铺总增量/父行业总增量]',
   `review_acco_1day`            decimal(5,2)        comment '近1天新增评论占比',

   `shop_add_7day`      bigint              comment '近7天新增店铺数',
   `review_add_7day`      bigint              comment '近7天新增评论数',
   `shop_acco_7day`      decimal(5,2)        comment '近7天新增店铺占比',
   `review_acco_7day`      decimal(5,2)        comment '近7天新增评论占比',

   `shop_add_30day`      bigint              comment '近30天新增店铺数',
   `review_add_30ay`      bigint              comment '近30天新增评论数',
   `shop_acco_30day`      decimal(5,2)        comment '近30天新增店铺占比',
   `review_acco_30day`      decimal(5,2)        comment '近30天新增评论占比',


   `create_time`           string            comment '创建时间'
)comment '全站-店铺分析-店铺行业评论数分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_cat_name_reviews/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_site_shop_cat_id_reviews                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_shop_cat_id_reviews`
(
   `id`                  string               comment '主键',
   `cat_id`              string               comment '行业ID',
   `site_id`             string               comment '站点ID',

   `shop_count`           bigint              comment '店铺总数',
   `review_count`           bigint              comment '评论总数',
   `shop_acco`      decimal(5,2)     comment '店铺总数占比 [各个子行业店铺总数/父行业总店铺数]',
   `review_acco`     decimal(5,2)     comment '评论总数占比 [各个子行业评论总数/父行业总评论数]',

   `shop_add_1day`            bigint              comment '近1天新增店铺数',
   `review_add_1day`            bigint              comment '近1天新增评论数',
   `shop_acco_1day`            decimal(5,2)        comment '近1天新增店铺占比 [各个子行业店铺总增量/父行业总增量]',
   `review_acco_1day`            decimal(5,2)        comment '近1天新增评论占比',

   `shop_add_7day`      bigint              comment '近7天新增店铺数',
   `review_add_7day`      bigint              comment '近7天新增评论数',
   `shop_acco_7day`      decimal(5,2)        comment '近7天新增店铺占比',
   `review_acco_7day`      decimal(5,2)        comment '近7天新增评论占比',

   `shop_add_30day`      bigint              comment '近30天新增店铺数',
   `review_add_30ay`      bigint              comment '近30天新增评论数',
   `shop_acco_30day`      decimal(5,2)        comment '近30天新增店铺占比',
   `review_acco_30day`      decimal(5,2)        comment '近30天新增评论占比',

   `create_time`          string               comment '创建时间'
)comment '分站-店铺分析-店铺行业评论数分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_shop_cat_id_reviews/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_shop_info                                      */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_shop_info`
(
   `id`                            string                comment '主键',
   `site_id`                       string                comment '站点ID',
   `shop_id`                       string                comment '店铺ID',
   `item_count`                      bigint                comment '产品总数',
   `itemReviewType_salePrice_avg`     decimal(10,2)         comment '有评论产品折扣均价',
   `item_reviewRate_1day`             decimal(5,2)          comment '近1天产品评论率 [有评论的产品数/总产品数]',

   `itemReviewType_count`                 bigint                comment '有评论产品总数',
   `praise_rate`                   decimal(5,2)          comment '好评率',
   `original_price_avg`                 decimal(10,2)         comment '原价均价 [原价总数/原价产品总数]',
   `sale_price_avg`                     decimal(10,2)         comment '折扣均价 [折扣价总数/折扣产品总数]',

   `onTimeDelivery_rate`         decimal(5,2)          comment '准时送达率',

   `cat_1d_name`                 string                comment '主营行业(一级类目)',
   `review_count`                    bigint                comment '评论总数',

   `newItem_ave_7day`        bigint                comment '近7天平均上新产品数',

   `chatResp_rate`            decimal(5,2)          comment '聊天回复率',

   `create_time`                    string                comment '创建时间'
)comment '店铺分析-店铺详情页-店铺信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_shop_info/'
tblproperties("orc.compress"="SNAPPY");




-- todo 店铺类型数量有变化
/*==============================================================*/
/* Table: app_rpt_site_shop_trend                                       */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_shop_trend`
(
   `id`                   string      comment '主键',
   `site_id`              string      comment '站点ID（默认为0意思是全站）',

   `sellerShop_count`         bigint      comment '普通店铺数量',
   `officShop_count`         bigint      comment '官方店铺数量 [官方店 = off旗舰店 + certi认证店]',
   `tbcShop_count`         bigint      comment '淘宝店铺数量',

   `create_time`           string      comment '创建时间'
)comment '全站/分站-店铺分析-店铺数量趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_shop_trend/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_shop_sales                            */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_shop_sales`
(
   `id`                            string           comment '主键',
   `shop_id`                       string           comment '店铺ID',
   `site_id`                       string           comment '站点ID',

   `original_price_avg`                 decimal(10,2)    comment '原价均价',
   `sale_price_avg`                     decimal(10,2)    comment '折扣价均价',
   `itemReviewType_salePrice_avg`           decimal(10,2)    comment '有评论产品折扣均价',
   `itemReviewType_origPrice_avg`       decimal(10,2)    comment '有评论产品原价均价',
 
   `item_count`                      bigint           comment '产品总数',
   `item_add_1day`              bigint           comment '近1天新增产品数',
   `itemReviewType_add_1day`         bigint           comment '近1天新增有评论产品数',


   `itemReviewType_count`                 bigint           comment '有评论产品总数',
   `review_count`                    bigint           comment '评论总数',

   `review_avg_7day`            bigint           comment '近7天平均评论数',

   `review_addRate_7day`    decimal(10,2)    comment '近7天评论增长率  [(T期总评论数-(T-1)期总评论数)/(T-1)期总评论数]',

   `newItem_ave_7day`        bigint           comment '近7天平均上新产品数',

   
   `item_reviewRate_1day`                decimal(5,2)     comment '近1天产品评论率 [有评论的产品数/总产品数]',
   `praise_num`                    bigint           comment '好评数',
   `average_count`                  bigint           comment '中评数',
   `negative_count`                 bigint           comment '差评数',

   `create_time`                    string           comment '创建时间'
)comment '店铺分析-店铺详情页-店铺概览-店铺销售数据明细'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_shop_sales/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_site_shop_type_percent                                 */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_shop_type_percent`
(
   `id`                   string           comment '主键',
   `site_id`              string           comment '站点ID',
   `shop_type`            string           comment '店铺类型(0.全站,1.普通,2.官方(旗舰+认证),,3.淘宝)',

   `shop_count_1day`         bigint           comment '近1天店铺总数',
   `shop_count_7day`       bigint           comment '近7天店铺总数',
   `shop_count_30day`       bigint           comment '近30天店铺总数',

   `shop_acco_1day`             decimal(5,2)     comment '近1天店铺总数占比 [各站点该店类的店铺总数/全站该店类的店铺总数]',
   `shop_acco_7day`           decimal(5,2)     comment '近7天店铺总数占比',
   `shop_acco_30day`           decimal(5,2)     comment '近30天店铺总数占比',

   `create_time`           string           comment '创建时间'
)comment '全站-店铺分析-各站点店铺类型占比图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_shop_type_percent/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_sku_reviews_star                              */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_sku_reviews_star`
(
   `id`                   string            comment '主键',
   `site_id`              string            comment '站点ID',
   `sku_id`               string            comment 'skuID',

   `review_count`           bigint            comment '评论总数',

   `skuStar_avg`         decimal(3,2)      comment 'sku平均星级 [sku的所有星级分数之和/sku总条数]',

   `one_star`             bigint            comment '一星',
   `two_star`             bigint            comment '二星',
   `three_star`           bigint            comment '三星',
   `four_star`            bigint            comment '四星',
   `five_star`            bigint            comment '五星',
   `create_time`           string            comment '创建时间'
)comment '产品分析-产品详情页-产品sku分析-SKU评论数的星级分布表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_sku_reviews_star/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_sku_trend                                      */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_sku_trend`
(
   `id`                   string            comment '主键',
   `site_id`              string            comment '站点ID',
   `sku_id`               string            comment 'skuID',

   `original_price`       decimal(10,2)        comment 'SKU原价',
   `sale_price`           decimal(10,2)     comment 'SKU折扣价',
   `review_count`         bigint            comment '评论总数',

   `inventory_count`            bigint            comment '库存总数(即每个sku下的商品总数)',
   `inventory_add_1day`        bigint            comment '近1天新增库存总数',
   `inventory_add_7day`      bigint            comment '近7天新增库存总数',
   `inventory_add_30day`      bigint            comment '近30天新增库存总数',

   `create_time`           string            comment '创建时间'
)comment '产品分析-产品详情页-产品sku分析-SKU趋势图表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_sku_trend/'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: app_rpt_site_shop_total                                   */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_shop_total`
(
   `id`                         string              comment '主键',
   `site_id`                    string              comment '站点ID (默认为0就是全站)',
   `shop_type`                  string              comment '店铺类型(0.全站,1.普通,2.官方(旗舰+认证),,3.淘宝)',

   `shop_count`                 bigint              comment '店铺总数',
   `shop_acco`                  decimal(5,2)        comment '店铺总数占比',
   `shop_addRate_1day`      decimal(10,2)       comment '近1天店铺增长率',

   `shopReviewType_count`        bigint              comment '有评论店铺总数',
   `shopReviewType_acco`             decimal(5,2)        comment '有评论店铺总数占比',
   `shopReviewType_addRate_1day`           decimal(10,2)       comment '近1天有评论店铺增长率',

   `shop_add_7day`       bigint              comment '近7天新增店铺数',
   `shopAdd_acco_7day`        decimal(5,2)        comment '近7天新增店铺数占比',
   `shop_addRate_7day`      decimal(10,2)       comment '7日新增店铺增长率',

   `create_time`                 string              comment '创建时间'
)comment '全站/分站-店铺分析-店铺统计'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_shop_total/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_cat_yest_top10                               */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_cat_yest_top10`
(
   `id`                   string          comment '主键',
   `cat_id`               string          comment '行业ID',
   `site_id`              string          comment '站点ID',

   `item_count`           bigint          comment '产品总数',
   `itemReviewType_count`      bigint          comment '有评论产品总数',
   `review_count`             bigint          comment '评论总数',

   `review_addRate_1day`         decimal(10,2)   comment '近1天评论增长率 [(T期评论总数-(T-1)期评论总数)/(T-1)期评论总数]',
   `review_acco`        decimal(5,2)    comment '评论总数占比 [子行业评论数/父行业评论总数]',

   `shop_count`             bigint          comment '店铺总数',
   `create_time`           string          comment '创建时间'
)comment '行业分析-行业详情页-子行业概况-昨日top10行业'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_cat_yest_top10/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_sku_sell_top5                         */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_sku_sell_top5`
(
   id                   string    comment '主键',
   item_id              string    comment '产品ID',
   site_id              string    comment '站点ID',
   sku_key              string    comment 'SKU名称的键',
   sku_value            string    comment 'SKU名称的值',
   review_count              bigint    comment '评论总数',
   create_time          string    comment '创建时间'
)comment '产品分析-产品详情页-产品sku分析-SKU热销top5'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_sku_sell_top5/'
tblproperties("orc.compress"="SNAPPY");








/*==============================================================*/
/* Table: app_rpt_data_timest                                    */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_data_timest`
(
   id                  string     comment '主键',
   table_name          string     comment '表名',
   timest              string     comment '数据账期',
   create_time          string    comment '创建时间',
   gmt_modified        string     comment '修改时间'
)comment '各表数据账期'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_data_timest/'
tblproperties("orc.compress"="SNAPPY");


