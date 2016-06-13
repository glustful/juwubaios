//
//  ProductRated.m
//  JuWuBaMall
//
//  Created by yanghua on 16/5/2.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductRated.h"
#import "DTApiBaseBean.h"
#import "NSString+Extent.h"
@implementation ProductRated




- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(t_product_id,@"");
        DTAPI_DICT_ASSIGN_STRING(t_rated_content, @"");
        DTAPI_DICT_ASSIGN_STRING(t_rated_createtime, @"");
        DTAPI_DICT_ASSIGN_STRING(t_rated_level, @"");
        DTAPI_DICT_ASSIGN_STRING(t_user_id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_product_rated_id, @"");
  
        
        
        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_rated_content);
    DTAPI_DICT_EXPORT_BASICTYPE(t_rated_createtime);
    DTAPI_DICT_EXPORT_BASICTYPE(t_rated_level);
    DTAPI_DICT_EXPORT_BASICTYPE(t_user_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_rated_id);


    
    return md;
    
}



-(void)caculateHeight{
    
    self.height=[self.t_rated_content heightWithText:self.t_rated_content font:[UIFont boldSystemFontOfSize:15.0] width:ScreenWidth-2*8]+80+8*5;
    
}


@end
