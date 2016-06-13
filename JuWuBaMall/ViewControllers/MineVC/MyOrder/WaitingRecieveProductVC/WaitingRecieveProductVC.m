//
//  WaitingRecieveProductVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/17.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "WaitingRecieveProductVC.h"
#import "WaitingRecieveProductCell.h"

#import "OrderInfo.h"
#import "MyOrderDetailVC.h"
#import "OrderNewModel.h"

//typedef NS_ENUM(NSInteger, AlertViewTag)
//{
//    eConfirmReceiveProductTag = 1,
//    eDelayReceiveProductTag
//};
@interface WaitingRecieveProductVC ()<UITableViewDataSource,UITableViewDelegate, WaitingRecieveProductCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic,weak)IBOutlet UITableView *tableViw;


@end

@implementation WaitingRecieveProductVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataList = [[NSMutableArray alloc] init];
    
#pragma Mark 根据用户ID查询订单信息
//    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]gettOrderByUserId:@"4b4c01d5-ec81-4bad-a505-a6b30677d172" networkDelegate:self];
//    [self.networkRequestArray  addObject:request];@"1111"
    
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance] getOrderCollectingGoods:[[GlobalSetting sharedInstance]gUser].t_user_id andOrderType:@"2" andNetworkDelegate:self];//
    [self.networkRequestArray  addObject:request];
    
    
    // topRightItem
    [self addNavRightItemWithImageName:@"editIcon"];
}

#pragma mark - topRightItem点击事件
- (void)doRightItemAction:(UIButton *)button
{
    [super doCommonRightItemAction:button];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"WaitingRecieveProductCell";
    WaitingRecieveProductCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (caseFieldNotificationCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WaitingRecieveProductCell" owner:self options:nil];
        for(id obj in nib)
        {
            if([obj isKindOfClass:[WaitingRecieveProductCell class]])
            {
                caseFieldNotificationCell = (WaitingRecieveProductCell *)obj;
            }
        }
        
        // cell 复用
        [tableView registerNib:[UINib nibWithNibName:@"WaitingRecieveProductCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
        
    }
    caseFieldNotificationCell.parentVC = self;
    caseFieldNotificationCell.delegate = self;
    
    OrderReceiveModel *order=_dataList[indexPath.row];
    [caseFieldNotificationCell  reloadData:order];
    
    return caseFieldNotificationCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 分割View
    UIImageView *sepeartorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    sepeartorView.image = [UIImage imageNamed:@"SepartorLine"];
    return sepeartorView;
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 232;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_dataList && _dataList.count > indexPath.row)
    {
        OrderReceiveModel *orderInfo = _dataList[indexPath.row];
        
        MyOrderDetailVC *orderDetailVC = [[MyOrderDetailVC alloc] initWithName:@"订单详情"];
        orderDetailVC.orderType = eMyOrderStatus_WaitingRecieve;
//        orderDetailVC.orderInfo = orderInfo;
        [orderDetailVC.dataList addObject:orderInfo];
        
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - WaitingRecieveProductCellDelegate

- (void)delayReceiveProductAction:(OrderReceiveModel *)orderInfo
{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"将延迟7天收货" preferredStyle:UIAlertControllerStyleAlert];
    [controller  addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma mark 延迟收货接口调用
        LogInfo(@"延长收货");
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)confirmReceiveProductAction:(OrderInfo *)orderInfo
{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认收货？" preferredStyle:UIAlertControllerStyleAlert];
    [controller  addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma mark 确认收货接口调用
        LogInfo(@"确认收货");
    }]];
    [self presentViewController:controller animated:YES completion:nil];

}
#pragma mark - 网络请求回调
- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
    }
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];
//    if ([fmNetworkRequest.requestName isEqualToString:kRequest_user_gettOrderByUserId]) {
//        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
//            NSMutableArray *dataArray=[NSMutableArray array];
//            dataArray=fmNetworkRequest.responseData;
//            //0-待付款 1-待发货 2-待收货 3-待评价 4-退款
//            for (OrderInfo *order in dataArray) {
//                if ([order.t_order_type isEqualToString:@"2"]) {//2
//                    [_dataList  addObject:order];
//                    [_tableViw  reloadData];
//                }
//            }
//        }
    
        if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getOrderCollectingGoods]) {
            if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
                [self.dataList removeAllObjects];
                self.dataList=fmNetworkRequest.responseData;
                [self.tableViw reloadData];
//                //0-待付款 1-待发货 2-待收货 3-待评价 4-退款
//                for (OrderReceiveModel *order in dataArray) {
//                    if ([order.t_order_type isEqualToString:@"0"]) {
//                        [self.dataList  addObject:order];
//                        [self.tableViw  reloadData];
//                    }
//                }
            }
            else{
                [self.dataList  removeAllObjects];
                OrderReceiveModel  *order=fmNetworkRequest.responseData;
                [self.dataList addObject:order];
                [self.tableViw  reloadData];

            }
            
        }
        
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[OrderInfo class]]) {
            [_dataList  removeAllObjects];
            Order *order=fmNetworkRequest.responseData;
            [_dataList addObject:order];
            [_tableViw  reloadData];
        }
    
    
}


@end
