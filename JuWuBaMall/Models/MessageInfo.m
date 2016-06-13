//
//  MessageInfo.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/26.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MessageInfo.h"
#import "DTApiBaseBean.h"

@implementation MessageInfo

-(id)initWithDictionary:(NSDictionary*)dict{
    self=[super init];
    if (self) {
        DTAPI_DICT_ASSIGN_STRING(t_message_push_createtime,@"");
        DTAPI_DICT_ASSIGN_STRING(t_message_push_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_message_push_message, @"");
        DTAPI_DICT_ASSIGN_STRING(t_message_push_pushtime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_message_push_state, @"");
        DTAPI_DICT_ASSIGN_STRING(t_message_push_title, @"");
        DTAPI_DICT_ASSIGN_STRING(t_message_push_type, @"");
        DTAPI_DICT_ASSIGN_STRING(t_msg_push_approach, @"");
    }
    return self;
}

-(NSDictionary*)dictionaryValue{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_message_push_createtime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_message_push_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_message_push_message);
    DTAPI_DICT_EXPORT_BASICTYPE(t_message_push_pushtime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_message_push_state);
    DTAPI_DICT_EXPORT_BASICTYPE(t_message_push_title);
    DTAPI_DICT_EXPORT_BASICTYPE(t_message_push_type);
    DTAPI_DICT_EXPORT_BASICTYPE(t_msg_push_approach);
    
    return md;
}

@end
