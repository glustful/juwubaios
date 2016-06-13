//
//  OrderConfirmVC.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/7.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "OrderConfirmVC.h"
#import "ReceiveAddressCell.h"
#import "AccountManageVC.h"
#import "ConfirmProductInfoCell.h"
#import "ConfirmTotalCountCell.h"
//#import "SelectPayTypeCell.h"
#import "ReceiveProductTypeCell.h"
#import "YouHuiJuanCell.h"
#import "CouponsVC.h"
#import "OrderMoneyInfoCell.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "UPPaymentControl.h"

#import "FSBShoppingCarProductInfo.h"


//#import "ToPayViewController.h"//去支付的页面
#import "ToPayNewViewController.h"//新的去支付页面

#import <UIImageView+WebCache.h>
#import "AddressInfo.h"//默认收获地址模型

@interface OrderConfirmVC ()<UITableViewDelegate, UITableViewDataSource, OrderMoneyInfoCellDelegate,ReceivveAddressCellDelegate,AccountManagerDelegate, ReceiveProductTypeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)AddressInfo *addressInfo;

@property (nonatomic, assign) NSInteger totalCount;//总的个数

@property (nonatomic, strong) AddressInfo *addModel;


//@property (nonatomic, assign) BOOL isFirst;//判断是否是第一次登陆


@end

@implementation OrderConfirmVC

- (NSMutableArray *)productArray
{
    if (!_productArray) {
        _productArray = [NSMutableArray array];
    }
    return _productArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //运送方式
    self.sendType = @"易门上门取货";
    
#pragma mark 加载默认的收获地址   @"688831b3-b671-46a1-8a14-e739c72ecac4"
    FMNetworkRequest * request1 = [[FSNetworkManager sharedInstance]requestForUserDefauleAddressWithUserID:[[GlobalSetting sharedInstance]gUser].t_user_id networkDelegate:self];
    [self.networkRequestArray addObject:request1];
 
//    self.isFirst = YES;
    // 默认支付类型
//    _payType = eAliPay;

    [_tableView  setShowsVerticalScrollIndicator:NO];
    [_tableView  reloadData];
    
    
    
    for (FSBShoppingCarProductInfo *productInfo in self.productArray) {
        //总个数
        self.totalCount = self.totalCount + [productInfo.t_shop_car_purchasequantity integerValue];
        //总价格
//        self.totalMoney = self.totalMoney + [productInfo.t_shop_car_paymentamount integerValue];

    }
 
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    // 地址+产品列表
    if (section == 0) {
        //return _productArray.count + 2;
        return self.productArray.count+1;
    }
    return 1;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0)
    {

        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        // 地址cell
        if (indexPath.row == 0)
        {
            static NSString *cellId = @"ReceiveAddressCell";
            ReceiveAddressCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if (caseFieldNotificationCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReceiveAddressCell" owner:self options:nil];
                for(id obj in nib)
                {
                    if([obj isKindOfClass:[ReceiveAddressCell class]])
                    {
                        caseFieldNotificationCell = (ReceiveAddressCell *)obj;
                    }
                }
                
                // cell 复用
                [tableView registerNib:[UINib nibWithNibName:@"ReceiveAddressCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                
            }
            caseFieldNotificationCell.presentVC=self;
            caseFieldNotificationCell.delegate=self;
            
//            [caseFieldNotificationCell reloadataWithOrederInfo:_orderInfo];
            
//            [caseFieldNotificationCell reloadReceivingAddresswithAddressInfo:self.addModel];
            [caseFieldNotificationCell reloadReceivingAddresswithAddressInfo:self.addressInfo];
            
            caseFieldNotificationCell.tag=1;
            
            return caseFieldNotificationCell;
        }else{
            
            static NSString *cellId = @"ConfirmProductInfoCell";
            ConfirmProductInfoCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
            FSBShoppingCarProductInfo *productInfo = self.productArray[indexPath.row-1];
            if (caseFieldNotificationCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ConfirmProductInfoCell" owner:self options:nil];
                for(id obj in nib)
                {
                    if([obj isKindOfClass:[ConfirmProductInfoCell class]])
                    {
                        caseFieldNotificationCell = (ConfirmProductInfoCell *)obj;
                    }
                }
                
                // cell 复用
                [tableView registerNib:[UINib nibWithNibName:@"ConfirmProductInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
              
            }
            
            [caseFieldNotificationCell customWithModel:productInfo];
            

            
            return caseFieldNotificationCell;
            
        }
   

    }
//    // 支付方式
//    else if (indexPath.section == 1)
//    {
//        static NSString *cellId = @"SelectPayTypeCell";
//        SelectPayTypeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        
//        if (caseFieldNotificationCell == nil) {
//            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SelectPayTypeCell" owner:self options:nil];
//            for(id obj in nib)
//            {
//                if([obj isKindOfClass:[SelectPayTypeCell class]])
//                {
//                    caseFieldNotificationCell = (SelectPayTypeCell *)obj;
//                }
//            }
//            
//            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//            
//            // cell 复用
//            [tableView registerNib:[UINib nibWithNibName:@"SelectPayTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
//            
//        }
//        
//        caseFieldNotificationCell.parentVC = self;
//        
//        return caseFieldNotificationCell;
//        
//    }
    // 取货方式
    else if (indexPath.section == 1)
    {
        static NSString *cellId = @"ReceiveProductTypeCell";
        ReceiveProductTypeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReceiveProductTypeCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[ReceiveProductTypeCell class]])
                {
                    caseFieldNotificationCell = (ReceiveProductTypeCell *)obj;
                }
            }
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"ReceiveProductTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            
        }
        caseFieldNotificationCell.delegate = self;
        
        return caseFieldNotificationCell;
        
    }
    // 优惠劵
    else if (indexPath.section == 2)
    {
        static NSString *cellId = @"YouHuiJuanCell";
        YouHuiJuanCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YouHuiJuanCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[YouHuiJuanCell class]])
                {
                    caseFieldNotificationCell = (YouHuiJuanCell *)obj;
                }
            }
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            caseFieldNotificationCell.userInteractionEnabled = NO;
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"YouHuiJuanCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            
        }
