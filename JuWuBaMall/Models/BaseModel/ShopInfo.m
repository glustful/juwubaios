//
//  ShopInfo.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ShopInfo.h"

@implementation ShopInfo
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        self.compare_quality=[dictionary[@"compare_quality"]floatValue];
        self.compare_server=dictionary[@"compare_server"];
        self.compare_speed=[dictionary[@"compare_speed"]floatValue];
        self.is_attention=[dictionary[@"is_attention"]integerValue];
        self.t_company_name=dictionary[@"t_company_name"];
        self.t_shop_address=dictionary[@"t_shop_address"];
        self.t_shop_attention_num=[dictionary[@"t_shop_attention_num"]integerValue];
        self.t_shop_comment_quality_score=[dictionary[@"t_shop_comment_quality_score" ]floatValue];
        self.t_shop_comment_server_score=[dictionary[@"t_shop_comment_server_score"]floatValue];
        self.t_shop_comment_speed_score=[dictionary[@"t_shop_comment_speed_score"]floatValue];
        self.t_shop_createtime=dictionary[@"t_shop_createtime"];
        self.t_shop_function=dictionary[@"t_shop_function"];
        self.t_shop_logo=dictionary[@"t_shop_logo"];
        self.t_shop_name=dictionary[@"t_shop_name"];
        self.t_shop_new_product=[dictionary[@"t_shop_new_product"]integerValue];
        self.t_shop_phone=dictionary[@"t_shop_phone"];
        self.t_shop_product_num=[dictionary[@"t_shop_product_num"]integerValue];
        self.t_shop_promotion=[dictionary[@"t_shop_promotion"]integerValue];
        self.t_shop_customer_service=dictionary[@"t_shop_customer_service"];
        self.t_shop_id=dictionary[@"t_shop_id"];
        
    }
    return self;
}
@end
