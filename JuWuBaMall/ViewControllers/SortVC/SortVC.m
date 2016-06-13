//
//  SortVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SortVC.h"
#import "SortTabelViewModel.h"
#import "SortCollectionViewCell.h"
#import "ADCollectionViewCell.h"

#import "SortDetailViewController.h"

#import "SortLeftModel.h"//分类左侧列表model
#import "SearchViewController.h"//搜索界面

#import "SweepViewController.h"//扫一扫


#define tableViewWidth    ScreenWidth*0.3
#define tableViewHeight    ScreenHeight-rootYStart-TabBarHeight
typedef NS_ENUM(NSInteger, ControllersTag)
{
    eTopViewsTag = 1,
    eSepartorView1,
    eSepartorView2,
    eSepartorView3,
    eSepartorView4,
    
};

@interface SortVC ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIButton *cityTitleButton;//城市
@property (nonatomic, strong) UITextField *searchTextField;//搜索
@property (nonatomic, strong) UITableView *tableView;//左视图
@property (nonatomic, strong) UICollectionView *collectionView;//右视图

@property (nonatomic, strong) UIButton *sortButton;//分类按钮
@property (nonatomic, assign) BOOL isBtnClick;//分类按钮点击事件

@property (nonatomic, copy) NSString *collectionTitle;//临时collectionTitle


@property (nonatomic, strong) NSMutableArray *sortDataArray;//分类的类型

@property (nonatomic, strong) NSMutableArray *sortLeftDataArray;//分类左边的列表
@property (nonatomic, strong) NSMutableArray *rightDataArray;//右边分类列表


@property (nonatomic, strong) SortLeftModel *leftModel;//左侧分类model

@property (nonatomic, strong) FMNetworkRequest *request;

@property (nonatomic, strong) FMNetworkRequest *request1;


@end

@implementation SortVC

- (NSMutableArray *)rightDataArray
{
    if (!_rightDataArray) {
        _rightDataArray = [NSMutableArray array];
    }
    return _rightDataArray;
}


- (NSMutableArray *)sortDataArray
{
    //    if (!_sortDataArray) {
    NSArray *array = [[NSArray alloc]init];
    if (_isBtnClick == YES) {
        [_sortDataArray removeAllObjects];
        array = @[@"南鹰",@"北大", @"清华",@"人大",@"云大",@"云理"];
        
    }else{
        
        array = @[@"地砖", @"内墙砖",@"外墙砖",@"瓦",@"地脚线",@"壁画", @"其他"];
    }
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    for (NSString *tmpString in array) {
        SortTabelViewModel *stvm = [[SortTabelViewModel alloc]init];
        stvm.title = tmpString;
        [tmpArray addObject:stvm];
    }
    _sortDataArray = tmpArray;
    //    }
    return _sortDataArray;
}

- (NSMutableArray *)sortLeftDataArray
{
    if (!_sortLeftDataArray) {
        _sortLeftDataArray = [NSMutableArray array];
    }
    return _sortLeftDataArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request];
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request1];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRootViewSubs: self.view];
    
    [[BaseAlert sharedInstance] showLodingWithMessage:@"加载中"];
//  获得左侧大分类
    _request = [[FSNetworkManager sharedInstance] selectFirstTypeWithNetworkDelegate:self];
    [self.networkRequestArray addObject:_request];


}

