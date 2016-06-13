//
//  CombinationProduct.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "CombinationProduct.h"
#import "DTApiBaseBean.h"

@implementation CombinationProduct
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(t_combination_attribute,@"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Status, @"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Sourcemoney, @"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Shop_Id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Picture, @"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Name, @"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Id, @"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Discountmoney, @"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Desc, @"");
        DTAPI_DICT_ASSIGN_STRING(t_Combination_Count, @"");
        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_combination_attribute);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Status);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Sourcemoney);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Shop_Id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Picture);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Name);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Discountmoney);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Desc);
    DTAPI_DICT_EXPORT_BASICTYPE(t_Combination_Count);
    
    
    
    return md;
    
}
@end
