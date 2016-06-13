//
//  DiscountProduct.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "DiscountProduct.h"
#import "DTApiBaseBean.h"
@implementation DiscountProduct
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(t_discount,@"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_brand, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_shop_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_type, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_discount_money, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_sort, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_province_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo, @"");

        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_province_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_discount);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_sort);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_type);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_discount_money);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_brand);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo);

    
    
    return md;
    
}
@end
