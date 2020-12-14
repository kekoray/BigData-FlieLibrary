

/*==============================================================*/
/*   Description :  app层的建表语句                              */
/*   FileName :   create_app_table.sql                          */
/*   Version  :   3.0                                           */
/*   Author   :   Koray                                         */
/*   Date     :   2020-11-19                                    */
/*   Company  :   menglar                                       */
/*==============================================================*/




/*==============================================================*/
/* Table: app_rpt_cat_contrast                                   */
/*==============================================================*/

create external table if not exists `lazada_dw.app_rpt_cat_contrast`
(
   `id`                          string             comment  '主键',
   `cat_id`                      string             comment  '行业ID',
   `site_id`                     string             comment  '站点ID',
   `shop_count`                  bigint             comment  '店铺总数',
   `item_count`                  bigint             comment  '产品总数',
   `review_count`                bigint             comment  '评论总数',
   `review_add_1day`             bigint             comment  '近1天新增评论数 [新增评论数之和]',
   `item_add_1day`               bigint             comment  '近1天新增产品数 [新增产品数之和]',
   `shop_add_1day`               bigint             comment  '近1天新增店铺数 [新增店铺数之和]',
   `orig_price_avg_1day`         decimal(15,2)      comment  '近1天原价均价 (行业均价) [原价的总销售额/总评论数(销售量)]',
   `sale_price_avg_1day`         decimal(15,2)      comment  '近1天折扣均价 (行业均价) [折扣价的总销售额/总评论数(销售量)]',
   `item_reviewRate_1day`        decimal(10,2)      comment  '近1天产品评论率 [有评论的产品数/总产品数]',
   `reviewAdd_addRate_1day`      decimal(10,2)      comment  '近1天评论增长率 [(T周期总评论数-(T-1)周期评论数)/(T-1)周期总评论数]',
   `itemAdd__avg_1day`           bigint             comment  '近1天平均新增产品数 [新增产品数之和/总时间]',
   `reviewAdd_avg_1day`          bigint             comment  '近1天平均新增评论数 [评论数之和/总时间]',
   `review_add_7day`             bigint             comment  '近7天新增评论数',
   `item_add_7day`               bigint             comment  '近7天新增产品数',
   `shop_add_7day`               bigint             comment  '近7天新增店铺数',
   `orig_price_avg_7day`         decimal(15,2)      comment  '近7天原价均价 (行业均价)',
   `sale_price_avg_7day`         decimal(15,2)      comment  '近7天折扣均价 (行业均价)',
   `item_reviewRate_7day`        decimal(10,2)      comment  '近7天产品评论率',
   `reviewAdd_addRate_7day`      decimal(10,2)      comment  '近7天评论增长率',
   `itemAdd__avg_7day`           bigint             comment  '近7天平均新增产品数',
   `reviewAdd_avg_7day`          bigint             comment  '近7天平均新增评论数',
   `review_add_30day`            bigint             comment  '近30天新增评论数',
   `item_add_30day`              bigint             comment  '近30天新增产品数',
   `shop_add_30day`              bigint             comment  '近30天新增店铺数',
   `orig_price_avg_30day`        decimal(15,2)      comment  '近30天原价均价 (行业均价)',
   `sale_price_avg_30day`        decimal(15,2)      comment  '近30天折扣均价 (行业均价)',
   `item_reviewRate_30day`       decimal(10,2)      comment  '近30天产品评论率',
   `reviewAdd_addRate_30day`        decimal(10,2)      comment  '近30天新增评论增长率',
   `itemAdd__avg_30day`          bigint             comment  '近30天平均新增产品数',
   `reviewAdd_avg_30day`            bigint             comment  '近30天平均新增评论数',
   `timest`                      string             comment  '数据账期',
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
   `id`                           string                comment '主键',
   `cat_id`                       string                comment '最小类目id',
   `cat_1d_id`                    string                comment '1级类目ID',
   `cat_2d_id`                    string                comment '2级类目ID',
   `cat_3d_id`                    string                comment '3级类目ID',
   `cat_4d_id`                    string                comment '4级类目ID',
   `cat_5d_id`                    string                comment '5级类目ID',
   `cat_6d_id`                    string                comment '6级类目ID',
   `site_id`                      string                comment '站点ID',
   `shop_count`                   bigint                comment '店铺总数',
   `item_count`                   bigint                comment '产品总数',
   `review_count`                 bigint                comment '评论总数',
   `review_add_1day`              bigint                comment '近1天新增评论数',
   `sale_price_avg`               decimal(15,2)         comment '产品折扣价均价 [所有产品折扣价之和/产品总数]',
   `item_add_1day`                bigint                comment '近1天新增产品数',
   `shop_add_7day`                bigint                comment '近7天新增店铺数',
   `orig_price_avg_7day`          decimal(15,2)         comment '近7天原价均价 (行业均价) [原价的总销售额/总评论数(销售量)]',
   `sale_price_avg_7day`          decimal(15,2)         comment '近7天折扣均价 (行业均价)',
   `item_reviewRate_7day`         decimal(10,2)         comment '近7天产品评论率',
   `reviewAdd_addRate_7day`       decimal(10,2)         comment '近7天新增评论增长率',
   `itemAdd__avg_7day`            bigint                comment '近7天平均新增产品数',
   `reviewAdd_avg_7day`           bigint                comment '近7天平均新增评论数',
   `orig_price_avg_30day`         decimal(15,2)         comment '近30天原价均价 (行业均价) [原价的总销售额/总评论数(销售量)]',
   `sale_price_avg_30day`         decimal(15,2)         comment '近30天折扣均价 (行业均价)',
   `reviewAdd_avg_30day`          bigint                comment '近30天平均新增评论数',
   `reviewAdd_addRate_1day`       decimal(10,2)         comment '近1天新增评论增长率',
   `reviewAdd_addRate_30day`      decimal(10,2)         comment '近30天新增评论增长率',
   `timest`                       string                comment '数据账期',
   `create_time`                  string                comment '创建时间'
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
   `cat_id`                   string           comment '行业ID',
   `site_id`                  string           comment '站点ID',
   `review_count`             bigint           comment '评论总数',
   `review_acco`              decimal(5,2)     comment '评论总数占比 [子行业评论数/父行业评论总数]',
   `item_add_7day`            bigint           comment '近7天新增产品数',
   `item_add_30day`           bigint           comment '近30天新增产品数',
   `itemAdd_acco_7day`        decimal(5,2)     comment '近7天新增产品占比 [子行业新增产品数/父行业新增产品总数]',
   `itemAdd_acco_30day`       decimal(5,2)     comment '近30天新增产品占比',
   `timest`                   string           comment '数据账期',
   `create_time`              string           comment '创建时间'
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
/* Table: app_rpt_site_item_reviews_pct                      */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_reviews_pct`
(
   `id`                      string           comment '主键',
   `site_id`                 string           comment '站点ID',
   `review_count`            bigint           comment '评论总数',
   `review_acco`             decimal(5,2)     comment '评论总数占比 [单站的评论总数/全站的评论总数]',
   `review_add_1day`         bigint           comment '近1天新增评论数',
   `reviewAdd_acco_1day`     decimal(5,2)     comment '近1天新增评论占比',
   `review_add_7day`         bigint           comment '近7天新增评论数',
   `reviewAdd_acco_7day`     decimal(5,2)     comment '近7天新增评论占比',
   `review_add_30day`        bigint           comment '近30天新增评论数',
   `reviewAdd_acco_30day `   decimal(5,2)     comment '近30天新增评论占比',
   `timest`                  string           comment '数据账期',
   `create_time`             string           comment '创建时间'
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
   `timest`           string          comment '数据账期',
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
/* Table: app_rpt_site_item_percent                              */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_percent`
(
   `id`                         string                  comment '主键',
   `site_id`                    string                  comment '站点ID',
   `item_count`                 bigint                  comment '产品总数',
   `item_acco`                  decimal(5,2)            comment '产品总数占比',
   `item_add_1day`              bigint                  comment '近1天新增产品数',
   `itemAdd_acco_1day`          decimal(5,2)            comment '近1天新增产品占比',
   `item_add_7day`              bigint                  comment '近7天新增产品数',
   `itemAdd_acco_7day`          decimal(5,2)            comment '近7天新增产品占比',
   `item_add_30day`             bigint                  comment '近30天新增产品数',
   `itemAdd_acco_30day`         decimal(5,2)            comment '近30天新增产品占比',
   `timest`                     string                  comment '数据账期',
   `create_time`                string                  comment '创建时间'
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
/* Table: app_rpt_site_item_and_reviews                       */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_and_reviews`
(
   `id`                      string      comment '主键',
   `site_id`                 string      comment '站点ID(默认为0就是全站)',
   `item_count`              bigint      comment '产品总数',
   `item_add_1day`           bigint      comment '近1天新增产品数',
   `review_count`            bigint      comment '评论总数',
   `review_add_1day`         bigint      comment '近1天新增评论数',
   `timest`                  string      comment '数据账期',
   `create_time`             string      comment '创建时间'
)comment '全站/分站分析-行业/产品分析-产品数/评价数趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_site_item_and_reviews/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_item_s1                                        */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_item_s1`
(
   `id`                           string             comment '主键',
   `item_id`                      string             comment '产品ID',
   `cat_1d_id`                    string             comment '1级类目ID',
   `cat_2d_id`                    string             comment '2级类目ID',
   `cat_3d_id`                    string             comment '3级类目ID',
   `cat_4d_id`                    string             comment '4级类目ID',
   `cat_5d_id`                    string             comment '5级类目ID',
   `cat_6d_id`                    string             comment '6级类目ID',
   `shop_id`                      string             comment '店铺ID',
   `shop_name`                    string             comment '店铺名字',
   `shop_address`                 string             comment '店铺地址(即产品表的location字段)',
   `shop_type`                    string             comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
   `brand_name`                   string             comment '所属品牌',
   `review_add_1day`              bigint             comment '近1天新增评论数',
   `reviewAdd_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',
   `review_add_7day`              bigint             comment '近7天新增评论总数',
   `reviewAdd_avg_7day`           bigint             comment '近7天平均新增评论数',
   `reviewAdd_addRate_7day`       decimal(10,2)      comment '近7天评论增长率',
   `review_add_30day`             bigint             comment '近30天新增评论总数',
   `reviewAdd_addRate_30day`      decimal(10,2)      comment '近30天新增评论增长率',
   `review_count`                 bigint             comment '累计评论总数',
   `original_price_avg`           decimal(15,2)      comment '原始均价[sku原价相加/sku数量]',
   `sale_price_avg`               decimal(15,2)      comment '折扣均价 [sku折扣价相加/sku数量]',
   `carriage`                     decimal(6,2)       comment '运费',
   `item_score`                   decimal(3,2)       comment '产品评分(平均星级)',
   `itemScore_add_1day`           decimal(3,2)       comment '产品评分较昨日增长 [今新增数-昨新增数]',
   `reviewAdd_quiteAdd_1day`      bigint             comment '新增评价数较昨日增长 [今新增数-昨新增数]',
   `sku_add_1day`                 bigint             comment '近1天的新增sku数量',
   `skuAdd_quiteAdd_1day`         bigint             comment '新增SKU数较昨日增长 [今新增数-昨新增数]',
   `salePriceAvg_add_1day`        decimal(15,2)      comment '折扣均价较昨日增长',
   `timest`                       string             comment '数据账期',
   `create_time`                  string             comment '创建时间'
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
   `id`                           string             comment '主键',
   `item_id`                      string             comment '产品ID',
   `cat_1d_id`                    string             comment '1级类目ID',
   `cat_2d_id`                    string             comment '2级类目ID',
   `cat_3d_id`                    string             comment '3级类目ID',
   `cat_4d_id`                    string             comment '4级类目ID',
   `cat_5d_id`                    string             comment '5级类目ID',
   `cat_6d_id`                    string             comment '6级类目ID',
   `shop_id`                      string             comment '店铺ID',
   `shop_name`                    string             comment '店铺名字',
   `shop_address`                 string             comment '店铺地址',
   `shop_type`                    string             comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
   `brand_name`                   string             comment '所属品牌',
   `review_add_1day`              bigint             comment '近1天新增评论数',
   `reviewAdd_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',
   `review_add_7day`              bigint             comment '近7天新增评论总数',
   `reviewAdd_avg_7day`           bigint             comment '近7天平均新增评论数',
   `reviewAdd_addRate_7day`       decimal(10,2)      comment '近7天评论增长率',
   `review_add_30day`             bigint             comment '近30天新增评论总数',
   `reviewAdd_addRate_30day`      decimal(10,2)      comment '近30天新增评论增长率',
   `review_count`                 bigint             comment '累计评论总数',
   `original_price_avg`           decimal(15,2)      comment '原始均价[sku原价相加/sku数量]',
   `sale_price_avg`               decimal(15,2)      comment '折扣均价 [sku折扣价相加/sku数量]',
   `carriage`                     decimal(6,2)       comment '运费',
   `item_score`                   decimal(3,2)       comment '产品评分(平均星级)',
   `itemScore_add_1day`           decimal(3,2)       comment '产品评分较昨日增长 [今新增数-昨新增数]',
   `reviewAdd_quiteAdd_1day`      bigint             comment '新增评价数较昨日增长 [今新增数-昨新增数]',
   `sku_add_1day`                 bigint             comment '近1天的新增sku数量',
   `skuAdd_quiteAdd_1day`         bigint             comment '新增SKU数较昨日增长 [今新增数-昨新增数]',
   `salePriceAvg_add_1day`        decimal(15,2)      comment '折扣均价较昨日增长',
   `timest`                       string             comment '数据账期',
   `create_time`                  string             comment '创建时间'
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
   `id`                           string             comment '主键',
   `item_id`                      string             comment '产品ID',
   `cat_1d_id`                    string             comment '1级类目ID',
   `cat_2d_id`                    string             comment '2级类目ID',
   `cat_3d_id`                    string             comment '3级类目ID',
   `cat_4d_id`                    string             comment '4级类目ID',
   `cat_5d_id`                    string             comment '5级类目ID',
   `cat_6d_id`                    string             comment '6级类目ID',
   `shop_id`                      string             comment '店铺ID',
   `shop_name`                    string             comment '店铺名字',
   `shop_address`                 string             comment '店铺地址',
   `shop_type`                    string             comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
   `brand_name`                   string             comment '所属品牌',
   `review_add_1day`              bigint             comment '近1天新增评论数',
   `reviewAdd_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',
   `review_add_7day`              bigint             comment '近7天新增评论总数',
   `reviewAdd_avg_7day`           bigint             comment '近7天平均新增评论数',
   `reviewAdd_addRate_7day`       decimal(10,2)      comment '近7天评论增长率',
   `review_add_30day`             bigint             comment '近30天新增评论总数',
   `reviewAdd_addRate_30day`      decimal(10,2)      comment '近30天新增评论增长率',
   `review_count`                 bigint             comment '累计评论总数',
   `original_price_avg`           decimal(15,2)      comment '原始均价[sku原价相加/sku数量]',
   `sale_price_avg`               decimal(15,2)      comment '折扣均价 [sku折扣价相加/sku数量]',
   `carriage`                     decimal(6,2)       comment '运费',
   `item_score`                   decimal(3,2)       comment '产品评分(平均星级)',
   `itemScore_add_1day`           decimal(3,2)       comment '产品评分较昨日增长 [今新增数-昨新增数]',
   `reviewAdd_quiteAdd_1day`      bigint             comment '新增评价数较昨日增长 [今新增数-昨新增数]',
   `sku_add_1day`                 bigint             comment '近1天的新增sku数量',
   `skuAdd_quiteAdd_1day`         bigint             comment '新增SKU数较昨日增长 [今新增数-昨新增数]',
   `salePriceAvg_add_1day`        decimal(15,2)      comment '折扣均价较昨日增长',
   `timest`                       string             comment '数据账期',
   `create_time`                  string             comment '创建时间'
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
    `id`                           string             comment '主键',
   `item_id`                      string             comment '产品ID',
   `cat_1d_id`                    string             comment '1级类目ID',
   `cat_2d_id`                    string             comment '2级类目ID',
   `cat_3d_id`                    string             comment '3级类目ID',
   `cat_4d_id`                    string             comment '4级类目ID',
   `cat_5d_id`                    string             comment '5级类目ID',
   `cat_6d_id`                    string             comment '6级类目ID',
   `shop_id`                      string             comment '店铺ID',
   `shop_name`                    string             comment '店铺名字',
   `shop_address`                 string             comment '店铺地址',
   `shop_type`                    string             comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
   `brand_name`                   string             comment '所属品牌',
   `review_add_1day`              bigint             comment '近1天新增评论数',
   `reviewAdd_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',
   `review_add_7day`              bigint             comment '近7天新增评论总数',
   `reviewAdd_avg_7day`           bigint             comment '近7天平均新增评论数',
   `reviewAdd_addRate_7day`       decimal(10,2)      comment '近7天评论增长率',
   `review_add_30day`             bigint             comment '近30天新增评论总数',
   `reviewAdd_addRate_30day`      decimal(10,2)      comment '近30天新增评论增长率',
   `review_count`                 bigint             comment '累计评论总数',
   `original_price_avg`           decimal(15,2)      comment '原始均价[sku原价相加/sku数量]',
   `sale_price_avg`               decimal(15,2)      comment '折扣均价 [sku折扣价相加/sku数量]',
   `carriage`                     decimal(6,2)       comment '运费',
   `item_score`                   decimal(3,2)       comment '产品评分(平均星级)',
   `itemScore_add_1day`           decimal(3,2)       comment '产品评分较昨日增长 [今新增数-昨新增数]',
   `reviewAdd_quiteAdd_1day`      bigint             comment '新增评价数较昨日增长 [今新增数-昨新增数]',
   `sku_add_1day`                 bigint             comment '近1天的新增sku数量',
   `skuAdd_quiteAdd_1day`         bigint             comment '新增SKU数较昨日增长 [今新增数-昨新增数]',
   `salePriceAvg_add_1day`        decimal(15,2)      comment '折扣均价较昨日增长',
   `timest`                       string             comment '数据账期',
   `create_time`                  string             comment '创建时间'
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
   `id`                           string             comment '主键',
   `item_id`                      string             comment '产品ID',
   `cat_1d_id`                    string             comment '1级类目ID',
   `cat_2d_id`                    string             comment '2级类目ID',
   `cat_3d_id`                    string             comment '3级类目ID',
   `cat_4d_id`                    string             comment '4级类目ID',
   `cat_5d_id`                    string             comment '5级类目ID',
   `cat_6d_id`                    string             comment '6级类目ID',
   `shop_id`                      string             comment '店铺ID',
   `shop_name`                    string             comment '店铺名字',
   `shop_address`                 string             comment '店铺地址',
   `shop_type`                    string             comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
   `brand_name`                   string             comment '所属品牌',
   `review_add_1day`              bigint             comment '近1天新增评论数',
   `reviewAdd_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',
   `review_add_7day`              bigint             comment '近7天新增评论总数',
   `reviewAdd_avg_7day`           bigint             comment '近7天平均新增评论数',
   `reviewAdd_addRate_7day`       decimal(10,2)      comment '近7天评论增长率',
   `review_add_30day`             bigint             comment '近30天新增评论总数',
   `reviewAdd_addRate_30day`      decimal(10,2)      comment '近30天新增评论增长率',
   `review_count`                 bigint             comment '累计评论总数',
   `original_price_avg`           decimal(15,2)      comment '原始均价[sku原价相加/sku数量]',
   `sale_price_avg`               decimal(15,2)      comment '折扣均价 [sku折扣价相加/sku数量]',
   `carriage`                     decimal(6,2)       comment '运费',
   `item_score`                   decimal(3,2)       comment '产品评分(平均星级)',
   `itemScore_add_1day`           decimal(3,2)       comment '产品评分较昨日增长 [今新增数-昨新增数]',
   `reviewAdd_quiteAdd_1day`      bigint             comment '新增评价数较昨日增长 [今新增数-昨新增数]',
   `sku_add_1day`                 bigint             comment '近1天的新增sku数量',
   `skuAdd_quiteAdd_1day`         bigint             comment '新增SKU数较昨日增长 [今新增数-昨新增数]',
   `salePriceAvg_add_1day`        decimal(15,2)      comment '折扣均价较昨日增长',
   `timest`                       string             comment '数据账期',
   `create_time`                  string             comment '创建时间'
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
   `id`                           string             comment '主键',
   `item_id`                      string             comment '产品ID',
   `cat_1d_id`                    string             comment '1级类目ID',
   `cat_2d_id`                    string             comment '2级类目ID',
   `cat_3d_id`                    string             comment '3级类目ID',
   `cat_4d_id`                    string             comment '4级类目ID',
   `cat_5d_id`                    string             comment '5级类目ID',
   `cat_6d_id`                    string             comment '6级类目ID',
   `shop_id`                      string             comment '店铺ID',
   `shop_name`                    string             comment '店铺名字',
   `shop_address`                 string             comment '店铺地址',
   `shop_type`                    string             comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
   `brand_name`                   string             comment '所属品牌',
   `review_add_1day`              bigint             comment '近1天新增评论数',
   `reviewAdd_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',
   `review_add_7day`              bigint             comment '近7天新增评论总数',
   `reviewAdd_avg_7day`           bigint             comment '近7天平均新增评论数',
   `reviewAdd_addRate_7day`       decimal(10,2)      comment '近7天评论增长率',
   `review_add_30day`             bigint             comment '近30天新增评论总数',
   `reviewAdd_addRate_30day`      decimal(10,2)      comment '近30天新增评论增长率',
   `review_count`                 bigint             comment '累计评论总数',
   `original_price_avg`           decimal(15,2)      comment '原始均价[sku原价相加/sku数量]',
   `sale_price_avg`               decimal(15,2)      comment '折扣均价 [sku折扣价相加/sku数量]',
   `carriage`                     decimal(6,2)       comment '运费',
   `item_score`                   decimal(3,2)       comment '产品评分(平均星级)',
   `itemScore_add_1day`           decimal(3,2)       comment '产品评分较昨日增长 [今新增数-昨新增数]',
   `reviewAdd_quiteAdd_1day`      bigint             comment '新增评价数较昨日增长 [今新增数-昨新增数]',
   `sku_add_1day`                 bigint             comment '近1天的新增sku数量',
   `skuAdd_quiteAdd_1day`         bigint             comment '新增SKU数较昨日增长 [今新增数-昨新增数]',
   `salePriceAvg_add_1day`        decimal(15,2)      comment '折扣均价较昨日增长',
   `timest`                       string             comment '数据账期',
   `create_time`                  string             comment '创建时间'
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
/* Table: app_rpt_site_item_total                                */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_item_total`
(
   `id`                                     string                       comment '主键',
   `site_id`                                string                       comment '站点ID(默认为0意思是全站）',
   `shop_type`                              string                       comment '店铺类型(1.普通,2.官方(旗舰+认证),3.淘宝)',
   `item_count`                             bigint                       comment '产品总数',
   `item_acco`                              decimal(5,2)                 comment '产品总数占比 [各店铺类型/全站]',
   `itemAdd_addRate_1day`                   decimal(10,2)                comment '近1天新增产品增长率 ',
   `itemReviewType_count`                   bigint                       comment '有评论产品总数',
   `itemReviewType_acco`                    decimal(5,2)                 comment '有评论产品总数占比 [各店铺类型/全站]',
   `itemAddReviewType_addRate_1day`         decimal(10,2)                comment '近1天新增有评论产品增长率 ',
   `item_add_7day`                          bigint                       comment '近7天新增产品总数',
   `itemAdd_acco_7day`                      decimal(5,2)                 comment '近7天新增产品总数占比',
   `itemAdd_addRate_7day`                   decimal(10,2)                comment '近7天新增产品增长率',
   `item_add_30day`                         bigint                       comment '近30天新增产品总数',
   `itemAdd_acco_30day`                     decimal(5,2)                 comment '近30天新增产品总数占比',
   `itemAdd_addRate_30day`                  decimal(10,2)                comment '近30天新增产品增长率',
   `itemReviewType_add_7day`                bigint                       comment '近7天新增有评论产品总数',
   `itemAddReviewType_acco_7day`            decimal(5,2)                 comment '近7天新增有评论产品总数占比',
   `itemAddReviewType_addRate_7day`         decimal(10,2)                comment '近7天新增有评论产品增长率',
   `itemReviewType_add_30day`               bigint                       comment '近30天新增有评论产品总数',
   `itemAddReviewType_acco_30day`           decimal(5,2)                 comment '近30天新增有评论产品总数占比',
   `itemAddReviewType_addRate_30day`        decimal(10,2)                comment '近30天新增有评论产品增长率',
   `review_add_7day`                        bigint                       comment '近7天新增评论总数',
   `reviewAdd_acco_7day`                    decimal(5,2)                 comment '近7天新增评论总数占比',
   `reviewAdd_addRate_7day`                 decimal(10,2)                comment '近7天新增评论数增长率',
   `review_add_30day`                       bigint                       comment '近30天新增评论总数',
   `reviewAdd_acco_30day `                  decimal(5,2)                 comment '近30天新增评论数总数占比',
   `reviewAdd_addRate_30day`                decimal(10,2)                comment '近30天新增评论数增长率',
   `reviewAdd_avg_7day`                     bigint                       comment '近7天平均新增评论数',
   `reviewAdd_avg_acco_7day`                decimal(5,2)                 comment '近7天平均新增评论数总数占比',
   `reviewAdd_avg_addRate_7day`             decimal(10,2)                comment '近7天平均新增评论数增长率',
   `item_avgReviewRate_7day`                decimal(10,2)                comment '近7天平均产品评论率(动销率) [7天有评论的产品数/7天总产品数/7]',
   `item_avgReviewRate_acco_7day`           decimal(5,2)                 comment '近7天平均产品评论率占比 [各店铺类型/全站]',
   `item_avgReviewRate_addRate_7day`        decimal(10,2)                comment '近7天平均产品评论率的增长率 [(T期该店类总率-(T-1)期该店类总率)/(T-1)期该店类总率]',
   `timest`                                 string                       comment '数据账期',
   `create_time`                            string                       comment '创建时间'
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
   `id`                      string                   comment '主键',
   `site_id`                 string                   comment '站点ID(默认为0就是全站的意思）',
   `7dayReview_set`          string                   comment '7天平均评论数区间(1.1-10,2.11-30,3.31-50,4.51-100,5.101-200,6.201-300,7.301+~ )',
   `item_count`              bigint                   comment '区间对应的产品总数',
   `item_acco`               decimal(5,2)             comment '区间对应的产品总数占比 [每项区间的产品总数/总产品数]',
   `shop_count`              bigint                   comment '区间对应的店铺总数',
   `shop_acco`               decimal(5,2)             comment '区间对应的店铺总数占比 [每项区间的店铺总数/总店铺数]',
   `timest`                  string                   comment '数据账期',
   `create_time`             string                   comment '创建时间'
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
   `id`                        string                    comment '主键',
   `cat_id`                    string                    comment '行业ID',
   `site_id`                   string                    comment '站点ID',
   `item_count`                bigint                    comment '产品总数',
   `review_count`              bigint                    comment '评论总数',
   `item_acco`                 decimal(5,2)              comment '产品总数占比 [各个子行业产品总数/父行业总产品数]',
   `review_acco`               decimal(5,2)              comment '评论总数占比 [各个子行业评论总数/父行业总评论数]',
   `item_add_1day`             bigint                    comment '近1天新增产品数',
   `review_add_1day`           bigint                    comment '近1天新增评论数',
   `itemAdd_acco_1day`         decimal(5,2)              comment '近1天新增产品占比 [各个子行业产品总增量/父行业总增量]',
   `reviewAdd_acco_1day`       decimal(5,2)              comment '近1天新增评论占比',
   `item_add_7day`             bigint                    comment '近7天新增产品数',
   `review_add_7day`           bigint                    comment '近7天新增评论数',
   `itemAdd_acco_7day`         decimal(5,2)              comment '近7天新增产品占比',
   `reviewAdd_acco_7day`       decimal(5,2)              comment '近7天新增评论占比',
   `item_add_30day`            bigint                    comment '近30天新增产品数',
   `review_add_30ay`           bigint                    comment '近30天新增评论数',
   `itemAdd_acco_30day`        decimal(5,2)              comment '近30天新增产品占比',
   `reviewAdd_acco_30day `     decimal(5,2)              comment '近30天新增评论占比',
   `timest`                    string                    comment '数据账期',
   `create_time`               string                    comment '创建时间'
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
   `id`                      string              comment '主键',
   `cat_id`                  string              comment '行业ID',
   `site_id`                 string              comment '站点ID',
   `parent_cat_id`           string              comment '父行业ID',
   `cat_potential`           bigint              comment '行业潜力值 [该子类目总评论数/该子类目总产品数]',
   `timest`                  string              comment '数据账期',
   `create_time`             string              comment '创建时间'
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
   `id`                           string                     comment '主键',
   `cat_name`                     string                     comment '行业名称',
   `item_count`                   bigint                     comment '产品总数',
   `review_count`                 bigint                     comment '评论总数',
   `item_acco`                    decimal(5,2)               comment '产品总数占比 [各个子行业产品总数/父行业总产品数]',
   `review_acco`                  decimal(5,2)               comment '评论总数占比 [各个子行业评论总数/父行业总评论数]',
   `item_add_1day`                bigint                     comment '近1天新增产品数',
   `review_add_1day`              bigint                     comment '近1天新增评论数',
   `itemAdd_acco_1day`            decimal(5,2)               comment '近1天新增产品占比 [各个子行业产品总增量/父行业总增量]',
   `reviewAdd_acco_1day`          decimal(5,2)               comment '近1天新增评论占比',
   `item_add_7day`                bigint                     comment '近7天新增产品数',
   `review_add_7day`              bigint                     comment '近7天新增评论数',
   `itemAdd_acco_7day`            decimal(5,2)               comment '近7天新增产品占比',
   `reviewAdd_acco_7day`          decimal(5,2)               comment '近7天新增评论占比',
   `item_add_30day`               bigint                     comment '近30天新增产品数',
   `review_add_30ay`              bigint                     comment '近30天新增评论数',
   `itemAdd_acco_30day`           decimal(5,2)               comment '近30天新增产品占比',
   `reviewAdd_acco_30day `        decimal(5,2)               comment '近30天新增评论占比',
   `timest`                      string                      comment '数据账期',
   `create_time`                 string                      comment '创建时间'
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
   `id`                               string            comment '主键',
   `site_id`                          string            comment '站点ID',
   `shop_id`                          string            comment '店铺ID',
   `item_count`                       bigint            comment '产品总数',
   `sale_price_avg`                   decimal(15,2)     comment '折扣均价 [折扣价总数/折扣产品总数]',
   `original_price_avg`               decimal(15,2)     comment '原价均价 [所有原价之和/原价产品总数] ',
   `review_count`                     bigint            comment '评论总数',
   `praise_rate`                      string            comment '好评率',
   `praise_num`                     bigint            comment '好评数',
   `average_num`                    bigint            comment '中评数',
   `negate_num`                       bigint            comment '差评数',
   `reviewAdd_avg_7day`               bigint            comment '7天平均评论数 [7天评论总数/7]',
   `reviewAdd_addRate_1day`           decimal(10,2)     comment '近1天评论增长率',
   `item_reviewRate_1day`             decimal(5,2)      comment '近1天产品评论率',
   `itemReviewType_salePrice_avg`     decimal(15,2)     comment '有评论产品折扣均价',
   `itemReviewType_origPrice_avg`     decimal(15,2)     comment '有评论产品原价均价',
   `item_add_1day`                    bigint            comment '近1天新增产品数',
   `itemReviewType_add_1day`          bigint            comment '近1天新增有评论产品数',
   `itemReviewType_count`             bigint            comment '有评论产品总数',
   `reviewAdd_addRate_7day`           decimal(10,2)     comment '近7天评论增长率',
   `review_add_1day`                  bigint            comment '近1天新增评论总数',
   `onTimeDelivery_rate`              decimal(5,2)      comment '准时送达率',
   --
   `shop_score`                       decimal(3,2)      comment '评分',
   `shopScore_add_1day`               decimal(3,2)      comment '评分较昨日增长',
   `oneStar_reviewNum`                bigint            comment '一星的评论数',
   `twoStar_reviewNum`                bigint            comment '二星的评论数',
   `threeStar_reviewNum`              bigint            comment '三星的评论数',
   `fourStar_reviewNum`               bigint            comment '四星的评论数',
   `fiveStar_reviewNum`               bigint            comment '五星的评论数',
   --
   `timest`                           string            comment '数据账期',
   `create_time`                      string            comment '创建时间'
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
   `id`                             string              comment '主键',
   `cat_name`                       string              comment '行业名称',
   `shop_count`                     bigint              comment '店铺总数',
   `review_count`                   bigint              comment '评论总数',
   `shop_acco`                      decimal(5,2)        comment '店铺总数占比 [各个子行业店铺总数/父行业总店铺数]',
   `review_acco`                    decimal(5,2)        comment '评论总数占比 [各个子行业评论总数/父行业总评论数]',
   `shop_add_1day`                  bigint              comment '近1天新增店铺数',
   `review_add_1day`                bigint              comment '近1天新增评论数',
   `shopAdd_acco_1day`              decimal(5,2)        comment '近1天新增店铺占比 [各个子行业店铺总增量/父行业总增量]',
   `reviewAdd_acco_1day`            decimal(5,2)        comment '近1天新增评论占比',
   `shop_add_7day`                  bigint              comment '近7天新增店铺数',
   `review_add_7day`                bigint              comment '近7天新增评论数',
   `shopAdd_acco_7day`              decimal(5,2)        comment '近7天新增店铺占比',
   `reviewAdd_acco_7day`            decimal(5,2)        comment '近7天新增评论占比',
   `shop_add_30day`                 bigint              comment '近30天新增店铺数',
   `review_add_30ay`                bigint              comment '近30天新增评论数',
   `shopAdd_acco_30day`             decimal(5,2)        comment '近30天新增店铺占比',
   `reviewAdd_acco_30day `          decimal(5,2)        comment '近30天新增评论占比',
   `timest`                         string              comment '数据账期',
   `create_time`                    string              comment '创建时间'
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
   `id`                         string              comment '主键',
   `cat_id`                     string              comment '行业ID',
   `site_id`                    string              comment '站点ID',
   `shop_count`                 bigint              comment '店铺总数',
   `review_count`               bigint              comment '评论总数',
   `shop_acco`                  decimal(5,2)        comment '店铺总数占比 [各个子行业店铺总数/父行业总店铺数]',
   `review_acco`                decimal(5,2)        comment '评论总数占比 [各个子行业评论总数/父行业总评论数]',
   `shop_add_1day`              bigint              comment '近1天新增店铺数',
   `review_add_1day`            bigint              comment '近1天新增评论数',
   `shopAdd_acco_1day`          decimal(5,2)        comment '近1天新增店铺占比 [各个子行业店铺总增量/父行业总增量]',
   `reviewAdd_acco_1day`        decimal(5,2)        comment '近1天新增评论占比',
   `shop_add_7day`              bigint              comment '近7天新增店铺数',
   `review_add_7day`            bigint              comment '近7天新增评论数',
   `shopAdd_acco_7day`          decimal(5,2)        comment '近7天新增店铺占比',
   `reviewAdd_acco_7day`        decimal(5,2)        comment '近7天新增评论占比',
   `shop_add_30day`             bigint              comment '近30天新增店铺数',
   `review_add_30ay`            bigint              comment '近30天新增评论数',
   `shopAdd_acco_30day`         decimal(5,2)        comment '近30天新增店铺占比',
   `reviewAdd_acco_30day `      decimal(5,2)        comment '近30天新增评论占比',
   `timest`                     string              comment '数据账期',
   `create_time`                string              comment '创建时间'
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
   `id`                                   string                comment '主键',
   `site_id`                              string                comment '站点ID',
   `shop_id`                              string                comment '店铺ID',
   `item_count`                           bigint                comment '产品总数',
   `itemReviewType_salePrice_avg`         decimal(15,2)         comment '有评论产品折扣均价',
   `item_reviewRate_1day`                 decimal(5,2)          comment '近1天产品评论率 [有评论的产品数/总产品数]',
   `itemReviewType_count`                 bigint                comment '有评论产品总数',
   `praise_rate`                          string                comment '好评率',
   `original_price_avg`                   decimal(15,2)         comment '原价均价 [所有原价之和/原价产品总数] ',
   `sale_price_avg`                       decimal(15,2)         comment '折扣均价 [折扣价总数/折扣产品总数]',
   `onTimeDelivery_rate`                  decimal(5,2)          comment '准时送达率',
   `cat_1d_name`                          string                comment '主营行业(一级类目)',
   `review_count`                         bigint                comment '评论总数',
   `itemAdd__avg_7day`                    bigint                comment '近7天平均新增产品数',
   `chatResp_rate`                        decimal(5,2)          comment '聊天回复率',
   `timest`                               string                comment '数据账期',
   `create_time`                          string                comment '创建时间'
)comment '店铺分析-店铺详情页-店铺信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_shop_info/'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: app_rpt_site_shop_trend                                       */
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_site_shop_trend`
(
   `id`                       string      comment '主键',
   `site_id`                  string      comment '站点ID（默认为0意思是全站）',
   `sellerShop_count`         bigint      comment '普通店铺数量',
   `officShop_count`          bigint      comment '官方店铺数量 [官方店 = off旗舰店 + certi认证店]',
   `tbcShop_count`            bigint      comment '淘宝店铺数量',
   `timest`                   string      comment '数据账期',
   `create_time`              string      comment '创建时间'
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
   `id`                                        string              comment '主键',
   `shop_id`                                   string              comment '店铺ID',
   `site_id`                                   string              comment '站点ID',
   `original_price_avg`                        decimal(15,2)       comment '原价均价 [所有原价之和/原价产品总数] ',
   `sale_price_avg`                            decimal(15,2)       comment '折扣价均价',
   `itemReviewType_salePrice_avg`              decimal(15,2)       comment '有评论产品折扣均价 [所有折扣评论产品的价格之和/折扣评论产品的总数]',
   `itemReviewType_origPrice_avg`              decimal(15,2)       comment '有评论产品原价均价 [所有原价评论产品的价格之和/原价评论产品的总数]',
   `item_count`                                bigint              comment '产品总数',
   `item_add_1day`                             bigint              comment '近1天新增产品数',
   `itemReviewType_add_1day`                   bigint              comment '近1天新增有评论产品数',
   `itemReviewType_count`                      bigint              comment '有评论产品总数',
   `review_count`                              bigint              comment '评论总数',
   `reviewAdd_avg_7day`                        bigint              comment '近7天平均新增评论数',
   `reviewAdd_addRate_7day`                    decimal(10,2)       comment '近7天评论增长率  [(T期总评论数-(T-1)期总评论数)/(T-1)期总评论数]',
   `itemAdd__avg_7day`                         bigint              comment '近7天平均新增产品数',
   `item_reviewRate_1day`                      decimal(5,2)        comment '近1天产品评论率 [有评论的产品数/总产品数]',
   `praise_num`                                bigint              comment '好评数',
   `average_num`                               bigint              comment '中评数',
   `negate_num`                                bigint              comment '差评数',
   `timest`                                    string              comment '数据账期',
   `create_time`                               string              comment '创建时间'
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
   `id`                          string           comment '主键',
   `site_id`                     string           comment '站点ID',
   `shop_type`                   string           comment '店铺类型(0.全站,1.普通,2.官方(旗舰+认证),3.淘宝)',
   `shop_add_1day`               bigint           comment '近1天新增店铺数',
   `shop_add_7day`               bigint           comment '近7天新增店铺数',
   `shop_add_30day`              bigint           comment '近30天新增店铺数',
   `shopAdd_acco_1day`           decimal(5,2)     comment '近1天新增店铺占比 [各站点该店类的店铺总数/全站该店类的店铺总数]',
   `shopAdd_acco_7day`           decimal(5,2)     comment '近7天新增店铺占比',
   `shopAdd_acco_30day`          decimal(5,2)     comment '近30天新增店铺占比',
   `timest`                      string           comment '数据账期',
   `create_time`                 string           comment '创建时间'
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
-- TS: sql-OK
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_sku_reviews_star`
(
   `id`                   string            comment '主键',
   `site_id`              string            comment '站点ID',
   `sku_id`               string            comment 'skuID',
   `review_count`         bigint            comment '评论总数',
   `skuStar_avg`          decimal(3,2)      comment 'sku平均星级 [sku的所有星级分数之和/sku总条数]',
   `one_star`             bigint            comment '一星',
   `two_star`             bigint            comment '二星',
   `three_star`           bigint            comment '三星',
   `four_star`            bigint            comment '四星',
   `five_star`            bigint            comment '五星',
   `timest`               string            comment '数据账期',
   `create_time`          string            comment '创建时间'
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
-- TS: sql-OK
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_sku_trend`
(
   `id`                         string                  comment '主键',
   `site_id`                    string                  comment '站点ID',
   `sku_id`                     string                  comment 'skuID',
   `sku_original_price`         decimal(15,2)           comment 'SKU原价',
   `sku_sale_price`             decimal(15,2)           comment 'SKU折扣价',
   `review_count`               bigint                  comment '评论总数',
   `inventory_count`            bigint                  comment '库存总数(即每个sku下的商品总数)',
   `inventory_add_1day`         bigint                  comment '近1天新增库存总数',
   `inventory_add_7day`         bigint                  comment '近7天新增库存总数',
   `inventory_add_30day`        bigint                  comment '近30天新增库存总数',
    `timest`                    string                  comment '数据账期',
   `create_time`                string                  comment '创建时间'
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
   `id`                                  string              comment '主键',
   `site_id`                             string              comment '站点ID (默认为0就是全站)',
   `shop_type`                           string              comment '店铺类型(0.全站,1.普通,2.官方(旗舰+认证),3.淘宝)',
   `shop_count`                          bigint              comment '店铺总数',
   `shop_acco`                           decimal(5,2)        comment '店铺总数占比',
   `shopAdd_addRate_1day`                decimal(10,2)       comment '近1天新增店铺增长率',
   `shopReviewType_count`                bigint              comment '有评论店铺总数',
   `shopReviewType_acco`                 decimal(5,2)        comment '有评论店铺总数占比',
   `shopReviewType_addRate_1day`         decimal(10,2)       comment '近1天有评论店铺增长率',
   `shop_add_7day`                       bigint              comment '近7天新增店铺数',
   `shopAdd_acco_7day`                   decimal(5,2)        comment '近7天新增店铺数占比',
   `shopAdd_addRate_7day`                decimal(10,2)       comment '近7天新增店铺增长率',
   `timest`                              string              comment '数据账期',
   `create_time`                         string              comment '创建时间'
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
   `id`                           string             comment '主键',
   `cat_id`                       string             comment '行业ID',
   `site_id`                      string             comment '站点ID',
   `item_count`                   bigint             comment '产品总数',
   `itemReviewType_count`         bigint             comment '有评论产品总数',
   `review_count`                 bigint             comment '评论总数',
   `reviewAdd_addRate_1day`       decimal(10,2)      comment '近1天评论增长率 [(T期评论总数-(T-1)期评论总数)/(T-1)期评论总数]',
   `review_acco`                  decimal(5,2)       comment '评论总数占比 [子行业评论数/父行业评论总数]',
   `shop_count`                   bigint             comment '店铺总数',
   `timest`                       string             comment '数据账期',
   `create_time`                  string             comment '创建时间'
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
/* Table: app_rpt_sku_sell_top5                                 */
-- TS: sql-OK
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_sku_sell_top5`
(
   `id`                   string      comment '主键',
   `item_id`              string      comment '产品ID',
   `site_id`              string      comment '站点ID',
   `sku_key`              string      comment 'SKU名称的键',
   `sku_value`            string      comment 'SKU名称的值',
   `review_count`         bigint      comment '评论总数',
   `timest`               string      comment '数据账期',
   `create_time`          string      comment '创建时间'
)comment '产品分析-产品详情页-产品sku分析-SKU热销top5'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_sku_sell_top5/'
tblproperties("orc.compress"="SNAPPY");








-----------------------------------  监控表 -----------------------------------------------




/*==============================================================*/
/* Table: app_rpt_monitor_item                                 */
-- TS: 不用了
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_monitor_item`
(
   `id`                           string             comment '主键',
   `site_id`                      string             comment '站点ID',
   `user_id`                      string             comment '用户ID',
   `item_id`                      string             comment '产品ID',
   `cat_1d_id`                    string             comment '1级类目ID',
   `cat_2d_id`                    string             comment '2级类目ID',
   `cat_3d_id`                    string             comment '3级类目ID',
   `cat_4d_id`                    string             comment '4级类目ID',
   `cat_5d_id`                    string             comment '5级类目ID',
   `cat_6d_id`                    string             comment '6级类目ID',
   `shop_id`                      string             comment '店铺ID',
   `shop_name`                    string             comment '店铺名字',
   `shop_address`                 string             comment '店铺地址',
   `shop_type`                    string             comment '店铺类型(1.普通店铺,2.官方店铺,3.淘宝店铺)',
   `brand_name`                   string             comment '所属品牌',
   `review_add_1day`              bigint             comment '近1天新增评论数',
   `reviewAdd_addRate_1day`       decimal(10,2)      comment '近1天评论增长率',
   `review_add_7day`              bigint             comment '近7天新增评论总数',
   `reviewAdd_avg_7day`           bigint             comment '近7天平均新增评论数',
   `reviewAdd_addRate_7day`       decimal(10,2)      comment '近7天评论增长率',
   `review_add_30day`             bigint             comment '近30天新增评论总数',
   `reviewAdd_addRate_30day`      decimal(10,2)      comment '近30天新增评论增长率',
   `review_count`                 bigint             comment '累计评论总数',
   `original_price_avg`           decimal(15,2)      comment '原始均价[sku原价相加/sku数量]',
   `sale_price_avg`               decimal(15,2)      comment '折扣均价 [sku折扣价相加/sku数量]',
   `carriage`                     decimal(6,2)       comment '运费',
   `item_score`                   decimal(3,2)       comment '产品评分(平均星级)',
   `itemScore_add_1day`           decimal(3,2)       comment '产品评分较昨日增长 [今新增数-昨新增数]',
   `reviewAdd_quiteAdd_1day`      bigint             comment '新增评价数较昨日增长 [今新增数-昨新增数]',
   `sku_add_1day`                 bigint             comment '近1天的新增sku数量',
   `skuAdd_quiteAdd_1day`         bigint             comment '新增SKU数较昨日增长 [今新增数-昨新增数]',
   `salePriceAvg_add_1day`        decimal(15,2)      comment '折扣均价较昨日增长',
   `timest`                       string             comment '数据账期',
   `create_time`                  string             comment '创建时间'
)comment '监控中心的产品展示表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_monitor_item/'
tblproperties("orc.compress"="SNAPPY");









/*==============================================================*/
/* Table: app_rpt_monitor_shop                                 */
-- TS: 不用了
/*==============================================================*/
create external table if not exists `lazada_dw.app_rpt_shop`
(
   `id`                               string            comment '主键',
   `site_id`                          string            comment '站点ID',
   `user_id`                          string            comment '用户ID',
   `shop_id`                          string            comment '店铺ID',
   `item_count`                       bigint            comment '产品总数',
   `sale_price_avg`                   decimal(15,2)     comment '折扣均价 [折扣价总数/折扣产品总数]',
   `original_price_avg`               decimal(15,2)     comment '原价均价 [所有原价之和/原价产品总数] ',
   `review_count`                     bigint            comment '评论总数',
   `praise_rate`                      string            comment '好评率',
   `praise_num`                       bigint            comment '好评数',
   `average_num`                      bigint            comment '中评数',
   `negate_num`                       bigint            comment '差评数',
   `reviewAdd_avg_7day`               bigint            comment '7天平均评论数 [7天评论总数/7]',
   `reviewAdd_addRate_1day`           decimal(10,2)     comment '近1天评论增长率',
   `item_reviewRate_1day`             decimal(5,2)      comment '近1天产品评论率',
   `itemReviewType_salePrice_avg`     decimal(15,2)     comment '有评论产品折扣均价',
   `itemReviewType_origPrice_avg`     decimal(15,2)     comment '有评论产品原价均价',
   `item_add_1day`                    bigint            comment '产品数较昨日增长',
   `itemReviewType_add_1day`          bigint            comment '有评论产品数较昨日增长',
   `itemReviewType_count`             bigint            comment '有评论产品总数',
   `reviewAdd_addRate_7day`           decimal(10,2)     comment '近7天评论增长率',
   `review_add_1day`                  bigint            comment '评论数较昨日增长',
   `onTimeDelivery_rate`              decimal(5,2)      comment '准时送达率',
    --
   `shop_score`                       decimal(3,2)      comment '店铺评分',
   `shopScore_add_1day`               decimal(3,2)      comment '店铺评分较昨日增长',
   `oneStar_reviewNum`                bigint            comment '一星的评论数',
   `twoStar_reviewNum`                bigint            comment '二星的评论数',
   `threeStar_reviewNum`              bigint            comment '三星的评论数',
   `fourStar_reviewNum`               bigint            comment '四星的评论数',
   `fiveStar_reviewNum`               bigint            comment '五星的评论数',
   --
   `timest`                           string            comment '数据账期',
   `create_time`                      string            comment '创建时间'
)comment '店铺分析-店铺展示表（店铺搜索，行业店铺）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/app/app_rpt_shop/'
tblproperties("orc.compress"="SNAPPY");










