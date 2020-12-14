





CREATE TABLE `channel_change_data_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(50) DEFAULT NULL COMMENT '渠道Id',
  `product_id` int(11) DEFAULT NULL COMMENT '套餐Id',
  `change_num` int(11) DEFAULT NULL COMMENT '转化人数',
  `past_change_num` int(11) DEFAULT NULL COMMENT '昨日转化人数',
  `gmv` int(11) DEFAULT NULL COMMENT '交易额',
  `past_gmv` int(11) DEFAULT NULL COMMENT '昨日交易额',
  `artificial_change` int(11) DEFAULT NULL COMMENT '人工转化人数',
  `natural_change` int(11) DEFAULT NULL COMMENT '自然转化人数',
  `first_buy_gmv` int(11) DEFAULT NULL COMMENT '初次购买交易额',
  `repetition_buy_gmv` int(11) DEFAULT NULL COMMENT '复购交易额',
  `artificial_change_gmv` int(11) DEFAULT NULL COMMENT '人工转化交易额',
  `natural_change_gmv` int(11) DEFAULT NULL COMMENT '自然转化交易额',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5892 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='统计当天注册当天购买的用户数据';





CREATE TABLE `channel_change_data_month` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(36) DEFAULT NULL COMMENT '渠道Id',
  `product_id` int(11) DEFAULT NULL COMMENT '套餐Id',
  `change_num` int(11) DEFAULT NULL COMMENT '转化人数',
  `past_change_num` int(11) DEFAULT NULL COMMENT '上月转化人数',
  `gmv` int(11) DEFAULT NULL COMMENT '交易额',
  `past_gmv` int(11) DEFAULT NULL COMMENT '上月交易额',
  `artificial_change` int(11) DEFAULT NULL COMMENT '人工转化',
  `natural_change` int(11) DEFAULT NULL COMMENT '自然转化',
  `first_buy_gmv` int(11) DEFAULT NULL COMMENT '初次购买交易额',
  `repetition_buy_gmv` int(11) DEFAULT NULL COMMENT '重购交易额',
  `artificial_change_gmv` int(11) DEFAULT NULL COMMENT '人工转化交易额',
  `natural_change_gmv` int(11) DEFAULT NULL COMMENT '自然转化交易额',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=344 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;




CREATE TABLE `channel_change_data_week` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(36) DEFAULT NULL COMMENT '渠道Id',
  `product_id` int(11) DEFAULT NULL COMMENT '套餐Id',
  `change_num` int(11) DEFAULT NULL COMMENT '转化人数',
  `past_change_num` int(11) DEFAULT NULL COMMENT '上周转化人数',
  `gmv` int(255) DEFAULT NULL COMMENT '交易额',
  `past_gmv` int(11) DEFAULT NULL COMMENT '上周交易额',
  `artificial_change` int(11) DEFAULT NULL COMMENT '人工转化',
  `natural_change` int(11) DEFAULT NULL COMMENT '自然转化',
  `first_buy_gmv` int(11) DEFAULT NULL COMMENT '初次购买交易额',
  `repetition_buy_gmv` int(11) DEFAULT NULL COMMENT '重购交易额',
  `artificial_change_gmv` int(11) DEFAULT NULL COMMENT '人工转化交易额',
  `natural_change_gmv` int(11) DEFAULT NULL COMMENT '自然转化交易额',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1087 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;



CREATE TABLE `channel_change_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `res_date` varchar(20) DEFAULT NULL,
  `channel_id` varchar(36) DEFAULT NULL COMMENT '渠道Id',
  `product_id` int(11) DEFAULT NULL COMMENT '套餐Id',
  `change_num` int(11) DEFAULT NULL COMMENT '转化量',
  `past_change_num` int(11) DEFAULT NULL COMMENT '昨日转化量',
  `gmv` int(11) DEFAULT NULL COMMENT '交易额',
  `past_gmv` int(11) DEFAULT NULL COMMENT '昨日交易额',
  `at_change_num` int(11) DEFAULT NULL COMMENT '累计转化量',
  `at_gmv` bigint(50) DEFAULT NULL COMMENT '累计交易额',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11673 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;




