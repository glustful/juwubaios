//
//  MyOrderDetailVC.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/2.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyOrderDetailVC.h"

#import "OrderDetailLogisticsCell_WaitingReceive.h"
//#import "BillInfoCell.h"
#import "OrderDetailActionCell.h"
#import "RefundVC.h"//退款
#import "LogisticsDetailVC.h"//物流详情
#import "ProductDetailVC.h"//商品详情页
#import "SubmitCommentVC.h"//订单评价
#import "AddressTableViewCell.h"//地址cell

#import "SelectPayTypeCell.h"//支付方式的选择
#import "ToPayNewViewController.h"//去支付

#import "AccountManageVC.h"//选择地址


@interface MyOrderDetailVC ()<OrderDetailActionCellDelegate, AccountManagerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation MyOrderDetailVC
//-(void)viewWillAppear:(BOOL)animated{
//    
//}

- (NSMutableArray *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.orderType == eMyOrderStatus_WaitingPay){
#pragma mark 根据用户id和订单id查询订单相关信息//@"688831b3-b671-46a1-8a14-e739c72ecac4"@"20160505110172"
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]selectOrderbyOrderid:self.orderNewIn.t_order_id andUserId:[[GlobalSetting sharedInstance]gUser].t_user_id andNetworkDelegate:self];
        [self.networkRequestArray  addObject:request];
    }
 
    UIView *fooderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    fooderView.backgroundColor = [UIColor redColor];
