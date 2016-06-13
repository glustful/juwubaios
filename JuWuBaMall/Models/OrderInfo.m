//
//  OrderInfo.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/2/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "OrderInfo.h"
#import "DTApiBaseBean.h"

@implementation OrderInfo

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(t_order_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_createtime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_final_payment, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_type, @"");
        DTAPI_DICT_ASSIGN_STRING(t_order_state, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_shop_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_thread_type_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_img, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo_image, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_color, @"");

        
    }
    return self;
}

-(NSDictionary*)dictionaryValue
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_createtime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_final_payment);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_type);
    DTAPI_DICT_EXPORT_BASICTYPE(t_order_state);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_thread_type_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_img);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo_image);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_color);

    return md;
}
@end
