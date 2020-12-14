package com.menglar.spider.consumer.model.csv;


import lombok.Data;

/**
 * 评价数据
 */
@Data
public class LzdReviewModel {

    private Long reviewRateId;//评价ID
    private Long skuId; //skuId
    private Long itemId; //商品ID
    private Integer siteId; // 站点ID
    private Long sellerId; //店铺ID
    private String rating; //星
    private Integer likeCount;//点赞数
    private String reviewType;//评价类型
    private String clientType;//评价端 手机 or PC
    private String reviewContents;// 评论内容
    private String reviewTime; //评价日期
    private Integer buyerId; // 买家ID
    private String buyerName; //买家名称
    private String boughtDate; //购买日期
    private String skuInfo; //sku信息
    private String itemPic; //物品图片
    private String itemUrl; // 商品详情
    private String creatTime; // 抓取时间


}
