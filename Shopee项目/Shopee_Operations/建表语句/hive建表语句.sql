
/*==============================================================*/
/* Database:  shopee_operations                                 */
/*==============================================================*/
create database if not exists `shopee_operations` COMMENT 'Shopee Operations Center Data Warehouse Project' 
WITH DBPROPERTIES ('creater'='koray','date'='20201105');


--查看库结构
DESCRIBE database shopee_operations;


--使用库
use shopee_operations;




/*==============================================================*/
/* Table:  bs_channel_change_data_day                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `bs_channel_change_data_day`(
  `channel_id` string, 
  `product_id` string, 
  `change_num` string, 
  `past_change_num` string, 
  `gmv` string, 
  `past_gmv` string, 
  `artificial_change` string, 
  `natural_change` string, 
  `first_buy_gmv` string, 
  `repetition_buy_gmv` string, 
  `artificial_change_gmv` string, 
  `natural_change_gmv` string)
COMMENT '渠道转化天留存表'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/bs_channel_change_data_day/';




/*==============================================================*/
/* Table:  bs_res_analysis_data_day                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `bs_res_analysis_data_day`(
  `channel_id` string, 
  `res_num` string, 
  `past_res_num` string)
COMMENT 'res_analysis_cumulative'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/bs_res_analysis_data_day/';





/*==============================================================*/
/* Table:  login_buy_detail                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `login_buy_detail`(
  `id` string, 
  `event` string COMMENT '事件名称', 
  `app_id` string COMMENT '产品名称', 
  `channel_id` string COMMENT '渠道ID', 
  `turn_type` string COMMENT '转化方式:0是自然\;1是人工\;默认是0', 
  `pay_times` string COMMENT '购买次数', 
  `ua` string COMMENT 'User-Agent', 
  `device_id` string COMMENT '设备id', 
  `device_type` string COMMENT '设备类型：访问来源，值是常量:DEVICE_TYPE_PC', 
  `uid` string COMMENT '用户id', 
  `ip` string COMMENT '用户ip', 
  `path` string COMMENT '请求路径', 
  `trigger_time` string COMMENT '日志的触发时间', 
  `province` string COMMENT '省份', 
  `city` string COMMENT '市', 
  `create_time` string COMMENT '日志的创建时间', 
  `status` string COMMENT '数据状态,正常是0', 
  `comment` string COMMENT '备注', 
  `reg_time` string COMMENT '注册时间,即用户的创建时间', 
  `mobile` string COMMENT '手机号码', 
  `over_time` string COMMENT '到期日期', 
  `member_type` string COMMENT '订单类型，普通(nml),标准(sta),专业(pro),高级(high),旗舰(flag),终身(life)', 
  `user_name` string COMMENT '用户名称', 
  `pay_date` string COMMENT '交易达成时间', 
  `member_months` string COMMENT '订单月数,月度会员(1),年度会员(12),终身会员(-1)', 
  `product_type` string COMMENT 'productID', 
  `amount` string)
COMMENT '渠道转化解析了json的'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/login_buy_detail/';





/*==============================================================*/
/* Table:  login_buy_log                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `login_buy_log`(
  `id` string, 
  `event` string COMMENT '事件名称', 
  `app_id` string COMMENT '产品名称', 
  `channel_id` string COMMENT '渠道ID', 
  `turn_type` string COMMENT '转化方式:0是自然\;1是人工\;默认是0', 
  `pay_times` string COMMENT '购买次数', 
  `ua` string COMMENT 'User-Agent', 
  `device_id` string COMMENT '设备id', 
  `device_type` string COMMENT '设备类型：访问来源，值是常量:DEVICE_TYPE_PC', 
  `uid` string COMMENT '用户id', 
  `ip` string COMMENT '用户ip', 
  `path` string COMMENT '请求路径', 
  `trigger_time` string COMMENT '日志的触发时间', 
  `province` string COMMENT '省份', 
  `city` string COMMENT '市', 
  `create_time` string COMMENT '日志的创建时间', 
  `status` string COMMENT '数据状态,正常是0', 
  `comment` string COMMENT '备注', 
  `reg_time` string COMMENT '注册时间,即用户的创建时间', 
  `data` string COMMENT '日期')
COMMENT '渠道转化原始日志'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/login_buy_log/';





/*==============================================================*/
/* Table:  login_buy_overtime                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `login_buy_overtime`(
  `uid` string, 
  `app_id` string, 
  `over_time` string)
COMMENT '用户信息表'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/login_buy_overtime/';





/*==============================================================*/
/* Table:  login_buy_overtime_change                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `login_buy_overtime_change`(
  `uid` string, 
  `app_id` string, 
  `bef_over_time` string COMMENT '变更前的续费时间,初始化为null', 
  `aft_over_time` string COMMENT '变更后的续费时间,', 
  `change_date` string COMMENT '变更时间,初始化为null')
COMMENT '用户过期时间变更表'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/login_buy_overtime_change/';





/*==============================================================*/
/* Table:  login_buy_real                           */
/*==============================================================*/
  CREATE EXTERNAL TABLE `login_buy_real`(
  `id` string, 
  `event` string COMMENT '事件名称', 
  `app_id` string COMMENT '产品名称', 
  `channel_id` string COMMENT '渠道ID', 
  `turn_type` string COMMENT '转化方式:0是自然\;1是人工\;默认是0', 
  `pay_times` string COMMENT '购买次数', 
  `ua` string COMMENT 'User-Agent', 
  `device_id` string COMMENT '设备id', 
  `device_type` string COMMENT '设备类型：访问来源，值是常量:DEVICE_TYPE_PC', 
  `uid` string COMMENT '用户id', 
  `ip` string COMMENT '用户ip', 
  `path` string COMMENT '请求路径', 
  `trigger_time` string COMMENT '日志的触发时间', 
  `province` string COMMENT '省份', 
  `city` string COMMENT '市', 
  `create_time` string COMMENT '日志的创建时间', 
  `status` string COMMENT '数据状态,正常是0', 
  `comment` string COMMENT '备注', 
  `reg_time` string COMMENT '注册时间,即用户的创建时间', 
  `mobile` string COMMENT '手机号码', 
  `over_time` string COMMENT '到期日期', 
  `member_type` string COMMENT '订单类型，普通(nml),标准(sta),专业(pro),高级(high),旗舰(flag),终身(life)', 
  `user_name` string COMMENT '用户名称', 
  `pay_date` string COMMENT '交易达成时间', 
  `member_months` string COMMENT '订单月数,月度会员(1),年度会员(12),终身会员(-1)', 
  `product_id` string COMMENT 'productID', 
  `amount` string)
