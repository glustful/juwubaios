//
//  SortLeftModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/5.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortLeftModel : NSObject

//@property (nonatomic, copy) NSString *t_check_status;//审核状态
//@property (nonatomic, copy) NSString *t_produce_id;//商品id
//@property (nonatomic, copy) NSString *t_produce_name;//商品名称
//@property (nonatomic, copy) NSString *t_product_type_id;//商品类型id
//@property (nonatomic, copy) NSString *t_product_typedescription;//类型介绍
//@property (nonatomic, copy) NSString *t_product_typename;//类型名
//@property (nonatomic, copy) NSString *t_sort;//排序

@property (nonatomic, copy) NSString *is_product_attention;//关注
@property (nonatomic, copy) NSString *p_id;//商品id
@property (nonatomic, copy) NSString *t_check_status;//商品名称
@property (nonatomic, copy) NSString *t_product_type_id;//商品类型id
@property (nonatomic, copy) NSString *t_product_typedescription;//类型介绍
@property (nonatomic, copy) NSString *t_product_typename;//类型名
@property (nonatomic, copy) NSString *t_sort;//排序
@property (nonatomic, copy) NSString *t_ptype_img;//图片
@property (nonatomic, copy) NSString *t_produce_sale_num;//销售数量


-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;


@end
