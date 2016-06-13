//
//  MyOrderListCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyOrderListCell.h"
#import <UIImageView+WebCache.h>

@implementation MyOrderListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - 刷新cell
- (void)reloadCellData:(OrderNewModel *)orderinfo
{
    _orderInfo = orderinfo;
    
    // 总金额
    _productTotalPriceLabel.text = [NSString stringWithFormat:@"合计：%@元", orderinfo.t_order_final_payment];
    _productCountLabel.text =[NSString stringWithFormat:@"共%@件商品",_orderInfo.t_total_num]; //_orderInfo.t_total_num;
    
    // t_order_type 0，待付款 1，待发货 2，待收货 3，待评价 4，退款
    switch ([orderinfo.t_order_type integerValue]) {
        case 0:
            [_button_3 setTitle:@"待付款" forState:UIControlStateNormal];
            [_button_2  setTitle:@"取消订单" forState:UIControlStateNormal];
            [_button_1 setHidden:YES];
            break;
        case 1:
            [_button_3 setTitle:@"待发货" forState:UIControlStateNormal];
            break;
        case 2:
            [_button_3 setTitle:@"待收货" forState:UIControlStateNormal];
            [_button_1 setHidden:NO];
            [_button_1 setTitle:@"延长收货" forState:UIControlStateNormal];
            [_button_2 setTitle:@"查看物流" forState:UIControlStateNormal];
            break;
        case 3:
            [_button_3 setTitle:@"待评价" forState:UIControlStateNormal];
            [_button_1 setHidden:YES];
            [_button_2 setTitle:@"删除订单" forState:UIControlStateNormal];
            break;
        case 4:
            [_button_3 setTitle:@"退款" forState:UIControlStateNormal];
            [_button_1 setHidden:YES];
            [_button_2 setHidden:YES];
            break;
        default:
            break;
    }
    
    _orderNoLabel.text = _orderInfo.t_order_id;
    _shopNameLabel.text = _orderInfo.t_shop_name; //_orderInfo.t_shop_name;
    _productNameLabel.text = _orderInfo.t_produce_name; //_orderInfo.t_produce_name;
    _productColorLabel.text = [NSString stringWithFormat:@"%@:%@", _orderInfo.t_product_first_type_name, _orderInfo.t_product_first_type_value]; //_orderInfo.t_produce_color;
    _productSizeLabel.text = [NSString stringWithFormat:@"%@:%@", _orderInfo.t_product_second_type_name, _orderInfo.t_product_second_type_value];
//    _productUnitPriceLabel.text = [NSString stringWithFormat:@"￥48.0/%@", _orderInfo.t_product_unit_value];//_orderInfo.t_produce_money;
    //商品的价格
    _productUnitPriceLabel.text = [NSString stringWithFormat:@"￥%.2f元/%@",[_orderInfo.t_order_total_money floatValue]/[_orderInfo.t_order_produce_number floatValue], _orderInfo.t_product_unit_value];
    
//    [_shopLogo  sd_setImageWithURL:[NSURL URLWithString:_orderInfo.t_shop_logo] placeholderImage:[UIImage imageNamed:@"ShopIcon.png"]];
    
    //店铺图片
    NSString *url1 = [_orderInfo.t_shop_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_shopLogo  sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"ShopIcon.png"]];
    
//    [_productLogo sd_setImageWithURL:[NSURL URLWithString:_orderInfo.t_product_img] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    
    //商品图片
    NSString *url = [_orderInfo.t_produce_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_productLogo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    
//    [_stateButton setTitle:_orderInfo.t_order_state forState:UIControlStateNormal];
#warning todo 接口少了数量
    _countLabel.text = _orderInfo.t_order_produce_number; //_orderInfo.t_total_num;
    
}

#pragma mark - T_ORDER_TYPE 0，待付款 1，待发货 2，待收货 3，待评价 4，退款
- (IBAction)doPayAction:(id)sender
{
   
    // 待付款
//    if ([_orderInfo.t_order_type integerValue] == 0)
//    {
//        if (_delegate && [_delegate respondsToSelector:@selector(orderPayAction:)])
//        {
//            [_delegate orderPayAction:_orderInfo];
//        }
    //}
}


- (IBAction)doCancelOrderAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(orderCancelAction:)]) {
        [_delegate orderCancelAction:_orderInfo];
    }
    LogInfo(@"取消订单");
}
-(IBAction)extentTheReceiving:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(extentTheReceiving:) ]) {
        [_delegate extentTheReceiving:_orderInfo];
    }
}

@end
