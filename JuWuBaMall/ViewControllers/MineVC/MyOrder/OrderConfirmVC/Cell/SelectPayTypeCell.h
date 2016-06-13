//
//  SelectPayTypeCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderConfirmVC.h"

typedef NS_ENUM(NSInteger, PayType) {
    eWeixinPay = 1,
    eAliPay,
    eUnionPay
};
@interface SelectPayTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *aliPaySelectIcon;
@property (weak, nonatomic) IBOutlet UIImageView *unionPaySelectIcon;
@property (weak, nonatomic) IBOutlet UIImageView *weixinPaySelectIcon;

@property (nonatomic, weak) OrderConfirmVC *parentVC;

@end
