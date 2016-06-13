//
//  SeckillModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/16.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SeckillModel.h"
#import "DTApiBaseBean.h"

@implementation SeckillModel


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(t_produce_detail_shop_price,@"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_img, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_stock, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_type_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_typename, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_value1, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_value2, @"");
        DTAPI_DICT_ASSIGN_STRING(t_seckill_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_seckill_product_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_seckill_product_totalnumber, @"");
        DTAPI_DICT_ASSIGN_STRING(t_seckill_starttime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_seckill_stoptime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");

    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_detail_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_img);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_stock);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_type_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_typename);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_value1);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_value2);
    DTAPI_DICT_EXPORT_BASICTYPE(t_seckill_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_seckill_product_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_seckill_product_totalnumber);
    DTAPI_DICT_EXPORT_BASICTYPE(t_seckill_starttime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_seckill_stoptime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);

    
    return md;
    
}

@end
