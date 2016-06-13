//
//  FSBShoppingCarProductInfo.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface FSBShoppingCarProductInfo : FMBean

@property (nonatomic, strong) NSString *t_produce_id; // 商品ID
@property (nonatomic, strong) NSString *t_shop_car_createtime;//创建时间
@property (nonatomic, strong) NSString *t_shop_car_goodsamount;//商品金额
@property (nonatomic, strong) NSString *t_shop_car_id;
@property (nonatomic, strong) NSString *t_shop_car_merchandisediscounts;//商品折扣
@property (nonatomic, strong) NSString *t_shop_car_paymentamount;//支付金额
@property (nonatomic, strong) NSString *t_shop_car_purchasequantity;//购买数量
@property (nonatomic, strong) NSString *t_user_id;

@property (nonatomic, strong) NSString *t_produce_name;
@property(nonatomic,strong)NSString *t_produce_logo;

@property(nonatomic,strong)NSString *t_produce_detail_grandsun_id;
@property(nonatomic,strong)NSString *t_produce_detail_grandsun_name;
@property(nonatomic,strong)NSString *t_produce_detail_grandsun_value;
@property(nonatomic,strong)NSString *t_product_attribute_id;
@property(nonatomic,strong)NSString *t_product_attribute_name;
@property(nonatomic,strong)NSString *t_product_attribute_sun_id;
@property(nonatomic,strong)NSString *t_product_attribute_sun_name;
@property(nonatomic,strong)NSString *t_product_attribute_sun_value;
@property(nonatomic,strong)NSString *t_product_attribute_value;
@property(nonatomic,strong)NSString *t_product_detail_id;
@property (nonatomic, strong) NSString *t_shop_id;
@property (nonatomic, strong) NSString *t_shop_name;

@property (nonatomic, strong) NSString *productid;

@property (nonatomic, strong) NSString *t_shop_phone;
@property (nonatomic, strong) NSString *t_shop_address;





@property (nonatomic, assign) BOOL isSelected;      // 是否被选中

-(id)initWithDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionaryValue;

@end