#pragma mark- 网络回调请求
-(void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance] dismiss];
    
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
    {
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        
        if ([fmNetworkRequest.requestName isEqualToString:kRequest_selectFirstType]) {

            NSArray *array =[[FMStorageManager sharedInstance] fetchArrayForFileName:kRequest_selectFirstType];
       
            NSMutableArray *tmpDataArr = [NSMutableArray array];
            
            for (NSDictionary *dic in array) {
                
            SortLeftModel *att = [[SortLeftModel alloc]initWithDictionary:dic];
            [tmpDataArr addObject:att];
                
            }
        
            self.sortLeftDataArray = tmpDataArr;
            
            LogInfo(@"分类数据:%@", tmpDataArr);
            [self.tableView reloadData];
            

            
        
        }
            
            

    }
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance]dismiss];
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_selectFirstType]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSMutableArray class]]) {
            
            ///缓存
            NSMutableArray *tmpDataArr = [NSMutableArray array];
        
            for ( SortLeftModel *attd in fmNetworkRequest.responseData) {
                
                NSDictionary *att = [attd dictionaryValue];
                [tmpDataArr addObject:att];
                
            }
            [[FMStorageManager sharedInstance] storeArray:tmpDataArr withFileName:kRequest_selectFirstType];
            
        
            
            self.sortLeftDataArray = fmNetworkRequest.responseData;
            
            LogInfo(@"分类数据:%@", fmNetworkRequest.responseData);
            [self.tableView reloadData];

        }else{
            [self.sortLeftDataArray removeAllObjects];
            
            [self.sortLeftDataArray addObject:fmNetworkRequest.responseData];
            LogInfo(@"分类数据:%@", self.sortLeftDataArray);

            [self.tableView reloadData];
        }
        
        SortLeftModel *leftModel = self.sortLeftDataArray[0];
        NSString *pId = leftModel.t_product_type_id;
        
        // 网络请求  获得左侧大分类
        _request1 = [[FSNetworkManager sharedInstance] selectSecondTypeWthPid:pId andNetworkDelegate:self];
        [self.networkRequestArray addObject:_request1];
        
    }
    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_selectSecondType]){
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSMutableArray class]]) {
            
            self.rightDataArray = fmNetworkRequest.responseData;
            
            LogInfo(@"分类数据:%@", fmNetworkRequest.responseData);
            [self.collectionView reloadData];
            
        }else{
            [self.rightDataArray removeAllObjects];
            
            [self.sortLeftDataArray addObject:fmNetworkRequest.responseData];
            LogInfo(@"分类数据:%@", self.sortLeftDataArray);
            
            [self.collectionView reloadData];
        }

    }
    
}


- (void)setupRootViewSubs:(UIView*)viewParent
{
    NSInteger rootXStart = 0;
    NSInteger rootYStart = 0;
    // =======================================================================
    // 顶部View
    // =======================================================================
    UIView *topView = (UIView *)[viewParent viewWithTag:eTopViewsTag];
    if (topView == nil) {
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        topView.tag = eTopViewsTag;
        
        [viewParent addSubview:topView];
        
        // 子视图
        [self setupTopViewSubs:topView];
    }
    
    //重置坐标
    rootXStart = 0;
    rootYStart += topView.height;
    /**
     =========================================================================
     分割线
     =========================================================================
     */
    UIImageView *seperatorView = (UIImageView *)[viewParent viewWithTag:eSepartorView1];
    if (!seperatorView) {
        seperatorView = [[UIImageView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, ScreenWidth, 10)];
        seperatorView.tag = eSepartorView1;
        seperatorView.image = [UIImage imageNamed:@"SepartorLine"];
        [viewParent addSubview:seperatorView];
    }
    
    //重置坐标
    rootXStart = 0;
    rootYStart += seperatorView.height;
    
    /**
     ===========================================================================
     左视图－tableView
     ===========================================================================
     */
    
    if (!_sortButton) {
        _sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sortButton.frame = CGRectMake(rootXStart, rootYStart, ScreenWidth*0.3, 40);
        [viewParent addSubview:_sortButton];
        [_sortButton addTarget:self action:@selector(doSortButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sortButton setTitle:@"全部分类" forState:UIControlStateNormal];
        [_sortButton setTitleColor:[UIColor colorWithRed:209/255.0f green:55/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
        //暂时分类按钮不能交互
        _sortButton.userInteractionEnabled = NO;

        _sortButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _sortButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_sortButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [_sortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sortButton.backgroundColor = [UIColor colorWithRed:233/255.0f green:231/255.0f blue:227/255.0f alpha:1];
        [_sortButton setImage:[UIImage imageNamed:@"ProductTopIcon"] forState:UIControlStateNormal];
        [_sortButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        
        {
            UIImageView *arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(_sortButton.width-25, 16, 13, 7)];
            arrowImage.image = [UIImage imageNamed:@"SortCategoryDown"];
            [_sortButton addSubview:arrowImage];
        }
        {
            UIImageView *bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _sortButton.height-1, _sortButton.width, 1)];
            bottomLine.image = [UIImage imageNamed:@"SortTableViewSeperator"];
            [_sortButton addSubview:bottomLine];
            
        }
        
    }
    //重置坐标
    rootXStart = 0;
    rootYStart += _sortButton.height;
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, tableViewWidth,tableViewHeight)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithRed:233/255.0f green:231/255.0f blue:227/255.0f alpha:1];
        _tableView.separatorStyle = 
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [self setExtraCellLineHidden:self.tableView];
    }
    
    [viewParent addSubview:(UIView *)_tableView];
    
    //重置坐标
    rootXStart += _tableView.width;
    rootYStart = rootYStart;
    
    /**
     ===========================================================================
     右视图－collectionView
     ===========================================================================
     */
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart-_sortButton.height, ScreenWidth-self.tableView.width, self.tableView.height+_sortButton.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerNib:[UINib nibWithNibName:@"SortCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"SortCollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"ADCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ADCollectionViewCell"];
        [viewParent addSubview:_collectionView];
    }
    
}

- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}

//分类按钮doSortButtonAction
- (void)doSortButtonAction:(UIButton *)button
{
    _isBtnClick = !_isBtnClick;
    if (_isBtnClick == YES) {
        [button setTitle:@"厂区分类" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:209/255.0f green:55/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    }else{
        [button setTitle:@"全部分类" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:209/255.0f green:55/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    }
    [_tableView reloadData];
    
}
//添加子视图
- (void)setupTopViewSubs:(UIView *)viewParent
{
    // 背景
    UIImageView *topBackImageView = [[UIImageView alloc] initWithFrame:viewParent.frame];
    [topBackImageView setImage:[UIImage imageNamed:@"headerBackground"]];
    
    [viewParent addSubview:topBackImageView];
    
    
    // 搜索
    UIImageView *searchBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20+(viewParent.height-30-20)/2, ScreenWidth-10-10-3-20, 30)];
    [searchBack setImage:[UIImage imageNamed:@"SearchBack"]];
    
    [viewParent addSubview:searchBack];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(searchBack.left+10, searchBack.top, searchBack.width-10, searchBack.height);
    [searchButton setTitle:@"搜索商城商品/店铺" forState:UIControlStateNormal];
    [searchButton setTintColor:kMainBackGroundColor];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [searchButton setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(doButtonSearch:) forControlEvents:UIControlEventTouchUpInside];
    [viewParent addSubview:searchButton];
    
    // 扫一扫
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton setImage:[UIImage imageNamed:@"Scan"] forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(searchBack.right+10, 20+(viewParent.height-20-20)/2, 20, 20);
    [scanButton addTarget:self action:@selector(doScanAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewParent addSubview:scanButton];
    
}

//搜索点击事件
- (void)doButtonSearch:(UIButton *)myButton
{
    SearchViewController *search = [[SearchViewController alloc] initWithName:@"搜索"];
    [self.navigationController pushViewController:search animated:YES];
}

//扫一扫
- (void)doScanAction:(UIButton *)button
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        UIAlertController *altC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查设备相机!" preferredStyle:UIAlertControllerStyleAlert];
        [altC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:altC animated:YES completion:nil];
        return;
    }else {
        SweepViewController *sweepV = [[SweepViewController alloc] init];
        [self.navigationController pushViewController:sweepV animated:YES];
    }
}

#pragma mark- dataSource-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sortLeftDataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"app";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
//    SortTabelViewModel *stvm = _sortDataArray[indexPath.row];
//    cell.textLabel.text = stvm.title;
    _leftModel = self.sortLeftDataArray[indexPath.row];
    cell.textLabel.text = _leftModel.t_product_typename;
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor = [UIColor colorWithRed:233/255.0f green:231/255.0f blue:227/255.0f alpha:1];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    SortLeftModel *leftModel = self.sortLeftDataArray[indexPath.row];
    NSString *pId = leftModel.t_product_type_id;
    
#warning 网络请求  获得左侧大分类
    FMNetworkRequest *request = [[FSNetworkManager sharedInstance] selectSecondTypeWthPid:pId andNetworkDelegate:self];
    [self.networkRequestArray addObject:request];

    
//    SortLeftModel *leftModel = self.sortLeftDataArray[indexPath.row];
//    self.collectionTitle = leftModel.t_product_typename;
//    
//    NSLog(@"indexPath:%ld", (long)indexPath.row);
//    
//    [_collectionView reloadData];
}

#pragma  mark- collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rightDataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        return CGSizeMake(self.collectionView.width-10, 120);
//    }
    return CGSizeMake(self.collectionView.width*0.5-10, 120);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) {
//        ADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ADCollectionViewCell" forIndexPath:indexPath];
//        return cell;
//    }
    
    SortLeftModel *rightModel = self.rightDataArray[indexPath.row];
    
    SortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SortCollectionViewCell" forIndexPath:indexPath];
    [cell customWithModel:rightModel];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    SortLeftModel *rightModel = self.rightDataArray[indexPath.row];
    NSString *pid = rightModel.t_product_type_id;
    NSString *pName = rightModel.t_product_typename;
    
//    if (indexPath.row != 0) {
//        SortCollectionViewCell *cell = (SortCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    SortDetailViewController *sortVC = [[SortDetailViewController alloc]initWithName:pName];
    sortVC.typeID = pid;
    sortVC.sortStatus = eMySortStatus_SortPage;
    [self.navigationController pushViewController:sortVC animated:YES];
   
}


//下面两个方法是将cell的分割线显示全
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


@end
