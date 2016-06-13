//
//  OrderDetailActionCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "OrderDetailActionCell.h"
// 申请退款
#import "RefundVC.h"
// 物流详情
#import "LogisticsDetailVC.h"
#import <UIImageView+WebCache.h>

@implementation OrderDetailActionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)doRefundAction:(id)sender
{
    RefundVC *logisticsDetailVC = [[RefundVC alloc] initWithName:@"申请退款"];
    [_parentVC.navigationController pushViewController:logisticsDetailVC animated:YES];
}

- (IBAction)doVIewLogisticsDetailAction:(id)sender
{
    LogisticsDetailVC *logisticsDetailVC = [[LogisticsDetailVC alloc] initWithName:@"物流详情"];
    [_parentVC.navigationController pushViewController:logisticsDetailVC animated:YES];
}

- (void)reloadData:(OrderReceiveModel *)orderIn
{
    _orderInfo = orderIn;
    
    self.titleLabel.text = orderIn.t_produce_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@/%@", orderIn.t_produce_shop_price, orderIn.t_product_unit_value];
    self.count.text = orderIn.t_order_produce_number;
    self.colorLabel.text = [NSString stringWithFormat:@"%@:%@",orderIn.t_product_thread_type_name, orderIn.t_product_thread_type_value];
    self.sizeLabel.text = [NSString stringWithFormat:@"%@:%@", orderIn.t_product_first_type_name, orderIn.t_product_first_type_value];
    
    NSString *str =  orderIn.t_produce_logo;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
}

// 延迟收货
- (IBAction)doDelayReceiveProduct:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(delayReceiveProductAction:)]) {
        [_delegate delayReceiveProductAction:_orderInfo];
    }
}


@end
