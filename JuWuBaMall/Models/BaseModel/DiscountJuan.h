//
//  DiscountJuan.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/9.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountJuan : NSObject

@property(strong,nonatomic)NSData *t_electric_volume_arrivedmoney;//优惠券抵用金额
@property(copy,nonatomic)NSString *t_electric_volume_id;//优惠券ID
@property(copy,nonatomic)NSString *t_electric_volume_info;//优惠券信息
@property(copy,nonatomic)NSString *t_electric_volume_startdate;//优惠券起始日期
@property(copy,nonatomic)NSString *t_electric_volume_enddate;//优惠券结束日期
@property(assign,nonatomic)NSInteger t_electric_volume_iseffect;//优惠券是否生效
@property(assign,nonatomic)NSInteger t_user_id;//用户ID

-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
