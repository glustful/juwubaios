//
//  YouGuessProduct.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "YouGuessProduct.h"
#import "DTApiBaseBean.h"
@implementation YouGuessProduct

-(id)initWithDictionary:(NSDictionary*)dict{
    self=[super init];
    if (self) {
        DTAPI_DICT_ASSIGN_STRING(t_produce_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_shop_price, @"");
    }
    return self;
}

-(NSDictionary*)dictionaryValue{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_shop_price);
    
    return md;
}

@end
