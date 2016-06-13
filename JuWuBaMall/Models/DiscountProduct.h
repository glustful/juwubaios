//
//  DiscountProduct.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface DiscountProduct : FMBean

@property(nonatomic,strong)NSString *t_produce_id;
@property(nonatomic,strong)NSString *t_discount;
@property(nonatomic,strong)NSString *t_produce_brand;
@property(nonatomic,strong)NSString *t_produce_name;
@property(nonatomic,strong)NSString *t_produce_shop_price;
@property(nonatomic,strong)NSString *t_produce_type;
@property(nonatomic,strong)NSString *t_product_discount_money;
@property(nonatomic,strong)NSString *t_product_sort;
@property(nonatomic,strong)NSString *t_product_unit_value;
@property(nonatomic,strong)NSString *t_province_id;
@property(nonatomic,strong)NSString *t_shop_id;
@property(nonatomic,strong)NSString *t_produce_logo;



-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
