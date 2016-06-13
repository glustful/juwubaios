//
//  HomeProductDetailModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//


#import "FMBean.h"

/**
 *  首页砖区具体的商品模型
 */
@interface HomeProductDetailModel : FMBean

@property (nonatomic, strong) NSString *produceID;
@property (nonatomic, strong) NSString *produceLogo;
@property (nonatomic, strong) NSString *produceName;
@property (nonatomic, strong) NSString *producePrice;
-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
