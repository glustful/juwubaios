//
//  NewsInfo.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/19.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface NewsInfo : FMBean

@property(nonatomic,copy)NSString *t_news_abstract;
@property(nonatomic,copy)NSString *t_news_author;
@property(nonatomic,copy)NSString *t_news_cotent;
@property(nonatomic,copy)NSString *t_news_cover;
@property(nonatomic,copy)NSString *t_news_createtime;
@property(nonatomic,copy)NSString *t_news_id;
@property(nonatomic,copy)NSString *t_news_title;
@property(nonatomic,copy)NSString *t_user_id;

-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
