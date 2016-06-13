//
//  ProductDetailStatuesModel.h
//  JuWuBaMall
//
//  Created by yanghua on 16/5/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface ProductDetailStatuesModel : FMBean

@property (nonatomic, strong)NSArray *product_first_type_value_array ;
//二级属性
@property (nonatomic, strong)NSArray *product_second_type_value_array;
//三级属性
@property (nonatomic, strong)NSArray *product_thread_type_value_array ;




//一级属性key -value
@property (nonatomic, strong) NSMutableDictionary *product_first_type_value_dic ;
//一级属性key -value
@property (nonatomic, strong) NSMutableDictionary *product_second_type_value_dic;
//一级属性key -value
@property (nonatomic, strong) NSMutableDictionary *product_thread_type_value_dic;



///所有详情种类
@property (nonatomic, strong)NSArray *typeArray ;

@property (nonatomic, assign) CGFloat cellHight; //cell高度
@end
