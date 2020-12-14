package com.menglar.spider.consumer.core.model.entity.lazada;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Proxy;

import javax.persistence.Transient;
import java.io.Serializable;
import java.math.BigDecimal;

@Data
@Proxy(lazy = false)
public class LazadaItemModel implements Serializable {


    @JSONField(alternateNames = {"itemId"})
    private String itemId;

    @JSONField(alternateNames = {"name"})
    private String itemName;

    private Integer shopId;


    @JSONField(alternateNames = {"sellerName"})
    private String shopName;


    /**
     * 站点ID
     */
    private Integer siteId;


    @JSONField(alternateNames = {"categories"})
    private String categories;

    @JSONField(alternateNames = {"brandId"})
    private Integer brandId;

    @JSONField(alternateNames = {"skuId"})
    private String skuId;

    @JSONField(alternateNames = {"originalPrice"})
    private BigDecimal originalPrice;

    @JSONField(alternateNames = {"originalPriceShow"})
    private String originalPriceShow;

    @JSONField(alternateNames = {"price"})
    private BigDecimal price;
    @JSONField(alternateNames = {"priceShow"})
    private String priceShow;


    @JSONField(alternateNames = {"discount"})
    private String discount;

    @JSONField(alternateNames = {"review"})
    private String review;

    @JSONField(alternateNames = {"ratingScore"})
    private BigDecimal ratingScore;
    @JSONField(alternateNames = {"location"})
    private String location;




    @JSONField(alternateNames = {"sku"})
    private String sku;

    @JSONField(alternateNames = {"cheapest_sku"})
    private String cheapest_sku;
    @JSONField(alternateNames = {"restrictedAge"})
    private Integer restrictedAge;

    @JSONField(alternateNames = {"inStock"})
    private Boolean inStock;


    @JSONField(alternateNames = {"installment"})
    private String installment;

//    @JSONField(alternateNames = {"tItemType"})
//    private String tItemType;


//    @JSONField(alternateNames = {"skus"})
//    //数组类型需要转换
//    private String skus;

    @JSONField(alternateNames = {"description"})
    private String description;
    @JSONField(alternateNames = {"productUrl"})
    private String productUrl;
    @JSONField(alternateNames = {"image"})
    private String image;
    @JSONField(alternateNames = {"sellerId"})
    private String sellerId;

    @JSONField(alternateNames = {"mainSellerId"})
    private String mainSellerId;

    @JSONField(alternateNames = {"nid"})
    private String nid;


    @JSONField(alternateNames = {"promotionId"})
    private String promotionId;


//    @JSONField(alternateNames = {"addToCartSkus"}
//
//    private String addToCartSkus;


    @JSONField(alternateNames = {"isAD"})
    private Integer isAD;


    @Transient
    @JSONField(alternateNames = {"clickTrace"})
    private String clickTrace;

    /**
     * 抓取时间 yyyy'-'MM'-'dd HH':'mm':'ss'
     */
    private String creatTime;






}
