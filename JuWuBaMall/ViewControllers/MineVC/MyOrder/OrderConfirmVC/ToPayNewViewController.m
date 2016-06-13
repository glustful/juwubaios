//
//  ToPayNewViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/5/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ToPayNewViewController.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "UPPaymentControl.h"

#import "FSBShoppingCarProductInfo.h"

typedef NS_ENUM(NSInteger, PayType) {
    eAliPay =0,
    eWeixinPay,
    eUnionPay
};
@interface ToPayNewViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;//主界面


@end

@implementation ToPayNewViewController

- (NSMutableArray *)producetArr
{
    if (!_producetArr) {
        _producetArr = [NSMutableArray array];
    }
    return _producetArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    for (FSBShoppingCarProductInfo *proInfo in self.producetArr) {
        NSString *carID = proInfo.t_shop_car_id;
        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] clearShoppingCarWithShoppingCarID:carID andNetworkDelegate:self];
        [self.networkRequestArray addObject:request];
    }

    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.view addSubview:self.myTableView];
    


}

#pragma mark  tableViewDelegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 40;
    }
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    static NSString *ID = @"cellOne";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
        cell.textLabel.text = @"订单总额";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",  self.allMoney];
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.userInteractionEnabled = NO;
        return cell;

    }
    
    
    static NSString *ID = @"cellTwo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"AlipayIcon.png"];
        cell.textLabel.text = @"支付宝支付";
        cell.detailTextLabel.text = @"用支付宝、心情就是好";
    }else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"WeiXinIcon.png"];
        cell.textLabel.text = @"微信支付";
        cell.detailTextLabel.text = @"用心、用微信";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"UnionpayIcon.png"];
        cell.textLabel.text = @"银联支付";
        cell.detailTextLabel.text = @"银联、银链";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       return cell;
    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {

    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth, 20)];
    nameLabel.text = @"支付方式";
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor lightGrayColor];
    [myView addSubview:nameLabel];
    return myView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self   orderingActionWithPayType:indexPath.row];

//    if (indexPath.row == 0) {
//        LogInfo(@"支付宝支付");
//        
//        
//    }else if (indexPath.row == 1){
//        LogInfo(@"微信支付");
//        [self   orderingActionWithPayType:indexPath.row];
//    }else if (indexPath.row == 2){
//        LogInfo(@"银联支付");
//    }
}

# pragma mark -支付调起
// 调起支付
- (void)orderingActionWithPayType:(NSInteger)payType{
    # pragma mark - 支付宝支付
    if (payType == eAliPay)
    {
        
//        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] openIAlipayRequestByOrderID:self.myOrderID orderID:self.myOrderID orderName:@"" orderMoney:self.allMoney produceManager:nil produceURL:nil networkDelegate:self];
//        [self.networkRequestArray addObject:request];
//        [AlipayToolKit genTradeNoWithTime]
        
        [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:self.myOrderID productName:[NSString stringWithFormat:@"中国瓷砖商城%@,金额：%@",self.myOrderID,self.allMoney] productDescription:[NSString stringWithFormat:@"中国瓷砖商城%@,金额：%@",self.myOrderID,self.allMoney]   amount:self.allMoney  notifyURL:kNotifyURL itBPay:@"30m"];
    }
#pragma mark -银联支付
    else if (payType == eUnionPay){

        CGFloat f = [self.allMoney floatValue] *100;
        int d= ceilf(f);
        NSString *aa = [NSString  stringWithFormat:@"%d",d];
        [[BaseAlert sharedInstance] showLodingWithMessage:@"加载中.."];
        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] openUnopayRequestByOrderID:self.myOrderID orderMoney:aa  networkDelegate:self];
        [self.networkRequestArray addObject:request];

    }
#pragma mark -微信支付
    
    else if (payType == eWeixinPay) {
        
        
        if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
            [[BaseAlert sharedInstance]showMessage:@"请安装最新版微信，再来支付！"];
            return;
        }
        
        
        [self bizPay];
        
    }
    else {
        
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"请选择支付方式" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

//微信支付
- (void)bizPay
{
    // 获取支付需要的信息

    
    CGFloat f = [self.allMoney floatValue] *100;
     int d= ceilf(f);
    NSString *aa = [NSString  stringWithFormat:@"%d",d];
    [[BaseAlert sharedInstance] showLodingWithMessage:@"加载中.."];

    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]weixinPayRequestByOrderID:self.myOrderID customerID:@"39.19.4.210" orderMoney:aa   trade_type:@"APP" networkDelegate:self];

    [self.networkRequestArray addObject:request];
    
    
    
}

#pragma mark - 网络请求回调
- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
{
   
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_WeixinPay])
    {
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
        {
    
    [[BaseAlert sharedInstance] showMessage:@"抱歉，信息有误，微信支付失败"];
            
        }
    }
    
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_UnionPay])
    {
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
        {
           
        [[BaseAlert sharedInstance] showMessage:@"抱歉，信息有误，银联支付失败"];
        }
    }
    

    
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    
    
    [[BaseAlert sharedInstance] dismiss];
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_WeixinPay])
    {
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[WXPayObject class]])
        {
            // 吊起微信支付
            [WXApiRequestHandler wxSendRequest:fmNetworkRequest.responseData];

        }
    }
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_UnionPay])
    {
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
        {
            NSString*tn = fmNetworkRequest.responseData;
            if ([tn isStringSafe]){
            
                // 吊起银联支付
            [[UPPaymentControl defaultControl] startPay:tn fromScheme:kJuWuBaUPPayScheme mode:UPPayReleaseMode viewController:self];
          
            }
        }
    }

}

@end
