//
//  FSBShoppingCarProductInfo.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FSBShoppingCarProductInfo.h"
#import "DTApiBaseBean.h"
@implementation FSBShoppingCarProductInfo

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_car_createtime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_car_goodsamount, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_car_id, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_shop_car_merchandisediscounts, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_car_paymentamount, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_car_purchasequantity
, @"");
        DTAPI_DICT_ASSIGN_STRING(t_user_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name,@"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo,@"");
        
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_grandsun_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_grandsun_name,@"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_grandsun_value,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_name,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_sun_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_sun_name,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_sun_value,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_value,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_detail_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_name,@"");
        
        DTAPI_DICT_ASSIGN_STRING(productid,@"");

        DTAPI_DICT_ASSIGN_STRING(t_shop_phone,@"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_address,@"");

    }
    return self;
}

-(NSDictionary*)dictionaryValue
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_car_createtime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_car_goodsamount);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_car_id);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_car_merchandisediscounts);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_car_paymentamount);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_car_purchasequantity);
    DTAPI_DICT_EXPORT_BASICTYPE(t_user_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_grandsun_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_grandsun_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_grandsun_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_sun_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_sun_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_sun_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_detail_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_name);
    
    DTAPI_DICT_EXPORT_BASICTYPE(productid);

    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_phone);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_address);

    return md;
}

@end
