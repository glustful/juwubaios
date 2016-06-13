//
//  MyCustomBtn.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomBtn : UIButton

@property(strong,nonatomic)UIImageView *imgView1;
@property(strong,nonatomic)UILabel     *msgLabel;

@property(assign,nonatomic) BOOL        isSelectedClick;

@end
