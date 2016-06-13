//
//  OrderMoneyInfoCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderMoneyInfoCellDelegate <NSObject>

- (void)orderingAction:(UIButton *)button;

@end

@interface OrderMoneyInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
/**
 *  运费
 */
@property (weak, nonatomic) IBOutlet UILabel *carriageLabel;
/**
 *  优惠金额
 */
@property (weak, nonatomic) IBOutlet UILabel *favourableLabel;
@property (nonatomic, assign) id <OrderMoneyInfoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *finalMoneyLabel;

@end
