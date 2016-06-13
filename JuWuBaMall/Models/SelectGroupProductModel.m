//
//  SelectGroupProductModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SelectGroupProductModel.h"
#import "DTApiBaseBean.h"

@implementation SelectGroupProductModel


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        DTAPI_DICT_ASSIGN_STRING(tGroupPurchaseProductId,@"");
        DTAPI_DICT_ASSIGN_STRING(tProduceName, @"");
        DTAPI_DICT_ASSIGN_STRING(groupProductColor, @"");
        DTAPI_DICT_ASSIGN_STRING(groupProductSize, @"");
        DTAPI_DICT_ASSIGN_STRING(groupProductUnit, @"");
        DTAPI_DICT_ASSIGN_STRING(tGroupPurchaseDiscount, @"");
        DTAPI_DICT_ASSIGN_STRING(tGroupPurchaseMoney, @"");
        DTAPI_DICT_ASSIGN_STRING(tGroupPurchasePicture, @"");
        DTAPI_DICT_ASSIGN_STRING(tGroupPurchaseProductCount, @"");
        DTAPI_DICT_ASSIGN_STRING(tGroupShopId, @"");

        
    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(tGroupPurchaseProductId);
    DTAPI_DICT_EXPORT_BASICTYPE(tProduceName);
    DTAPI_DICT_EXPORT_BASICTYPE(groupProductColor);
    DTAPI_DICT_EXPORT_BASICTYPE(groupProductSize);
    DTAPI_DICT_EXPORT_BASICTYPE(groupProductUnit);
    DTAPI_DICT_EXPORT_BASICTYPE(tGroupPurchaseDiscount);
    DTAPI_DICT_EXPORT_BASICTYPE(tGroupPurchaseMoney);
    DTAPI_DICT_EXPORT_BASICTYPE(tGroupPurchasePicture);
    DTAPI_DICT_EXPORT_BASICTYPE(tGroupPurchaseProductCount);
    DTAPI_DICT_EXPORT_BASICTYPE(tGroupShopId);
    
    return md;
    
}

+ (instancetype)selectGroupProductWithDictionay:(NSDictionary *)dictionary
{
    
    return [[SelectGroupProductModel alloc] initWithDictionary:dictionary];
}


@end
