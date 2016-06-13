//
//  HomeProductInfo.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/5.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeProductInfo.h"

@implementation HomeProductInfo
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        self.p_id=dictionary[@"p_id"];
        self.t_check_status=[dictionary[@"t_check_status"]integerValue];
        self.t_produce_id=dictionary[@"t_produce_id"];
        self.t_produce_label=dictionary[@"t_produce_label"];
        self.t_produce_name=dictionary[@"t_produce_name"];
        self.t_produce_shop_price=dictionary[@"t_produce_shop_price"];
        self.t_product_detail_id=dictionary[@"t_product_detail_id"];
        self.t_product_typename=dictionary[@"t_product_typename"];
        self.t_ptype_img=dictionary[@"t_ptype_img"];
        self.t_sort=[dictionary[@"t_sort"]integerValue];
        self.t_produce_logo=dictionary[@"t_produce_logo"];
    }
    return self;
}
@end
