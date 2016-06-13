//
//  ProductStatusModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/23.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"
#import "ProductDetailStatuesModel.h"
@interface ProductStatusModel : FMBean
/**
 *  关注
 */
@property (nonatomic, strong) NSString *is_product_attention;

/**
 *  折扣
 */
@property (nonatomic, strong) NSString *t_discount;

/**
 *  检查状态
 */
@property (nonatomic, strong) NSString *t_check_status;
/**
 *  商品详情经销商价格
 */
@property (nonatomic, strong) NSString *t_produce_detail_dealer_price;
/**
 *商品详情子ID
 */
@property (nonatomic, strong) NSString *t_produce_detail_grandsun_id;
/**
 *  商品详情市场价格
 */
@property (nonatomic, strong) NSString *t_produce_detail_market_price;
/**
 *  商品详情店铺价格
 */
@property (nonatomic, strong) NSString *t_produce_detail_shop_price;
/**
 *  商品ID
 */
@property (nonatomic, strong) NSString *t_produce_shop_price;


@property (nonatomic, strong) NSString *t_produce_id;
/**
 *  销售数量
 */
@property (nonatomic, strong) NSString *t_produce_sale_num;
/**
 *  属性ID
 */
@property (nonatomic, strong) NSString *t_product_attribute_id;
/**
 *  属性子ID
 */
@property (nonatomic, strong) NSString *t_product_attribute_sun_id;
/**
 *  商品详情ID
 */
@property (nonatomic, strong) NSString *t_product_detail_id;
/**
 *  首个类型名
 */
@property (nonatomic, strong) NSString *t_product_first_type_name;
/**
 *  首个类型值
 */
@property (nonatomic, strong) NSString *t_product_first_type_value;
/**
 *  产品图片
 */
@property (nonatomic, strong) NSString *t_product_img;
/**
 *  第二个类型名
 */
@property (nonatomic, strong) NSString *t_product_second_type_name;
/**
 *  第二个类型值
 */
@property (nonatomic, strong) NSString *t_product_second_type_value;
/**
 *  库存
 */
@property (nonatomic, strong) NSString *t_product_stock;
/**
 *  类型ID
 */
@property (nonatomic, strong) NSString *t_product_type_id;
/**
 *  产品单位ID
 */
@property (nonatomic, strong) NSString *t_product_unit_id;
/**
 *  产品单位名称
 */
@property (nonatomic, strong) NSString *t_product_unit_name;
/**
 *  产品单位值
 */
@property (nonatomic, strong) NSString *t_product_unit_value;
/**
 *  产品分类
 */
@property (nonatomic, strong) NSString *t_sort;


@property (nonatomic, strong) NSString *t_produce_name;
/**
 *  第3个类型名
 */
@property (nonatomic, strong)NSString * t_product_thread_type_name;

/**
 *  第3个类型值
 */
@property (nonatomic, strong)NSString *t_product_thread_type_value;



//
//"is_product_attention":"0",
//"t_check_status":"0",
//"t_produce_detail_dealer_price":"88.0",
//"t_produce_detail_grandsun_id":"b1d199ba-7d92-4c6a-8d34-37e9fd071de4",
//"t_produce_detail_market_price":"88.0",
//"t_produce_detail_shop_price":"88.0",
//"t_produce_id":"efddd636-deb6-4040-8711-22b993f0ae48",
//"t_produce_sale_num":"0",
//"t_product_attribute_id":"47b5b39d-14b5-49c2-bbc1-0ec308fec750",
//"t_product_attribute_sun_id":"3af0ef2d-9574-40b9-8583-b44c2a216512",
//"t_product_detail_id":"63bf97b7-993c-4b91-bc78-7427461418ed",
//"t_product_first_type_name":"重量",
//"t_product_first_type_value":"15kg/件",
//"t_product_img":"",
//"t_product_second_type_name":"尺寸",
//"t_product_second_type_value":"120X240",
//"t_product_stock":"55",
//"t_product_thread_type_name":"颜色",
//"t_product_thread_type_value":"金黄色",
//"t_product_type_id":"pt000006",
//"t_product_unit_id":"000001",
//"t_product_unit_name":"单位",
//"t_product_unit_value":"对",
//"t_sort":"0"


-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
