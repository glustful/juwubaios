//
//  BrandPavilionDetailVC.m
//  JuWuBaMall
//
//  Created by JWB on 16/2/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BrandPavilionDetailVC.h"
//#import "ProductInfoNoConcernCell.h"
#import "NewProductInMarketFilterView.h"
#import <UIImageView+WebCache.h>
#import "ProductDetailVC.h"
//#import "NewProductReusableView.h"
#import "SortDetailCollectionViewCell.h"//与分类信息列表的cell相同
#import "MyCollectionHeader.h"//与折扣的头部相同
#import "CatFlowLayout.h"

#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新

#define SortDetailCollectionViewCellIdentifier  @"SortDetailCollectionViewCell"

@interface BrandPavilionDetailVC ()<UICollectionViewDelegate,UICollectionViewDataSource,MyCollectionHeaderDelegate>
@property(strong,nonatomic)UICollectionView  *brandCollectionView;
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(assign,nonatomic)NSInteger type;
@property (nonatomic, assign) BOOL countClick;//销量点击 升降排序
@property (nonatomic, assign) BOOL priceClick;//价格点击 升级排序

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@end

@implementation BrandPavilionDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.page = 0;
    self.num = 20;
    
    [self  addNavRightItemWithImageName:@"editIcon"];
    self.countClick = YES;
    self.priceClick = YES;
    
    _dataArray=[[NSMutableArray alloc]init];
//    UICollectionViewFlowLayout  *layout=[[UICollectionViewFlowLayout alloc]init];
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    layout.itemSize=CGSizeMake((ScreenWidth-30)/2, 230);
//    layout.headerReferenceSize=CGSizeMake(ScreenWidth, 44);
//    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    CatFlowLayout *layout = [[CatFlowLayout alloc] init];
    layout.naviHeight = 0;
    layout.allItems = YES;//设置是否全部悬浮
    
    _brandCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:layout];
    _brandCollectionView.backgroundColor=[UIColor whiteColor];
    _brandCollectionView.dataSource=self;
    _brandCollectionView.delegate=self;
    _brandCollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_brandCollectionView];
    [_brandCollectionView setShowsVerticalScrollIndicator:NO];
    
//    [self.brandCollectionView registerClass:[ProductInfoNoConcernCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.brandCollectionView registerNib:[UINib nibWithNibName:@"SortDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:SortDetailCollectionViewCellIdentifier];
    [_brandCollectionView registerNib:[UINib nibWithNibName:@"NewProductReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    _type=0;
    
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getBrandProductWithType:_type start:self.page number:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id networkDelegate:self];
    [self.networkRequestArray addObject:request];
    
    [self refreshDataUpOrDown];
}

- (void)refreshDataUpOrDown{
    
    self.brandCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getBrandProductWithType:_type start:self.page number:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
        [self.networkRequestArray  addObject:request];
        // 模拟延迟加载数据，在加载MJDuration秒后才调用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.brandCollectionView reloadData];
            
            // 结束刷新
            [self.brandCollectionView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //    self.myCollectionView.mj_footer.hidden = YES;
    
    
}

#pragma mark - topRightItem点击事件
- (void)doRightItemAction:(UIButton *)button
{
    [super doCommonRightItemAction:button];
}


#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth*0.5-10, (ScreenWidth*0.5-10)*1.4);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth, 30);
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    SortProductModel *pModel = self.dataArray[indexPath.row];
    SortDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SortDetailCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell customWithModel: pModel];
    
    return cell;
}

#pragma mark UICollectionViewDelegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailVC *newProduct = [[ProductDetailVC alloc] initWithName:@""];
    SortProductModel *pModel = self.dataArray[indexPath.row];
     newProduct.productId =pModel.t_produce_id;
    [self.navigationController pushViewController:newProduct animated:YES];
    [collectionView  deselectItemAtIndexPath:indexPath animated:YES];
    
}
#pragma mark NewProductReusableViewDelegate
-(void)doCollectionHeaderClick:(UIButton *)button{
 

    switch (button.tag) {
        case 11:{//综合
            [self.dataArray  removeAllObjects];
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
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getBrandProductWithType:_type start:self.page number:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id networkDelegate:self];
    [self.networkRequestArray  addObject:request];
    
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *myHeaderView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        MyCollectionHeader  *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        header.delegate = self;
        myHeaderView = header;
    }
    return myHeaderView;
    
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
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
        [_dataArray  removeAllObjects];
        [_dataArray addObjectsFromArray:fmNetworkRequest.responseData];
        [_brandCollectionView reloadData];
    }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSDictionary class]]){
        [_dataArray  removeAllObjects];
        [_dataArray addObject:fmNetworkRequest.responseData];
        [_brandCollectionView reloadData];
    }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]){
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
    }
    
    [self.brandCollectionView.mj_footer endRefreshing];
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
