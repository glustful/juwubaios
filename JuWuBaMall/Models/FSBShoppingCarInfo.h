//
//  FSBShoppingCarInfo.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface FSBShoppingCarInfo : FMBean

@property (nonatomic, strong) NSString *t_shop_id;
@property (nonatomic, strong) NSString *t_shop_name;

@property (nonatomic, strong) NSMutableArray *productArray;

@property (nonatomic, assign) BOOL isSelected;      // 是否被选中

-(id)initWithDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionaryValue;

@end
