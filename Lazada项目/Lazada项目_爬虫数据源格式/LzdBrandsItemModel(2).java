package com.menglar.spider.consumer.core.model.entity.lazada;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Proxy;

import javax.persistence.*;
import java.time.LocalDateTime;

/**
 *Lazada品牌实体
 */
@Data
public class LzdBrandsItemModel {


    private Integer brandId;

    private Integer siteId;


    //品牌实际名称
    private String name;

    //品牌英文名称
    private String nameEn;

    //跨不同系统的品牌唯一标识符 如：NIKE APPLE
    private String globalIdentifier;

    //卖方中心分配该品牌的标识符
    private int brandIdTemp;

    //创建时间
    private String creatTime;


}
