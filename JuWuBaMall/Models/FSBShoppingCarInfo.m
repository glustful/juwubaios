//
//  FSBShoppingCarInfo.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FSBShoppingCarInfo.h"
#import "DTApiBaseBean.h"

@implementation FSBShoppingCarInfo

- (NSMutableArray *)productArray
{
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(t_shop_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_id, @"");
        DTAPI_DICT_ASSIGN_ARRAY_BASICTYPE(productArray);
    }
    return self;
}

-(NSDictionary*)dictionaryValue
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_id);
    DTAPI_DICT_EXPORT_ARRAY_BASICTYPE(productArray);

    
    return md;
}


@end
