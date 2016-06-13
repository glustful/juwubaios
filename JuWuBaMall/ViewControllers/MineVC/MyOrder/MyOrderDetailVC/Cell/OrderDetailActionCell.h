//
//  OrderDetailActionCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "OrderInfo.h"
#import "OrderNewModel.h"
#import "OrderReceiveModel.h"

@protocol OrderDetailActionCellDelegate <NSObject>

- (void)delayReceiveProductAction:(OrderReceiveModel *)orderInfo;

@end

@interface OrderDetailActionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@property (weak, nonatomic) IBOutlet UILabel *count;

@property (nonatomic, weak) BaseVC *parentVC;

@property (nonatomic, assign) id<OrderDetailActionCellDelegate> delegate;

@property (nonatomic, strong) OrderReceiveModel *orderInfo;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

- (void)reloadData:(OrderReceiveModel *)orderInfo;

@end
