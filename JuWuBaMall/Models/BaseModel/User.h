//
//  User.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/19.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMBean.h"

@interface User : FMBean

@property (nonatomic, strong) NSString *t_birthday;
@property (nonatomic, strong) NSString *t_email;
@property (nonatomic, strong) NSString *t_identity; // 身份证号
@property (nonatomic, strong) NSString *t_nickname;
@property (nonatomic, strong) NSString *t_phone;
@property (nonatomic, strong) NSString *t_realname;
@property (nonatomic, strong) NSString *t_sex;  // 1：男，2：女，0：保密
@property (nonatomic, strong) NSString *t_user_id;

@property (nonatomic, strong) NSString *t_membership_gradle;
@property (nonatomic, strong) NSString *t_user_password;
@property (nonatomic, strong) NSString *t_user_phone;
@property (nonatomic, strong) NSString *t_user_type;    // 用户类型

// 公共参数
@property (nonatomic, strong) NSString *resultCode;
@property (nonatomic, strong) NSString *msg;


-(id)initWithDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionaryValue;

@end