#warning 待选择的优惠劵信息
        [caseFieldNotificationCell reloadData:@""];
        
        return caseFieldNotificationCell;
        
    }
    else if (indexPath.section == 3)
    {
        static NSString *cellId = @"OrderMoneyInfoCell";
        OrderMoneyInfoCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderMoneyInfoCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[OrderMoneyInfoCell class]])
                {
                    caseFieldNotificationCell = (OrderMoneyInfoCell *)obj;
                }
            }
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"OrderMoneyInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            
        }
        caseFieldNotificationCell.delegate = self;
        caseFieldNotificationCell.totalMoneyLabel.text = [NSString stringWithFormat:@"%.2f元", self.totalMoney];
        caseFieldNotificationCell.carriageLabel.text = @"0元";
        caseFieldNotificationCell.favourableLabel.text = @"0元";
        caseFieldNotificationCell.finalMoneyLabel.text = [NSString stringWithFormat:@"总金额为：%.2f元", self.totalMoney];
        return caseFieldNotificationCell;
        
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth, 25)];
        countLabel.text = [NSString stringWithFormat:@"总数量为：%ld", self.totalCount];
        countLabel.textColor = [UIColor blackColor];
        countLabel.font = [UIFont boldSystemFontOfSize:15];
        [myView addSubview:countLabel];
        // 分割View
        UIImageView *sepeartorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, ScreenWidth, 20)];
        sepeartorView.image = [UIImage imageNamed:@"SepartorLine"];
        [myView addSubview:sepeartorView];
        return myView;
        
    }else{
        // 分割View
        UIImageView *sepeartorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        sepeartorView.image = [UIImage imageNamed:@"SepartorLine"];
        return sepeartorView;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            ReceiveAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveAddressCell"];
            
            if (cell)
            {
                [cell setNeedsUpdateConstraints];
                [cell updateConstraintsIfNeeded];
                
                CGFloat height = cell.height;
                
                return height;
            }
        }else{
            ConfirmProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmProductInfoCell"];
            
            if (cell)
            {
                [cell setNeedsUpdateConstraints];
                [cell updateConstraintsIfNeeded];
                
                CGFloat height = cell.height;
                
                return height;
            }

        }
    }