CREATE TABLE `channel_change_num` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `res_date` varchar(20) DEFAULT NULL COMMENT '注册日期(保留近七天)',
  `channel_id` varchar(36) DEFAULT NULL COMMENT '渠道Id',
  `change_num` int(11) DEFAULT NULL COMMENT '转化人数',
  `date` varchar(20) DEFAULT NULL COMMENT '统计时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1660 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='这个统计的是有近七天的日期,注册日期是近七天的时间，转化人数是注册日期在统计当天的转化人数';



CREATE TABLE `channel_change_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(36) DEFAULT NULL COMMENT '渠道Id',
  `res_date` varchar(15) DEFAULT NULL COMMENT '注册日期',
  `seven_day_num` int(11) DEFAULT NULL COMMENT '近7天转化量',
  `fourteen_day_num` int(11) DEFAULT NULL COMMENT '近14天转化量',
  `thirty_day_num` int(11) DEFAULT NULL COMMENT '近30天转化量',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19059 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;



CREATE TABLE `channel_res_num` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(36) DEFAULT NULL COMMENT '渠道Id',
  `res_num` int(11) DEFAULT NULL COMMENT '注册人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1133 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;


CREATE TABLE `repurchase_analysis_data_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色Id',
  `product_id` int(11) DEFAULT NULL,
  `repurchase_num` int(11) DEFAULT NULL COMMENT '复购量',
  `past_repurchase_num` varchar(255) DEFAULT NULL COMMENT '昨日复购量',
  `gmv` int(11) DEFAULT NULL COMMENT '交易额',
  `past_gmv` int(11) DEFAULT NULL COMMENT '昨日交易额',
  `artificial_change` int(11) DEFAULT NULL COMMENT '人工转化人数',
  `natural_change` int(11) DEFAULT NULL COMMENT '自然转化人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2860 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `repurchase_analysis_data_month` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色Id',
  `product_id` int(11) DEFAULT NULL,
  `repurchase_num` int(11) DEFAULT NULL COMMENT '复购量',
  `past_repurchase_num` varchar(255) DEFAULT NULL COMMENT '昨日复购量',
  `gmv` int(11) DEFAULT NULL COMMENT '交易额',
  `past_gmv` int(11) DEFAULT NULL COMMENT '昨日交易额',
  `artificial_change` int(11) DEFAULT NULL COMMENT '人工转化人数',
  `natural_change` int(11) DEFAULT NULL COMMENT '自然转化人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `repurchase_analysis_data_week` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL COMMENT '角色Id',
  `product_id` int(11) DEFAULT NULL,
  `repurchase_num` int(11) DEFAULT NULL COMMENT '复购量',
  `past_repurchase_num` varchar(255) DEFAULT NULL COMMENT '昨日复购量',
  `gmv` int(11) DEFAULT NULL COMMENT '交易额',
  `past_gmv` int(11) DEFAULT NULL COMMENT '昨日交易额',
  `artificial_change` int(11) DEFAULT NULL COMMENT '人工转化人数',
  `natural_change` int(11) DEFAULT NULL COMMENT '自然转化人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=472 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `repurchase_analysis_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(20) DEFAULT NULL,
  `repurchase_num` int(11) DEFAULT NULL COMMENT '复购量',
  `past_repurchase_num` varchar(255) DEFAULT NULL COMMENT '昨日复购量',
  `gmv` int(11) DEFAULT NULL COMMENT '交易额',
  `past_gmv` int(11) DEFAULT NULL COMMENT '昨日交易额',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=294 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `repurchase_num` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(10) DEFAULT NULL,
  `over_date` varchar(20) DEFAULT NULL COMMENT '过期时间',
  `repurchase_num` int(11) DEFAULT NULL COMMENT '复购人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1657 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `repurchase_over_num` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(10) DEFAULT NULL,
  `over_num` int(11) DEFAULT NULL COMMENT '过期人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `repurchase_total` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` varchar(10) DEFAULT NULL COMMENT '项目Id',
  `over_date` varchar(15) DEFAULT NULL COMMENT '过期时间',
  `seven_day_num` int(11) DEFAULT NULL COMMENT '近7天复购量',
  `fourteen_day_num` int(11) DEFAULT NULL COMMENT '近14天复购量',
  `thirty_day_num` int(11) DEFAULT NULL COMMENT '近30天复购量',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12358 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `res_analysis_cumulative` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(50) DEFAULT NULL COMMENT '渠道Id',
  `res_num` int(11) DEFAULT NULL COMMENT '累计注册人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2468 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `res_analysis_data_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(50) DEFAULT NULL COMMENT '渠道Id',
  `res_num` int(11) DEFAULT NULL COMMENT '注册人数',
  `past_res_num` int(11) DEFAULT NULL COMMENT '昨日注册人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1573 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `res_analysis_data_month` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(50) DEFAULT NULL COMMENT '渠道Id',
  `res_num` int(11) DEFAULT NULL COMMENT '注册人数',
  `past_res_num` int(11) DEFAULT NULL COMMENT '上月注册人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `res_analysis_data_week` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` varchar(50) DEFAULT NULL COMMENT '渠道Id',
  `res_num` int(11) DEFAULT NULL COMMENT '注册人数',
  `past_res_num` int(11) DEFAULT NULL COMMENT '上周注册人数',
  `date` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb4;



