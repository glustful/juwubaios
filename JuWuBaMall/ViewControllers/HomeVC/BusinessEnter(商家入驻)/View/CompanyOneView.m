//
//  CompanyOneView.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/3.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "CompanyOneView.h"

@interface CompanyOneView ()
@property (nonatomic, strong) UIScrollView *companyOneScroll;

@end
@implementation CompanyOneView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    self.companyOneScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.companyOneScroll.backgroundColor = [UIColor redColor];
    
}


@end