//    else if (indexPath.section == 1)
//    {
//        SelectPayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPayTypeCell"];
//        
//        if (cell)
//        {
//            [cell setNeedsUpdateConstraints];
//            [cell updateConstraintsIfNeeded];
//            
//            CGFloat height = cell.height;
//            
//            return height;
//        }
//    }
    else if (indexPath.section == 1)
    {
        ReceiveProductTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveProductTypeCell"];
        
        if (cell)
        {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            CGFloat height = cell.height;
            
            return height;
        }
    }
    else if (indexPath.section == 2)
    {
        YouHuiJuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouHuiJuanCell"];
        
        if (cell)
        {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            CGFloat height = cell.height;
            
            return height;
        }
    }
    else if (indexPath.section == 3)
    {
        OrderMoneyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderMoneyInfoCell"];
        
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
    return 0.005;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 45;
    }
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        // 选择收货地址
        if (indexPath.row == 0) {
           
        }
    }
    // 选择优惠劵
    else if (indexPath.section == 3)
    {
//        CouponsVC *couponsVC=[[CouponsVC alloc]initWithName:@"优惠券"];
//        [self.navigationController pushViewController:couponsVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - OrderMoneyInfoCellDelegate
// 调起支付
- (void)orderingAction:(UIButton *)button
{
    
    if (self.addressInfo==nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择收货地址" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }else{
        
    
    
    if (1) {
        //获得系统时间
        NSDate *  senddate=[NSDate date];
//        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//        [dateformatter setDateFormat:@"HH:mm"];
//        NSString *  locationString=[dateformatter stringFromDate:senddate];
//        LogInfo(@"系统时间:%@", locationString);
        //[dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
        //NSString *  morelocationString=[dateformatter stringFromDate:senddate];

        //获得系统日期
        NSCalendar  * cal=[NSCalendar  currentCalendar];
        NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
        NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
        NSInteger year=[conponent year];
        NSInteger month=[conponent month];
        NSInteger day=[conponent day];
        NSInteger hour = [conponent hour];
        NSInteger minu = [conponent minute];
        NSInteger second = [conponent second];
        //生成订单ID   t_order_id
        NSString *orderId= [NSString  stringWithFormat:@"%4ld%.2ld%.2ld%.2ld%.2ld%.2ld",year,month,day, hour, minu, second];
        NSString *createtime = [NSString stringWithFormat:@"%4ld-%.2ld-%.2ld", year, month, day];

        FSBShoppingCarProductInfo *productInfo = self.productArray[0];
        
        FMNetworkRequest * request1 = [[FSNetworkManager sharedInstance] insertOrderWithDeliverNum:@"1" andCreateTime:createtime andPayment:[NSString stringWithFormat:@"%.2f", self.totalMoney] andOrderId:orderId andState:@"未支付" andType:@"0" andProduceId:productInfo.productid andShopId:productInfo.t_shop_id andTotalNum:[NSString stringWithFormat:@"%ld", self.totalCount] andUserId:[[GlobalSetting sharedInstance]gUser].t_user_id andNetworkDelegate:self];
            [self.networkRequestArray addObject:request1];
        
        
//        for (FSBShoppingCarInfo *carInfo in self.productArray) {
//            
//            FSBShoppingCarProductInfo *productInfo = carInfo.productArray[0];
        for (FSBShoppingCarProductInfo *productInfo in self.productArray) {
            //单个商品的价格
            NSString *payment = productInfo.t_shop_car_goodsamount;
            //总的价格
            NSString *totMoney = productInfo.t_shop_car_paymentamount;
            //产品数量
            NSString *produceNum = productInfo.t_shop_car_purchasequantity;
            //产品详情ID
            NSString *produceDetailId = productInfo.t_product_detail_id;
            //品牌
            NSString *productBrand = productInfo.t_shop_name;
            //颜色
            NSString *color = productInfo.t_produce_detail_grandsun_value;
            //尺寸
            NSString *size = productInfo.t_product_attribute_value;
            //商品折扣
            NSString *discounts = productInfo.t_shop_car_merchandisediscounts;
            //卖家电话
            NSString *shopPhone = productInfo.t_shop_phone;
            NSString *shopAddress = productInfo.t_shop_address;
            
            //随机生成订单详情ID  t_order_detail_id
            int value = arc4random()%20000;
            NSString *dateStr= [NSString  stringWithFormat:@"%ld%ld%ld",hour, minu, second];
            NSString *orderDetailId = [NSString stringWithFormat:@"%@%d", dateStr, value];
            //买家姓名
            NSString *BuyerName = self.addressInfo.t_receipt_name;
            //买家电话
            NSString *BuyerPhone = self.addressInfo.t_receipt_phone;
            
//            FMNetworkRequest *request=[[FSNetworkManager sharedInstance]insertOrderDetailAmountDue:discounts andBuyeraddress:@"马原" andPhone:BuyerPhone andNum:@"0" andOrderDetailId:orderDetailId andPayment:payment andOrderId:orderId andProduceNumber:produceNum andSellerAddress:@"新亚洲" andSellerphone:@"98765" andTotalMoney:totMoney andProduceDetailId:produceDetailId andProductBrand:productBrand andProductColor:color andProductSize:size andReceipAddress:[NSString stringWithFormat:@"%@%@", _addressInfo.t_receipt_area, _addressInfo.t_receipt_streetaddress ]  andNetworkDelegate:self];
            
            
            FMNetworkRequest *request=[[FSNetworkManager sharedInstance]insertOrderDetailAmountDue:discounts andBuyeraddress:@"马原" andPhone:BuyerPhone andNum:@"0" andOrderDetailId:orderDetailId andPayment:payment andOrderId:orderId andProduceNumber:produceNum andSellerAddress:shopAddress andSellerphone:shopPhone andTotalMoney:totMoney andProduceDetailId:produceDetailId andProductBrand:productBrand andProductColor:color andProductSize:size andReceipAddress:[NSString stringWithFormat:@"%@%@", _addressInfo.t_receipt_area, _addressInfo.t_receipt_streetaddress ]  andReceipId:self.addressInfo.t_receipt_id andReceivingmode:self.sendType andNetworkDelegate:self];
            [self.networkRequestArray  addObject:request];

            
        }
        //type  待发货等等
        //TotalNum  总的商品
        //DeliverNum 已发货的数量
        //DetailAmountDue zhekoui
        //_deliver_num  已发货的数量
        //SellerAddress卖家地址
        //单价
        
        
//        ToPayViewController *toPayVC = [[ToPayViewController alloc] initWithName:@"去支付"];
//        [self.navigationController pushViewController:toPayVC animated:YES];
        
        
//        for (FSBShoppingCarProductInfo *proInfo in self.productArray) {
//            NSString *carID = proInfo.t_shop_car_id;
//            FMNetworkRequest *request = [[FSNetworkManager sharedInstance] clearShoppingCarWithShoppingCarID:carID andNetworkDelegate:self];
//            [self.networkRequestArray addObject:request];
//        }

        
        ToPayNewViewController *toPayVC = [[ToPayNewViewController alloc ] initWithName:@"去支付"];
        //订单的总金额
        toPayVC.allMoney = [NSString stringWithFormat:@"%.2f", self.totalMoney];
        //订单ID
        toPayVC.myOrderID = orderId;
        
        toPayVC.producetArr = self.productArray;
        
        [self.navigationController pushViewController:toPayVC animated:YES];
//
        
        
    }
//    else{
        

    
#pragma mark - 支付宝支付
//    if (_payType == eAliPay)
//    {
//        [[BaseAlert sharedInstance]showMessage:@"加载中"];
//        
//        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] openIAlipayRequestByOrderID:nil orderID:@"24244" orderName:@"" orderMoney:@"1212" produceManager:nil produceURL:nil networkDelegate:self];
//        [self.networkRequestArray addObject:request];
//        
//        [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:[AlipayToolKit genTradeNoWithTime] productName:@"邮票" productDescription:@"全真邮票" amount:@"0.8" notifyURL:kNotifyURL itBPay:@"30m"];
//    }
#pragma mark -银联支付
//    else if (_payType == eUnionPay)
//    {
//        NSString *tn = @"131313333355667";
//        
//        [[BaseAlert sharedInstance]showMessage:@"加载中"];
//        
//        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] openUnopayRequestByOrderID:@"201602220006" orderMoney:@"34" networkDelegate:self];
//        [self.networkRequestArray addObject:request];
//        
//        
//        if(![[UPPaymentControl defaultControl] isPaymentAppInstalled])
//        {
//            //当判断用户手机上已安装银联App，商户客户端可以做相应个性化处理
//            UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"请先安装银联客户端" preferredStyle:UIAlertControllerStyleAlert];
//            [controller addAction:[UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:controller animated:YES completion:nil];
//            
//            return;
//        }
//        
//        tn = @"201603171344450093148";
//        
//#warning todo 服务端接口（获取tn）
//        
//        if ([tn isStringSafe])
//        {
//            // 调起支付
//            [[UPPaymentControl defaultControl] startPay:tn fromScheme:kJuWuBaUPPayScheme mode:UPPayDebugMode viewController:self];
//        }
//    }
#pragma mark -微信支付
    
//    else if (_payType == eWeixinPay) {
//        
//        
//        if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
//            [[BaseAlert sharedInstance]showMessage:@"您需要安装最新版的微信客户端才能支付！"];
//            return;
//        }
//
//        
//        [self bizPay];
//        
//    }
//    else {
//
//        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"请选择支付方式" preferredStyle:UIAlertControllerStyleAlert];
//        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:controller animated:YES completion:nil];
//        
//    }
        
        
        
//        }
        
    }

}

//微信支付
- (void)bizPay
{
    // 获取支付需要的信息
    [[BaseAlert sharedInstance]showMessage:@"加载中"];
    
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]weixinPayRequestByOrderID:@"201623022320123475" customerID:@"39.19.4.200" orderMoney:@"34" trade_type:@"APP" networkDelegate:self];
   [self.networkRequestArray addObject:request];



    
}

