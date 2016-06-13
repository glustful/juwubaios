//
//  SearchProductOrShopModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface SearchProductOrShopModel : FMBean
/**
 *  商品是否关注
 */
@property (nonatomic, strong) NSString *is_product_attention;
/**
 *  终止状态
 */
@property (nonatomic, strong) NSString *typet_check_statusName;
/**
 *  公司名称
 */
@property (nonatomic, strong) NSString *t_company_name;
/**
    产品ID
 */
@property (nonatomic, strong) NSString *t_produce_id;
/**
    产品名称
 */
@property (nonatomic, strong) NSString *t_produce_name;
/**
    产品销售数量
 */
@property (nonatomic, strong) NSString *t_produce_sale_num;
/**
    产品店铺价格
 */
@property (nonatomic, strong) NSString *t_produce_shop_price;
/**
    店铺ID
 */
@property (nonatomic, strong) NSString *t_shop_id;

/**
    分类
 */
@property (nonatomic, strong) NSString *t_sort;
/**
 *  商品图片
 */
@property (nonatomic, strong) NSString *t_produce_logo;


-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;


@end
