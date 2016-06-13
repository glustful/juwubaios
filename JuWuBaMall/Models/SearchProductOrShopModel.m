//
//  SearchProductOrShopModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SearchProductOrShopModel.h"
#import "DTApiBaseBean.h"

@implementation SearchProductOrShopModel
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(is_product_attention,@"");
        DTAPI_DICT_ASSIGN_STRING(typet_check_statusName, @"");
        DTAPI_DICT_ASSIGN_STRING(t_company_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_sale_num, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_shop_price, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_sort, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo, @"");

        
        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(is_product_attention);
    DTAPI_DICT_EXPORT_BASICTYPE(typet_check_statusName);
    DTAPI_DICT_EXPORT_BASICTYPE(t_company_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_sale_num);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_shop_price);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_sort);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo);

    return md;
    
}

@end
