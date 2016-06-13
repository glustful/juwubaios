//
//  ReceiveProductTypeCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ReceiveProductTypeCell.h"

@implementation ReceiveProductTypeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//  易门上门取货，运费到付砍掉
- (IBAction)doReceiveProductPay:(id)sender
{
    _logisticsFeeType = ereceivePayType;
    
    [self.delegate sendType:@"易门上门取货"];
    
    UIButton *button = sender;
    [button setBackgroundImage:[UIImage imageNamed:@"ReceiveProductTypeBackselect"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    [_ownGetButton setBackgroundImage:[UIImage imageNamed:@"ReceiveProductTypeBackUnselect"] forState:UIControlStateNormal];
//    [_ownGetButton setTitleColor:kTextColor forState:UIControlStateNormal];
}

// 上门自提
- (IBAction)doGoShopGetProduct:(id)sender
{
    _logisticsFeeType = eownGetType;
    
    [self.delegate sendType:@"上门取货"];
    
    UIButton *button = sender;
    [button setBackgroundImage:[UIImage imageNamed:@"ReceiveProductTypeBackselect"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_receivePayButton setBackgroundImage:[UIImage imageNamed:@"ReceiveProductTypeBackUnselect"] forState:UIControlStateNormal];
    [_receivePayButton setTitleColor:kTextColor forState:UIControlStateNormal];
}

@end
