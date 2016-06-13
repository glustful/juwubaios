//
//  MyOrderVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/17.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderListCell.h"
#import "OrderInfo.h"
#import "MyOrderDetailVC.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "UPPaymentControl.h"
#import "RefundVC.h"
#import "SubmitCommentVC.h"
#import "LogisticsDetailVC.h"


typedef NS_ENUM(NSInteger, PayType)
{
    eAlipayType,    // 支付宝
    eWeiXinPayType, // 微信支付
    eUnionPayType,  // 银联支付
};

@interface MyOrderVC ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,MyOrderListCellDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UISearchBar *searchBar;
@property (nonatomic, strong) NSString *payType;        // 支付类型

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *filterDataList;

@property (nonatomic, strong) OrderInfo *waitingPayOrderInfo;   // 待支付订单信息
@property(nonatomic,strong)UISearchDisplayController  *searchDisplayController;
@property(nonatomic,strong)NSMutableArray *resultArray;

@property (nonatomic, assign) int page;
@property (nonatomic, assign) int num;




@end

@implementation MyOrderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.page = 0;
    self.num = 20;
        // 初始化
    _dataList = [[NSMutableArray alloc] init];
    _resultArray=[[NSMutableArray alloc]init];
    _filterDataList = [[NSMutableArray alloc] init];
    
    // topRightItem
    [self addNavRightItemWithImageName:@"editIcon"];
    [self createScreenView];
    
#warning TEST 719ff03d-a904-476d-8545-6851a971a137
//    [[BaseAlert sharedInstance] showLodingWithMessage:@"加载中"];
    
//    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]QueryOrderWithUserID:@"4b4c01d5-ec81-4bad-a505-a6b30677d172" networkDelegate:self];
//    [self.networkRequestArray  addObject:request];
    
//    FMNetworkRequest *request=[[FSNetworkManager sharedInstance] getOrderProductByUserIdCountWithUserId:[[GlobalSetting sharedInstance]gUser].t_user_id andPage:@"0" andRow:@"20" andNetworkDelegate:self];
//    
//    [self.networkRequestArray  addObject:request];
    
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance] findAllOrderByUderId:[[GlobalSetting sharedInstance]gUser].t_user_id andPage:[NSString stringWithFormat:@"%d", self.page] andRow:[NSString stringWithFormat:@"%d", self.num] andNetworkDelegate:self];
    
    [self.networkRequestArray  addObject:request];
    
//    [_tableView  reloadData];
 
 
}
-(void)createScreenView{
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    [self.view  addSubview:titleView];
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    _searchBar.placeholder=@"按订单编号搜索订单";
    [titleView  addSubview:_searchBar];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,44, ScreenWidth, ScreenHeight-108) style:UITableViewStylePlain];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view  addSubview:_tableView];
    _searchDisplayController=[[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.searchResultsDelegate=self;
    _searchDisplayController.searchResultsDataSource=self;
    _searchDisplayController.delegate=self;

}
#pragma mark - topRightItem点击事件
- (void)doRightItemAction:(UIButton *)button
{
    [super doCommonRightItemAction:button];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView==_tableView) {
        return _dataList.count;
    }
    return _resultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // 订单相关cell
    static NSString *cellId = @"MyOrderListCell";
    MyOrderListCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (caseFieldNotificationCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyOrderListCell" owner:self options:nil];
        for(id obj in nib)
        {
            if([obj isKindOfClass:[MyOrderListCell class]])
            {
                caseFieldNotificationCell = (MyOrderListCell *)obj;
            }
        }
        
        // cell 复用
        [tableView registerNib:[UINib nibWithNibName:@"MyOrderListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
        
    }
    
    caseFieldNotificationCell.delegate = self;
    
    if (tableView==_tableView) {
        if (_dataList && _dataList.count > indexPath.row)
        {
            OrderNewModel *orderInfo = _dataList[indexPath.row];
            
            [caseFieldNotificationCell reloadCellData:orderInfo];
        }
    }else{
        if (_resultArray && _resultArray.count > indexPath.row)
        {
            OrderNewModel *orderInfo = _resultArray[indexPath.row];
            
            [caseFieldNotificationCell reloadCellData:orderInfo];
        }
        LogInfo(@"ggg%lu",(unsigned long)_resultArray.count);
    }
    
    return caseFieldNotificationCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyOrderListCell"];
    if (cell) {
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        CGFloat height=cell.height;
        return height;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableView) {
        if (_dataList && _dataList.count > indexPath.row)
        {
            OrderNewModel *orderInfo = _dataList[indexPath.row];
            
            MyOrderDetailVC *orderDetailVC = [[MyOrderDetailVC alloc] initWithName:@"订单详情"];
            orderDetailVC.orderNewIn = orderInfo;
            
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        }
    }
    else{
        if (_resultArray && _resultArray.count > indexPath.row)
        {
            OrderNewModel *orderInfo = _resultArray[indexPath.row];
            
            MyOrderDetailVC *orderDetailVC = [[MyOrderDetailVC alloc] initWithName:@"订单详情"];
            orderDetailVC.orderNewIn = orderInfo;
            
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UISearchDisplayControllerdelegate
//搜索内容改变 并且刷新结果集内容的时候执行的方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //处理搜索内容
    //清空上次搜索内容
    [_resultArray removeAllObjects];
    //判断当前搜索类型
    for (OrderInfo *order in _dataList)
    {
        NSString *name=order.t_order_id;
        //判断name字符串是否包含搜索字符串的内容
        NSRange range=[name rangeOfString:searchString];
        if (range.location!=NSNotFound)
        {
            [_resultArray addObject:order];
        }
    }
    
    return YES;
}

#pragma mark - 网络请求回调
- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];
    
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
    {
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
    }
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];//kRequest_User_getOrderProductByUserIdCount
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_findAllOrderByUderId]){
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]])
        {
            [_dataList removeAllObjects];
            
            [_dataList addObjectsFromArray:fmNetworkRequest.responseData];
            
            [_tableView reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[OrderNewModel class]]) {
            [_dataList removeAllObjects];
            OrderNewModel *order=fmNetworkRequest.responseData;
            [_dataList addObject:order];
            [_tableView reloadData];
        }

    }
    
}

