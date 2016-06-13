//
//  PromotionProduct.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface PromotionProduct : FMBean

@property(nonatomic,strong)NSString *t_produce_id;
@property(nonatomic,strong)NSString *t_produce_logo;
@property(nonatomic,strong)NSString *t_produce_name;
@property(nonatomic,strong)NSString *t_produce_shop_price;
@property(nonatomic,strong)NSString *t_product_unit_value;
@property(nonatomic,strong)NSString *t_product_value;
@property(nonatomic,strong)NSString *t_promotion_discount;
@property(nonatomic,strong)NSString *t_shop_id;
@property(nonatomic,strong)NSString *t_product_value2;//尺寸
@property(nonatomic,strong)NSString *t_product_type_id;
@property(nonatomic,strong)NSString *t_product_typename;

-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;


@end
