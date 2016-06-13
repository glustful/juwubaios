//
//  RebateViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#define Identifier  @"RebateCollectionViewCell"
#define HeaderView  @"identifierHeaderView"

#import "RebateViewController.h"
#import "RebateCollectionViewCell.h"
#import "MyCollectionHeader.h"

#import "ProductDetailVC.h"
#import "CatFlowLayout.h"
#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新

@interface RebateViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MyCollectionHeaderDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property(nonatomic,strong)NSMutableArray *productList;

@property(assign,nonatomic)NSInteger type;
@property (nonatomic, assign) BOOL countClick;//销量点击 升降排序
@property (nonatomic, assign) BOOL priceClick;//价格点击 升级排序

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@property (nonatomic, strong) FMNetworkRequest *request;


@end

@implementation RebateViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.countClick = YES;
    self.priceClick = YES;
    _type=0;
    self.page = 1;
    self.num = 20;
     [[BaseAlert sharedInstance] showLodingWithMessage:@""];
    _request=[[FSNetworkManager sharedInstance]getDiscountProductRequestWithType:self.type currentPage:self.page pageSize:self.num networkDelegate:self];
    [self.networkRequestArray addObject:_request];
    
    _productList=[NSMutableArray array];
    
    CatFlowLayout *layout = [[CatFlowLayout alloc] init];
    layout.naviHeight = 0;
    layout.allItems = YES;//设置是否全部悬浮
    
    self.myCollectionView.collectionViewLayout = layout;
    self.myCollectionView.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    self.myCollectionView.alwaysBounceVertical = YES;

    [self.myCollectionView registerNib:[UINib nibWithNibName:@"RebateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:Identifier];
    [self.view addSubview:self.myCollectionView];

    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MyCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderView];

    [self refreshDataUpOrDown];
}


- (void)refreshDataUpOrDown{
    
    self.myCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        [[BaseAlert sharedInstance] showLodingWithMessage:@""];

        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getDiscountProductRequestWithType:self.type currentPage:self.page pageSize:self.num networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
        [self.networkRequestArray  addObject:request];
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.myCollectionView reloadData];
            
            // 结束刷新
            [self.myCollectionView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //    self.myCollectionView.mj_footer.hidden = YES;
}


#pragma mark- collectionViewDelegate And CollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (self.productList.count == 0) {
//        self.myCollectionView.mj_footer.hidden = YES;
//    }
    return _productList.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
   
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth, 30);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth*0.5-10, (ScreenWidth*0.5-10)*1.4);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *myHeaderView = nil;

//    if (kind == UICollectionElementKindSectionHeader) {
       MyCollectionHeader  *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderView forIndexPath:indexPath];
        header.delegate = self;
        myHeaderView = header;
//    }
    return myHeaderView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RebateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    DiscountProduct *product=_productList[indexPath.row];
    [cell  reloadCellDateWithProduct:product];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    ProductDetailVC *detail = [[ProductDetailVC alloc]initWithName:@"商品详情页"];
     DiscountProduct *product=_productList[indexPath.row];
    detail.productId=product.t_produce_id;
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)doCollectionHeaderClick:(UIButton *)button
{

    switch (button.tag) {
        case 11:{//综合
            [self.productList  removeAllObjects];
            _type=0;
            //            LogInfo(@"11111%ld",(long)button.buttonClickCount);
        }break;
        case 12:{//销量  3—	按销量排序，高到低   4-按销量排序，低到高
            //价格   1—按价格排序，高到低  2—按价格排序，低到高
            [self.productList removeAllObjects];
            if (self.countClick == YES) {
                self.type = 3;
            }else{
                self.type = 4;
            }
            self.countClick = !self.countClick;
            
        }break;
        case 13:{//价格   1—按价格排序，高到低  2—按价格排序，低到高
            
            [self.productList removeAllObjects];
            if (self.priceClick == YES) {
                self.type = 1;
            }else{
                self.type = 2;
            }
            self.priceClick = !self.priceClick;
            
        }break;
        case 14:{//筛选
            [self.productList removeAllObjects];
            self.type = 2;

        }break;
            
        default:
            break;
    }
    self.page = 1;
//    self.num = 10;
    [[BaseAlert sharedInstance] showLodingWithMessage:@""];

    FMNetworkRequest *saleNumRequest=[[FSNetworkManager sharedInstance]getDiscountProductRequestWithType:self.type currentPage:self.page pageSize:self.num networkDelegate:self];
    [self.networkRequestArray  addObject:saleNumRequest];
    
    
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
    //返回来的是一个josn解析过的数组
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
        NSMutableArray *array=[NSMutableArray  array];
        [array addObjectsFromArray:fmNetworkRequest.responseData];
        for (NSDictionary  *dic in array) {
            DiscountProduct  *product=[[DiscountProduct alloc]initWithDictionary:dic];
            [_productList  addObject:product];
        }
        [_myCollectionView  reloadData];
    }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]){
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
    }
    
     [self.myCollectionView.mj_footer endRefreshing];
}

@end
