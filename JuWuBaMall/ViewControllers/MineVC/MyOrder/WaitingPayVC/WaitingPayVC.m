//
//  WaitingPayVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/17.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "WaitingPayVC.h"
#import "WaitingPayCell.h"

#import "MyOrderDetailVC.h"

@interface WaitingPayVC ()<UITableViewDataSource,UITableViewDelegate, WaitingPayCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic,strong)IBOutlet UITableView *tableView;

@end

@implementation WaitingPayVC

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    // topRightItem
    [self addNavRightItemWithImageName:@"editIcon"];
    
#pragma Mark 根据用户ID查询订单信息  //4b4c01d5-ec81-4bad-a505-a6b30677d172
//    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]gettOrderByUserId:@"688831b3-b671-46a1-8a14-e739c72ecac4" networkDelegate:self];//688831b3-b671-46a1-8a14-e739c72ecac4
//    [self.networkRequestArray  addObject:request];
    

//    FMNetworkRequest *request=[[FSNetworkManager sharedInstance] getOrderProductByUserId:@"688831b3-b671-46a1-8a14-e739c72ecac4" andOrderType:@"0" andNetworkDelegate:self];//688831b3-b671-46a1-8a14-e739c72ecac4

//    FMNetworkRequest *request=[[FSNetworkManager sharedInstance] getOrderProductByUserId:@"79236e94-43ae-4cae-aaa5-7be7ff1d8f16" andType:@"0" andNetworkDelegate:self];//688831b3-b671-46a1-8a14-e739c72ecac4 @"79236e94-43ae-4cae-aaa5-7be7ff1d8f16"
    
     [[BaseAlert sharedInstance] showLodingWithMessage:@"加载中..."];
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance] getOrderProductByUserId:[[GlobalSetting sharedInstance]gUser].t_user_id andOrderType:@"0" andNetworkDelegate:self];

    [self.networkRequestArray  addObject:request];
}

#pragma mark - topRightItem点击事件
- (void)doRightItemAction:(UIButton *)button
{
    [super doCommonRightItemAction:button];
    
}


#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"WaitingPayCell";
    WaitingPayCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (caseFieldNotificationCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WaitingPayCell" owner:self options:nil];
        for(id obj in nib)
        {
            if([obj isKindOfClass:[WaitingPayCell class]])
            {
                caseFieldNotificationCell = (WaitingPayCell *)obj;
            }
        }
        
        // cell 复用
        [tableView registerNib:[UINib nibWithNibName:@"WaitingPayCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
        
    }
    
    caseFieldNotificationCell.delegate = self;
    caseFieldNotificationCell.parentVC = self;
    OrderNewModel *order=_dataList[indexPath.row];
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
    return self.dataList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 243;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.01;
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (_dataList && _dataList.count > indexPath.row)
    {
        OrderNewModel *orderInfo = _dataList[indexPath.row];
        
        MyOrderDetailVC *orderDetailVC = [[MyOrderDetailVC alloc] initWithName:@"订单详情"];
        orderDetailVC.orderStatus = eMyOrderStatus_WaitingPay;
    
        orderDetailVC.orderNewIn = orderInfo;
        
        
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - WaitingPayCellDelegate
- (void)cancelOrderAction:(OrderInfo *)orderInfo
{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否取消订单" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //从数组中将对应的数据删除掉
        [self.dataList removeObject:orderInfo];
        
#pragma mark 取消订单
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]cancelOrderRequestWithOrderID:orderInfo.t_order_id networkDelegate:self];
    [self.networkRequestArray  addObject:request];

    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
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
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getOrderProductByOrderTypeAndUserId]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            [self.dataList removeAllObjects];
            NSMutableArray *dataArray=[NSMutableArray array];
            dataArray=fmNetworkRequest.responseData;
            //0-待付款 1-待发货 2-待收货 3-待评价 4-退款
            for (OrderNewModel *order in dataArray) {
                if ([order.t_order_type isEqualToString:@"0"]) {
                    [self.dataList  addObject:order];
                    [_tableView  reloadData];
                }
            }
        }
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[OrderNewModel class]]) {
            [self.dataList  removeAllObjects];
             OrderNewModel  *order=fmNetworkRequest.responseData;
            [self.dataList addObject:order];
            [_tableView  reloadData];
        }
    }
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_CancelOrder]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
            [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
            
             [_tableView  reloadData];
            
        }
    }
    
}

@end
