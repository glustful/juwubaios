//
//  HomeSortModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeSortModel.h"
#import "DTApiBaseBean.h"

@implementation HomeSortModel
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(typeID,@"");
        DTAPI_DICT_ASSIGN_STRING(typeName, @"");
        DTAPI_DICT_ASSIGN_STRING(typeImage, @"");
        DTAPI_DICT_ASSIGN_ARRAY_BASICTYPE(produces);
    
        
        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(typeID);
    DTAPI_DICT_EXPORT_BASICTYPE(typeName);
    DTAPI_DICT_EXPORT_BASICTYPE(typeImage);
    DTAPI_DICT_EXPORT_ARRAY_BASICTYPE(produces);

    return md;
    
}

@end
