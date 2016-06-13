//
//  GroupBuyingController.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "GroupBuyingController.h"
#import "GroupBuyingCell.h"
#import "XMFSegmentView.h"
#import "ProductDetailVC.h"
#import "SelectTypeGroupModel.h"
#import "SelectGroupProductModel.h"
#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新

@interface GroupBuyingController ()<XMFSegmentViewDataSource, XMFSegmentViewDelegate,UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic, strong) NSMutableArray *typeArr;//类型数组
@property (nonatomic, strong) NSMutableArray *productArr;//产品数组
@property (nonatomic, strong) SelectGroupProductModel *groupModel;

@property (nonatomic, strong) XMFSegmentView *segmentView;
@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数
@property (nonatomic, copy) NSString *stiId;//类型的ID

@property (nonatomic, strong) FMNetworkRequest *proRequest;


@end

@implementation GroupBuyingController

- (NSMutableArray *)productArr
{
    if (!_productArr) {
        _productArr = [NSMutableArray array];
    }
    return _productArr;
}

- (NSMutableArray *)typeArr
{
    if (!_typeArr) {
        _typeArr = [NSMutableArray array];
    }
    return _typeArr;
}

- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self setupSegmentViewSubs:self.view];
    

//    SelectTypeGroupModel *typeModel = self.typeArr[0];
//    NSString *stiId = typeModel.t_product_type_id;
//
//#pragma mark- 网络请求
//    FMNetworkRequest *proRequest=[[FSNetworkManager sharedInstance]getSelectGroupProductTypeId:stiId andCurrentPage:1 andPageSize:5 andNetworkDelegate:self];
//    [self.networkRequestArray addObject:proRequest];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_proRequest];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.num = 20;

#pragma mark- 网络请求 请求的类型
    _proRequest=[[FSNetworkManager sharedInstance]getSelectTypeGroupNetWorkDelegate:self];
    [self.networkRequestArray addObject:_proRequest];

    [self.tableView registerNib:[UINib nibWithNibName:@"GroupBuyingCell" bundle:nil] forCellReuseIdentifier:@"GroupBuyingCell"];
    
   
    
}


- (void)refreshDataUpOrDown{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getSelectGroupProductTypeId:self.stiId andCurrentPage:self.page andPageSize:self.num andNetworkDelegate:self];
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


- (void)setupSegmentViewSubs:(UIView *)viewParent
{
    //初始化坐标
    NSInteger viewXStart = 0;
    NSInteger viewYStart = 0;
    
    self.segmentView = [XMFSegmentView new];
    self.segmentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"groupBuyingButtonBack"]];
    self.segmentView.dataSource = self;
    self.segmentView.columDelegate = self;
//    self.segmentView.defaultIndex = 0;
    self.segmentView.defaultIndex = 0;

 
    
    self.segmentView.frame = CGRectMake(viewXStart, viewYStart, ScreenWidth, 30);
    [self.view addSubview: self.segmentView];
    
    
    
}

#pragma mark- tableViewDelegate and tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupBuyingCell *groupCell = [tableView dequeueReusableCellWithIdentifier:@"GroupBuyingCell"];
//    SelectGroupProductModel *groupModel = [[SelectGroupProductModel alloc]init];
    if (self.productArr.count>0) {
         self.groupModel = self.productArr[indexPath.row];
        [groupCell customWithModel:self.groupModel];
    }

    return groupCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerView.size = CGSizeMake(ScreenWidth, 30);
    return self.headerView;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    LogInfo(@"indexPath:%ld", indexPath.row);
    
    //商品详情页
    ProductDetailVC *prodDetail = [[ProductDetailVC alloc] initWithName:@"商品详情页"];
SelectGroupProductModel *groupModel=self.productArr[indexPath.row];
    

    prodDetail.productId =groupModel.tGroupPurchaseProductId;
    [self.navigationController pushViewController:prodDetail animated:YES];
}


//  标题
- (NSString *)segmentView:(XMFSegmentView *)segmentView titleOfIndex:(NSUInteger)index {
    
    if (self.typeArr.count>0) {
        SelectTypeGroupModel *typeModel = self.typeArr[index];
        NSString *str = typeModel.t_product_typename;
        
        return str;
    }
    return nil;
 
}
//  每个item的宽度
- (CGFloat)segmentView:(XMFSegmentView *)segmentView widthOfIndex:(NSUInteger)index {
    
    
    return ScreenWidth*0.33;
    
}
//  item的数量
- (NSUInteger)numberOfItemsInSegmentView:(XMFSegmentView *)segmentView {

    if (self.typeArr.count>0) {
        
         [self refreshDataUpOrDown];
        
        self.page = 1;
        SelectTypeGroupModel *typeModel = self.typeArr[0];
        self.stiId = typeModel.t_product_type_id;
        
#pragma mark- 网络请求
        FMNetworkRequest *proRequestm=[[FSNetworkManager sharedInstance]getSelectGroupProductTypeId:self.stiId andCurrentPage:self.page andPageSize:self.num andNetworkDelegate:self];
        [self.networkRequestArray addObject:proRequestm];
        return self.typeArr.count;
    }
    return 0;


}
//  点击item
- (void)segmentView:(XMFSegmentView *)segmentView didSelectItemsAtIndex:(NSUInteger)index {
    
    [self.productArr  removeAllObjects];
    SelectTypeGroupModel *typeModel = self.typeArr[index];
    NSString *stiId = typeModel.t_product_type_id;
    
    self.page = 1;
#pragma mark- 网络请求
    FMNetworkRequest *proRequest=[[FSNetworkManager sharedInstance]getSelectGroupProductTypeId:stiId andCurrentPage:self.page andPageSize:self.num andNetworkDelegate:self];
    [self.networkRequestArray addObject:proRequest];
    
}
//  高亮的颜色
- (UIColor *)highlightColorInSegmentView:(XMFSegmentView *)segmentView {
//    return [UIColor colorWithRed:208/255.0f green:71/255.0f blue:50/255.0f alpha:1];
    return [UIColor whiteColor];
}
//  标题字体颜色
- (UIColor *)fontColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor colorWithRed:121/255.0f green:122/255.0f blue:123/255.0f alpha:1];
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
   
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_selectTypeGroup]) {
        
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]){
            //类型
            //        [self.typeArr removeAllObjects];
            self.typeArr = fmNetworkRequest.responseData;
            [self setupSegmentViewSubs:self.view];
        }
        
    }else if ([fmNetworkRequest.requestName isEqualToString:kRequest_selectGroupProduct]){
        
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]){
            //产品
//            [self.productArr  removeAllObjects];
            [self.productArr addObjectsFromArray: fmNetworkRequest.responseData];
            [self.tableView reloadData];

        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[SelectGroupProductModel class]]){
            
            [self.productArr addObject: fmNetworkRequest.responseData];
            [self.tableView reloadData];
            
        }else{
            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
//            [self.tableView reloadData];
        }
        
    }
    // 结束刷新
    [self.tableView.mj_footer endRefreshing];
    
    
    
}

@end
