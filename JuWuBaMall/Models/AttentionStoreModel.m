//
//  AttentionStoreModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/24.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "AttentionStoreModel.h"
#import "DTApiBaseBean.h"

@implementation AttentionStoreModel


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
        DTAPI_DICT_ASSIGN_STRING(t_shop_logo, @"");
        DTAPI_DICT_ASSIGN_STRING(t_shop_name, @"");

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
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_logo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_shop_name);

    return md;
    
}
@end
