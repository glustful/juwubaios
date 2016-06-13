//
//  IntegralInfo.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "IntegralInfo.h"
#import "DTApiBaseBean.h"

@implementation IntegralInfo

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(t_point_avaliable_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_point_detail_createtime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_point_detail_end_time, @"");
        DTAPI_DICT_ASSIGN_STRING(t_point_detail_records_info, @"");
        DTAPI_DICT_ASSIGN_STRING(t_point_detail_type, @"");
        DTAPI_DICT_ASSIGN_STRING(t_point_detail_value, @"");
        DTAPI_DICT_ASSIGN_STRING(t_pointvalue_detail_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_logo, @"");
        DTAPI_DICT_ASSIGN_STRING(t_produce_name, @"");
    }
    
    return self;
}


- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_point_avaliable_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_point_detail_createtime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_point_detail_end_time);
    DTAPI_DICT_EXPORT_BASICTYPE(t_point_detail_records_info);
    DTAPI_DICT_EXPORT_BASICTYPE(t_point_detail_type);
    DTAPI_DICT_EXPORT_BASICTYPE(t_point_detail_value);
    DTAPI_DICT_EXPORT_BASICTYPE(t_pointvalue_detail_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_logo);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_id);
    
    
    return md;
    
}


@end
