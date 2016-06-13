//
//  WaitingCommentCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "WaitingCommentCell.h"
#import "SubmitCommentVC.h"
// 物流详情
#import "LogisticsDetailVC.h"
#import <UIImageView+WebCache.h>

@implementation WaitingCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)doCommentAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(submitCommentVCEventDid)]) {
        [_delegate submitCommentVCEventDid];
    }
}

- (IBAction)doDeleteOrderAction:(id)sender
{
    if (_delegate) {
        [_delegate deleteOrderAction:_orderInfo];
    }
}

// 查看物流
- (IBAction)doViewLogiticsStatusAction:(id)sender
{

    if (_delegate && [_delegate respondsToSelector:@selector(deleteOrderAction:)]) {
        [_delegate deleteOrderAction:_orderInfo];
    }
    

//    LogisticsDetailVC *logisticsDetailVC = [[LogisticsDetailVC alloc] initWithName:@"物流详情"];
//    [_parentVC.navigationController pushViewController:logisticsDetailVC animated:YES];

}

- (void)reloadData:(OrderReceiveModel *)orderInfo
{
    _orderInfo = orderInfo;
    _orderInfo = orderInfo;
    self.orderCodeLabel.text=orderInfo.t_order_detail_id;
    self.shopNameLabel.text=@"南鹰";//orderInfo.t_shop_name;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"ShopIcon.png"]];
    [self.stateButton setTitle:orderInfo.t_order_type forState:UIControlStateNormal];
    
    NSString *str =  orderInfo.t_product_img;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    self.colorLabel.text=@"孔雀蓝";//orderInfo.t_produce_color;
    self.measureLabel.text=@"1000*800";
    self.numberLabel.text=orderInfo.t_produce_sale_num;
    self.productName.text=@"南鹰仿古砖";//orderInfo.t_produce_name;
    self.priceLabel.text=[NSString stringWithFormat:@"共计：%@元",orderInfo.t_order_total_money];
//    self.totalNumLabel.text=[NSString stringWithFormat:@"共计%@件商品",orderInfo.t_total_num];
    self.productPrice.text=@"￥50.0/片";//[NSString stringWithFormat:@"￥%@/片",orderInfo.t_produce_money];
}

@end