COMMENT '关联获取了正式的channel_id和product_type的表'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/login_buy_real/';





/*==============================================================*/
/* Table:  login_buy_total                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `login_buy_total`(
  `channel_id` string, 
  `product_id` string, 
  `total_change_num` string, 
  `total_gmv` string, 
  `total_artificial_change` string, 
  `total_natural_change` string)
COMMENT '渠道转化累计表'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/login_buy_total/';





/*==============================================================*/
/* Table:  register_total                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `register_total`(
  `channel_id` string, 
  `res_num` string)
COMMENT '渠道累计注册人数统计'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/register_total/';





/*==============================================================*/
/* Table:  sys_all_level_category                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `sys_all_level_category`(
  `type1_name` string COMMENT '一级类目', 
  `type1_id` string COMMENT '一级类目ID', 
  `type1_code` string COMMENT '一级类目code', 
  `type2_name` string COMMENT '二级级类目', 
  `type2_id` string COMMENT '二级级类目ID', 
  `type2_code` string COMMENT '二级类目code', 
  `type3_name` string COMMENT '三级级类目', 
  `type3_id` string COMMENT '三级级类目ID', 
  `type3_code` string COMMENT '三级类目code', 
  `type4_name` string COMMENT '四级级类目', 
  `type4_id` string COMMENT '四级级类目ID', 
  `type4_code` string COMMENT '四级类目code')
COMMENT '同步sys_category把类目打横'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/sys_all_level_category/';






/*==============================================================*/
/* Table:  sys_product_type                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `sys_product_type`(
  `app_id` string COMMENT '产品名称', 
  `role_id` string COMMENT '角色Id', 
  `role_name` string COMMENT '角色名称', 
  `sys_role_id` string COMMENT '对应系统Id', 
  `product_name` string COMMENT '套餐名称', 
  `product_id` string COMMENT '套餐Id', 
  `sys_product_id` string COMMENT '对应系统套餐Id')
COMMENT '同步sys_product_type'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/sys_product_type/';






/*==============================================================*/
/* Table:  tmp_login_buy_dic_overtime                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `tmp_login_buy_dic_overtime`(
  `uid` string, 
  `app_id` string, 
  `over_time` string)
COMMENT '用户过期时间去重表'
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/tmp_login_buy_dic_overtime/';





/*==============================================================*/
/* Table:  tmp_login_buy_overtime_range                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `tmp_login_buy_overtime_range`(
  `uid` string, 
  `app_id` string, 
  `min_over_time` string COMMENT '当天最小过期时间', 
  `max_over_time` string COMMENT '当天最大过期时间')
COMMENT '用户每天过期时间区间表'
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/tmp_login_buy_overtime_range/';



/*--------------------------------------------====== 业务分割线 ======---------------------------------------------------------*/


