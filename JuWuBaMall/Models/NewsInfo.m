//
//  NewsInfo.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/19.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "NewsInfo.h"
#import "DTApiBaseBean.h"

@implementation NewsInfo

-(id)initWithDictionary:(NSDictionary*)dict{
    self=[super init];
    if (self) {
        DTAPI_DICT_ASSIGN_STRING(t_news_abstract, @"");
        DTAPI_DICT_ASSIGN_STRING(t_news_author, @"");
        DTAPI_DICT_ASSIGN_STRING(t_news_cotent, @"");
        DTAPI_DICT_ASSIGN_STRING(t_news_cover, @"");
        DTAPI_DICT_ASSIGN_STRING(t_news_createtime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_news_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_news_title, @"");
        DTAPI_DICT_ASSIGN_STRING(t_user_id, @"");
    }
    return self;
}
-(NSDictionary*)dictionaryValue{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
     DTAPI_DICT_EXPORT_BASICTYPE(t_news_abstract);
     DTAPI_DICT_EXPORT_BASICTYPE(t_news_author);
     DTAPI_DICT_EXPORT_BASICTYPE(t_news_cotent);
     DTAPI_DICT_EXPORT_BASICTYPE(t_news_cover);
     DTAPI_DICT_EXPORT_BASICTYPE(t_news_createtime);
     DTAPI_DICT_EXPORT_BASICTYPE(t_news_id);
     DTAPI_DICT_EXPORT_BASICTYPE(t_news_title);
     DTAPI_DICT_EXPORT_BASICTYPE(t_user_id);
    
    return md;
}


@end
