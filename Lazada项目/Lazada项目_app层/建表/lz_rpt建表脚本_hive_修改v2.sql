
--使用库
use lazada_base;




/*==============================================================*/
/* Table:  lz_rpt_eval_item_trend                               */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_eval_item_trend`
(
   `id`                   string comment '主键',
   `site_id`              bigint comment '站点 ID(默认为0表示全站）',
   `item_count`           string comment '产品总数',
   `eval_count`           string comment '评论总数',
   `item_incr`            bigint comment '产品增量',
   `eval_incr`            bigint comment '评论增量',
   `gmt_create`           string comment '创建时间'
    
)comment '行业分析-评论数和产品数趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_ind_contrast                                   */
/*==============================================================*/

create external table if not exists `lazada_base.lz_rpt_ind_contrast`
(
   `id`                   bigint  comment '主键',
   `category_id`          bigint comment '类目 ID',
   `site_id`              bigint comment '站点 ID',
   `day_eval_num`         bigint comment '日评价数',
   `day_new_item_num`     bigint comment '日新增商品数',
   `shop_count`           bigint comment '店铺总数',
   `item_count`           bigint comment '商品总数',
   `eval_count`           bigint comment '评价总量',
   `new_eval_num`         bigint comment '新增评价数',
   `new_item_num`         bigint comment '新增商品数',
   `new_shop_num`         bigint comment '新增店铺数',
   `ave_ori_price`        decimal(10,2) comment '原价均价',
   `ave_price`            decimal(10,2) comment '折扣均价',
   `item_eval_rate`       decimal(10,2) comment '产品评价率',
   `eval_gro_rate`        decimal(10,2) comment '评价增长率',
   `ave_new_item_num`     bigint comment '平均上新产品数',
   `ave_eval_num`         bigint comment '平均评价数',
   `gmt_create`           datetime comment '创建时间'
)comment '行业对比(行业）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_ind_item                                       */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_ind_item`
(
   `id`                   bigint  comment '主键',
   `category_id`          bigint comment '行业 ID',
   `site_id`              bigint comment '站点 ID',
   `item_id`              bigint comment '产品 ID',
   `shop_id`              bigint comment '店铺 ID',
   `brand_id`             bigint comment '所属品牌',
   `day_eval_num`         bigint comment '日评价数',
   `yest_eval_gro_rate`   decimal(10,2) comment '昨日评价增长率',
   `weeks_eval_num`       bigint comment '7天评价数',
   `weeks_ave_eval_num`   bigint comment '7天平均评价数',
   `weeks_eval_gro_rate`  decimal(10,2) comment '7天评价增长率',
   `month_eval_num`       bigint comment '30天评价数',
   `month_eval_gro_rate`  decimal(10,2) comment '30天评价增长率',
   `gmt_create`           string comment '创建时间' 
)comment '行业-行业产品'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: lz_rpt_ind_sea                                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_ind_sea`
(
   `id`                   bigint  comment '主键',
   `category_id`          bigint comment '行业 ID',
   `site_id`              bigint comment '站点 ID',
   `shop_num`             bigint comment '店铺数',
   `item_num`             string comment '商品数',
   `eval_count`           string comment '评价数',
   `day_eval_num`         bigint comment '日评价数',
   `item_ave_price`       decimal(10,2) comment '产品均价',
   `day_new_item_num`     bigint comment '日新增商品数',
   `weeks_new_shop_num`   bigint comment '7天新增店铺数',
   `weeks_ave_ori_price`  decimal(10,2) comment '7天原价均价',
   `weeks_ave_price`      decimal(10,2) comment '7天折扣均价',
   `weeks_item_eval_rate` decimal(10,2) comment '7天产品评价率',
   `weeks_eval_gro_rate`  decimal(10,2) comment '7天评价增长率',
   `weeks_ave_new_item_num` bigint comment '7天平均上新产品数',
   `weeks_ave_eval_num`   bigint comment '7天平均评价数',
   `month_ave_ori_price`  decimal(10,2) comment '30天原价均价',
   `month_ave_price`      decimal(10,2) comment '30天折扣均价',
   `month_ave_eval_num`   string comment '30天平均评价数',
   `day_eval_gro_rate`    decimal(10,2) comment '近一天评价增长率',
   `month_eval_gro_rate`  decimal(10,2) comment '近30天评价增长率',
   `gmt_create`           string comment '创建时间'  
)comment '行业-行业搜索(行业搜索，行业概况）'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_ind_shop                                       */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_ind_shop`
(
   `id`                         bigint  comment '主键',
   `category_id`                bigint comment '行业 ID',
   `site_id`                    bigint comment '站点 ID',
   `shop_id`                    bigint comment '店铺 ID',
   `item_num`                   bigint comment '商品数',
   `ave_price`                  decimal(10,2) comment '折扣均价',
   `ave_ori_price`              decimal(10,2) comment '原价均价',
   `price_currency`             string comment '价格币种(1-RM,2-$)',
   `eval_count`                 bigint comment '累计评价数',
   `praise_rate`                decimal(5,2) comment '好评率',
   `praise_num`                 bigint comment '好评数',
   `cen_eval_num`               bigint comment '中评数',
   `poor_eval_num`              bigint comment '差评数',
   `weeks_ave_eval_num`         bigint comment '7天平均评价数',
   `yest_eval_gro_rate`         decimal(10,2) comment '昨日评价增长率',
   `item_eval_rate`             decimal(5,2) comment '产品评价率',
   `eval_item_ave_price`        decimal(10,2) comment '有评价商品折扣均价',
   `eval_item_ave_ori_price`    decimal(10,2) comment '有评价商品原价均价',
   `day_new_item_num`           bigint comment '日新增商品数',
   `day_new_eval_item_num`      bigint comment '日新增有评价商品数',
   `eval_item_num`              bigint comment '有评价商品数',
   `weeks_eval_num_gro_rate`    decimal(10,2) comment '7天评价数增长率',
   `day_eval_num`               bigint comment '日评论数',
   `on_time_delivery_rate`      decimal(5,2) comment '准时送达率',
   `gmt_create`                 string comment '创建时间'
)comment '行业-行业店铺'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_ind_son_acco                                   */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_ind_son_acco`
(
   `id`                   bigint comment '主键',
   `category_id`          bigint comment '行业 ID',
   `site_id`              bigint comment '站点 ID',
   `eval_num`             bigint comment '评价量',
   `acco`                 decimal(5,2) comment '比例',
   `weeks_new_item_num`   bigint comment '近7天新增产品量',
   `month_new_item_num`   bigint comment '近30天新增产品量',
   `weeks_acco`           decimal(5,2) comment '近7天比例',
   `month_acco`           decimal(5,2) comment '近30天比例',
   `gmt_create`           string comment '创建时间' 
)comment '行业-子行业占比图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_item_eval_num_acco                             */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_eval_num_acco`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点 ID',
   `eval_count`           bigint comment '评价总量',
   `eval_acco`            decimal(5,2) comment '评价占比',
   `day_eval_incr`        bigint comment '近1天评价增量',
   `day_eval_acco`        decimal(5,2) comment '近1天评价占比',
   `weeks_eval_incr`      bigint comment '近7天评价增量',
   `weeks_eval_acco`      decimal(5,2) comment '近7天评价占比',
   `month_eval_incr`      bigint comment '近30天评价增量',
   `month_eval_acco`      decimal(5,2) comment '近30天评价占比',
   `gmt_create`           string comment '创建时间'
)comment '产品分析-各站点产品评价数占比图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: lz_rpt_item_eval_num_trend                            */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_eval_num_trend`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点id(默认为0意思是全站）',
   `eval_count`           bigint comment '评价总量',
   `eval_inc`             bigint comment '评价增量',
   `gmt_create`           string comment '创建时间'
)comment '产品分析-产品评价数趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_item_num                                       */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_num`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点 ID(默认为0意思是全站）',
   `item_num`             string comment '产品数量(1. 0-50  2. 51-100  3. 101-150  4. 151-200  5. 201-300  6. 301-1000  7. 1001-2000  8. 2001+)',
   `shop_num`             bigint comment '店铺数',
   `acco`                 decimal(5,2) comment '占比',
   `item_type`            string comment '类型(1.产品数量  2.有评价的产品数量)',
   `gmt_create`           string comment '创建时间'
)comment '店铺分析-产品数量分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_item_num_acco                                  */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_num_acco`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点 ID',
   `item_count`           bigint comment '产品总量',
   `item_acco`            decimal(5,2) comment '产品占比',
   `day_item_incr`        bigint comment '近1天产品增量',
   `day_item_acco`        decimal(5,2) comment '近1天产品占比',
   `weeks_item_incr`      bigint comment '近7天产品增量',
   `weeks_item_acco`      decimal(5,2) comment '近7天产品占比',
   `month_item_incr`      bigint comment '近30天产品增量',
   `month_item_acco`      decimal(5,2) comment '近30天产品占比',
   `gmt_create`           string comment '创建时间'
)comment '产品分析-各站点产品数占比图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: lz_rpt_item_num_trend                                 */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_num_trend`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点 ID(默认为0就是全站)',
   `item_count`           bigint comment '产品总量',
   `item_inc`             bigint comment '产品增量',
   `gmt_create`           string comment '创建时间'
)comment '产品分析-产品数趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_item_s1                                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_s1`
(
   `id`                   string  comment '主键',
   `item_id`              string comment '产品 ID',
   `category_id`          bigint comment '类目 ID',
   `shop_id`              bigint comment '店铺 ID',
   `brand_name`           string comment '所属品牌',
   `day_eval_num`         bigint comment '日评价数',
   `yest_eval_gro_rate`   decimal(10,2) comment '昨日评价增长率',
   `weeks_eval_num`       bigint comment '7天评价数',
   `weeks_ave_eval_num`   bigint comment '7天平均评价数',
   `weeks_eval_gro_rate`  decimal(10,2) comment '7天评价增长率',
   `month_eval_num`       bigint comment '30天评价数',
   `month_eval_gro_rate`  decimal(10,2) comment '30天评价增长率',
   `eval_count`           bigint comment '累计评价数',
   `gmt_create`           string comment '创建时间',
   `original_price`       decimal(10,2) comment '原始价格',
   `price`                decimal(10,2) comment '折扣后的价格',
   `price_currency`       string comment '价格币种 (1：RM，2：$，待定)',
   `freight`              decimal(6,2) comment '运费',
   `item_score`           decimal(3,2) comment '商品评分'
)comment '产品-产品展示表-马来西亚'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_item_s2                                       */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_s2`
(
   `id`                   string  comment '主键',
   `item_id`              string comment '产品 ID',
   `category_id`          bigint comment '类目 ID',
   `shop_id`              bigint comment '店铺 ID',
   `brand_name`           string comment '所属品牌',
   `day_eval_num`         bigint comment '日评价数',
   `yest_eval_gro_rate`   decimal(10,2) comment '昨日评价增长率',
   `weeks_eval_num`       bigint comment '7天评价数',
   `weeks_ave_eval_num`   bigint comment '7天平均评价数',
   `weeks_eval_gro_rate`  decimal(10,2) comment '7天评价增长率',
   `month_eval_num`       bigint comment '30天评价数',
   `month_eval_gro_rate`  decimal(10,2) comment '30天评价增长率',
   `eval_count`           bigint comment '累计评价数',
   `gmt_create`           string comment '创建时间',
   `original_price`       decimal(10,2) comment '原始价格',
   `price`                decimal(10,2) comment '折扣后的价格',
   `price_currency`       string comment '价格币种 (1：RM，2：$，待定)',
   `freight`              decimal(6,2) comment '运费',
   `item_score`           decimal(3,2) comment '商品评分'
)comment '产品-产品展示表-新加坡'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_item_s3                                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_s3`
(
   `id`                   string  comment '主键',
   `item_id`              string comment '产品 ID',
   `category_id`          bigint comment '类目 ID',
   `shop_id`              bigint comment '店铺 ID',
   `brand_name`           string comment '所属品牌',
   `day_eval_num`         bigint comment '日评价数',
   `yest_eval_gro_rate`   decimal(10,2) comment '昨日评价增长率',
   `weeks_eval_num`       bigint comment '7天评价数',
   `weeks_ave_eval_num`   bigint comment '7天平均评价数',
   `weeks_eval_gro_rate`  decimal(10,2) comment '7天评价增长率',
   `month_eval_num`       bigint comment '30天评价数',
   `month_eval_gro_rate`  decimal(10,2) comment '30天评价增长率',
   `eval_count`           bigint comment '累计评价数',
   `gmt_create`           string comment '创建时间',
   `original_price`       decimal(10,2) comment '原始价格',
   `price`                decimal(10,2) comment '折扣后的价格',
   `price_currency`       string comment '价格币种 (1：RM，2：$，待定)',
   `freight`              decimal(6,2) comment '运费',
   `item_score`           decimal(3,2) comment '商品评分'
)comment '产品-产品展示表-菲律宾'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_item_s4                                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_s4`
(
   `id`                   string  comment '主键',
   `item_id`              string comment '产品 ID',
   `category_id`          bigint comment '类目 ID',
   `shop_id`              bigint comment '店铺 ID',
   `brand_name`           string comment '所属品牌',
   `day_eval_num`         bigint comment '日评价数',
   `yest_eval_gro_rate`   decimal(10,2) comment '昨日评价增长率',
   `weeks_eval_num`       bigint comment '7天评价数',
   `weeks_ave_eval_num`   bigint comment '7天平均评价数',
   `weeks_eval_gro_rate`  decimal(10,2) comment '7天评价增长率',
   `month_eval_num`       bigint comment '30天评价数',
   `month_eval_gro_rate`  decimal(10,2) comment '30天评价增长率',
   `eval_count`           bigint comment '累计评价数',
   `gmt_create`           string comment '创建时间',
   `original_price`       decimal(10,2) comment '原始价格',
   `price`                decimal(10,2) comment '折扣后的价格',
   `price_currency`       string comment '价格币种 (1：RM，2：$，待定)',
   `freight`              decimal(6,2) comment '运费',
   `item_score`           decimal(3,2) comment '商品评分'
)comment '产品-产品展示表-泰国'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_item_s5                                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_s5`
(
   `id`                   string  comment '主键',
   `item_id`              string comment '产品 ID',
   `category_id`          bigint comment '类目 ID',
   `shop_id`              bigint comment '店铺 ID',
   `brand_name`           string comment '所属品牌',
   `day_eval_num`         bigint comment '日评价数',
   `yest_eval_gro_rate`   decimal(10,2) comment '昨日评价增长率',
   `weeks_eval_num`       bigint comment '7天评价数',
   `weeks_ave_eval_num`   bigint comment '7天平均评价数',
   `weeks_eval_gro_rate`  decimal(10,2) comment '7天评价增长率',
   `month_eval_num`       bigint comment '30天评价数',
   `month_eval_gro_rate`  decimal(10,2) comment '30天评价增长率',
   `eval_count`           bigint comment '累计评价数',
   `gmt_create`           string comment '创建时间',
   `original_price`       decimal(10,2) comment '原始价格',
   `price`                decimal(10,2) comment '折扣后的价格',
   `price_currency`       string comment '价格币种 (1：RM，2：$，待定)',
   `freight`              decimal(6,2) comment '运费',
   `item_score`           decimal(3,2) comment '商品评分'
)comment '产品-产品展示表-越南'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");






