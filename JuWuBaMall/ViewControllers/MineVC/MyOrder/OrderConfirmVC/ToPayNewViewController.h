//
//  ToPayNewViewController.h
//  JuWuBaMall
//
//  Created by JWB on 16/5/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BaseVC.h"

@interface ToPayNewViewController : BaseVC
@property (nonatomic, copy) NSString *allMoney;//总的钱数
@property (nonatomic, copy) NSString *myOrderID;//订单号

@property (nonatomic, strong) NSMutableArray *producetArr;//商品数组


@end