//    self.tableView.tableFooterView = fooderView;
    

    
}
-(void)doRightItemAction:(UIButton *)button{
    [self doCommonRightItemAction:button];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        if (self.orderType == eMyOrderStatus_WaitingPay) {
              return 1;
        }
        return 3;
    }else if (section == 1){
           return self.dataList.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

        
        NSInteger indexPathRow;

        if (self.orderType != eMyOrderStatus_WaitingPay) {
            indexPathRow = 1;
            
            if (indexPath.row == 0)
            {
                // 物流相关cell
                static NSString *cellId = @"AddressTableViewCell";
                AddressTableViewCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if (caseFieldNotificationCell == nil) {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:nil];
                    for(id obj in nib)
                    {
                        if([obj isKindOfClass:[AddressTableViewCell class]])
                        {
                            caseFieldNotificationCell = (AddressTableViewCell *)obj;
                        }
                    }
                    
                    // cell 复用
                    [tableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                    
                    //                    caseFieldNotificationCell.parentVC = self;
                    
                }
                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
                OrderReceiveModel *reModel = self.dataList[0];
                caseFieldNotificationCell.addressLabel.text = reModel.t_order_notice;
                return caseFieldNotificationCell;
            }
            
            
            
            else if (indexPath.row == indexPathRow+1)
            {
                static NSString *cellId = @"SelectPayTypeCell";
                SelectPayTypeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if (caseFieldNotificationCell == nil) {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SelectPayTypeCell" owner:self options:nil];
                    for(id obj in nib)
                    {
                        if([obj isKindOfClass:[SelectPayTypeCell class]])
                        {
                            caseFieldNotificationCell = (SelectPayTypeCell *)obj;
                        }
                    }
                    
                    // cell 复用
                    [tableView registerNib:[UINib nibWithNibName:@"SelectPayTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                }
                
                if (self.orderType != eMyOrderStatus_WaitingPay){
                    //当为待收货的时候，支付方式无法选择
                    caseFieldNotificationCell.userInteractionEnabled = NO;
                }
                
                return caseFieldNotificationCell;
                
            }


        
        }else{
            indexPathRow = 0;
        }

            // 地址cell
            if (indexPath.row == indexPathRow)
            {
                static NSString *cellId = @"OrderDetailLogisticsCell_WaitingReceive";
                OrderDetailLogisticsCell_WaitingReceive *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if (caseFieldNotificationCell == nil) {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailLogisticsCell_WaitingReceive" owner:self options:nil];
                    for(id obj in nib)
                    {
                        if([obj isKindOfClass:[OrderDetailLogisticsCell_WaitingReceive class]])
                        {
                            caseFieldNotificationCell = (OrderDetailLogisticsCell_WaitingReceive *)obj;
                        }
                    }
                    
                    // cell 复用
                    [tableView registerNib:[UINib nibWithNibName:@"OrderDetailLogisticsCell_WaitingReceive" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                    
                    caseFieldNotificationCell.parentVC = self;
                    
                }
                
                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                caseFieldNotificationCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

//                if (self.orderType != eMyOrderStatus_WaitingPay){
                if (self.dataList.count>0 && !_addressInfo) {
                    
                    OrderReceiveModel *reModel = self.dataList[0];
                    
                    caseFieldNotificationCell.receiveNameLabel.text = reModel.t_receipt_name;
                    caseFieldNotificationCell.receivePhoneLabel.text = reModel.t_receipt_phone;
                    caseFieldNotificationCell.receiveAddressLabel.text = reModel.t_receipt_area;
                }else{
                    [caseFieldNotificationCell reloadWithModel:_addressInfo];
                }

//                }
                
                return caseFieldNotificationCell;
            }
            
//            else if (indexPath.row == indexPathRow+1)
//            {
//                static NSString *cellId = @"SelectPayTypeCell";
//                SelectPayTypeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
//                
//                if (caseFieldNotificationCell == nil) {
//                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SelectPayTypeCell" owner:self options:nil];
//                    for(id obj in nib)
//                    {
//                        if([obj isKindOfClass:[SelectPayTypeCell class]])
//                        {
//                            caseFieldNotificationCell = (SelectPayTypeCell *)obj;
//                        }
//                    }
//                    
//                    // cell 复用
//                    [tableView registerNib:[UINib nibWithNibName:@"SelectPayTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
//                }
//                
//                if (self.orderType != eMyOrderStatus_WaitingPay){
//                    //当为待收货的时候，支付方式无法选择
//                    caseFieldNotificationCell.userInteractionEnabled = NO;
//                }
//
//                return caseFieldNotificationCell;
//                
//            }
      

        
    }
    else if(indexPath.section == 1){
        static NSString *cellId = @"OrderDetailActionCell";
        OrderDetailActionCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderDetailActionCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[OrderDetailActionCell class]])
                {
                    caseFieldNotificationCell = (OrderDetailActionCell *)obj;
                }
            }
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"OrderDetailActionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            
            caseFieldNotificationCell.parentVC = self;
            
        }
        
        caseFieldNotificationCell.delegate = self;
        
        OrderReceiveModel *newModel = self.dataList[indexPath.row];
        
        [caseFieldNotificationCell reloadData:newModel];
    
        
        return caseFieldNotificationCell;

    }

    
    return nil;
}

//头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
//        UIView *header = [[[NSBundle mainBundle] loadNibNamed: @"OrderDetailHeaderView"
//                                                        owner: self
//                                                      options: nil] lastObject];
//    
//        return header;

        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        
        UIImageView *imgView =[[UIImageView alloc]initWithFrame:headerView.frame];
        imgView.image = [UIImage imageNamed:@"headerBackground.png"];
        [headerView addSubview:imgView];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 200, 20)];
        if (self.orderType == eMyOrderStatus_WaitingPay) {
            titleLabel.text = @"还没付款啊亲";
        }else if (self.orderType == eMyOrderStatus_WaitingRecieve)
        {
            titleLabel.text = @"静待收货哦亲";
        }else if (self.orderType == eMyOrderStatus_WaitingComment)
        {
            titleLabel.text = @"已经收到货了哦亲";
        }
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [headerView addSubview:titleLabel];
        
        return headerView;
    }
    return nil;
}

