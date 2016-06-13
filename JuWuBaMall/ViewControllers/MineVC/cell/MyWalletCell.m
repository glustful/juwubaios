//
//  MyWalletCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyWalletCell.h"

@implementation MyWalletCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClickAction:(id)sender
{
    UIButton *button = sender;
    
    if (_delegate && [_delegate respondsToSelector:@selector(MyWalletCellButtonDidTouchDown:)])
    {
        [_delegate MyWalletCellButtonDidTouchDown:button];
    }

}



@end
