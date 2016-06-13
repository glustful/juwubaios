//
//  WaitingRecieveProductCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "WaitingRecieveProductCell.h"
// 物流详情
#import "LogisticsDetailVC.h"
#import <UIImageView+WebCache.h>


@implementation WaitingRecieveProductCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)reloadData:(OrderReceiveModel *)orderInfo
{
    _orderInfo = orderInfo;
//    self.orderCodeLabel.text=orderInfo.t;
    self.shopNameLabel.text=orderInfo.t_shop_id;//orderInfo.t_shop_name;
    
    NSString *str =  orderInfo.t_shop_logo;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"ShopIcon.png"]];
    [self.stateButton setTitle:orderInfo.t_order_type forState:UIControlStateNormal];
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:orderInfo.t_product_img] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    self.colorLabel.text=@"浅黄";//orderInfo.t_produce_color;
    self.measureLabel.text=@"1000*900";
    self.numberLabel.text=orderInfo.t_produce_sale_num;
    self.productName.text=@"远方小地砖";//orderInfo.t_produce_name;
    self.priceLabel.text=[NSString stringWithFormat:@"共计：%@元",orderInfo.t_order_total_money];
    self.totalNumLabel.text=[NSString stringWithFormat:@"共计%@件商品",orderInfo.t_produce_sale_num];
    self.productLabel.text=@"￥39.0/片";//[NSString stringWithFormat:@"￥%@/片",orderInfo.t_produce_money];
}

// 延迟收货
- (IBAction)doDelayReceiveProduct:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(delayReceiveProductAction:)]) {
        [_delegate delayReceiveProductAction:_orderInfo];
    }
}

// 确认收货
- (IBAction)doConfirmReceiveProduct:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(confirmReceiveProductAction:)]) {
        [_delegate confirmReceiveProductAction:_orderInfo];
    }
}

// 查看物流
- (IBAction)doViewLogiticsStatusAction:(id)sender
{
    LogisticsDetailVC *logisticsDetailVC = [[LogisticsDetailVC alloc] initWithName:@"物流详情"];
    [_parentVC.navigationController pushViewController:logisticsDetailVC animated:YES];
}



@end