//footerView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {

        UIView *moneyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        moneyView.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
        UILabel *monewLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth*0.5-10, 40)];
        monewLabel.text = [NSString stringWithFormat:@"共计：%@元", self.orderNewIn.t_order_final_payment];
        monewLabel.font = [UIFont boldSystemFontOfSize:15];
        monewLabel.textColor = [UIColor redColor];
        [moneyView addSubview:monewLabel];
        
     
        
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(monewLabel.right, 0, ScreenWidth*0.5-10, 40)];
        
        if (self.dataList.count>0) {
            OrderReceiveModel  *order = self.dataList[0];
            countLabel.text = order.t_receivingmode;
        }
        countLabel.font = [UIFont boldSystemFontOfSize:15];
        countLabel.textColor = [UIColor redColor];
        [moneyView addSubview:countLabel];
        return moneyView;
    
    }
    
    if (self.orderType == eMyOrderStatus_WaitingPay) {
        UIView *waitPayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        payButton.frame = CGRectMake(0, 0, ScreenWidth, 40);
        [payButton setTitle:@"去付款" forState:UIControlStateNormal];
        payButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [payButton addTarget:self action:@selector(toPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        payButton.backgroundColor = [UIColor colorWithRed:221/255.0f green:78/255.0f blue:44/255.0f alpha:1];
        [waitPayView addSubview:payButton];
        waitPayView.backgroundColor = [UIColor redColor];
        return waitPayView;
        
    }else{
        
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    footerView.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1];
    NSInteger spaceButton = 10;
    NSInteger xStart = spaceButton;
    NSInteger yStart = 5;
    NSInteger widthButton = (ScreenWidth-5*spaceButton)*0.33;
    NSInteger heightButton = 30;
    NSMutableArray *titleArray = [NSMutableArray array];
    if (self.orderType == eMyOrderStatus_WaitingRecieve) {
    [titleArray addObjectsFromArray: @[@"延长收货", @"查看物流", @"确认收货"]];
    }else if (self.orderType == eMyOrderStatus_WaitingComment){
        [titleArray addObjectsFromArray: @[@"退款", @"删除订单", @"评价"]];
    }
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xStart+i*(spaceButton+widthButton), yStart, widthButton, heightButton);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"ActionBack_Comment.png"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        if (i == 2) {
            [button setBackgroundColor:[UIColor colorWithRed:222/255.0f green:92/255.0f blue:64/255.0f alpha:1]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        if (self.orderType == eMyOrderStatus_WaitingComment) {
            button.tag = 200 + i;
        }else{
            button.tag = 100 + i;
        }
        [button addTarget:self action:@selector(fooderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:button];
    }
    return footerView;
    }

}
/**
 *去付款的点击事件
 */
- (void)toPayButtonClick:(UIButton *)button
{
    LogInfo(@"老子明天不上班，爽翻");
    ToPayNewViewController *toPayVC = [[ToPayNewViewController alloc] initWithName:@"去支付"];
    toPayVC.allMoney = self.orderNewIn.t_order_final_payment;
    toPayVC.myOrderID = self.orderNewIn.t_order_id;
    
    [self.navigationController pushViewController:toPayVC animated:YES];
}

//点击事件
- (void)fooderButtonClick:(UIButton *)button
{
    LogInfo(@"%d", button.tag);
    NSInteger buttonTag = button.tag;
    
    switch (buttonTag) {
//        case 100:
//        { 
//            //退款
//            RefundVC *logisticsDetailVC = [[RefundVC alloc] initWithName:@"申请退款"];
//            [self.navigationController pushViewController:logisticsDetailVC animated:YES];
//        }
//            break;
        case 100:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将延迟7天收货" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
            [alertView show];
            
            UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"将延迟7天收货" preferredStyle:UIAlertControllerStyleAlert];
            [controller addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
            [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#warning todo 延迟收货接口调用
                
            }]];
            [self presentViewController:controller animated:YES completion:nil];
    
        }
            break;
        case 101:
        {
            LogisticsDetailVC *logisticsDetailVC = [[LogisticsDetailVC alloc] initWithName:@"物流详情"];
            [self.navigationController pushViewController:logisticsDetailVC animated:YES];

            
        }
            break;
        case 102:
        {
            LogInfo("确认收货");
        }
            break;
        case 200:
        {
            RefundVC *logisticsDetailVC = [[RefundVC alloc] initWithName:@"申请退款"];
            [self.navigationController pushViewController:logisticsDetailVC animated:YES];
        }
            break;
        case 201:
        {
            UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除订单？" preferredStyle:UIAlertControllerStyleAlert];
            [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma mark 删除订单接口
                LogInfo(@"订单删除");
            }]];
            [self presentViewController:controller animated:YES completion:nil];
        }
            break;
        case 202:
        {
            SubmitCommentVC *commentVC = [[SubmitCommentVC alloc] initWithName:@"订单评价"];
            
            [self.navigationController pushViewController:commentVC animated:YES];
        }
            break;
        default:
            break;
    }


}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        NSInteger indextPathRow;
        if (self.orderType == eMyOrderStatus_WaitingPay) {
            indextPathRow = 0;
        }else
        {
            indextPathRow = 1;
            if (indexPath.row == 0) {
                return 110;
            }
        }
        if (indexPath.row == indextPathRow)
        {
            OrderDetailLogisticsCell_WaitingReceive *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailLogisticsCell_WaitingReceive"];
            
            if (cell)
            {
                [cell setNeedsUpdateConstraints];
                [cell updateConstraintsIfNeeded];
                
                CGFloat height = cell.height;
                
                return height;
            }
        }
        
        if (indexPath.row == indextPathRow+1)
        {
            SelectPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPayTypeCell"];
            
            if (cell)
            {
                [cell setNeedsUpdateConstraints];
                [cell updateConstraintsIfNeeded];
                
                CGFloat height = cell.height;
                
                return height;
            }
        }

   }

    if (indexPath.section == 1) {
        OrderDetailActionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailActionCell"];
        
        if (cell)
        {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            CGFloat height = cell.height;
            
            return height;
        }

    }
      return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        if(section == 0){
        return 60;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 0;
//    }
//    else if (self.orderType == eMyOrderStatus_WaitingPay) {
//        return 0;
//    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
//        AccountManageVC *accountManagerVC=[[AccountManageVC alloc]initWithName:@"选择收货地址"];
//        accountManagerVC.accountDelegate=self;
//        [self.navigationController pushViewController:accountManagerVC animated:YES];
    }
    
    if (indexPath.section == 1) {
        ProductDetailVC  *proDetail = [[ProductDetailVC alloc]initWithName:@"商品详情页"];
        
         OrderReceiveModel *newModel = self.dataList[indexPath.row];
        proDetail.productId = newModel.t_produce_id;
        
        [self.navigationController pushViewController:proDetail animated:YES];
    }
    
    
}

