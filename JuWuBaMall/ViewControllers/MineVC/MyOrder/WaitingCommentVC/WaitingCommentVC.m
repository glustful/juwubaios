//
//  WaitingCommentVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/17.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "WaitingCommentVC.h"
#import "WaitingCommentCell.h"

//#import "OrderInfo.h"
#import "MyOrderDetailVC.h"
#import "SubmitCommentVC.h"
#import "OrderReceiveModel.h"


@interface WaitingCommentVC ()<UITableViewDataSource, UITableViewDelegate, WaitingCommentCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic,assign)NSInteger selectedRowIndex;
@property(nonatomic,weak)IBOutlet UITableView *tableView;


@end

@implementation WaitingCommentVC

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
    
    
    
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance] getOrderCollectingGoods:[[GlobalSetting sharedInstance]gUser].t_user_id andOrderType:@"3" andNetworkDelegate:self];//
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
    static NSString *cellId = @"WaitingCommentCell";
    WaitingCommentCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (caseFieldNotificationCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WaitingCommentCell" owner:self options:nil];
        for(id obj in nib)
        {
            if([obj isKindOfClass:[WaitingCommentCell class]])
            {
                caseFieldNotificationCell = (WaitingCommentCell *)obj;
            }
        }
        
        caseFieldNotificationCell.delegate = self;
        
        // cell 复用
        [tableView registerNib:[UINib nibWithNibName:@"WaitingCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
        
    }
    
    caseFieldNotificationCell.parentVC = self;
    
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

    return _dataList.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 243;
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
        orderDetailVC.orderType = eMyOrderStatus_WaitingComment;

        orderDetailVC.orderInfo = orderInfo;
        
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }
    _selectedRowIndex=indexPath.row;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - WaitingCommentCellDelegate
- (void)deleteOrderAction:(OrderInfo *)orderInfo
{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除订单？" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma mark 删除订单接口
        [self.dataList removeObject:orderInfo];
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]cancelOrderRequestWithOrderID:orderInfo.t_order_id networkDelegate:self];
        [self.networkRequestArray  addObject:request];
        
        
        
        
        LogInfo(@"订单删除");
    }]];
//    [self presentViewController:controller animated:YES completion:nil];
}
-(void)myOrderCellButtonDidTouchDown:(UIButton *)button{
    
}
-(void)submitCommentVCEventDid{
    SubmitCommentVC *commentVC = [[SubmitCommentVC alloc] initWithName:@""];
    OrderInfo *order=_dataList[_selectedRowIndex];
    commentVC.orderInfo=order;
    [self.navigationController pushViewController:commentVC animated:YES];
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
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getOrderCollectingGoods]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            NSMutableArray *dataArray=[NSMutableArray array];
            dataArray=fmNetworkRequest.responseData;
            //2-待收货 3-待评价
            for (OrderReceiveModel *order in dataArray) {
                if ([order.t_order_type isEqualToString:@"3"]) {//3
                    [_dataList  addObject:order];
                    [_tableView  reloadData];
                }
            }
        }else{
            [_dataList  removeAllObjects];
            OrderReceiveModel *order=fmNetworkRequest.responseData;
            [_dataList addObject:order];
            [_tableView reloadData];

        }
    }
    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_CancelOrder]){
        [self.tableView reloadData];
        
    }
    
}
@end
