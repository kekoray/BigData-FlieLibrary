package com.menglar.spider.consumer.model.csv;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

import java.math.BigDecimal;

/**
 * sku表
 */
@Data
public class LzdSkuModel {



    private String skuId;       //skuid
    private String itemId;      //商品ID
    private Integer siteId; //站点Id
    private String brandId;    //品牌ID
    private String shopId;    //商店ID
    private String stock;     // 库存数据
    private String originalPrice; //原价
    private String salePrice; //现价价格
    private String discount;    //折扣
    private String propPath;    // 规格 100005683:19962;100006170:53631
    private BigDecimal feeValue; //  运费 不带单位
    @JSONField(name = "image")
    private String photo;     //sku图片
    private String sellerId;    //卖家ID
    private String innerSkuId ; //sku名称和id的组合
    private String requestParams;//请求参数

    //新加
    private String supplierId;   // 供应商ID
    private String fee; // 运费 带单位
    private String sellerName; //商家名称

    private String creatTime;  //创建时间


}
