//
//  ProductStatusCanChoseModel.h
//  JuWuBaMall
//
//  Created by yanghua on 16/5/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface ProductStatusCanChoseModel : FMBean


@property (nonatomic ,strong) NSArray*firstStatusCanChoseArray;//三级数组能够选择列表
@property (nonatomic ,strong) NSArray*secondStatusCanChoseArray;//二级数组能够选择列表
@property (nonatomic ,strong) NSArray*thirdStatusCanChoseArray;//三级数组能够选择列表



@end
