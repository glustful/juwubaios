//
//  Attention.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/23.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "Attention.h"
#import "DTApiBaseBean.h"

@implementation Attention

- (id)initWithDictionary:(NSDictionary *)dict
{
    
    if (self = [super init]) {
        
        DTAPI_DICT_ASSIGN_STRING( t_attention_herf, @"");
        DTAPI_DICT_ASSIGN_STRING(t_attention_createtime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_attention_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_attention_money, @"");
        DTAPI_DICT_ASSIGN_STRING(t_attention_title, @"");
        DTAPI_DICT_ASSIGN_STRING(t_attention_type, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_user_id, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_product_img, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_grandsun_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_grandsun_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_value, @"");

        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_shop_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_sun_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_attribute_sun_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_detail_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(productid, @"");

        
    }
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    DTAPI_DICT_EXPORT_BASICTYPE(t_attention_herf);
    DTAPI_DICT_EXPORT_BASICTYPE(t_attention_createtime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_attention_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_attention_money);
    DTAPI_DICT_EXPORT_BASICTYPE(t_attention_title);
    DTAPI_DICT_EXPORT_BASICTYPE(t_attention_type);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_user_id);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_img);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_grandsun_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_value);

    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_grandsun_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_sun_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_attribute_sun_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_detail_id);

    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(productid);

    

    return md;
    
}

+ (instancetype)modelWithDictionay:(NSDictionary *)dic
{
    Attention *at = [[Attention alloc]init];
    [at setValuesForKeysWithDictionary:dic];
    return at;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
