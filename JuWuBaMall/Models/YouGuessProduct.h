//
//  YouGuessProduct.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface YouGuessProduct : FMBean

@property(nonatomic,copy)NSString *t_produce_id;
@property(nonatomic,copy)NSString *t_produce_logo;
@property(nonatomic,copy)NSString *t_produce_name;
@property(nonatomic,copy)NSString *t_produce_shop_price;

-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
