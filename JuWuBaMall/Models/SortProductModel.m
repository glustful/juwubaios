//
//  SortProductModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/29.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SortProductModel.h"
#import "DTApiBaseBean.h"

@implementation SortProductModel


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(is_product_attention,@"");
        DTAPI_DICT_ASSIGN_STRING(t_check_status, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_sale_num, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_shop_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_sort, @"");
//        DTAPI_DICT_ASSIGN_STRING(produceLogo, @"");

        
        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(is_product_attention);
    DTAPI_DICT_EXPORT_BASICTYPE(t_check_status);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_sale_num);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_sort);
//    DTAPI_DICT_EXPORT_BASICTYPE(produceLogo);

    return md;
    
}

@end
