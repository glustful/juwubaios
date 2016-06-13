//
//  OrderMoneyInfoCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "OrderMoneyInfoCell.h"

@implementation OrderMoneyInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

// 下单
- (IBAction)doOrderingAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(orderingAction:)]) {
        [_delegate orderingAction:sender];
    }
}


@end
