//
//  WaitingPayCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
#import "BaseVC.h"
#import "OrderNewModel.h"

@protocol WaitingPayCellDelegate <NSObject>

- (void)cancelOrderAction:(OrderNewModel *)orderInfo;

@end

@interface WaitingPayCell : UITableViewCell

@property (nonatomic, strong) OrderNewModel *orderInfo;
@property (nonatomic, strong) BaseVC *parentVC;
@property (nonatomic, assign) id <WaitingPayCellDelegate> delegate;
@property(nonatomic,weak)IBOutlet UILabel *orderCodeLabel;
@property(nonatomic,weak)IBOutlet UIImageView *iconImg;
@property(nonatomic,weak)IBOutlet UILabel *shopNameLabel;
@property(nonatomic,weak)IBOutlet UIButton *stateButton;
@property(nonatomic,weak)IBOutlet UIImageView *productImg;
@property(nonatomic,weak)IBOutlet UILabel *productName;
@property(nonatomic,weak)IBOutlet UILabel *colorLabel;
@property(nonatomic,weak)IBOutlet UILabel *measureLabel;
@property(nonatomic,weak)IBOutlet UILabel *numberLabel;
@property(nonatomic,weak)IBOutlet UILabel *totalNumLabel;
@property(nonatomic,weak)IBOutlet UILabel *priceLabel;
@property(nonatomic,weak)IBOutlet UILabel *productPrice;


- (void)reloadData:(OrderNewModel *)orderInfo;

@end
