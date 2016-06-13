//
//  SearchViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/18.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHistoryDataBase.h"
#import "HomeVC.h"
#import "SearchTableViewCell.h"//搜索结果的cell
#import "ProductDetailVC.h"//商品详情页
#import "MJRefresh.h"

static const CGFloat MJDuration = 7.0;//当刷新7秒后在无数据返回，就自动停止刷新
#define SearchTableViewCellIdentifier  @"SearchTableViewCell"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *searchListArray;//搜索的数组数据
@property (nonatomic, strong) UITableView *tableView;//显示的数据列表

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@property (nonatomic, copy) NSString *searchStr;//搜索的内容

@property (nonatomic, strong) FMNetworkRequest *request;



@end

@implementation SearchViewController

- (NSMutableArray *)searchListArray
{
    if (!_searchListArray) {
        _searchListArray = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return _searchListArray;
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

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.page = 0;
    self.num = 20;
    
    //初始化搜索Bar
    self.mb_searchBar = [[NewSearchBar alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.mb_searchBar.mb_delegate = self;
    [self.view addSubview:self.mb_searchBar];
    
    [self.mb_searchBar.mb_searchTextField becomeFirstResponder];
    
    //初始化历史记录列表
    [self loadHistoryTableView];

}

- (void)refreshDataUpOrDown{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        _request=[[FSNetworkManager sharedInstance]getProductOrShopByBlurNameText:self.searchStr andPage:[NSString stringWithFormat:@"%d", self.page] andRow:[NSString stringWithFormat:@"%d", self.num] andNetWorkDelegate:self];
        [self.networkRequestArray  addObject:_request];
        // 模拟延迟加载数据，因此2秒后才调用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //    self.myCollectionView.mj_footer.hidden = YES;
}


#pragma mark ------历史记录显示列表-------
- (void)loadHistoryTableView{
    
    self.mb_historyTableView = [[HistoryTableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight-70)];
    [self.view addSubview:self.mb_historyTableView];
    
    __weak typeof(self)weakSelf = self;
    self.mb_historyTableView.mb_beginDraggingBlock = ^(){
        [weakSelf.mb_searchBar.mb_searchTextField resignFirstResponder];
    };
    self.mb_historyTableView.mb_selectHistoryCell = ^(NSString *string){
        [weakSelf searchDataWithInputString:string];
    };
}


#pragma mark ------搜索结果显示列表-------
- (void)loadSearchResultTableView{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight-70) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:SearchTableViewCellIdentifier];
 
    [self refreshDataUpOrDown];
    
}

#pragma mark tableViewDelegate and tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchTableViewCellIdentifier forIndexPath:indexPath];
    SearchProductOrShopModel *model = self.searchListArray[indexPath.row];
    [cell customWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     SearchProductOrShopModel *model = self.searchListArray[indexPath.row];
    ProductDetailVC *detailVC = [[ProductDetailVC alloc]initWithName:@"详情页"];
    detailVC.productId = model.t_produce_id;
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - DY_newSearchBarDelegate
//退出搜索界面
- (void)touchQuitButton{
    LogInfo(@"退出");
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}


//隐藏搜索结果页，显示历史记录页（在点击输入框内的清除按钮或者用键盘把文字一个个删除后）
- (void)hideSearchResultTableView{
    
    //隐藏搜索结果列表，显示历史列表
    self.mb_searchResultTableView.hidden = YES;
    
}

//点击键盘上的搜索按钮后进行的搜索操作
- (void)searchDataWithInputString:(NSString *)string{

    //清楚缓存的数据
    [self.searchListArray removeAllObjects];
    if ([string isEqualToString:@""]) {
        return;
    }
    self.page = 0;
    self.searchStr = string;
    FMNetworkRequest *allProductRequest=[[FSNetworkManager sharedInstance]getProductOrShopByBlurNameText:self.searchStr andPage:[NSString stringWithFormat:@"%d", self.page] andRow:[NSString stringWithFormat:@"%d", self.num] andNetWorkDelegate:self];
    [self.networkRequestArray addObject:allProductRequest];
    
    self.mb_searchBar.mb_searchTextField.text = string;
    //添加一条历史记录
    [self.mb_historyTableView addHistoryWithString:string];
    
    //开始搜索,显示搜索结果列表
    self.mb_searchResultTableView.hidden = NO;
    
    //取消键盘
    [self.mb_searchBar.mb_searchTextField resignFirstResponder];
    
    
}

- (void)dealloc
{
    
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
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductOrShopByBlurName]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSMutableArray class]]) {
            
            [self.searchListArray addObjectsFromArray:fmNetworkRequest.responseData];
            
            //初始化搜索结果列表
            [self loadSearchResultTableView];

            [self.tableView reloadData];

        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[SearchProductOrShopModel class]]){
//            [self.searchListArray removeAllObjects];
            
            //            self.myAttention = fmNetworkRequest.responseData;
            [self.searchListArray addObject:fmNetworkRequest.responseData];
            [self.tableView reloadData];
        }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]){
            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        }
        
        
    }
    
    // 结束刷新
    [self.tableView.mj_footer endRefreshing];
    
}



@end