#pragma mark - MyOrderListCellDelegate
- (void)orderPayAction:(OrderInfo *)orderInfo{
    _waitingPayOrderInfo = orderInfo;
//  t_order_type  0-待付款 1-待发货 2-待收货 3-待评价 4-退款
    switch ([orderInfo.t_order_type integerValue]) {
        case 0:{//0-待付款
            UIAlertController *controller=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
#pragma mark -支付宝支付
            [controller addAction:[UIAlertAction actionWithTitle:@"支付宝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LogInfo(@"支付宝");
                _payType = @"alipay";
                
                [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:[AlipayToolKit genTradeNoWithTime] productName:@"邮票" productDescription:@"全真邮票" amount:@"0.8" notifyURL:kNotifyURL itBPay:@"30m"];
            }]];
#pragma mark 微信支付
            [controller addAction:[UIAlertAction actionWithTitle:@"微信" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LogInfo(@"微信");
                _payType = @"wx";
                
                [self bizPay];
            }]];
#pragma mark 银联支付
            [controller addAction:[UIAlertAction actionWithTitle:@"银联" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                LogInfo(@"银联");
                _payType = @"upacp";
                
#warning todo 服务端接口（获取tn）
                NSString *tn = @"131313333355667";
                
                if(![[UPPaymentControl defaultControl] isPaymentAppInstalled])
                {
                    //当判断用户手机上已安装银联App，商户客户端可以做相应个性化处理
                    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"请先安装银联客户端" preferredStyle:UIAlertControllerStyleAlert];
                    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:controller animated:YES completion:nil];
                    
                    return;
                }
                
                if ([tn isStringSafe])
                {
                    // 调起支付
                    [[UPPaymentControl defaultControl] startPay:tn fromScheme:kJuWuBaUPPayScheme mode:UPPayDebugMode viewController:self];
                }
                
            }]];
            [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:controller animated:YES completion:nil];
        }break;
        case 1:{//1-待发货
            
        }break;
        case 2:{// 2-待收货
            
        }break;
        case 3:{//3-待评价
            SubmitCommentVC *submitCommentVC=[[SubmitCommentVC alloc]initWithName:@""];
            [self.navigationController pushViewController:submitCommentVC animated:YES];
        }break;
        case 4:{//4-退款
            UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退款吗？" preferredStyle:UIAlertControllerStyleAlert];
            [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                RefundVC *refundVC=[[RefundVC alloc]initWithName:@"申请退款"];
                [self.navigationController pushViewController:refundVC animated:YES];
            }]];
            [self presentViewController:controller animated:YES completion:nil];
        }
        default:
            break;
    }
}
-(void)orderCancelAction:(OrderNewModel *)orderInfo{
    //t_order_type 0，待付款 1，待发货 2，待收货 3，待评价 4，退款
     if ([orderInfo.t_order_type integerValue] == 0){
         UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要取消订单吗？" preferredStyle:UIAlertControllerStyleAlert];
         [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
         [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             
             [self.dataList removeObject:orderInfo];
             [self.tableView reloadData];
             
#pragma mark -取消订单
             FMNetworkRequest  *request=[[FSNetworkManager sharedInstance]cancelOrderRequestWithOrderID:orderInfo.t_order_id networkDelegate:self];
             [self.networkRequestArray  addObject:request];
         }]];
         [self presentViewController:controller animated:YES completion:nil];
     }
    if([orderInfo.t_order_type integerValue]==2){
        LogisticsDetailVC  *logisticsDetailVC=[[LogisticsDetailVC alloc]initWithName:@"物流查询"];
        [self.navigationController pushViewController:logisticsDetailVC animated:YES];
    }
    if ([orderInfo.t_order_type integerValue]==3) {//删除订单
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要删除订单吗？" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             LogInfo(@"删除订单");
        }]];
        [self presentViewController:controller animated:YES completion:nil];
    }
    
}
-(void)extentTheReceiving:(OrderInfo *)orderInfo{
    
    if ([orderInfo.t_order_type integerValue]==2) {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要延长7天收货吗？" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LogInfo(@"延长收货");
        }]];
        [self presentViewController:controller animated:YES completion:nil];

    }
}


- (void)bizPay {
    NSString *res = [WXApiRequestHandler jumpToBizPay];
    if( ![@"" isEqual:res] ){
        
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"支付失败" message:res preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:controller animated:YES completion:nil];
    }
    
}

#warning 暂时保留--后续修改为basealert
- (void)showAlertWait
{
    mAlert = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [mAlert show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [mAlert addSubview:aiv];
}

- (void)showAlertMessage:(NSString*)msg
{
    mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [mAlert show];
}

- (void)hideAlert
{
    if (mAlert != nil)
    {
        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
        mAlert = nil;
    }
}

@end
