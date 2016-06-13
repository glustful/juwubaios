//
//  Brand.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/17.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "Brand.h"
#import "DTApiBaseBean.h"

@implementation Brand

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(t_product_brand_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_brandinfo, @"");
        DTAPI_DICT_ASSIGN_STRING(t_check_status , @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_brand_logo, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_branddescription, @"");
    }
    return self;
}

-(NSDictionary*)dictionaryValue
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_brand_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_brandinfo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_check_status);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_brand_logo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_branddescription);
    
    return md;
}


@end
