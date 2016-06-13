//
//  HomeProductInfo.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/5.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeProductInfo : NSObject

@property(copy,nonatomic)NSString *p_id;
@property(copy,nonatomic)NSString *t_produce_id;
@property(copy,nonatomic)NSString *t_produce_label;
@property(copy,nonatomic)NSString *t_produce_name;
@property(copy,nonatomic)NSString *t_produce_shop_price;
@property(assign,nonatomic)NSInteger t_check_status;
@property(assign,nonatomic)NSInteger t_sort;
@property(copy,nonatomic)NSString *t_product_detail_id;
@property(copy,nonatomic)NSString *t_product_typename;
@property(copy,nonatomic)NSString *t_ptype_img;
@property(copy,nonatomic)NSString *t_produce_logo;

-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
