//
//  ExchangeHeaderView.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ExchangeHeaderView.h"

@implementation ExchangeHeaderView

- (instancetype)initWithOrderNumber:(NSString *)number andTime:(NSString *)time
{
    self.orderNumber.text = number;
    self.orderTime.text = time;
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
