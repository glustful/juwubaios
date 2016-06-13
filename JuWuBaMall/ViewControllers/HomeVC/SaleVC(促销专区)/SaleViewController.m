//
//  SaleViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#define saleCellIdentifier @"saleCell"
#define saleHeaderIdentifier @"saleHeader"

#import "SaleViewController.h"
#import "SaleCollectionViewCell.h"
//header与折扣一样
#import "MyCollectionHeader.h"
//flowLayout算法也和折扣一样
#import "CatFlowLayout.h"
#import <UIImageView+WebCache.h>
#import "ProductDetailVC.h"
#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新

@interface SaleViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MyCollectionHeaderDelegate>
@property (nonatomic, strong) UICollectionView *collection;
@property(nonatomic,strong)PromotionProduct  *product;
@property(nonatomic,strong)NSMutableArray  *dataArray;
@property(assign,nonatomic)NSInteger type;

@property (nonatomic, assign) BOOL countClick;//销量点击 升降排序
@property (nonatomic, assign) BOOL priceClick;//价格点击 升级排序

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@property (nonatomic, strong) FMNetworkRequest *proRequest;

@end

@implementation SaleViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_proRequest];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.countClick = YES;
    self.priceClick = YES;
    _type=0;
    self.page = 0;
    self.num = 20;
    _dataArray=[NSMutableArray array];
//     [[BaseAlert sharedInstance] showLodingWithMessage:@"小瓷努力加载中"];
    _proRequest=[[FSNetworkManager sharedInstance]getAllPromotoiomProductRequestWithtype:_type start:self.page num:self.num networkDelegate:self];
    [self.networkRequestArray addObject:_proRequest];
    
    CatFlowLayout *flowLayout = [[CatFlowLayout alloc]init];
    flowLayout.naviHeight = 0;
    flowLayout.allItems = YES;
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLayout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    self.collection.alwaysBounceVertical = YES;

    [self.view addSubview:self.collection];
    
    //    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:saleCellIdentifier];
    
    [self.collection registerNib:[UINib nibWithNibName:@"SaleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:saleCellIdentifier];
    
    [self.collection registerNib:[UINib nibWithNibName:@"MyCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:saleHeaderIdentifier];
    
    [self refreshDataUpOrDown];
    
}

- (void)refreshDataUpOrDown{
    
    self.collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        [[BaseAlert sharedInstance] showLodingWithMessage:@""];
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getAllPromotoiomProductRequestWithtype:_type start:self.page num:self.num networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
        [self.networkRequestArray  addObject:request];
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collection reloadData];
            
            // 结束刷新
            [self.collection.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //    self.myCollectionView.mj_footer.hidden = YES;
}

#pragma mark- collectionViewDelegate And collectionViewdatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (self.dataArray.count ==0) {
//        self.collection.mj_footer.hidden = YES;
//    }
    return _dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth*0.5-10, (ScreenWidth*0.5-10)*1.4);
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
    SaleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:saleCellIdentifier forIndexPath:indexPath];
        PromotionProduct *productInfo=_dataArray[indexPath.row];
    
        NSString *str = productInfo.t_produce_logo;
        //将url转码
        NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        [cell.icomImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
        cell.nameLabel.text=[NSString stringWithFormat:@"%@%@",productInfo.t_produce_name,productInfo.t_product_value];
        cell.priceLabel.text=[NSString stringWithFormat:@"原价:%@元",productInfo.t_produce_shop_price];
        cell.promotionLabel.text=[NSString stringWithFormat:@"促销价:%.2f元",[(productInfo.t_produce_shop_price) floatValue]*[(productInfo.t_promotion_discount) floatValue]];
    cell.backgroundColor = [UIColor whiteColor];
    
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionHeader *saleHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:saleHeaderIdentifier forIndexPath:indexPath];
    saleHeader.delegate = self;
    return saleHeader;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailVC *productDetail=[[ProductDetailVC alloc]initWithName:@"商品详情页"];
    PromotionProduct *productInfo=_dataArray[indexPath.row];
    productDetail.productId =productInfo.t_produce_id;
    [self.navigationController pushViewController:productDetail animated:YES];
}
- (void)doCollectionHeaderClick:(UIButton *)button
{
    LogInfo(@"button.tag:%ld", (long)button.tag);
    
    

    switch (button.tag) {
        case 11:{//综合
            [_dataArray  removeAllObjects];
            _type=0;
//            LogInfo(@"11111%ld",(long)button.buttonClickCount);
        }break;
        case 12:{//销量  3—	按销量排序，高到低   4-按销量排序，低到高
            //价格   1—按价格排序，高到低  2—按价格排序，低到高
            [self.dataArray removeAllObjects];
            if (self.countClick == YES) {
                self.type = 3;
            }else{
                self.type = 4;
            }
            self.countClick = !self.countClick;
            
        }break;
        case 13:{//价格   1—按价格排序，高到低  2—按价格排序，低到高
            
            [self.dataArray removeAllObjects];
            if (self.priceClick == YES) {
                self.type = 1;
            }else{
                self.type = 2;
            }
            self.priceClick = !self.priceClick;
            
        }break;
        case 14:{//筛选
            [self.dataArray removeAllObjects];
            self.type = 2;
        }break;
            
        default:
            break;
    }
    self.page = 0;
//    self.num = 10;
    [[BaseAlert sharedInstance] showLodingWithMessage:@""];

    FMNetworkRequest *saleNumRequest=[[FSNetworkManager sharedInstance]getAllPromotoiomProductRequestWithtype:_type start:self.page num:self.num networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
    [self.networkRequestArray  addObject:saleNumRequest];
}
#pragma mark -网络回调
-(void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
    }
}
-(void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[PromotionProduct class]]) {
        [self.dataArray addObject: fmNetworkRequest.responseData];
        //        [self.dataArray addObject:self.product];
        [_collection  reloadData];
    }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
        [_dataArray addObjectsFromArray:fmNetworkRequest.responseData];
        [_collection  reloadData];
    }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]){
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
    }
    [self.collection.mj_footer endRefreshing];
    
    
}


@end
