//
//  ExchangeHeaderView.h
//  JuWuBaMall
//
//  Created by JWB on 16/1/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;

- (instancetype)initWithOrderNumber:(NSString*)number andTime:(NSString *)time;

@end