/*==============================================================*/
/* Table: lz_rpt_item_s6                                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_s6`
(
   `id`                   string  comment '主键',
   `item_id`              string comment '产品 ID',
   `category_id`          bigint comment '类目 ID',
   `shop_id`              bigint comment '店铺 ID',
   `brand_name`           string comment '所属品牌',
   `day_eval_num`         bigint comment '日评价数',
   `yest_eval_gro_rate`   decimal(10,2) comment '昨日评价增长率',
   `weeks_eval_num`       bigint comment '7天评价数',
   `weeks_ave_eval_num`   bigint comment '7天平均评价数',
   `weeks_eval_gro_rate`  decimal(10,2) comment '7天评价增长率',
   `month_eval_num`       bigint comment '30天评价数',
   `month_eval_gro_rate`  decimal(10,2) comment '30天评价增长率',
   `eval_count`           bigint comment '累计评价数',
   `gmt_create`           string comment '创建时间',
   `original_price`       decimal(10,2) comment '原始价格',
   `price`                decimal(10,2) comment '折扣后的价格',
   `price_currency`       string comment '价格币种 (1：RM，2：$，待定)',
   `freight`              decimal(6,2) comment '运费',
   `item_score`           decimal(3,2) comment '商品评分'
)comment '产品-产品展示表-印度尼西亚'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_item_sta                                       */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_sta`
(
   `id`                                   bigint     comment '主键',
   `item_count`                           bigint     comment '产品总数',
   `item_acco`                            decimal(5,2)     comment '产品全站占比',
   `item_cycle_ratio`                     decimal(10,2)     comment '产品环比增幅',
   `eval_item_count`                      bigint     comment '有评价产品总量',
   `eval_item_acco`                       decimal(5,2)     comment '有评价产品全站占比',
   `eval_item_cycle_ratio`                decimal(10,2)     comment '有评价产品环比增幅',
   `month_new_item_count`                 bigint     comment '30日上新产品总量',
   `month_new_item_acco`                  decimal(5,2)     comment '30日上新产品全站占比',
   `month_new_item_cycle_ratio`           decimal(10,2)     comment '30日上新产品环比增幅',
   `month_new_eval_item_count`            bigint     comment '30日上新有评价产品总量',
   `month_new_eval_item_acco`             decimal(5,2)     comment '30日上新有评价产品全站占比',
   `month_new_eval_item_ratio`            decimal(10,2)     comment '30日上新有评价产品环比增幅',
   `month_eval_count`                     bigint     comment '30日评价量',
   `month_eval_acco`                      decimal(5,2)     comment '30日评价量全站占比',
   `month_eval_cycle_ratio`               decimal(10,2)     comment '30日评价量环比增幅',
   `weeks_new_item_count`                 bigint     comment '7日上新产品总量',
   `weeks_new_item_acco`                  decimal(5,2)     comment '7日上新产品全站占比',
   `weeks_new_item_cycle_ratio`           decimal(10,2)     comment '7日上新产品环比增幅',
   `weeks_eval_count`                     bigint     comment '7日评价量',
   `weeks_eval_acco`                      decimal(5,2)     comment '7日评价量全站占比',
   `weeks_eval_cycle_ratio`               decimal(10,2)     comment '7日评价量环比增幅',
   `weeks_new_eval_item_count`            bigint     comment '7日上新有评价产品总量',
   `weeks_new_eval_item_acco`             decimal(5,2)     comment '7日上新有评价产品全站占比',
   `weeks_new_eval_item_ratio`            decimal(10,2)     comment '7日上新有评价产品环比增幅',
   `weeks_ave_eval_count`                 bigint     comment '7日日均评价量',
   `weeks_ave_eval_acco`                  decimal(5,2)     comment '7日日均评价量全站占比',
   `weeks_ave_eval_cycle_ratio`           decimal(10,2)     comment '7日日均评价量环比增幅',
   `weeks_ave_pin_rate`                   decimal(10,2)     comment '7日日均动销率',
   `weeks_ave_pin_rate_acco`              decimal(5,2)     comment '7日日均动销率全站占比',
   `weeks_ave_pin_rate_ratio`             decimal(10,2)     comment '7日日均动销率环比增幅',
   `shop_type`                            string     comment '类型(1.全站  2.普通店铺   3.官方店铺  4.淘宝店铺)',
   `gmt_create`                           string     comment '创建时间'
)comment '产品分析-产品统计'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_item_weeks_item                                */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_weeks_item`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点 ID(默认为0意思是全站）',
   `weeks_day_ave_eval`   string comment '7日日均评价量(1. 1-10  2. 11-30  3. 31-50  4. 51-100  5. 101-200  6. 201-300  7. 301+)',
   `item_num`             bigint comment '产品数',
   `acco`                 decimal(5,2) comment '占比',
   `gmt_create`           string comment '创建时间'
)comment '产品分析-产品7日日均评论量分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_item_weeks_shop                                */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_item_weeks_shop`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint default 0 comment '站点 ID(默认为0就是全站的意思）',
   `weeks_day_ave_eval`   string comment '7日日均评价量(1. 1-10  2. 11-30  3. 31-50  4. 51-100  5. 101-200  6. 201-300  7. 301+)',
   `shop_num`             bigint comment '店铺数',
   `acco`                 decimal(5,2) comment '占比',
   `gmt_create`           string comment '创建时间'
)comment '店铺分析-产品7日日均评价量分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_lnd_pro                                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_lnd_pro`
(
   `id`                   bigint  comment '主键',
   `category_id`          bigint comment '行业 ID',
   `site_id`              bigint comment '站点 ID',
   `item_count`           bigint comment '产品总数',
   `eval_count`           bigint comment '评论总数',
   `item_incr`            bigint comment '近1天产品增量',
   `eval_incr`            bigint comment '近1天评论增量',
   `item_acco`            decimal(5,2) comment '近1天产品数占比',
   `eval_acco`            decimal(5,2) comment '近1天评论数占比',
   `weeks_item_incr`      bigint comment '近7天产品增量',
   `weeks_eval_incr`      bigint comment '近7天评论增量',
   `weeks_item_acco`      decimal(5,2) comment '近7天产品数占比',
   `weeks_eval_acco`      decimal(5,2) comment '近7天评论数占比',
   `month_item_incr`      bigint comment '近30天产品增量',
   `month_eval_incr`      bigint comment '近30天评论增量',
   `month_item_acco`      decimal(5,2) comment '近30天产品数占比',
   `month_eval_acco`      decimal(5,2) comment '近30天评论数占比',
   `gmt_create`           string comment '创建时间'
)comment '分站行业分析-行业概况'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_pot_cat                                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_pot_cat`
(
   `id`                   bigint   comment '主键',
   `category_id`          bigint   comment '行业 ID',
   `site_id`              bigint   comment '站点 ID',
   `parent_category_id`   bigint   comment '父类目 ID',
   `item_num`             bigint   comment '潜力值 类目潜力值=当前类目下的评价数/当前类目下的商品数',
   `gmt_create`           string   comment '创建时间'
)comment '行业-潜力类目'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_pri_lnd_pro                                    */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_pri_lnd_pro`
(
   `id`                   bigint   comment '主键',
   `category_name`        string   comment '类目名字',
   `item_count`           bigint  comment '产品总数',
   `eval_count`           bigint  comment '评论总数',
   `item_incr`            bigint   comment '近1天产品增量',
   `eval_incr`            bigint   comment '近1天评论增量',
   `item_acco`            decimal(5,2)  comment '近1天产品数占比',
   `eval_acco`            decimal(5,2)  comment '近1天评论数占比',
   `weeks_item_incr`      bigint   comment '近7天产品增量',
   `weeks_eval_incr`      bigint   comment '近7天评论增量',
   `weeks_item_acco`      decimal(5,2)  comment '近7天产品数占比',
   `weeks_eval_acco`      decimal(5,2)  comment '近7天评论数占比',
   `month_item_incr`      bigint   comment '近30天产品增量',
   `month_eval_incr`      bigint   comment '近30天评论增量',
   `month_item_acco`      decimal(5,2)  comment '近30天产品数占比',
   `month_eval_acco`      decimal(5,2)  comment '近30天评论数占比',
   `gmt_create`           string   comment '创建时间'
)comment '行业分析-一级行业概况(全站)'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_shop                                           */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_shop`
(
   `id`                          bigint           comment '主键',
   `site_id`                     bigint           comment '站点 ID',
   `shop_id`                     bigint           comment '店铺 ID',
   `item_num`                    bigint           comment '商品数',
   `ave_price`                   decimal(10,2)    comment '折扣均价',
   `ave_ori_price`               decimal(10,2)    comment '原价均价',
   `price_currency`              string           comment '价格币种   1 RM  2  $    后面再扩展其他符号',
   `eval_count`                  bigint           comment '累计评价数',
   `praise_rate`                 decimal(5,2)     comment '好评率',
   `praise_num`                  bigint           comment '好评数',
   `cen_eval_num`                bigint           comment '中评数',
   `poor_eval_num`               bigint           comment '差评数',
   `weeks_ave_eval_num`          bigint           comment '7天平均评价数',
   `yest_eval_gro_rate`          decimal(10,2)    comment '昨日评价增长率',
   `item_eval_rate`              decimal(5,2)     comment '产品评价率',
   `eval_item_ave_price`         decimal(10,2)    comment '有评价商品折扣均价',
   `eval_item_ave_ori_price`     decimal(10,2)    comment '有评价商品原价均价',
   `day_new_item_num`            bigint           comment '日新增商品数',
   `day_new_eval_item_num`       bigint           comment '日新增有评价商品数',
   `eval_item_num`               bigint           comment '有评价商品数',
   `weeks_eval_num_gro_rate`     decimal(10,2)    comment '7天评价数增长率',
   `day_eval_num`                bigint           comment '日评论数',
   `on_time_delivery_rate`       decimal(5,2)     comment '准时送达率',
   `gmt_create`                  string           comment '创建时间'
)comment '店铺-店铺展示表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_shop_cate_eval_num                             */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_shop_cate_eval_num`
(
   `id`                   bigint  comment '主键',
   `category_name`        string comment '类目名字',
   `shop_count`           bigint comment '店铺总数',
   `eval_count`           string comment '评论总数',
   `shop_incr`            bigint comment '近1天店铺增量',
   `eval_incr`            bigint comment '近1天评论增量',
   `shop_acco`            decimal(5,2)  comment '近1天店铺数占比',
   `eval_acco`            decimal(5,2)  comment '近1天评论数占比',
   `weeks_shop_incr`      bigint comment '近7天店铺增量',
   `weeks_eval_incr`      bigint comment '近7天评论增量',
   `weeks_shop_acco`      decimal(5,2)  comment '近7天店铺数占比',
   `weeks_eval_acco`      decimal(5,2)  comment '近7天评论数占比',
   `month_shop_incr`      bigint comment '近30天店铺增量',
   `month_eval_incr`      bigint comment '近30天评论增量',
   `month_shop_acco`      decimal(5,2)  comment '近30天店铺数占比',
   `month_eval_acco`      decimal(5,2)  comment '近30天评论数占比',
   `gmt_create`           string comment '创建时间'
)comment '店铺分析-店铺类目评价数分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_shop_cate_eval_num_subs                        */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_shop_cate_eval_num_subs`
(
   `id`                   bigint  comment '主键',
   `category_id`          bigint comment '行业 ID',
   `site_id`              bigint comment '站点 ID',
   `shop_count`           bigint comment '店铺总数',
   `eval_count`           bigint comment '评论总数',
   `shop_incr`            bigint comment '近1天店铺增量',
   `eval_incr`            bigint comment '近1天评论增量',
   `shop_acco`            decimal(5,2)  comment '近1天店铺数占比',
   `eval_acco`            decimal(5,2)  comment '近1天评论数占比',
   `weeks_shop_incr`      bigint comment '近7天店铺增量',
   `weeks_eval_incr`      bigint comment '近7天评论增量',
   `weeks_shop_acco`      decimal(5,2)  comment '近7天店铺数占比',
   `weeks_eval_acco`      decimal(5,2)  comment '近7天评论数占比',
   `month_shop_incr`      bigint comment '近30天店铺增量',
   `month_eval_incr`      bigint comment '近30天评论增量',
   `month_shop_acco`      decimal(5,2)  comment '近30天店铺数占比',
   `month_eval_acco`      decimal(5,2)  comment '近30天评论数占比',
   `gmt_create`           string comment '创建时间'
)comment '分站店铺分析-店铺类目评价数分布'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_shop_info                                      */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_shop_info`
(
   `id`                            bigint  comment '主键',
   `site_id`                       bigint comment '站点 ID',
   `shop_id`                       bigint comment '店铺 ID',
   `item_num`                      bigint comment '商品数',
   `eval_item_ave_price`           decimal(10,2) comment '有评价商品折扣均价',
   `item_eval_rate`                decimal(5,2) comment '产品评价率',
   `eval_item_num`                 bigint comment '有评价商品数',
   `praise_rate`                   decimal(5,2) comment '好评率',
   `ave_ori_price`                 decimal(10,2) comment '原价均价',
   `ave_price`                     decimal(10,2) comment '折扣价均价',
   `price_currency`                string comment '价格币种   1 RM  2  $    后面再扩展其他符号',
   `on_time_delivery_rate`         decimal(5,2) comment '准时送达率',
   `category_name`                 varchar(200) comment '主营类目',
   `eval_count`                    bigint comment '累计评论数',
   `weeks_ave_new_item_num`        bigint comment '近7天平均上新产品数',
   `chat_response_rate`            decimal(5,2) comment '聊天回复率',
   `gmt_create`                    string comment '创建时间'
)comment '店铺-店铺信息表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_shop_num                                       */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_shop_num`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点 ID（默认为0意思是全站）',
   `ord_shop_num`         bigint comment '普通店铺数量',
   `off_shop_num`         bigint comment '官方店铺数量',
   `tao_shop_num`         bigint comment '淘宝店铺数量',
   `gmt_create`           string comment '创建时间'
)comment '店铺分析-店铺数量趋势图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_shop_sales_data_det                            */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_shop_sales_data_det`
(
   `id`                            bigint  comment '主键',
   `shop_id`                       bigint comment '店铺 ID',
   `site_id`                       bigint comment '站点 ID',
   `ave_ori_price`                 decimal(10,2) comment '原价均价',
   `ave_price`                     decimal(10,2) comment '折扣价均价',
   `eval_item_ave_price`           decimal(10,2) comment '有评价商品折扣均价',
   `eval_item_ave_ori_price`       decimal(10,2) comment '有评价商品原价均价',
   `price_currency`                string comment '价格币种   1 RM  2  $    后面再扩展其他符号',
   `item_num`                      bigint comment '商品数',
   `day_new_item_num`              bigint comment '日新增商品数',
   `day_new_eval_item_num`         bigint comment '日新增有评价商品数',
   `eval_item_num`                 bigint comment '有评价的商品数',
   `eval_count`                    bigint comment '累计评价数',
   `weeks_ave_eval_num`            bigint comment '7天平均评价数',
   `weeks_eval_num_cycle_ratio`    decimal(10,2) comment '7天评价数环比',
   `weeks_ave_new_item_num`        bigint comment '7天平均上新产品数',
   `item_eval_rate`                decimal(5,2) comment '产品评价率',
   `praise_num`                    bigint comment '好评数',
   `cen_eval_num`                  bigint comment '中评数',
   `poor_eval_num`                 bigint comment '差评数',
   `gmt_create`                    string comment '创建时间'
)comment '店铺-店铺销售数据明细'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_shop_type_acco                                 */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_shop_type_acco`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点 ID',
   `shop_type`            string comment '店铺类型(1.普通店铺  2.官方店铺  3.淘宝店铺)',
   `day_shop_num`         bigint comment '近1天店铺数',
   `weeks_shop_num`       bigint comment '近7天店铺数',
   `month_shop_num`       bigint comment '近30天店铺数',
   `day_acco`             decimal(5,2)  comment '近1天占比',
   `weeks_acco`           decimal(5,2)  comment '近7天占比',
   `month_acco`           decimal(5,2)  comment '近30天占比',
   `gmt_create`           string comment '创建时间'
)comment '店铺分析-各站点店铺类型占比图'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_sku_eval_star_dis                              */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_sku_eval_star_dis`
(
   `id`                   bigint  comment '主键',
   `site_id`              bigint comment '站点 ID',
   `sku_id`               string comment 'sku ID',
   `eval_count`           bigint comment '评论数',
   `rating_score`         decimal(3,2) comment '平均星级',
   `one_star`             bigint comment '一星',
   `two_star`             bigint comment '二星',
   `three_star`           bigint comment '三星',
   `four_star`            bigint comment '四星',
   `five_star`            bigint comment '五星',
   `gmt_create`           string comment '创建时间'
)comment '产品-SKU 评价数的星级分布表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_sku_trend                                      */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_sku_trend`
(
   `id`                   bigint ,
   `site_id`              bigint comment '站点 ID',
   `sku_id`               string comment 'sku ID',
   `original_price`       decimal(10,2) comment 'SKU 原价',
   `price`                decimal(10,2) comment 'SKU 折扣价',
   `day_eval_num`         bigint comment '日评价数',
   `inventory`            bigint comment '总增量库存(前面的所有库存的增量之和)',
   `day_inventory`        bigint comment '1天增量库存',
   `weeks_inventory`      bigint comment '7天增量库存',
   `month_inventory`      bigint comment '30天增量库存',
   `gmt_create`           string comment '创建时间'
)comment '产品-SKU趋势图表'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");




