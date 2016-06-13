//
//  CombinationProduct.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface CombinationProduct : FMBean

@property(nonatomic,strong)NSString *t_Combination_Count;
@property(nonatomic,strong)NSString *t_Combination_Desc;
@property(nonatomic,strong)NSString *t_Combination_Discountmoney;
@property(nonatomic,strong)NSString *t_Combination_Id;
@property(nonatomic,strong)NSString *t_Combination_Name;
@property(nonatomic,strong)NSString *t_Combination_Picture;
@property(nonatomic,strong)NSString *t_Combination_Shop_Id;
@property(nonatomic,strong)NSString *t_Combination_Sourcemoney;
@property(nonatomic,strong)NSString *t_Combination_Status;
@property(nonatomic,strong)NSString *t_combination_attribute;




-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;


@end
