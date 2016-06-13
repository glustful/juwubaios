//
//  SortDetailViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/26.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SortDetailViewController.h"
#import "SortDetailCollectionViewCell.h"
#import "ProductDetailVC.h"

//与折扣专区的header相同
#import "MyCollectionHeader.h"
//flowOut算法与“折扣专区相同”
#import "CatFlowLayout.h"
#import "MJRefresh.h"

#define SortDetailCollectionViewCellIdentifier @"SortDetailCollectionViewCell"
#define SortDetailViewCellHeaderIdentifier  @"SortDetailViewCellHeaderIdentifier"


static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新
@interface SortDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MyCollectionHeaderDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;//商品数组

@property(assign,nonatomic)NSInteger type;
@property (nonatomic, assign) BOOL countClick;//销量点击 升降排序
@property (nonatomic, assign) BOOL priceClick;//价格点击 升级排序

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@end

@implementation SortDetailViewController
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 0;
    self.num = 20;
    
    self.countClick = YES;
    self.priceClick = YES;
    _type=0;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (self.sortStatus == eMySortStatus_HomePage) {
        
#pragma mark 网络请求
        [[BaseAlert sharedInstance] showLodingWithMessage:@"加载中.."];
        
    FMNetworkRequest *request = [[FSNetworkManager sharedInstance] getAppProductByTypePid:self.typeID andTypes:_type andPage:[NSString stringWithFormat:@"%d", self.page] andRows:[NSString stringWithFormat:@"%d", self.num] andNetworkDelegate:self];
    [self.networkRequestArray addObject:request];
    }else if (self.sortStatus == eMySortStatus_SortPage){
    FMNetworkRequest *request1 = [[FSNetworkManager sharedInstance] appselectproductByTypeId:self.typeID andTypes:_type andPage:[NSString stringWithFormat:@"%d", self.page] andRows:[NSString stringWithFormat:@"%d", self.num] andNetworkDelegate:self];
    [self.networkRequestArray addObject:request1];
    }

    
    CatFlowLayout *flowLayout = [[CatFlowLayout alloc]init];
    flowLayout.naviHeight = 0;
    flowLayout.allItems = YES;//全部悬浮
    
    if (!self.collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
        
        
        //当数据不组一屏时也能滑动
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:_collectionView];
    }

    [self.collectionView registerNib:[UINib nibWithNibName:@"SortDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:SortDetailCollectionViewCellIdentifier];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SortDetailViewCellHeaderIdentifier];

    [self refreshDataUpOrDown];
    
}

- (void)refreshDataUpOrDown{
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getAppProductByTypePid:self.typeID andTypes:self.type andPage:[NSString stringWithFormat:@"%d", self.page] andRows:[NSString stringWithFormat:@"%d", self.num] andNetworkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
        [self.networkRequestArray  addObject:request];
        // 模拟延迟加载数据，在加载MJDuration秒后才调用
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
    return self.dataArr.count;
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
    SortDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SortDetailCollectionViewCellIdentifier forIndexPath:indexPath];
    
    SortProductModel *sortModel = self.dataArr[indexPath.row];
    [cell customWithModel:sortModel];
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SortDetailViewCellHeaderIdentifier forIndexPath:indexPath];
    header.delegate = self;
    return header;
    
}

//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailVC *detailVC = [[ProductDetailVC alloc]initWithName:@"详情页"];
    SortProductModel *sortModel = self.dataArr[indexPath.row];
    detailVC.productId = sortModel.t_produce_id;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)doCollectionHeaderClick:(UIButton *)button
{
    LogInfo(@"button.tag:%ld", (long)button.tag);
    
    switch (button.tag) {
        case 11:{//综合
            [_dataArr  removeAllObjects];
            _type=0;
            //            LogInfo(@"11111%ld",(long)button.buttonClickCount);
        }break;
        case 12:{//销量  3—	按销量排序，高到低   4-按销量排序，低到高
            //价格   1—按价格排序，高到低  2—按价格排序，低到高
            [_dataArr removeAllObjects];
            if (self.countClick == YES) {
                self.type = 3;
            }else{
                self.type = 4;
            }
            self.countClick = !self.countClick;
            
        }break;
        case 13:{//价格   1—按价格排序，高到低  2—按价格排序，低到高
            
            [_dataArr removeAllObjects];
            if (self.priceClick == YES) {
                self.type = 1;
            }else{
                self.type = 2;
            }
            self.priceClick = !self.priceClick;
            
        }break;
        case 14:{//筛选
            [_dataArr removeAllObjects];
            self.type = 2;
        }break;
            
        default:
            break;
    }
    self.page = 0;
    
    if (self.sortStatus == eMySortStatus_HomePage) {
        
    FMNetworkRequest *saleNumRequest=[[FSNetworkManager sharedInstance] getAppProductByTypePid:self.typeID andTypes:self.type andPage:[NSString stringWithFormat:@"%d", self.page] andRows:[NSString stringWithFormat:@"%d", self.num] andNetworkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
    [self.networkRequestArray  addObject:saleNumRequest];

    }else if (self.sortStatus == eMySortStatus_SortPage){
        
        FMNetworkRequest *request1 = [[FSNetworkManager sharedInstance] appselectproductByTypeId:self.typeID andTypes:_type andPage:[NSString stringWithFormat:@"%d", self.page] andRows:[NSString stringWithFormat:@"%d", self.num] andNetworkDelegate:self];
        [self.networkRequestArray addObject:request1];
        
    }

    
    
    
}



#pragma mark- 网络回调请求
-(void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance] dismiss];
    
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
    {
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
    }
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance]dismiss];
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_getAppProductByTypePid] || [fmNetworkRequest.requestName isEqualToString:kRequest_appselectproductByTypeId]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSMutableArray class]]) {
            
//            [self.dataArr removeAllObjects];
            
            [self.dataArr addObjectsFromArray: fmNetworkRequest.responseData];
            
            [self.collectionView reloadData];
//
//            LogInfo(@"分类数据:%@", fmNetworkRequest.responseData);
//            [self.tableView reloadData];
            
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSMutableArray class]]) {
            [self.dataArr addObjectsFromArray: fmNetworkRequest.responseData];
            
            [self.collectionView reloadData];
            
//            [self.sortLeftDataArray removeAllObjects];
//            
//            [self.sortLeftDataArray addObject:fmNetworkRequest.responseData];
//            LogInfo(@"分类数据:%@", self.sortLeftDataArray);
//            
//            [self.tableView reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSMutableArray class]]){
            [self.dataArr addObject: fmNetworkRequest.responseData];
            [self.collectionView reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]){
            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        }
    }
    

    
    [self.collectionView.mj_footer endRefreshing];
    
}



@end
