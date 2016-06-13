//
//  NewProductInMarketVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#define saleHeaderIdentifier @"saleHeader"


#import "NewProductInMarketVC.h"
//#import "ProductInfoNoConcernCell.h"
#import "NewProductInMarketFilterView.h"
#import <UIImageView+WebCache.h>
#import "ProductDetailVC.h"
#import "NewProductReusableView.h"

#import "CatFlowLayout.h"
#import "SortDetailCollectionViewCell.h"//获得分类列表信息的cell，因为和新品上市的一样，故用同一个
#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新
#define NewCollectionViewCellIdentifier @"SortDetailCollectionViewCell"


@interface NewProductInMarketVC ()<NewProductReusableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate, UIScrollViewDelegate>

@property(strong,nonatomic)UICollectionView  *myCollectionView;
@property(assign,nonatomic)NSInteger type;

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@property (nonatomic, strong) NSMutableArray *lastDataArr;//上一次的数据

//@property (nonatomic, assign) NSInteger oldOffset;//老的位移

@property (nonatomic, strong) FMNetworkRequest *request;




@end

@implementation NewProductInMarketVC

- (NSMutableArray *)lastDataArr
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   // self.navigationController.navigationBarHidden = NO;
    
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[[NSMutableArray alloc]init];
    _type=0;
    self.page = 0;
    self.num = 20;
    
    [[BaseAlert sharedInstance] showLodingWithMessage:@""];
    _request=[[FSNetworkManager sharedInstance]getNewProductWithType:_type start:self.page num:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id  networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
    [self.networkRequestArray  addObject:_request];
    
    

//    UICollectionViewFlowLayout  *layout=[[UICollectionViewFlowLayout alloc]init];
//    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    layout.itemSize=CGSizeMake((ScreenWidth-30)/2, 230);
//    layout.headerReferenceSize=CGSizeMake(ScreenWidth, 44);
//    layout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    
    CatFlowLayout *layout = [[CatFlowLayout alloc] init];
    layout.naviHeight = 0;
    layout.allItems = YES;//设置是否全部悬浮


    _myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:layout];
    _myCollectionView.backgroundColor=[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    _myCollectionView.dataSource=self;
    _myCollectionView.delegate=self;
    _myCollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_myCollectionView];
    
//    [_myCollectionView  registerClass:[UICollectionViewCell  class] forCellWithReuseIdentifier:@"SortDetailCollectionViewCell"];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"SortDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NewCollectionViewCellIdentifier];
    [_myCollectionView registerNib:[UINib nibWithNibName:@"NewProductReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
//    self.oldOffset = self.view.height;
    [self refreshDataUpOrDown];
}

- (void)refreshDataUpOrDown{
    
    self.myCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getNewProductWithType:_type start:self.page num:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id  networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
        [self.networkRequestArray  addObject:request];
        // 模拟延迟加载数据，在加载MJDuration秒后才调用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.myCollectionView reloadData];
            
            // 结束刷新
            [self.myCollectionView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //    self.myCollectionView.mj_footer.hidden = YES;
    

}


#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // 设置尾部控件的显示和隐藏
//    if (self.dataArray.count<4) {
//        self.myCollectionView.mj_footer.hidden = self.dataArray.count == 0;
//        self.myCollectionView.mj_footer.hidden = YES;
//    }
    return self.dataArray.count;
  
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenWidth*0.5-10, (ScreenWidth*0.5-10)*1.2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth, 30);
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SortDetailCollectionViewCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:NewCollectionViewCellIdentifier forIndexPath:indexPath];
    
    SortProductModel *newModel = self.dataArray[indexPath.row];
    [newCell customWithModel:newModel];
    newCell.backgroundColor = [UIColor whiteColor];
    
    return newCell;
}

#pragma mark UICollectionViewDelegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailVC *newProduct = [[ProductDetailVC alloc] initWithName:@""];
    SortProductModel *newModel = self.dataArray[indexPath.row];
    newProduct.productId = newModel.t_produce_id;
    [self.navigationController pushViewController:newProduct animated:YES];
    [collectionView  deselectItemAtIndexPath:indexPath animated:YES];
    
    
}
#pragma mark MyCollectionHeaderDelegate
-(void)doCollectionHeaderClick:(TitleButton *)button{

    switch (button.tag) {
        case 11:{//综合
            [_dataArray  removeAllObjects];
            _type=0;
            LogInfo(@"11111%ld",(long)button.buttonClickCount);
        }break;
        case 12:{//销量  3—	按销量排序，高到低   4-按销量排序，低到高
            //价格   1—按价格排序，高到低  2—按价格排序，低到高
            button.buttonClickCount=button.buttonClickCount+1;
            if (button.buttonClickCount%2==0) {//按钮点击次数为偶数次销量从高到低
                [_dataArray  removeAllObjects];
                _type=3;
            }
            if (button.buttonClickCount%2==1) {//按钮点击次数为奇数次销量从低到高
                [_dataArray  removeAllObjects];
                _type=4;
            }
            LogInfo(@"2222%ld",(long)button.buttonClickCount);
        }break;
        case 13:{//价格   1—按价格排序，高到低  2—按价格排序，低到高
            button.buttonClickCount=button.buttonClickCount+1;
            if (button.buttonClickCount%2==0) {//按钮点击次数为偶数次  价格从高到低
                [_dataArray  removeAllObjects];
                _type=1;
                
            }
            if (button.buttonClickCount%2==1) {//按钮点击次数为奇数次  价格从低到高
                [_dataArray  removeAllObjects];
                _type=2;

            }
            LogInfo(@"3333%ld",(long)button.buttonClickCount);
        }break;
        case 14:{//筛选
            [_dataArray  removeAllObjects];
            _type=2;
        }break;
            
        default:
            break;
    }
    self.page = 0;
//    self.num = 10;
    [[BaseAlert sharedInstance] showLodingWithMessage:@""];
    FMNetworkRequest *saleNumRequest=[[FSNetworkManager sharedInstance]getNewProductWithType:_type start:self.page num:self.num userID:[[GlobalSetting sharedInstance]gUser].t_user_id networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
    [self.networkRequestArray  addObject:saleNumRequest];

}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *myHeaderView = nil;
    

//    if (kind == UICollectionElementKindSectionHeader) {
        NewProductReusableView  *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        header.delegate = self;
        myHeaderView = header;
//    }
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
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_GetNewProduct]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
//            [self.dataArray  removeAllObjects];
#warning todo dataArr
            
            [_dataArray  addObjectsFromArray:fmNetworkRequest.responseData];
            [_myCollectionView  reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[SortProductModel class]]){
            
            [_dataArray  addObject:fmNetworkRequest.responseData];
            [_myCollectionView  reloadData];

        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]){
            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        }
        [self.myCollectionView.mj_header endRefreshing];
        [self.myCollectionView.mj_footer endRefreshing];
    }
}



#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    if (self.myCollectionView.contentOffset.y > self.oldOffset) {
//        LogInfo(@"papapa");
//        self.myCollectionView.mj_footer.hidden = NO;
//    }
//
//}


@end
