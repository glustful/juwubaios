//
//  OrderConfirmVC.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BaseVC.h"

@interface OrderConfirmVC : BaseVC

@property (nonatomic, strong) NSMutableArray *productArray;
@property (nonatomic, assign) NSInteger payType;

@property(nonatomic,strong)OrderInfo *orderInfo;

@property (nonatomic, assign) float totalMoney;//总的钱数

@property (nonatomic, copy) NSString *sendType;//送货方式


@end
