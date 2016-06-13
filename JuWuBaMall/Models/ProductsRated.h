//
//  ProductsRated.h
//  JuWuBaMall
//
//  Created by yanghua on 16/4/29.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface ProductsRated : FMBean


/**
 *  商品id
 */
@property (nonatomic, strong) NSString *t_product_id;
/**
 *  评价信息id
 */
@property (nonatomic, strong) NSString *t_product_rated_id;
/**
 *  评价内容
 */
@property (nonatomic, strong) NSString *t_rated_content;
/**
 *评价创建时间
 */
@property (nonatomic, strong) NSString *t_rated_createtime;
/**
 *  评价等级（0、差评1、中评2、好评）
 */
@property (nonatomic, strong) NSString *t_rated_level;
/**
 *  用户id
 */
@property (nonatomic, strong) NSString *t_user_id;



/*
 计算对应的FMTableCell高度
 */
-(void)caculateHeight;
@end
