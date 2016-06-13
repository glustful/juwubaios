//
//  OrderNewModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/5/6.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface OrderNewModel : FMBean

@property (nonatomic, strong) NSString *is_product_attention;
@property (nonatomic, strong) NSString *t_check_status;
@property (nonatomic, strong) NSString *t_order_createtime;
@property (nonatomic, strong) NSString *t_order_detail_id;
@property (nonatomic, strong) NSString *t_order_id;
@property (nonatomic, strong) NSString *t_order_total_money;
@property (nonatomic, strong) NSString *t_order_type;
@property (nonatomic, strong) NSString *t_produce_detail_id;
@property (nonatomic, strong) NSString *t_produce_id;
@property (nonatomic, strong) NSString *t_produce_interduce;
@property (nonatomic, strong) NSString *t_produce_logo;
@property (nonatomic, strong) NSString *t_produce_name;
@property (nonatomic, strong) NSString *t_produce_sale_num;
@property (nonatomic, strong) NSString *t_product_first_type_name;
@property (nonatomic, strong) NSString *t_product_first_type_value;
@property (nonatomic, strong) NSString *t_product_img;
@property (nonatomic, strong) NSString *t_product_second_type_name;
@property (nonatomic, strong) NSString *t_product_second_type_value;
@property (nonatomic, strong) NSString *t_product_thread_type_name;
@property (nonatomic, strong) NSString *t_product_thread_type_value;
@property (nonatomic, strong) NSString *t_product_unit_value;
@property (nonatomic, strong) NSString *t_shop_id;
@property (nonatomic, strong) NSString *t_sort;

@property (nonatomic, strong) NSString *t_shop_logo;
@property (nonatomic, strong) NSString *t_shop_name;
@property (nonatomic, strong) NSString *t_produce_shop_price;

@property (nonatomic, strong) NSString *t_order_produce_number;

@property (nonatomic, strong) NSString *t_total_num;

/**
 *  订单的最终的价格
 */
@property (nonatomic, strong) NSString *t_order_final_payment;


-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
