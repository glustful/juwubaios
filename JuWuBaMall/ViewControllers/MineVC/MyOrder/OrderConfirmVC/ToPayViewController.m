//
//  ToPayViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/27.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ToPayViewController.h"

#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "UPPaymentControl.h"
#import "SelectPayTypeCell.h"

@interface ToPayViewController ()

@end

@implementation ToPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _payType = eAliPay;

    
    //订单已经生成
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, 20)];
    myLabel.text = @"订单已经生成";
    myLabel.textColor = [UIColor blackColor];
    myLabel.font = [UIFont systemFontOfSize:13];
    myLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:myLabel];
    
    //去支付
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [myButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [myButton setBackgroundColor:[UIColor orangeColor]];
    myButton.frame = CGRectMake(20, myLabel.bottom, ScreenWidth-40, 30);
    [myButton addTarget:self action:@selector(toPayClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myButton];
    
}

- (void)toPayClick:(UIButton *)button
{
#pragma mark - 支付宝支付
    if (_payType == eAliPay)
    {
        [[BaseAlert sharedInstance]showMessage:@"加载中"];
        
        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] openIAlipayRequestByOrderID:nil orderID:@"24244" orderName:@"" orderMoney:@"1212" produceManager:nil produceURL:nil networkDelegate:self];
        [self.networkRequestArray addObject:request];
        
        [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:[AlipayToolKit genTradeNoWithTime] productName:@"邮票" productDescription:@"全真邮票" amount:@"0.8" notifyURL:kNotifyURL itBPay:@"30m"];
    }
#pragma mark -银联支付
    else if (_payType == eUnionPay)
    {
        NSString *tn = @"131313333355667";
        
        [[BaseAlert sharedInstance]showMessage:@"加载中"];
        
        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] openUnopayRequestByOrderID:@"201602220006" orderMoney:@"34" networkDelegate:self];
        [self.networkRequestArray addObject:request];
        
        
        if(![[UPPaymentControl defaultControl] isPaymentAppInstalled])
        {
            //当判断用户手机上已安装银联App，商户客户端可以做相应个性化处理
            UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"请先安装银联客户端" preferredStyle:UIAlertControllerStyleAlert];
            [controller addAction:[UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:controller animated:YES completion:nil];
            
            return;
        }
        
        tn = @"201603171344450093148";
        
#warning todo 服务端接口（获取tn）
        
        if ([tn isStringSafe])
        {
            // 调起支付
            [[UPPaymentControl defaultControl] startPay:tn fromScheme:kJuWuBaUPPayScheme mode:UPPayDebugMode viewController:self];
        }
    }
#pragma mark -微信支付
    
    else if (_payType == eWeixinPay) {
        
        
        if (![WXApi isWXAppInstalled] || ![WXApi isWXAppSupportApi]) {
            [[BaseAlert sharedInstance]showMessage:@"您需要安装最新版的微信客户端才能支付！"];
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
    [[BaseAlert sharedInstance]showMessage:@"加载中"];
    
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]weixinPayRequestByOrderID:@"201602220123" customerID:@"39.19.4.200" orderMoney:@"34" trade_type:@"NATIVE" networkDelegate:self];
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
    [[BaseAlert sharedInstance] dismiss];
    
    // 吊起微信支付
    //    NSString *res = [WXApiRequestHandler jumpToBizPay];
    [WXApiRequestHandler wxSendRequest:fmNetworkRequest.responseData];
    
    
    //    if( ![@"" isEqual:res] ){
    //
    //        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"支付失败" message:res preferredStyle:UIAlertControllerStyleAlert];
    //        [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    //        [self presentViewController:controller animated:YES completion:nil];
    //    }
}


@end
