package com.menglar.spider.consumer.model.csv;

import lombok.Data;

import java.math.BigDecimal;

/**
 * 商品详情csv
 */
@Data
public class LzdItemInfoModel {

    private Long itemId ;    // 物品ID
    private String itemName;  //物品名称
    private Integer siteId;    //站点ID
    private String catName2;   // 类目2
    private String cataName3; // 类目3
    private Integer rateCount; //评论总条数
    private Integer reviewCount; //有文本评论数
    private String fee; //标准运费 带符号
    private BigDecimal feeValue;// 不带符号
    private String dsc; //描述
    private String itemImage; // 商品图片 使用;分割
    private BigDecimal avgStarScore; //商品评分(平均星级)
    private Integer starScore1; //评分为1的数量
    private Integer starScore2; //评分为2的数量
    private Integer starScore3; //评分为3的数量
    private Integer starScore4; //评分为4的数量
    private Integer starScore5; //评分为5的数量

    private Integer skusNum; // sku数量
    private String creatIime; // 创建时间


}
