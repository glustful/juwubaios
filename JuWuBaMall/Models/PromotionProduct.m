//
//  PromotionProduct.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "PromotionProduct.h"
#import "DTApiBaseBean.h"

@implementation PromotionProduct

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(t_produce_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_shop_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_promotion_discount, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_type_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_typename, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_value2, @"");
        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_promotion_discount);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_value);
     DTAPI_DICT_EXPORT_BASICTYPE(t_product_value2);
     DTAPI_DICT_EXPORT_BASICTYPE(t_product_typename);
     DTAPI_DICT_EXPORT_BASICTYPE(t_product_type_id);
    
    
    return md;
    
}
@end