#pragma mark - 网络请求回调
- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];
}

//- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
//{
//    [[BaseAlert sharedInstance] dismiss];
//    
//    // 吊起微信支付
//   NSString *res = [WXApiRequestHandler jumpToBizPay];
//    if( ![@"" isEqual:res] ){
//
//        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"支付失败" message:res preferredStyle:UIAlertControllerStyleAlert];
//        [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:controller animated:YES completion:nil];
//    }
//}


- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];//kRequest_user_defaultAddress
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_user_defaultAddress]){
        
        self.addressInfo = fmNetworkRequest.responseData;
        [self.tableView reloadData];
        
    }
//    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_user_defaultAddress]){
//        
//    }
    
    
    
    // 吊起微信支付
//    [WXApiRequestHandler wxSendRequest:fmNetworkRequest.responseData];
    
    
    //    if( ![@"" isEqual:res] ){
    //
    //        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"支付失败" message:res preferredStyle:UIAlertControllerStyleAlert];
    //        [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    //        [self presentViewController:controller animated:YES completion:nil];
    //    }
}





//
//
//#pragma mark - WXApiManagerDelegate
//- (void)managerDidRecvPayResponse:(PayResp *)response {
//    [WXApi registerApp:kJuWuBaMallWechatAppID];
//    if (weixinPayIsResp) {
//        return;
//    }
//    NSString *strMsg;
//    
//    switch (response.errCode) {
//        case WXSuccess:
//            weixinPayIsResp = YES;
//            strMsg = @"支付结果：成功！";
//            NSLog(@"支付成功－PaySuccess，retcode = %d", response.errCode);
//            [self paySucceed];
//            break;
//        case WXErrCodeUserCancel:
//            strMsg = [NSString stringWithFormat:@"用户取消支付"];
//            break;
//            
//        default:
//            strMsg = @"支付结果：失败!";
//            NSLog(@"错误，retcode = %d, retstr = %@", response.errCode,response.errStr);
//            break;
//            
//    }
//    [[BaseAlert sharedInstance]showMessage:strMsg];
//}

#pragma mark -支付成功之后的操作。
- (void)paySucceed{
    
    
}

- (void)sendType:(NSString *)type
{
    self.sendType = type;
}



#pragma mark ReceivveAddressCellDelegate
-(void)receiveAddressCellDelegate{
    AccountManageVC *accountManagerVC=[[AccountManageVC alloc]initWithName:@"选择收货地址"];
    accountManagerVC.accountDelegate=self;
    [self.navigationController pushViewController:accountManagerVC animated:YES];
}
#pragma mark AccountManagerDelegate
-(void)didSelectedAddressInfoToOrderConfirmWithOrder:(AddressInfo *)addressInfo{
    _addressInfo=addressInfo;
    
    ReceiveAddressCell *cell=[_tableView viewWithTag:1];
    [cell reloadReceivingAddresswithAddressInfo:addressInfo];
    
    LogInfo(@"fff%@",_addressInfo.t_receipt_area);
   
}
@end