/*==============================================================*/
/* Table: lz_rpt_sta_shop_sta                                   */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_sta_shop_sta`
(
   `id`                         bigint  comment '主键',
   `site_id`                    bigint comment '站点 ID (默认为0就是全站)',
   `shop_type`                  string comment '类型(1.全站  2.普通店铺   3.官方店铺  4.淘宝店铺)',
   `shop_count`                 string comment '店铺总数',
   `shop_acco`                  decimal(5,2)  comment '店铺全站占比',
   `shop_growth`                decimal(10,2)  comment '店铺环比增幅',
   `eval_shop_count`            string comment '有评价店铺总数',
   `eval_shop_acco`             decimal(5,2)  comment '有评价全站占比',
   `eval_shop_growth`           decimal(10,2)  comment '有评价店铺环比增幅',
   `weeks_new_shop_count`       string comment '7日新增店铺总数',
   `weeks_new_shop_acco`        decimal(5,2)  comment '7日新增店铺全站占比',
   `weeks_new_shop_growth`      decimal(10,2)  comment '7日新增店铺环比增幅',
   `gmt_create`                 string comment '创建时间'
)comment '店铺分析-店铺统计'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");





/*==============================================================*/
/* Table: lz_rpt_yest_top_ten_ind                               */
/*==============================================================*/
create external table if not exists `lazada_base.lz_rpt_yest_top_ten_ind`
(
   `id`                   bigint comment '主键',
   `category_id`          bigint comment '行业 ID',
   `site_id`              bigint comment '站点 ID',
   `item_count`           bigint comment '商品总数',
   `eval_item_count`      bigint comment '有评价商品总数',
   `eval_num`             bigint comment '评价数',
   `eval_num_gro`         decimal(10,2)  comment '评价数增幅',
   `eval_num_acco`        decimal(5,2)  comment '评价数占比',
   `shop_num`             bigint comment '店铺数',
   `gmt_create`           string comment '创建时间'
)comment '行业-昨日top10行业'
partitioned by (
    `dt` string  comment '日期分区字段{"format":"yyyymmdd"}')
row format delimited
    fields terminated by '\t'
    lines terminated by '\n'
stored as ORC  
location 'cosn://...'
tblproperties("orc.compress"="SNAPPY");



/*==============================================================*/
/* Table: lz_rpt_sku_sell_well_top_five                         */
/*==============================================================*/
create table lz_rpt_sku_sell_well_top_five
(
   id                   bigint(64) not null comment '主键',
   item_id              bigint(64) comment '产品 ID',
   site_id              int(11) comment '站点 ID',
   sku_key              varchar(20) comment 'SKU名字的键',
   sku_value            varchar(20) comment 'SKU名字的值',
   reviews              int(11) comment '评价数',
   gmt_create           datetime comment '创建时间',
   primary key (id)
);

alter table lz_rpt_sku_sell_well_top_five comment 'RPT-产品-SKU热销top5';