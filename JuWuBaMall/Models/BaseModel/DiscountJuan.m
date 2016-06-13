//
//  DiscountJuan.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/9.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "DiscountJuan.h"

@implementation DiscountJuan
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
    self.t_electric_volume_arrivedmoney=dictionary[@"t_electric_volume_arrivedmoney"];
    self.t_electric_volume_id=dictionary[@"t_electric_volume_id"];
    self.t_electric_volume_info=dictionary[@"t_electric_volume_info"];
    self.t_electric_volume_startdate=dictionary[@"t_electric_volume_startdate"];
    self.t_electric_volume_enddate=dictionary[@"t_electric_volume_enddate"];
    self.t_electric_volume_iseffect=[dictionary[@"t_electric_volume_iseffect"]integerValue];
        self.t_user_id=[dictionary[@"t_user_id"]integerValue];
    }
    return self;
}
@end
