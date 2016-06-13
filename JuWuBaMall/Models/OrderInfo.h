//
//  OrderInfo.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/2/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface OrderInfo : FMBean

@property (nonatomic, strong) NSString *t_order_id;             // 订单id
@property (nonatomic, strong) NSString *t_order_createtime;     // 下单时间
@property (nonatomic, strong) NSString *t_order_final_payment;  // 最终支付金额
@property (nonatomic, strong) NSString *t_total_num;            // 最终总数量

@property (nonatomic, strong) NSString *t_order_type;           // 订单类型（0，待付款 1，待发货 2，待收货 3，待评价 4，退款）
@property (nonatomic, strong) NSString *t_order_state;          // 订单状态：未支付、已支付、关闭、完成

@property (nonatomic, strong) NSString *t_user_id;              // 用户ID

@property (nonatomic, strong) NSString *t_shop_id;              // 店铺id
@property (nonatomic, strong) NSString *t_shop_name;            // 店铺名称

@property (nonatomic, strong) NSString *t_produce_id;           // 商品id
@property (nonatomic, strong) NSString *t_produce_shop_price;        // 商品单价
@property (nonatomic, strong) NSString *t_produce_name;         // 商品名称
@property (nonatomic, strong) NSString *t_product_thread_type_value;        // 商品颜色
@property (nonatomic, strong) NSString *t_product_img;   // 商品logo

@property (nonatomic, strong) NSString *t_produce_logo_image;   // 商品logo
@property (nonatomic, strong) NSString *t_product_color;   // 商品logo




@end
