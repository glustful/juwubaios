//
//  ReceiveAddressCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ReceiveAddressCell.h"
#import <UIImageView+WebCache.h>
#import "ProductDetailVC.h"

@implementation ReceiveAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)reloadataWithOrederInfo:(OrderInfo*)orderInfo{
    _orderInfo = orderInfo;
    
    NSString *str =  orderInfo.t_product_img;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    self.colorLabel.text=@"孔雀蓝";//orderInfo.t_produce_color;
    self.measureLabel.text=@"1000*800";
    self.numberLabel.text=orderInfo.t_total_num;
    self.productName.text=@"南鹰仿古砖";//orderInfo.t_produce_name;
    self.productPrice.text=@"￥50.0/片";//[NSString stringWithFormat:@"￥%@/片",orderInfo.t_produce_money];
}

-(IBAction)doProductDetailPageAction:(id)sender{
    ProductDetailVC *productVC=[[ProductDetailVC alloc]init];
    [_presentVC.navigationController pushViewController:productVC animated:YES];
}

-(IBAction)doAreaseChooseAction:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(receiveAddressCellDelegate)]) {
        [_delegate receiveAddressCellDelegate];
    }
}
-(void)reloadReceivingAddresswithAddressInfo:(AddressInfo*)addressInfo{
    _addressInfo=addressInfo;
    self.receiveNameLabel.text=addressInfo.t_receipt_name;
    self.receivePhoneLable.text=addressInfo.t_receipt_phone;
    self.receiveAddressLabel.text=[NSString stringWithFormat:@"%@%@",addressInfo.t_receipt_area,addressInfo.t_receipt_streetaddress];
    
    LogInfo(@"lll%@",addressInfo.t_receipt_area);
}

@end
