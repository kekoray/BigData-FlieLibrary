

/*==============================================================*/
/*   Description :  dws层的建表语句 (主题表)                     */
/*   FileName :  create_dws_table.sql                           */
/*   Version  :  1.0                                            */
/*   Author   :  Koray                                          */
/*   Date     :  2020-12-03                                     */
/*   Company  :  menglar                                        */
/*==============================================================*/




/*==============================================================*/
/* Table: dws_itemTopic_itemDim_itemInfo                        */
/*==============================================================*/
create external table if not exists `lazada_dw.dws_itemTopic_itemDim_itemInfo`
(
   `site_id`                      string             comment '站点id',
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
   `create_time`                  string             comment '创建时间'
)comment '产品主题中产品维度的产品信息宽表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dws/dws_itemTopic_itemDim_itemInfo/'
tblproperties("orc.compress"="SNAPPY");







/*==============================================================*/
/* Table: dws_itemTopic_AllSiteDim_itemAndReviewNum             */
/*==============================================================*/
create external table if not exists `lazada_dw.dws_itemTopic_AllSiteDim_itemAndReviewNum`
(
`site_id`                           string                     comment '站点id',
`review_count`                      bigint                     comment '评论总数',
`review_add_1day`                   bigint                     comment '近1天新增评论数',
`review_add_7day`                   bigint                     comment '近7天新增评论数',
`review_add_30day`                  bigint                     comment '近30天新增评论数',
`review_acco`                       decimal(5,2)               comment '评论总数占比',
`reviewAdd_acco_1day`               decimal(5,2)               comment '近1天新增评论占比',
`reviewAdd_acco_7day`               decimal(5,2)               comment '近7天新增评论占比',
`reviewAdd_acco_30day `             decimal(5,2)               comment '近30天新增评论占比',
`item_count`                        bigint                     comment '产品总数',
`item_add_1day`                     bigint                     comment '近1天新增产品数',
`item_add_7day`                     bigint                     comment '近7天新增产品数',
`item_add_30day`                    bigint                     comment '近30天新增产品数',
`item_acco`                         decimal(5,2)               comment '产品总数占比',
`itemAdd_acco_1day`                 decimal(5,2)               comment '近1天新增产品占比',
`itemAdd_acco_7day`                 decimal(5,2)               comment '近7天新增产品占比',
`itemAdd_acco_30day`                decimal(5,2)               comment '近30天新增产品占比',
`create_time`                       string                     comment '创建时间'
)comment '产品主题中全站维度的产品数和评论数的宽表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyy-MM-dd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC
location 'cosn://emr-1254463213/lazada_dw/dws/dws_itemTopic_AllSiteDim_itemAndReviewNum/'
tblproperties("orc.compress"="SNAPPY");

















