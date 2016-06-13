//
//  HomeProductDetailModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeProductDetailModel.h"
#import "DTApiBaseBean.h"

@implementation HomeProductDetailModel
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(produceID,@"");
        DTAPI_DICT_ASSIGN_STRING(produceLogo, @"");
        DTAPI_DICT_ASSIGN_STRING(produceName, @"");
        DTAPI_DICT_ASSIGN_STRING(producePrice, @"");
        
        
        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(produceID);
    DTAPI_DICT_EXPORT_BASICTYPE(produceLogo);
    DTAPI_DICT_EXPORT_BASICTYPE(produceName);
    DTAPI_DICT_EXPORT_BASICTYPE(producePrice);
    
    return md;
    
}

@end
