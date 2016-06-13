//
//  WaitingRecieveProductCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
//#import "OrderInfo.h"
//
//#import "OrderNewModel.h"

#import "OrderReceiveModel.h"

@protocol WaitingRecieveProductCellDelegate <NSObject>

- (void)delayReceiveProductAction:(OrderReceiveModel *)orderInfo;
- (void)confirmReceiveProductAction:(OrderReceiveModel *)orderInfo;

@end

@interface WaitingRecieveProductCell : UITableViewCell

@property (nonatomic, weak) BaseVC *parentVC;

@property (nonatomic, assign) id<WaitingRecieveProductCellDelegate> delegate;

@property (nonatomic, strong) OrderReceiveModel *orderInfo;


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
@property(nonatomic,weak)IBOutlet UILabel *productLabel;

- (void)reloadData:(OrderReceiveModel *)orderInfo;


@end