/*==============================================================*/
/* Table:  burying_point_log                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `burying_point_log`(
  `si` string COMMENT '唯一id，用于标识应用的唯一标识', 
  `tt` string COMMENT '页面标题', 
  `ds` string COMMENT '屏幕分辨率', 
  `lang` string COMMENT '浏览器语言', 
  `vs` string COMMENT 'js版本', 
  `su` string COMMENT '上一次来源地址', 
  `ep` string COMMENT '数据研报，事件', 
  `epcategory` string COMMENT '事件类别', 
  `epaction` string COMMENT '事件类型', 
  `eplabel` string COMMENT '事件别名', 
  `pi` string COMMENT '用户产品标识 (事件、自定义变量皆可),类似会员角色，事件没有具体使用时长概念', 
  `et` string COMMENT '事件触发时间，秒', 
  `cv` string COMMENT '数据研报，15 自定义变量', 
  `cvevent` string, 
  `cvmodel` string, 
  `cvname` string, 
  `cvvalue` string, 
  `uid` string COMMENT '用户id', 
  `ud` string COMMENT '用户唯一标识', 
  `vl` string COMMENT '距离顶部距离+可视化窗口距离 可视化窗口位置', 
  `cl` string COMMENT '24-bit 色彩深度位数', 
  `utm` string COMMENT '渠道追踪标识', 
  `st` string COMMENT 'session存储的页面session开始时间，刷新及改变', 
  `std` string COMMENT '页面session时间段', 
  `hst` string COMMENT '页面host地址', 
  `v` string COMMENT '当前页面地址', 
  `rnd` string COMMENT '随机串', 
  `ip` string COMMENT '请求服务IP地址', 
  `province` string COMMENT '省份', 
  `city` string COMMENT '城市', 
  `sc` string COMMENT '来源地址是否为外部地址 0 空来源 1外部来源 2内部来源', 
  `lv` string COMMENT '事件变量级别', 
  `pct` string COMMENT '标识-请求页请求页面页面属于那个标签')
COMMENT '用户时长等信息统计的原始日志'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/burying_point_log/';





/*==============================================================*/
/* Table:  sync_shopee_pd_order                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `sync_shopee_pd_order`(
  `id` string COMMENT '主键id', 
  `order_no` string COMMENT '订单号', 
  `user_id` string COMMENT '用户id', 
  `charge_id` string, 
  `product_id` string COMMENT '主产品id', 
  `product_item_id` string COMMENT '子产品id', 
  `amount` string COMMENT '订单金额', 
  `price` string COMMENT '原价，单位是分', 
  `discount` string COMMENT '折扣', 
  `discount_price` string COMMENT '折后价，单位是分', 
  `discount_code_id` string COMMENT '折扣码id', 
  `pay_mode` string COMMENT '支付模式：0线上，1线下', 
  `pay_time` string COMMENT '支付时间', 
  `maturity_time` string COMMENT '到期时间', 
  `online_pay_type` string COMMENT '线上支付方式：微信、支付宝（对接支付网关）', 
  `offline_pay_type` string COMMENT '线下支付方式：0企业微信，1企业支付宝，2个人微信，3个人支付宝，4对公转账，99其他', 
  `order_status` string COMMENT '订单状态：0待支付，1支付成功，2支付失败', 
  `gateway_code` string COMMENT '支付网关返回状态码', 
  `gateway_callback_time` string COMMENT '支付网关回调时间', 
  `ram_code` string COMMENT 'ram处理返回状态码', 
  `ram_call_time` string COMMENT 'ram调用时间', 
  `create_time` string COMMENT '订单生成时间', 
  `operator` string COMMENT '操作人', 
  `remark` string COMMENT '支付备注', 
  `tenant_id` string COMMENT '租户id')
COMMENT '知虾支付表'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/sync_shopee_pd_order/'





/*==============================================================*/
/* Table:  user_shopee_portrait_first_repeat                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `user_shopee_portrait_first_repeat`(
  `app_id` string COMMENT '业务名称', 
  `role_id` string COMMENT '角色id', 
  `role_name` string COMMENT '角色名称', 
  `sys_role_id` string COMMENT '对应系统Id', 
  `user_id` string COMMENT '用户id', 
  `pay_mode` string COMMENT '支付模式：0线上，1线下', 
  `maturity_time` string COMMENT '有效日期', 
  `pay_time` string COMMENT '创建时间', 
  `type` string COMMENT '1，首次 2，复购')
COMMENT '参谋各个服务版版本下的用户数据'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/user_shopee_portrait_first_repeat/'
 





 /*==============================================================*/
