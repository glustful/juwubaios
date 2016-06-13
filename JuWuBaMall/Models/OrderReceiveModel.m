//
//  OrderReceiveModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/5/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "OrderReceiveModel.h"
#import "DTApiBaseBean.h"

@implementation OrderReceiveModel
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(is_product_attention,@"");
        DTAPI_DICT_ASSIGN_STRING(t_check_status, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_notice, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_detail_id, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_shop_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_total_money, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_type, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_brand, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_sale_num, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_first_type_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_first_type_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_img, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_second_type_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_second_type_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_thread_type_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_thread_type_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_unit_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_sort, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_shop_logo, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_name, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_receipt_area, @"");
        DTAPI_DICT_ASSIGN_STRING(t_receipt_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_receipt_phone, @"");
        DTAPI_DICT_ASSIGN_STRING(t_receipt_streetaddress, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_shop_price, @"");

        DTAPI_DICT_ASSIGN_STRING(t_receivingmode, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_produce_number, @"");

    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(is_product_attention);
    DTAPI_DICT_EXPORT_BASICTYPE(t_check_status);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_notice);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_detail_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_total_money);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_type);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_brand);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_sale_num);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_first_type_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_first_type_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_img);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_second_type_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_second_type_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_thread_type_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_thread_type_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_unit_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_sort);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_logo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_shop_price);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_area);
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_phone);
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_streetaddress);

    DTAPI_DICT_EXPORT_BASICTYPE(t_receivingmode);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_produce_number);

    return md;
    
}
@end
