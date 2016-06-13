//
//  ProductDetialModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface ProductDetialModel : FMBean



/**
 *  商品详情展示图文
 */
@property (nonatomic, strong) NSString *t_produce_details;

/**
 *  商品属性ID
 */
@property (nonatomic, strong) NSString *t_product_attribute_id;
/**
 *  商品属性子ID
 */
@property (nonatomic, strong) NSString *t_product_attribute_sun_id;
/**
 *  商品详情ID
 */
@property (nonatomic, strong) NSString *t_product_detail_id;
/**
 *  商品图片
 */
@property (nonatomic, strong) NSString *t_product_img;
/**
 *  商品名称
 */
@property (nonatomic, strong) NSString *t_product_name;
/**
 *  商品pid
 */
@property (nonatomic, strong) NSString *t_product_pid;
/**
 *  商品销售数量
 */
@property (nonatomic, strong) NSString *t_product_sale_num;
/**
 *  商品分类
 */
@property (nonatomic, strong) NSString *t_product_sort;
/**
 *  商品库存
 */
@property (nonatomic, strong) NSString *t_product_stock;
/**
 *  商品类型ID
 */
@property (nonatomic, strong) NSString *t_product_type_id;
/**
 *  商品类型描述
 */
@property (nonatomic, strong) NSString *t_product_typedescription;
/**
 *  商品类型名称
 */
@property (nonatomic, strong) NSString *t_product_typename;
/**
 *  商品单位ID
 */
@property (nonatomic, strong) NSString *t_product_unit_id;
/**
 *  商品单位名称
 */
@property (nonatomic, strong) NSString *t_product_unit_name;
/**
 *  商品单位值
 */
@property (nonatomic, strong) NSString *t_product_unit_value;
/**
 *  商品值   写的是尺寸
 */
@property (nonatomic, strong) NSString *t_product_value;
/**
 *  商品省级ID
 */
@property (nonatomic, strong) NSString *t_province_id;
/**
 *  产品类型图片
 */
@property (nonatomic, strong) NSString *t_ptype_img;
/**
 *  店铺ID
 */
@property (nonatomic, strong) NSString *t_shop_id;
/**
 *  分类
 */
@property (nonatomic, strong) NSString *t_sort;


-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;


@end
