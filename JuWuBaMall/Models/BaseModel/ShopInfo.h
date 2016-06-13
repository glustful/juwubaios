//
//  ShopInfo.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopInfo : NSObject

@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *imageUrl;

@property(assign,nonatomic)CGFloat compare_quality;
@property(copy,nonatomic)NSString *compare_server;
@property(assign,nonatomic)CGFloat  compare_speed;
@property(assign,nonatomic)NSInteger is_attention;
@property(copy,nonatomic)NSString *t_company_name;
@property(copy,nonatomic)NSString *t_shop_address;
@property(assign,nonatomic)NSInteger t_shop_attention_num;
@property(assign,nonatomic)CGFloat  t_shop_comment_quality_score;
@property(assign,nonatomic)CGFloat t_shop_comment_server_score;
@property(assign,nonatomic)CGFloat t_shop_comment_speed_score;
@property(copy,nonatomic)NSString *t_shop_createtime;
@property(copy,nonatomic)NSString *t_shop_function;
@property(copy,nonatomic)NSString *t_shop_logo;
@property(copy,nonatomic)NSString *t_shop_name;
@property(copy,nonatomic)NSString *t_shop_phone;
@property(assign,nonatomic)NSInteger t_shop_new_product;
@property(assign,nonatomic)NSInteger t_shop_product_num;
@property(assign,nonatomic)NSInteger t_shop_promotion;
@property(copy,nonatomic)NSString *t_shop_customer_service;
@property(copy,nonatomic)NSString *t_shop_id;


-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
