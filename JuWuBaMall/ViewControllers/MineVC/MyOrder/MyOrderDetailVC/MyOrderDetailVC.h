//
//  MyOrderDetailVC.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/2.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BaseVC.h"
#import "OrderInfo.h"

#import "OrderReceiveModel.h"
#import "OrderNewModel.h"

#warning todo 

typedef NS_ENUM(NSInteger, MyOrderStatusType)
{
//    eMyOrderStatus_WaitingSend,     // 待发货
    eMyOrderStatus_WaitingPay,      // 待付款
    eMyOrderStatus_WaitingRecieve,  // 待收货
    eMyOrderStatus_WaitingComment,  // 待评价
};
@interface MyOrderDetailVC : BaseVC

@property (nonatomic, assign) MyOrderStatusType orderStatus;

@property (nonatomic, strong) OrderReceiveModel *orderInfo;
@property (nonatomic, strong) OrderInfo *orderIn;

@property (nonatomic, strong) OrderNewModel *orderNewIn;


@property (nonatomic, assign) MyOrderStatusType orderType;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, copy) NSString *totalCount;//总的数量
@property (nonatomic, copy) NSString *totalMoney;//总的金额

@property(strong,nonatomic)AddressInfo *addressInfo;


@end
