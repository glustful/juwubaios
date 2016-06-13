//
//  BrandPavilionVC.m
//  JuWuBaMall
//
//  Created by JWB on 16/2/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BrandPavilionVC.h"
#import "BrandPavilionCell.h"
#import "BrandPavilionDetailVC.h"
#import <UIImageView+WebCache.h>
#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新
@interface BrandPavilionVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *brandList;
@property(nonatomic,strong)NSString *attentionNum;
@property(nonatomic,strong)Brand *brand;

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数
@end

@implementation BrandPavilionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.page = 0;
//    self.num = 20;
    [_tableView  registerNib:[UINib nibWithNibName:@"BrandPavilionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BrandPavilionCell"];
    _brandList=[NSMutableArray array];
    [_tableView setShowsVerticalScrollIndicator:NO];
    
    [[BaseAlert sharedInstance]showMessage:@"加载中"];
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]TPbrandListRequestWithNetworkDelegate:self];
    [self.networkRequestArray addObject:request];//@"d0e86dd4-5de2-4f02-b569-002c72c99dd7"
    
    FMNetworkRequest *requestAbountNum=[[FSNetworkManager sharedInstance]selectAttentionNumWithProductID:[[GlobalSetting sharedInstance]gUser].t_user_id withNetworkDelegate:self];
    [self.networkRequestArray addObject:requestAbountNum];
    
//    [self refreshDataUpOrDown];

}

- (void)refreshDataUpOrDown{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]TPbrandListRequestWithNetworkDelegate:self];
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


#pragma mark 网络回调
- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.requestData isKindOfClass:[NSString class]]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
    }
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance]dismiss];
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_TpBrandList]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            [_brandList  addObjectsFromArray:fmNetworkRequest.responseData];
            [_tableView  reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[Brand class]]) {
            _brand=fmNetworkRequest.responseData;
            [self.brandList addObject:self.brand];
            [_tableView  reloadData];
        }
    }
    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_SelectBrand_attentionNum]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
            _attentionNum=fmNetworkRequest.responseData;
        }
    }
    
    // 结束刷新
//    [self.tableView.mj_footer endRefreshing];

}
#pragma mark ---UITableViewDataSource---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return _brandList.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BrandPavilionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BrandPavilionCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    Brand *brand=_brandList[indexPath.row];
    cell.messageLabel.text=brand.t_product_brandinfo;
    
    NSString *str = brand.t_product_brand_logo;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [cell.logoView  sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    cell.desLabel.text=[NSString stringWithFormat:@"%@人收藏中国瓷砖商城%@旗舰店",_attentionNum,brand.t_product_brandinfo];
    return cell;
}
#pragma mark ---UITableViewDelegate---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BrandPavilionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BrandPavilionCell"];
    if (cell) {
        [cell  setNeedsUpdateConstraints];
        [cell  updateConstraintsIfNeeded];
        CGFloat  height=cell.height;
        return height;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BrandPavilionDetailVC  *brandDetailVC=[[BrandPavilionDetailVC alloc]initWithName:@"品牌馆"];
    [self.navigationController  pushViewController:brandDetailVC animated:YES];
}


@end
