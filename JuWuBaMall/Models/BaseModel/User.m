//
//  User.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/19.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "User.h"
#import "DTApiBaseBean.h"

@implementation User

-(id)initWithDictionary:(NSDictionary*)dict
{
    if (self = [super init])
    {
        DTAPI_DICT_ASSIGN_STRING(t_birthday, @"");
        DTAPI_DICT_ASSIGN_STRING(t_email, @"");
        DTAPI_DICT_ASSIGN_STRING(t_identity, @"");
        DTAPI_DICT_ASSIGN_STRING(t_nickname, @"");
        DTAPI_DICT_ASSIGN_STRING(t_phone, @"");
        DTAPI_DICT_ASSIGN_STRING(t_realname, @"");
        DTAPI_DICT_ASSIGN_STRING(t_sex, @"");
        
        DTAPI_DICT_ASSIGN_STRING(t_membership_gradle, @"");
        DTAPI_DICT_ASSIGN_STRING(t_user_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_user_password, @"");
        DTAPI_DICT_ASSIGN_STRING(t_user_phone, @"");
        
        DTAPI_DICT_ASSIGN_STRING(resultCode, @"");
        DTAPI_DICT_ASSIGN_STRING(msg, @"");
        
    }
    return self;
}

-(NSDictionary*)dictionaryValue
{
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_birthday);
    DTAPI_DICT_EXPORT_BASICTYPE(t_email);
    DTAPI_DICT_EXPORT_BASICTYPE(t_identity);
    DTAPI_DICT_EXPORT_BASICTYPE(t_nickname);
    DTAPI_DICT_EXPORT_BASICTYPE(t_phone);
    DTAPI_DICT_EXPORT_BASICTYPE(t_realname);
    DTAPI_DICT_EXPORT_BASICTYPE(t_sex);
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_membership_gradle);
    DTAPI_DICT_EXPORT_BASICTYPE(t_user_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_user_password);
    DTAPI_DICT_EXPORT_BASICTYPE(t_user_phone);
    
    DTAPI_DICT_EXPORT_BASICTYPE(resultCode);
    DTAPI_DICT_EXPORT_BASICTYPE(msg);
    
    return md;
}

@end
