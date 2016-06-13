//
//  BusinessEnterViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/1.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BusinessEnterViewController.h"
#import "CompanyOneController.h"
#import "CompanyOneView.h"
//#import "MBProgressHUD.h"


#define scrollViewFrame   CGRectMake(0, 30, ScreenWidth, ScreenHeight)

@interface BusinessEnterViewController ()<UIScrollViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *companyOneScrollView;

@property (weak, nonatomic) IBOutlet UIButton *upPhotoClick;
@property (strong, nonatomic) IBOutlet UIScrollView *companyTwoScrollView;
@property (weak, nonatomic) IBOutlet UILabel *taxRegistration;//税务登记
@property (strong, nonatomic) IBOutlet UIScrollView *ShopInformationScrollView;

@end

@implementation BusinessEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载webView
    NSString *urlStr = @"http://192.168.1.122:8080/JWBPCWeb/phoneagent.html?userPhone=123466666666";
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //    NSURL *url = [NSURL URLWithString:_urlPath];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    web.delegate = self;
    web.scalesPageToFit = YES;
    
    [self.view addSubview:web];
    
    
    
    
    LogInfo(@"taxRegistratin:%lf", self.taxRegistration.frame.size.width);
    
    [self setupMyScrollViewSubs:self.myScrollView];
}

- (void)setupMyScrollViewSubs:(UIScrollView *)viewPrent
{
    //设置坐标
    NSInteger scrollXStart = 0;
    NSInteger scrollYStart = 0;
    
    //入驻协议
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 30)];
    label.text = @"入驻协议";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:142/255.0f green:143/255.0f blue:144/255.0f alpha:1];
    [viewPrent addSubview:label];
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += label.height;
    
    //协议内容
    UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(scrollXStart+10, scrollYStart, ScreenWidth-20, 200)];
    contentTextView.text = @"今天早上九点，记者来到马来西亚世乒赛比赛场馆——美拉瓦蒂体育馆的媒体通道，准备进入二楼的媒体间。记者从一楼楼梯步行至二楼时，看到靠近二楼楼梯的地上已经布满了一些水迹，还不断有水滴落下。头一看，墙顶用于遮盖里层管道的挡板已经缺少了三块， 水正是从这儿漏下来的今天早上九点，记者来到马来西亚世乒赛比赛场馆——美拉瓦蒂体育馆的媒体通道，准备进入二楼的媒体间。记者从一楼楼梯步行至二楼时，看到靠近二楼楼梯的地上已经布满了一些水迹，还不断有水滴落下。记者抬头一看，墙顶用于遮盖里层管道的挡板已经缺少了三块， 水正是从这儿漏下来的的媒体间。记者从一楼楼梯步行至二楼时，看到靠近二楼楼梯的地上已经布满了一些水迹，还不断有水滴落下。头一看，墙顶用于遮盖里层管道的挡板已经缺少了三块， 水正是从这儿漏下来的今天早上九点，记者来到马来西亚世乒赛比赛场馆——美拉瓦蒂体育馆的媒体通道，准备进入二楼的媒体间。记者从一楼楼梯步行至二楼时，看到靠近二楼楼梯的地上已经布满了一些水迹，还不断有水滴落下。记者抬头一看，墙顶用于遮盖里层管道的挡板已经缺少了三块， 水正是从这儿漏下来的";
    [viewPrent addSubview:contentTextView];
    
    //重置坐标
    scrollXStart = ScreenWidth*0.5;
    scrollYStart += contentTextView.height;
    
    //我已经阅读此协议
    UIButton *readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    readButton.frame = CGRectMake(scrollXStart-70, scrollYStart+10, 140, 20);
    readButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [readButton setTitle:@"我已经阅读此协议" forState:UIControlStateNormal];
    [readButton setImage:[UIImage imageNamed:@"enterAgreement"] forState:UIControlStateNormal];
    [readButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [viewPrent addSubview:readButton];
    
    //重置坐标
    scrollYStart += readButton.height+10+10;
    
    //设置下一步
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(scrollXStart-50, scrollYStart, 100, 20);
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"enterNextButton"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextPageChangeClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewPrent addSubview:nextButton];
    
    
    self.myScrollView.contentInset = UIEdgeInsetsMake(0, 0, ScreenHeight, 0);
    
}

- (void)nextPageChangeClick:(UIButton*)button
{
    self.companyOneScrollView.frame = scrollViewFrame;
    [self.view addSubview:self.companyOneScrollView];
    self.companyOneScrollView.contentInset = UIEdgeInsetsMake(0, 0, 1100, 0);
    self.myScrollView.alpha = 0;
}

//companyOneNextClick-->companyTwo
- (IBAction)companyOneNextClick:(UIButton *)sender {
    self.companyTwoScrollView.frame = scrollViewFrame;
    [self.view addSubview:self.companyTwoScrollView];
    
    self.companyTwoScrollView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
    self.companyOneScrollView.alpha = 0;
    
    
}
- (IBAction)companyTwoNextClick:(UIButton *)sender {
    self.ShopInformationScrollView.frame = scrollViewFrame;
    [self.view addSubview:self.ShopInformationScrollView];
    self.ShopInformationScrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.companyTwoScrollView.alpha = 0;
}

- (IBAction)saveClick:(id)sender {
    
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存资料么" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}




@end
