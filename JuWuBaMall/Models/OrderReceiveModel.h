//
//  OrderReceiveModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/5/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface OrderReceiveModel : FMBean
@property (nonatomic, strong) NSString *is_product_attention;
@property (nonatomic, strong) NSString *t_check_status;
@property (nonatomic, strong) NSString *t_order_notice;
@property (nonatomic, strong) NSString *t_order_detail_id;

@property (nonatomic, strong) NSString *t_order_total_money;
@property (nonatomic, strong) NSString *t_order_type;



@property (nonatomic, strong) NSString *t_produce_brand;
@property (nonatomic, strong) NSString *t_produce_detail_id;
@property (nonatomic, strong) NSString *t_produce_id;
@property (nonatomic, strong) NSString *t_produce_detail_shop_price;
@property (nonatomic, strong) NSString *t_produce_logo;
@property (nonatomic, strong) NSString *t_produce_name;
@property (nonatomic, strong) NSString *t_produce_sale_num;
@property (nonatomic, strong) NSString *t_produce_shop_price;
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

@property (nonatomic, strong) NSString *t_receipt_area;
@property (nonatomic, strong) NSString *t_receipt_name;
@property (nonatomic, strong) NSString *t_receipt_phone;
@property (nonatomic, strong) NSString *t_receipt_streetaddress;

@property (nonatomic, strong) NSString *t_receivingmode;

@property (nonatomic, strong) NSString *t_order_produce_number;




-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;


@end
