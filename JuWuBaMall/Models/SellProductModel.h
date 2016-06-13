//
//  SellProductModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/5.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface SellProductModel : FMBean
//@property (nonatomic, assign) int is_product_attention;//是否关注
@property (nonatomic, copy) NSString *is_product_attention;
@property (nonatomic, copy) NSString *t_produce_id;//商品id
@property (nonatomic, copy) NSString *t_produce_name;//商品名字
//@property (nonatomic, assign) double t_produce_shop_price;//商品价格
@property (nonatomic, copy) NSString *t_produce_shop_price;
@property (nonatomic, copy) NSString *t_product_img;//商品图片
//@property (nonatomic, assign) int t_product_sale_num;//商品销量
@property (nonatomic, copy) NSString *t_product_sale_num;

@property (nonatomic, copy) NSString *t_produce_logo;


-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;


@end
