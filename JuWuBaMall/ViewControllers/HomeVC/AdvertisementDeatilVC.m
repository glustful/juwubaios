//
//  AdvertisementDeatilVC.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/1.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "AdvertisementDeatilVC.h"

@interface AdvertisementDeatilVC ()

@end

@implementation AdvertisementDeatilVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view  addSubview:webView];
    [webView loadRequest:[NSURLRequest  requestWithURL:[NSURL URLWithString:self.adinfo.t_advertisement_href]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
