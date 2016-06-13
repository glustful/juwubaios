//
//  ProductRated.h
//  JuWuBaMall
//
//  Created by yanghua on 16/5/2.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface ProductRated : FMBean

@property (nonatomic, strong) NSString *t_product_id;
@property (nonatomic, strong) NSString *t_rated_content;
@property (nonatomic, strong) NSString *t_rated_createtime;
@property (nonatomic, strong) NSString *t_rated_level;
@property (nonatomic, strong) NSString *t_user_id;

@property (nonatomic, strong) NSString *t_product_rated_id;

@end
