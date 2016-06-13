//
//  SelectTypeGroupModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SelectTypeGroupModel.h"
#import "DTApiBaseBean.h"


@implementation SelectTypeGroupModel


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(t_product_type_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_product_typename, @"");

    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_type_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_typename);
    
    
    return md;
    
}

@end