/* Table:  user_shopee_portrait_middle_data                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `user_shopee_portrait_middle_data`(
  `app_id` string COMMENT '业务名称', 
  `role_id` string COMMENT '角色id', 
  `role_name` string COMMENT '角色名称', 
  `sys_role_id` string COMMENT '对应系统Id', 
  `product_id` string COMMENT '套餐id', 
  `user_id` string COMMENT '用户id', 
  `pay_mode` string COMMENT '支付模式：0线上，1线下', 
  `maturity_time` string COMMENT '有效日期', 
  `pay_time` string COMMENT '创建时间')
COMMENT '参谋各个服务版版本下的用户数据'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/user_shopee_portrait_middle_data/'




 /*==============================================================*/
/* Table:  sync_product_type                           */
/*==============================================================*/
CREATE EXTERNAL TABLE `sync_product_type`(
  `id` string COMMENT '主键id', 
  `app_id` string COMMENT '业务名称', 
  `role_id` string COMMENT '角色id', 
  `role_name` string COMMENT '角色名称', 
  `sys_role_id` string COMMENT '对应系统Id', 
  `product_name` string COMMENT '套餐名称', 
  `product_id` string COMMENT '套餐id', 
  `sys_product_id` string COMMENT '对应系统套餐Id')
COMMENT '各个业务服务版本信息对应信息表'
PARTITIONED BY ( 
  `dt` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe' 
WITH SERDEPROPERTIES ( 
  'field.delim'='\t', 
  'line.delim'='\n', 
  'serialization.format'='\t') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'cosn://emr-1254463213/shopee_dw/operations_center/sync_product_type/'



