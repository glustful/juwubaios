//
//  MyCustomBtn.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyCustomBtn.h"

@implementation MyCustomBtn
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        _isSelectedClick=YES;
        _imgView1=[[UIImageView alloc]init];
        _imgView1.frame=CGRectMake(8, 10, 20, 15);
        [self  addSubview:_imgView1];
        
        _msgLabel=[[UILabel alloc]init];
        _msgLabel.frame=CGRectMake(30, 5, 90, 25);
        _msgLabel.textAlignment=NSTextAlignmentCenter;
        [self  addSubview:_msgLabel];
    }
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
