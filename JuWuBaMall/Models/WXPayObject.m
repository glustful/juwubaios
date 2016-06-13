//
//  WXPayObject.m
//  JuWuBaMall
//
//  Created by yanghua on 16/4/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "WXPayObject.h"
#import "DTApiBaseBean.h"

@implementation WXPayObject

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
//        DTAPI_DICT_ASSIGN_STRING(appid,@"");
//        DTAPI_DICT_ASSIGN_STRING(err_code, @"");
//        DTAPI_DICT_ASSIGN_STRING(err_code_des, @"");
//        DTAPI_DICT_ASSIGN_STRING(mch_id, @"");
//        DTAPI_DICT_ASSIGN_STRING(nonce_str,@"");
//        DTAPI_DICT_ASSIGN_STRING(result_code, @"");
//        DTAPI_DICT_ASSIGN_STRING(return_code, @"");
//        DTAPI_DICT_ASSIGN_STRING(return_msg, @"");
//        DTAPI_DICT_ASSIGN_STRING(sign, @"");
        
        DTAPI_DICT_ASSIGN_STRING(appid,@"");
        DTAPI_DICT_ASSIGN_STRING(partnerid, @"");
        DTAPI_DICT_ASSIGN_STRING(prepayid, @"");
        DTAPI_DICT_ASSIGN_STRING(noncestr, @"");
        DTAPI_DICT_ASSIGN_STRING(timestamp,@"");
        DTAPI_DICT_ASSIGN_STRING(package, @"");
        DTAPI_DICT_ASSIGN_STRING(sign, @"");



    }
    
    return self;
}







- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(appid);
    DTAPI_DICT_EXPORT_BASICTYPE(partnerid);
    DTAPI_DICT_EXPORT_BASICTYPE(prepayid);
    DTAPI_DICT_EXPORT_BASICTYPE(noncestr);
    DTAPI_DICT_EXPORT_BASICTYPE(timestamp);
    DTAPI_DICT_EXPORT_BASICTYPE(package);
    DTAPI_DICT_EXPORT_BASICTYPE(sign);
    
    return md;
    
}


@end
