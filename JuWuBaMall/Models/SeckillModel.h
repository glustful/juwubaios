//
//  SeckillModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/16.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface SeckillModel : FMBean

@property(nonatomic,strong)NSString *t_produce_detail_shop_price;//商品店铺价格
@property(nonatomic,strong)NSString *t_produce_name;//商品名称
@property(nonatomic,strong)NSString *t_product_img;//商品图片
@property(nonatomic,strong)NSString *t_product_stock;//商品库存
@property(nonatomic,strong)NSString *t_product_type_id;//商品类型id
@property(nonatomic,strong)NSString *t_product_typename;//商品类型名称
@property(nonatomic,strong)NSString *t_product_value;//商品属性1 尺寸
@property(nonatomic,strong)NSString *t_product_value1;//商品属性2 颜色

@property(nonatomic,strong)NSString *t_product_value2;//商品属性3 重量
@property(nonatomic,strong)NSString *t_seckill_price;//秒杀价格
@property(nonatomic,strong)NSString *t_seckill_product_id;//商品id
@property(nonatomic,strong)NSString *t_seckill_product_totalnumber;//秒杀商品总数量
@property(nonatomic,strong)NSString *t_seckill_starttime;//秒杀开始时间
@property(nonatomic,strong)NSString *t_seckill_stoptime;//秒杀结束时间
@property(nonatomic,strong)NSString *t_shop_id;//店铺id




-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;




@end
