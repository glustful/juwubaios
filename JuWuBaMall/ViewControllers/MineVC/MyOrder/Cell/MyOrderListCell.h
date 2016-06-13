//
//  MyOrderListCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
#import "OrderNewModel.h"

@protocol MyOrderListCellDelegate <NSObject>

- (void)orderPayAction:(OrderNewModel *)orderInfo;
-(void)orderCancelAction:(OrderNewModel*)orderInfo;
-(void)extentTheReceiving:(OrderNewModel*)orderInfo;

@end

@interface MyOrderListCell : UITableViewCell
// 数据
@property (nonatomic, strong) OrderNewModel *orderInfo;
// 代理
@property (nonatomic, assign) id <MyOrderListCellDelegate> delegate;

// 控件
@property (weak, nonatomic) IBOutlet UIButton *button_1;

@property (weak, nonatomic) IBOutlet UIButton *button_2;

@property (weak, nonatomic) IBOutlet UIButton *button_3;

@property (weak, nonatomic) IBOutlet UILabel *productCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *productTotalPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *productSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *productUnitPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property(weak,nonatomic)IBOutlet UIImageView *shopLogo;
@property(weak,nonatomic)IBOutlet UIImageView *productLogo;
@property(weak,nonatomic)IBOutlet UIButton *stateButton;


#pragma mark - 刷新cell
/**
 *  刷新cell
 *
 *  @param orderinfo 订单信息
 */
- (void)reloadCellData:(OrderNewModel *)orderinfo;

@end
