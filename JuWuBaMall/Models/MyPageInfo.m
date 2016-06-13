//
//  MyPageInfo.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/5.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyPageInfo.h"

@implementation MyPageInfo

-(id)initWithDictionary:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
     self.attention_product=[dictionary[@"attention_product"]integerValue];
        self.attention_shop=[dictionary[@"attention_shop"]integerValue ];
        self.browse_records=[dictionary[@"browse_records"]integerValue];
        self.coupons=[dictionary[@"coupon"] integerValue];
        self.integral=[dictionary[@"integral"] integerValue];
    }
    return self;
}
@end
