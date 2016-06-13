//
//  CombinViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "CombinViewController.h"
#import "TableViewCell.h"

#import "ProductDetailVC.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新

@interface CombinViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic,strong) CombinationProduct *product;

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@property (nonatomic, strong) FMNetworkRequest *request;


@end

@implementation CombinViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    self.num = 20;
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-60) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataArray=[[NSMutableArray alloc]init];
    
    _request=[[FSNetworkManager sharedInstance]getAppCombinationListRequestWithpage:self.page rows:self.num NetworkDelegate:self];
    [self.networkRequestArray  addObject:_request];
    
    [self refreshDataUpOrDown];

}

- (void)refreshDataUpOrDown{  
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getAppCombinationListRequestWithpage:self.page rows:self.num NetworkDelegate:self];
        [self.networkRequestArray  addObject:request];
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //    self.myCollectionView.mj_footer.hidden = YES;
}


#pragma mark- tableViewDelegate And tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 255;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"tableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CombinationProduct *product=_dataArray[indexPath.row];
    
    NSString *str = product.t_Combination_Picture;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.iconImageView  sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    cell.titleLabel.text=[NSString stringWithFormat:@"%@%@%@",product.t_Combination_Desc,product.t_Combination_Name,product.t_combination_attribute];
    cell.oldPrice.text =[NSString stringWithFormat:@"总价：%@元／套",product.t_Combination_Sourcemoney];
    cell.groupPrice.text = [NSString stringWithFormat:@"优惠价：%@元／套",product.t_Combination_Discountmoney];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductDetailVC *pdv = [[ProductDetailVC alloc]init];
      CombinationProduct *product=_dataArray[indexPath.row];
    
    pdv.productId =product.t_Combination_Id;
    [self.navigationController pushViewController:pdv animated:YES];
    
}

#pragma mark 网络回调
-(void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
    }
}
-(void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_getAppCombinationList]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            [_dataArray  addObjectsFromArray:fmNetworkRequest.responseData];
            [_tableView  reloadData];
        }
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[CombinationProduct class]]) {
//            [_dataArray  removeAllObjects];
            _product=fmNetworkRequest.responseData;
            [_dataArray  addObject:_product];
            [_tableView  reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]){
            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        }
    }
    [self.tableView.mj_footer endRefreshing];
}


@end
