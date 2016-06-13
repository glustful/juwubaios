//
//  Brand.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/17.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface Brand : FMBean

@property(nonatomic,copy)NSString *t_product_brand_id;//品牌ID
@property(nonatomic,copy)NSString *t_product_brandinfo;//品牌信息
@property(nonatomic,copy)NSString *t_check_status;//审核状态
@property(nonatomic,copy)NSString *t_product_brand_logo;//品牌logo
@property(nonatomic,copy)NSString *t_product_branddescription;//品牌描述



-(id)initWithDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionaryValue;

@end