#pragma mark AccountManagerDelegate
-(void)didSelectedAddressInfoToOrderConfirmWithOrder:(AddressInfo *)addressInfo{
    _addressInfo=addressInfo;
    
    OrderDetailLogisticsCell_WaitingReceive *cell=[_tableView viewWithTag:1];
//    [cell reloadWithModel:_addressInfo];
    
    [self.tableView reloadData];
    LogInfo(@"fff%@",_addressInfo.t_receipt_area);
    
}

#pragma mark - OrderDetailActionCellDelegate

//- (void)delayReceiveProductAction:(OrderInfo *)orderInfo
//{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将延迟7天收货" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
//    [alertView show];
//    
//    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"将延迟7天收货" preferredStyle:UIAlertControllerStyleAlert];
//    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:nil]];
//    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//#warning todo 延迟收货接口调用
//        
//    }]];
//    [self presentViewController:controller animated:YES completion:nil];
//}




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
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_selectOrderbyOrderidAndUserid]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            [self.dataList removeAllObjects];
//            NSMutableArray *dataArray=[NSMutableArray array];
            self.dataList=fmNetworkRequest.responseData;
            [self.tableView reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[OrderReceiveModel class]]){
            [self.dataList  removeAllObjects];
            OrderReceiveModel  *order=fmNetworkRequest.responseData;
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



//将cell的分割线显示全
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
