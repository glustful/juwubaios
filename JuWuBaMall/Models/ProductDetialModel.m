//
//  ProductDetialModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

/**
 *  商品详情模型
 */
#import "ProductDetialModel.h"
#import "DTApiBaseBean.h"

@implementation ProductDetialModel
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
      DTAPI_DICT_ASSIGN_STRING(t_produce_details,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_sun_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_detail_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_img, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_pid, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_sale_num, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_sort, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_stock, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_type_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_typedescription, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_typename, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_province_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_ptype_img, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_sort, @"");


    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
//    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_details);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_sun_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_detail_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_img);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_pid);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_sale_num);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_sort);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_stock);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_type_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_typedescription);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_typename);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_province_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_ptype_img);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_sort);


    
    return md;
    
}

@end
