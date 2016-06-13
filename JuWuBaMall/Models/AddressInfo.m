//
//  AddressInfo.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/10.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "AddressInfo.h"
#import "DTApiBaseBean.h"

@implementation AddressInfo

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(t_is_default_address, @"");
        DTAPI_DICT_ASSIGN_STRING(t_receipt_area, @"");
        DTAPI_DICT_ASSIGN_STRING(t_user_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_receipt_streetaddress, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_receipt_phone, @"");
        DTAPI_DICT_ASSIGN_STRING(t_receipt_zip_code, @"");
        DTAPI_DICT_ASSIGN_STRING(t_receipt_name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_receipt_id, @"");
    }
    return self;
}

-(NSDictionary*)dictionaryValue
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    DTAPI_DICT_EXPORT_BASICTYPE(t_is_default_address);
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_area);
    DTAPI_DICT_EXPORT_BASICTYPE(t_user_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_streetaddress);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_phone);
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_zip_code);
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_receipt_id);
    
    return md;
}



@end