CREATE TABLE `rpt_user_portrait_details` (
  `id` varchar(255) CHARACTER SET utf8 NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `valid_user_num` int(11) DEFAULT NULL COMMENT '有效用户数,有效期大于等于今天的',
  `before_day_valid_user_num` int(11) DEFAULT NULL COMMENT '前天有效用户数',
  `first_pay_num` int(11) DEFAULT NULL COMMENT '初次购买人数，支付表只有一条记录的',
  `repeat_pay_num` int(11) DEFAULT NULL COMMENT '复购人数，支付表有大于一条记录的',
  `pay_num` int(11) DEFAULT NULL COMMENT '当天购买人数',
  `before_day_pay_num` int(11) DEFAULT NULL COMMENT '前天购买人数',
  `over_num` int(11) DEFAULT NULL COMMENT '当天即将过期人数，有效期等于今天的',
  `before_day_over_num` int(11) DEFAULT NULL COMMENT '前天过期人数',
  `natural_pay_num` int(11) DEFAULT NULL COMMENT '自然转化人数',
  `artificial_pay_num` int(11) DEFAULT NULL COMMENT '人工转化人数',
  `date` varchar(20) DEFAULT NULL COMMENT '日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;



CREATE TABLE `rpt_user_portrait_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `valid_user_num` int(11) DEFAULT NULL COMMENT '用户量',
  `date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4706 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;



CREATE TABLE `user_liveness` (
  `id` varchar(150) NOT NULL COMMENT '主键id',
  `user_name` varchar(100) DEFAULT NULL COMMENT '实际内容是uid，只是字段名叫user_name',
  `user_type_id` int(11) DEFAULT NULL COMMENT '用户类型id',
  `login_date` varchar(50) DEFAULT NULL COMMENT '用户登录日期时间',
  `app_id` varchar(50) DEFAULT NULL COMMENT '项目标识',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户活跃度分析';



CREATE TABLE `user_liveness_data` (
  `id` varchar(150) NOT NULL COMMENT '主键id',
  `DAU` bigint(255) DEFAULT NULL COMMENT '近一天不同登录用户数量',
  `WAU` bigint(255) DEFAULT NULL COMMENT '近七天不同登录用户数量',
  `MAU` bigint(255) DEFAULT NULL COMMENT '近三十天不同用户登录数量',
  `login_date` varchar(50) DEFAULT NULL COMMENT '用户登录日期(统计日期)',
  `app_id` varchar(50) DEFAULT NULL COMMENT '项目标识',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户活跃度分析数量数据';



CREATE TABLE `tj_visit_analysis` (
  `id` varchar(40) NOT NULL COMMENT 'ID app_name_timest',
  `app_name` varchar(20) NOT NULL COMMENT 'APPID',
  `day_pv` int(11) NOT NULL DEFAULT '0' COMMENT '日PV',
  `day_uv` int(11) NOT NULL DEFAULT '0' COMMENT '日UV',
  `day_ip` int(11) NOT NULL DEFAULT '0' COMMENT '日IP',
  `day_avg_visit_time` int(11) NOT NULL COMMENT '日平均访问时长，单位秒',
  `timest` varchar(10) NOT NULL COMMENT '账期：2020-08-07代表08-06日的数据',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `app_time_idx` (`app_name`,`timest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='运营后台-产品访问分析(数据保留近半年)';




CREATE TABLE `tj_use_time` (
  `id` varchar(100) NOT NULL COMMENT 'APP_ID+PRODUCT_ID+TIMEST',
  `app_id` varchar(50) NOT NULL COMMENT '应用ID',
  `main_product_id` int(11) DEFAULT NULL COMMENT '主产品ID不产于计算',
  `product_id` int(5) DEFAULT NULL COMMENT '产品ID',
  `day_use_time` int(11) DEFAULT NULL COMMENT '日使用总时长(单位：秒)',
  `day_avg_use_time` int(11) DEFAULT NULL COMMENT '日平均使用时长(单位：秒)',
  `day_use_count` int(11) DEFAULT NULL COMMENT '日使用人数(单位：个)',
  `timest` varchar(10) DEFAULT NULL COMMENT '账期(2020-08-10的为2020-08-09日的数据)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `timest_idx` (`timest`),
  KEY `app_product_idx` (`app_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品使用时长';



CREATE TABLE `tj_use_time_analysis` (
  `id` varchar(100) NOT NULL COMMENT 'APP_ID_SOLT_ID+PRODUCT_ID+TIMEST',
  `app_id` varchar(50) NOT NULL COMMENT '应用ID',
  `solt_id` int(11) NOT NULL COMMENT '时间段ID',
  `main_product_id` int(11) DEFAULT NULL COMMENT '主产品ID，不参与统计',
  `product_id` int(5) DEFAULT NULL COMMENT '产品ID',
  `day_use_time` int(11) DEFAULT NULL COMMENT '日使用总时长(单位：秒)',
  `day_avg_use_time` int(11) DEFAULT NULL COMMENT '日平均使用时长(单位：秒)',
  `day_use_count` int(11) DEFAULT NULL COMMENT '日使用人数(单位：个)',
  `timest` varchar(10) DEFAULT NULL COMMENT '账期(2020-08-10的为2020-08-09日的数据)',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `timest_idx` (`timest`),
  KEY `app_product_idx` (`app_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品使用时长';



CREATE TABLE `tj_track_event` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `appid` varchar(50) DEFAULT NULL COMMENT '应用ID',
  `label` varchar(60) DEFAULT NULL COMMENT '事件具体名称',
  `action` varchar(60) DEFAULT NULL COMMENT '事件',
  `category` varchar(60) DEFAULT NULL COMMENT '类型',
  `main_product_id` int(11) DEFAULT NULL COMMENT '主产品ID，不参与统计',
  `pid` int(11) DEFAULT NULL COMMENT '产品类型',
  `all_event_count` int(11) DEFAULT NULL COMMENT '事件点击总数',
  `event_count` int(11) DEFAULT NULL COMMENT '事件点击总数(按产品区分)',
  `all_uid_count` int(11) DEFAULT NULL COMMENT '访客总数',
  `uniq_event_count` int(11) DEFAULT NULL COMMENT '唯一访客事件数(按产品区分)',
  `timest` varchar(14) DEFAULT NULL COMMENT 'YYYY-DD-MM 账期（今日代表昨日）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `tj_label_pid_index` (`label`,`pid`,`action`,`category`),
  KEY `tj_appid_index` (`appid`),
  KEY `tj_timest_index` (`timest`)
) ENGINE=InnoDB AUTO_INCREMENT=108557 DEFAULT CHARSET=utf8mb4 COMMENT='事件表';



CREATE TABLE `tj_page_count` (
  `id` varchar(100) NOT NULL COMMENT 'pct_id_app_id_timest',
  `app_id` varchar(20) NOT NULL,
  `pct_id` varchar(60) NOT NULL COMMENT '页面唯一标识',
  `pct_name` varchar(40) DEFAULT NULL COMMENT '页面功能描叙',
  `day_uv` int(11) DEFAULT NULL COMMENT '日访问人数',
  `day_uv_rato` int(11) DEFAULT '0' COMMENT '日访问人数增长率（分子/10000）',
  `day_pv` int(11) DEFAULT '0' COMMENT '日访问次数',
  `day_use_time` int(11) DEFAULT '0' COMMENT '日总访问时长',
  `day_avg_use_time` int(11) DEFAULT NULL COMMENT '日平均时长',
  `timest` varchar(10) DEFAULT NULL COMMENT '账期:2020-08-10为2020-08-09日的数据',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `app_pct_idx` (`app_id`,`pct_id`),
  KEY `timest_idx` (`timest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='页面访问数据';




CREATE TABLE `tj_page_product_count` (
  `id` varchar(100) NOT NULL COMMENT 'pct_id_app_id_product_timest',
  `app_id` varchar(20) NOT NULL,
  `pct_id` varchar(60) NOT NULL COMMENT '页面唯一标识',
  `pct_name` varchar(60) DEFAULT NULL COMMENT '页面功能描叙',
  `main_product_id` int(11) DEFAULT NULL COMMENT '主产品ID，不参与统计',
  `product_id` int(5) DEFAULT NULL COMMENT '产品ID',
  `day_uv` int(11) DEFAULT '0' COMMENT '日访问人数',
  `day_pv` int(11) DEFAULT '0' COMMENT '日访问次数',
  `day_use_time` int(11) DEFAULT '0' COMMENT '日总访问时长',
  `day_avg_use_time` int(11) DEFAULT NULL COMMENT '日平均时长',
  `timest` varchar(10) DEFAULT NULL COMMENT '账期:2020-08-10为2020-08-09日的数据',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `app_pct_idx` (`app_id`,`pct_id`),
  KEY `timest_idx` (`timest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='页面产品级别访问数据';



CREATE TABLE `pd_order` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ORDER_NO` varchar(64) DEFAULT NULL COMMENT '订单号',
  `USER_ID` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `CHARGE_ID` int(10) unsigned DEFAULT NULL,
  `PRODUCT_ID` int(10) unsigned DEFAULT NULL COMMENT '主产品ID',
  `PRODUCT_ITEM_ID` int(10) unsigned DEFAULT NULL COMMENT '子产品ID',
  `AMOUNT` int(10) unsigned DEFAULT NULL COMMENT '订单金额',
  `PRICE` int(10) unsigned DEFAULT NULL COMMENT '原价（单位：分）',
  `DISCOUNT` decimal(10,2) DEFAULT NULL COMMENT '折扣',
  `DISCOUNT_PRICE` int(11) DEFAULT NULL COMMENT '折后价（单位：分）',
  `DISCOUNT_CODE_ID` int(10) unsigned DEFAULT NULL COMMENT '折扣码ID',
  `PAY_MODE` int(10) unsigned DEFAULT NULL COMMENT '支付模式：0线上，1线下',
  `PAY_TIME` datetime DEFAULT NULL COMMENT '支付时间',
  `MATURITY_TIME` datetime DEFAULT NULL COMMENT '到期时间',
  `ONLINE_PAY_TYPE` varchar(50) DEFAULT NULL COMMENT '线上支付方式：微信、支付宝（对接支付网关）',
  `OFFLINE_PAY_TYPE` int(10) unsigned DEFAULT NULL COMMENT '线下支付方式：0企业微信，1企业支付宝，2个人微信，3个人支付宝，4对公转账，99其他',
  `ORDER_STATUS` int(10) unsigned DEFAULT '0' COMMENT '订单状态：0待支付，1支付成功，2支付失败',
  `GATEWAY_CODE` int(11) DEFAULT NULL COMMENT '支付网关返回状态码',
  `GATEWAY_CALLBACK_TIME` datetime DEFAULT NULL COMMENT '支付网关回调时间',
  `RAM_CODE` int(11) DEFAULT NULL COMMENT 'ram处理返回状态码',
  `RAM_CALL_TIME` datetime DEFAULT NULL COMMENT 'ram调用时间',
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '生成订单时间',
  `OPERATOR` int(11) DEFAULT NULL COMMENT '操作人ID',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '支付备注',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2030 DEFAULT CHARSET=utf8mb4 COMMENT='订单信息表';



