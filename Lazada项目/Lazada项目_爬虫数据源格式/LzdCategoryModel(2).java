package com.menglar.spider.consumer.core.model.entity.lazada;

import lombok.Data;
import org.hibernate.annotations.Proxy;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDateTime;

/**
 *LazadaCategory数据库实体
 */
@Data
public class LzdCategoryModel {


    private Integer categoryId;
    //类别名称
    private String name;
    //父id
    private int superclassId;

    private Integer siteId;

    //创建时间
    private String createTime;





}
