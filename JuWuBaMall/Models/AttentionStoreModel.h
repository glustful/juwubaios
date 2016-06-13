//
//  AttentionStoreModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/24.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMBean.h"

@interface AttentionStoreModel : FMBean

@property (nonatomic, copy) NSString *t_attention_createtime;//关注时间
@property (nonatomic, copy) NSString *t_attention_herf;//关注链接地址
@property (nonatomic, copy) NSString *t_attention_id;//关注id
@property (nonatomic, copy) NSString *t_attention_money;//关注商品的价钱
@property (nonatomic, copy) NSString *t_attention_title;//关注标题
@property (nonatomic, copy) NSString *t_attention_type;//关注类型，0店铺，1商品
@property (nonatomic, copy) NSString *t_produce_id;//商品id
@property (nonatomic, copy) NSString *t_shop_id;//店铺id
@property (nonatomic, copy) NSString *t_user_id;//用户id

@property (nonatomic, copy) NSString *t_shop_logo;//店铺logo

@property (nonatomic, copy) NSString *t_shop_name;



-(id)initWithDictionary:(NSDictionary*)dict;

//+ (instancetype)modelWithDictionay:(NSDictionary *)dic;



- (NSDictionary *)dictionaryValue;

@end
