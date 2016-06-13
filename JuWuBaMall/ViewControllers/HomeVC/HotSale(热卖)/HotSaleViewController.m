//
//  HotSaleViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#define HotSaleViewCellIdentifier @"UICollectionViewCell"
#define HotSaleViewCellHeaderIdentifier  @"HotSaleViewCellHeader"

#import "HotSaleViewController.h"
#import "HotSaleViewCell.h"
#import "ProductDetailVC.h"
#import <UIImageView+WebCache.h>

//与折扣专区的header相同
#import "MyCollectionHeader.h"
//flowOut算法与“折扣专区相同”
#import "CatFlowLayout.h"
#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新


@interface HotSaleViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MyCollectionHeaderDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)SellProductModel  *sell;
@property(nonatomic,strong)NSMutableArray *productArray;

@property (nonatomic, assign) BOOL countClick;//销量点击 升降排序
@property (nonatomic, assign) BOOL priceClick;//价格点击 升级排序

@property (nonatomic, assign) NSInteger type;//类型

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@property (nonatomic, strong) FMNetworkRequest *request;

@end

@implementation HotSaleViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countClick = YES;
    self.priceClick = YES;
    self.type = 0;
    self.page = 0;
    self.num = 20;
    /**
     网络请求
     */

//    FMNetworkRequest *request = [[FSNetworkManager sharedInstance]querySelectedAllNetworkDelegate:self];
//    [self.networkRequestArray addObject:request];
    [[BaseAlert sharedInstance] showLodingWithMessage:@""];
    _request = [[FSNetworkManager sharedInstance]querySelectedAllRequestType:self.type start:self.page num:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id NetworkDelegate:self];
    [self.networkRequestArray addObject:_request];

    
    
    //    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    CatFlowLayout *flowLayout = [[CatFlowLayout alloc]init];
    flowLayout.naviHeight = 0;
    flowLayout.allItems = YES;//全部悬浮
    
    if (!self.collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
        self.collectionView.alwaysBounceVertical = YES;

        [self.view addSubview:_collectionView];
    }
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotSaleViewCell" bundle:nil] forCellWithReuseIdentifier:HotSaleViewCellIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HotSaleViewCellHeaderIdentifier];
    _productArray=[[NSMutableArray alloc]init];
    
    [self refreshDataUpOrDown];

}

- (void)refreshDataUpOrDown{
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        [[BaseAlert sharedInstance] showLodingWithMessage:@""];
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]querySelectedAllRequestType:self.type start:self.page num:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id NetworkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
        [self.networkRequestArray  addObject:request];
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            
            // 结束刷新
            [self.collectionView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //    self.myCollectionView.mj_footer.hidden = YES;
}

#pragma mark- collectionViewDelegateAndCollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return _productArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth*0.5-10, (ScreenWidth*0.5-10)*1.2);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth, 30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotSaleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HotSaleViewCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        SellProductModel *sell=_productArray[indexPath.row];
    
        NSString *str = sell.t_produce_logo;
        //将url转码
        NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        [cell.productIcon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
        cell.priceLabel.text=[NSString stringWithFormat:@"￥%@/片",sell.t_produce_shop_price];
        cell.productTitleLabel.text=sell.t_produce_name;
       return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HotSaleViewCellHeaderIdentifier forIndexPath:indexPath];
    header.delegate = self;
    return header;
    
}
//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailVC *detailVC = [[ProductDetailVC alloc]init];
    SellProductModel *sell=_productArray[indexPath.row];
    detailVC.productId =sell.t_produce_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)doCollectionHeaderClick:(UIButton *)button
{
    LogInfo(@"button.tag:%ld", (long)button.tag);
    
    switch (button.tag) {
        case 11:{//综合
            [self.productArray  removeAllObjects];
            _type=0;
            //            LogInfo(@"11111%ld",(long)button.buttonClickCount);
        }break;
        case 12:{//销量  3—	按销量排序，高到低   4-按销量排序，低到高
            //价格   1—按价格排序，高到低  2—按价格排序，低到高
            [self.productArray removeAllObjects];
            if (self.countClick == YES) {
                self.type = 3;
            }else{
                self.type = 4;
            }
            self.countClick = !self.countClick;
            
        }break;
        case 13:{//价格   1—按价格排序，高到低  2—按价格排序，低到高
            
            [self.productArray removeAllObjects];
            if (self.priceClick == YES) {
                self.type = 1;
            }else{
                self.type = 2;
            }
            self.priceClick = !self.priceClick;
            
        }break;
        case 14:{//筛选
            [self.productArray removeAllObjects];
            self.type = 2;
        }break;
            
        default:
            break;
    }
    self.page = 0;
//    self.num = 10;
    [[BaseAlert sharedInstance] showLodingWithMessage:@""];

    FMNetworkRequest *saleNumRequest=[[FSNetworkManager sharedInstance]querySelectedAllRequestType:self.type start:self.page num:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id NetworkDelegate:self];
    [self.networkRequestArray  addObject:saleNumRequest];

}


/**
 *  数据回调
 */
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
    [[BaseAlert sharedInstance]dismiss];
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_HotSaleProduct]) {
        
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[SellProductModel class]]) {
            _sell= fmNetworkRequest.responseData;
            [self.productArray addObject:self.sell];
            [self.collectionView reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            [_productArray addObjectsFromArray:fmNetworkRequest.responseData];
            [_collectionView  reloadData];
//            LogInfo(@"kkk%@",fmNetworkRequest.responseData);
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]){
            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        }
    }
    [self.collectionView.mj_footer endRefreshing];
}

@end
