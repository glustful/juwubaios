//
//  WaitingPayCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "WaitingPayCell.h"
#import "OrderConfirmVC.h"
#import <UIImageView+WebCache.h>
//#import "ToPayViewController.h"
#import "ToPayNewViewController.h"

@implementation WaitingPayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

// 取消订单
- (IBAction)doCancelOrderAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(cancelOrderAction:)]) {
        [_delegate cancelOrderAction:_orderInfo];
    }
}

// 付款
- (IBAction)doPayAction:(id)sender
{
    ToPayNewViewController *confirmVC = [[ToPayNewViewController alloc] initWithName:@"去支付"];
    confirmVC.myOrderID=_orderInfo.t_order_id;
    confirmVC.allMoney = _orderInfo.t_order_final_payment;
    [_parentVC.navigationController pushViewController:confirmVC animated:YES];
}

- (void)reloadData:(OrderNewModel *)orderInfo
{
    _orderInfo = orderInfo;
    self.orderCodeLabel.text=orderInfo.t_order_id;
    self.shopNameLabel.text=orderInfo.t_shop_name;//orderInfo.t_shop_name;
    
    //将url转码
    NSString *url = [orderInfo.t_shop_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ShopIcon.png"]];
//    [self.stateButton setTitle:orderInfo.t_order_state forState:UIControlStateNormal];
    
    NSString *url1 = [orderInfo.t_produce_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self.productImg sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    self.colorLabel.text= [NSString stringWithFormat:@"%@:%@",orderInfo.t_product_thread_type_name, orderInfo.t_product_thread_type_value];//orderInfo.t_produce_color;
    self.measureLabel.text= [NSString stringWithFormat:@"%@:%@",orderInfo.t_product_first_type_name, orderInfo.t_product_first_type_value];
    self.numberLabel.text=orderInfo.t_order_produce_number;
    self.productName.text=orderInfo.t_produce_name;//orderInfo.t_produce_name;
    self.priceLabel.text=[NSString stringWithFormat:@"共计：%@元",orderInfo.t_order_final_payment];
    self.totalNumLabel.text=[NSString stringWithFormat:@"共计%@件商品",orderInfo.t_total_num];
    self.productPrice.text=[NSString stringWithFormat:@"￥%.2f/片",[orderInfo.t_order_total_money floatValue]/[orderInfo.t_order_produce_number floatValue]];//[NSString stringWithFormat:@"￥%@/片",orderInfo.t_produce_money];
}
@end
