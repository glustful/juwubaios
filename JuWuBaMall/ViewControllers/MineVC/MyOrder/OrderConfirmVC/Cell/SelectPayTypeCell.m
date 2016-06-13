//
//  SelectPayTypeCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SelectPayTypeCell.h"

@implementation SelectPayTypeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)doAliPayAction:(id)sender
{
    _parentVC.payType = eAliPay;
    
    [_aliPaySelectIcon setImage:[UIImage imageNamed:@"CircleSelected"]];
    
    [_weixinPaySelectIcon setImage:[UIImage imageNamed:@"Circle"]];
    [_unionPaySelectIcon setImage:[UIImage imageNamed:@"Circle"]];
    
}
- (IBAction)doWeiXinPayAction:(id)sender
{
    _parentVC.payType = eWeixinPay;
    
    [_weixinPaySelectIcon setImage:[UIImage imageNamed:@"CircleSelected"]];
    
    [_aliPaySelectIcon setImage:[UIImage imageNamed:@"Circle"]];
    [_unionPaySelectIcon setImage:[UIImage imageNamed:@"Circle"]];
    
    
}
- (IBAction)doUnionPayAction:(id)sender
{
    _parentVC.payType = eUnionPay;
    [_unionPaySelectIcon setImage:[UIImage imageNamed:@"CircleSelected"]];
    
    [_weixinPaySelectIcon setImage:[UIImage imageNamed:@"Circle"]];
    [_aliPaySelectIcon setImage:[UIImage imageNamed:@"Circle"]];
}

@end
