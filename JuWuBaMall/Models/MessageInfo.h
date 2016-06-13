//
//  MessageInfo.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/26.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface MessageInfo : FMBean

@property(nonatomic,copy)NSString *t_message_push_createtime;
@property(nonatomic,copy)NSString *t_message_push_id;
@property(nonatomic,copy)NSString *t_message_push_message;
@property(nonatomic,copy)NSString *t_message_push_pushtime;
@property(nonatomic,copy)NSString *t_message_push_state;
@property(nonatomic,copy)NSString *t_message_push_title;
@property(nonatomic,copy)NSString *t_message_push_type;
@property(nonatomic,copy)NSString *t_msg_push_approach;

-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;



@end
