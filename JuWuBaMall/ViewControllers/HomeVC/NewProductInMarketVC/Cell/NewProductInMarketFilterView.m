//
//  NewProductInMarketFilterView.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "NewProductInMarketFilterView.h"

@implementation NewProductInMarketFilterView
- (IBAction)doNewProductViewClickAction:(UIButton*)sender {
    if (_delegate && [_delegate  respondsToSelector:@selector(NewProductInMarketFilterViewDelegateWithButton:)] ) {
        [_delegate NewProductInMarketFilterViewDelegateWithButton:sender];
    }
    static NSInteger buttonTag;
    if (buttonTag) {
        UIButton *button = (UIButton *)[self viewWithTag:buttonTag];
        [button setTitleColor:[UIColor colorWithRed:155/255.0f green:153/255.0f blue:157/255.0f alpha:1] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    buttonTag = sender.tag;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
