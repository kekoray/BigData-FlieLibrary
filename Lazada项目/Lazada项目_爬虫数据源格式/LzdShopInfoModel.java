package com.menglar.spider.consumer.model.csv;

import lombok.Data;

@Data
public class LzdShopInfoModel {

    private Integer shopId; //店铺id
//    private String chatUrl; //聊天连接
//    private Boolean imEnable;
//    private String imUserId;
//    private String name;
//    private Boolean newSeller;
//    private String percentRate;
//    private Double rate;
//    private Integer rateLevel;
//    private String sellerId;
//    private Integer shopId;
//    private Integer time;
//    private String unit;
//    private String url;
//    private String chatResponsiveRate;
//    private String positiveSellerRating;
//    private String shipOnTime;
//    private String creatTime; // 抓取时间
    private String siteId;	//站点id
    private String shopName;//	店铺名称
    private String mainCat;//	主营类目(一级类目)
    private String salesCat;//	店铺销售类别,逗号隔开 (二级类目)
    private String totalResults;//	商品总数量
    private String totalItems;//	累计评价数
    private String followerNum;//	用户关注数/收藏数
    private String negative;//	差评数量
    private String neutral;//	中评数量
    private String positive;//	好评数量
    private String shoprating;//	好评率
    private String identity;//	店铺类型(旗舰-official,认证-certified,普通-seller)
    private String officialLabel;//	官方标签
    private String shopRating;//	店铺评级
    private String cancelRate;//	卖家取消率
    private String deliveryRate;//	准时送达
    private String responseratestr;//	聊天回复率
    private String increaserate;//	准时送达增长率
    private String sellerId;//	卖家id
    private String joinTime;//	加入时间
    private String shopLogo;//	店铺主图链接
    private String sellerKey;//	店铺key,用于拼接url
    private String shopCenterDomain;//	请求路径
    private String appDomain;//	请求路径
    private String shopUrl;//	店铺url=请求路径+店铺key
    private String pageId;
    private String pageName;//

    //加入时间
    private Integer time; //数字
    private String unit;  //单位
    private Integer rateLevel; //评分等级

    private String createTime;//	创建时间



}
