//
//  Attention.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/23.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMBean.h"

@interface Attention : FMBean
@property (nonatomic, copy) NSString *t_attention_createtime;//关注时间
@property (nonatomic, copy) NSString *t_attention_herf;//关注链接地址
@property (nonatomic, copy) NSString *t_attention_id;//关注id
@property (nonatomic, copy) NSString *t_attention_money;//关注商品的价钱
@property (nonatomic, copy) NSString *t_attention_title;//关注标题
@property (nonatomic, copy) NSString *t_attention_type;//关注类型，0店铺，1商品
@property (nonatomic, copy) NSString *t_produce_id;//商品id
@property (nonatomic, copy) NSString *t_shop_id;//店铺id
@property (nonatomic, copy) NSString *t_user_id;//用户id
@property (nonatomic, copy) NSString *t_product_img;//商品图片

@property (nonatomic, copy) NSString *t_produce_detail_grandsun_name;//尺寸
@property (nonatomic, copy) NSString *t_produce_detail_grandsun_value;//尺寸属性
@property (nonatomic, copy) NSString *t_product_attribute_name;//重量
@property (nonatomic, copy) NSString *t_product_attribute_value;//重量属性

@property (nonatomic, copy) NSString *t_produce_detail_shop_price;//价格
@property (nonatomic, copy) NSString *t_product_attribute_sun_name;//颜色
@property (nonatomic, copy) NSString *t_product_attribute_sun_value;//颜色属性
@property (nonatomic, copy) NSString *t_product_detail_id;

@property (nonatomic, copy) NSString *t_produce_name;

@property (nonatomic, copy) NSString *productid;










-(id)initWithDictionary:(NSDictionary*)dict;

//+ (instancetype)modelWithDictionay:(NSDictionary *)dic;



- (NSDictionary *)dictionaryValue;







@end
