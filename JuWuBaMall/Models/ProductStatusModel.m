//
//  ProductStatusModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/23.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductStatusModel.h"
#import "DTApiBaseBean.h"

@implementation ProductStatusModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(is_product_attention,@"");
        DTAPI_DICT_ASSIGN_STRING(t_check_status, @"");
        DTAPI_DICT_ASSIGN_STRING(t_discount, @"");
  
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_dealer_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_grandsun_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_market_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_shop_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_sale_num, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_sun_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_detail_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_first_type_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_first_type_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_img, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_second_type_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_second_type_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_stock, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_type_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_sort, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_thread_type_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_thread_type_value, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_produce_shop_price, @"");

        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(is_product_attention);
    DTAPI_DICT_EXPORT_BASICTYPE(t_check_status);
    DTAPI_DICT_EXPORT_BASICTYPE(t_discount);

    
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_dealer_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_grandsun_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_market_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_sale_num);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_sun_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_detail_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_first_type_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_first_type_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_img);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_second_type_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_second_type_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_stock);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_type_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_sort);

     DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_shop_price);

    
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_thread_type_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_thread_type_value);
    

    
    return md;
    
}

@end
