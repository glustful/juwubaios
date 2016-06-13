//
//  AreaInfo.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "AreaInfo.h"
#import "DTApiBaseBean.h"

@implementation AreaInfo

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(t_province_city, @"");
        DTAPI_DICT_ASSIGN_STRING(t_province_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_province_district, @"");
        DTAPI_DICT_ASSIGN_STRING(t_province_id, @"");
    }
    return self;
}

-(NSDictionary*)dictionaryValue
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    DTAPI_DICT_EXPORT_BASICTYPE(t_province_city);
    DTAPI_DICT_EXPORT_BASICTYPE(t_province_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_province_district);
    DTAPI_DICT_EXPORT_BASICTYPE(t_province_id);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_province_type);
    
    return md;
}




@end
