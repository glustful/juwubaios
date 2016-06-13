//
//  SeckillViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SeckillViewController.h"
#import "XMFSegmentView.h"
#import "SeckillCell.h"
#import "ProductDetailVC.h"
#import "SeckillModel.h"
#import "MJRefresh.h"

static const CGFloat MJDuration = 5.0;//当刷新7秒后在无数据返回，就自动停止刷新

@interface SeckillViewController ()<XMFSegmentViewDataSource, XMFSegmentViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;//请求数据数组
/**
 *  显示日期数组
 */
@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) NSMutableArray *requestTimeDateArray;//请求的日期的数组

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) int page;//刷新的页数
@property (nonatomic, assign) int num;//每次刷新的个数

@property (nonatomic, copy) NSString * nsDateString;//当前的时间
@property (nonatomic, copy) NSString * nsDateString1;//第二天的时间

@property (nonatomic, strong) FMNetworkRequest *proRequest;
@property (nonatomic, strong) FMNetworkRequest *proRequest1;
@property (nonatomic, strong) FMNetworkRequest *proRequest3;

@end

@implementation SeckillViewController
- (NSMutableArray *)requestTimeDateArray
{
    if (!_requestTimeDateArray) {
        _requestTimeDateArray = [[NSMutableArray alloc]init];
    }
    return _requestTimeDateArray;
}

- (NSMutableArray *)timeArray
{
    if (!_timeArray) {
        _timeArray = [[NSMutableArray alloc]init];
    }
    return _timeArray;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_proRequest];
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_proRequest1];
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_proRequest3];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 0;
    self.num = 20;
    
    //获得系统日期
    NSDate *  senddate=[NSDate date];
    
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSCalendarUnitYear|NSCalendarUnitWeekday;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    self.year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSInteger week=[conponent weekday];
    LogInfo(@"星期：%ld", week);
    
//    NSString  * nsDateString= [NSString  stringWithFormat:@"%2ld月%2ld日",month,day];
//    NSString *requestDateString = [NSString stringWithFormat:@"%4ld-%2ld-%2ld 00:00:01", year, month, day];
//    LogInfo(@"获得系统日期:%@", nsDateString);
    
    /**
     *  显示的是几月几号，但是没有具体的分类
     */
//    for (int i = 0; i<5; i++) {
//        NSString *timeStr = [NSString stringWithFormat:@"%2ld月%2ld日", month, day+i];
//        [self.timeArray addObject:timeStr];
//        NSString *requestTimeStr = [NSString stringWithFormat:@"%4ld-%2ld-%2ld 00:00:01", year, month, day+i];
//        [self.requestTimeDateArray addObject:requestTimeStr];
//    }
    
    
    /**
     *  显示的是星期几
     */
    for (int i = 0; i<7; i++) {
        NSString *timeString = [self timeTransformWeek:day withMonth:month];
        [self.timeArray addObject:timeString];
        day++;
    }
   
    self.nsDateString= [NSString  stringWithFormat:@"%4ld-%@",self.year,self.timeArray[0]];
    self.nsDateString1 = [NSString stringWithFormat:@"%4ld-%@",self.year,self.timeArray[1]];
    
#pragma mark- 网络请求
    _proRequest=[[FSNetworkManager sharedInstance]getAppSeckillProductPage:[NSString stringWithFormat:@"%d", self.page] andRow:[NSString stringWithFormat:@"%d", self.num] andStartTime:[NSString stringWithFormat:@"%@ 00:00:01", self.nsDateString] andEndTime:[NSString stringWithFormat:@"%@ 00:00:01", self.nsDateString1] andNetworkDelegate:self];
    [self.networkRequestArray addObject:_proRequest];
    
    [self setupSegmentViewSubs:self.view];
    
     [self refreshDataUpOrDown];

}


- (void)refreshDataUpOrDown{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.page++;
        _proRequest1=[[FSNetworkManager sharedInstance]getAppSeckillProductPage:[NSString stringWithFormat:@"%d", self.page] andRow:[NSString stringWithFormat:@"%d", self.num] andStartTime:[NSString stringWithFormat:@"%@ 02:00:00", self.nsDateString] andEndTime:[NSString stringWithFormat:@"%@ 02:00:00", self.nsDateString1] andNetworkDelegate:self];
        [self.networkRequestArray addObject:_proRequest1];
        // 模拟延迟加载数据，因此MJDuration秒后才调用
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            // 结束刷新
            [self.tableView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    //    self.myCollectionView.mj_footer.hidden = YES;
}

- (NSString *)timeTransformWeek:(NSInteger)myDay withMonth:(NSInteger)myMonth
{
//    NSString *timeStr;
    
    if (myMonth==1||myMonth==3||myMonth==5||myMonth==7||myMonth==8||myMonth==10||myMonth==12) {
        if (myDay<=31) {
            
            return [NSString stringWithFormat:@"%.2ld-%.2ld", myMonth, myDay];
        }else{
            myDay = myDay-31;
            return [NSString stringWithFormat:@"%.2ld-%.2ld", myMonth+1, myDay];
        }
    }else if (myMonth==4||myMonth==6||myMonth==8||myMonth==10){
        if (myDay<=30) {
            
            return [NSString stringWithFormat:@"%.2ld-%.2ld", myMonth, myDay];
        }else{
            myDay = myDay-30;
            return [NSString stringWithFormat:@"%.2ld-%.2ld", myMonth+1, myDay];
        }
    }else{
        if (myDay<=28) {
            
            return [NSString stringWithFormat:@"%.2ld-%.2ld", myMonth, myDay];
        }else{
            myDay = myDay-28;
            return [NSString stringWithFormat:@"%.2ld-%.2ld", myMonth+1, myDay];
        }
    }
    

}
- (void)setupSegmentViewSubs:(UIView *)viewParent
{
    //初始化坐标
    NSInteger viewXStart = 0;
    NSInteger viewYStart = 0;
    
    XMFSegmentView *segmentView = [XMFSegmentView new];
    segmentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"groupBuyingButtonBack"]];
    segmentView.dataSource = self;
    segmentView.columDelegate = self;
    segmentView.defaultIndex = 0;
    CGSize size = [UIScreen mainScreen].bounds.size;
    segmentView.frame = CGRectMake(viewXStart, viewYStart, size.width, 30);
    [self.view addSubview: segmentView];
    
    //重置坐标
    viewXStart = 0;
    viewYStart += segmentView.height;
    
    if (!self.tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(viewXStart, viewYStart, ScreenWidth, ScreenHeight-viewYStart)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [viewParent addSubview:self.tableView];
        
        self.tableView.delaysContentTouches = NO;

        
        [self.tableView registerNib:[UINib nibWithNibName:@"SeckillCell" bundle:nil] forCellReuseIdentifier:@"SeckillCell"];
    }
    
}


#pragma mark- tableViewDelegate and tableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeckillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeckillCell"];
    
    SeckillModel *seck = self.dataArray[indexPath.row];
    [cell customWithModel:seck];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
        
    //商品详情页
    ProductDetailVC *prodeDetail = [[ProductDetailVC alloc] initWithName:@"商品详情页"];
    SeckillModel *seck = self.dataArray[indexPath.row];
    prodeDetail.productId =seck.t_seckill_product_id;
    [self.navigationController pushViewController:prodeDetail animated:YES];
    
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

#pragma mark -网络回调
-(void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
    }
}
-(void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
    
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
        [self.dataArray addObjectsFromArray: fmNetworkRequest.responseData];
        [self.tableView reloadData];
        
    }else if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[SeckillModel class]]){

        [self.dataArray addObject:fmNetworkRequest.responseData];
        [self.tableView reloadData];
    }else{
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        [self.tableView reloadData];
    }

    // 结束刷新
    [self.tableView.mj_footer endRefreshing];


}





//  标题
- (NSString *)segmentView:(XMFSegmentView *)segmentView titleOfIndex:(NSUInteger)index {
   
//    NSArray *ary = @[@"08:00", @"10:00", @"12:00", @"14:00", @"16:00"];
    if (index==0) {
        NSString *str = @"今天";
        return str;
    }else{
        NSString *str = self.timeArray[index];
        return str;
    }
}
//  每个item的宽度
- (CGFloat)segmentView:(XMFSegmentView *)segmentView widthOfIndex:(NSUInteger)index {
    
    return ScreenWidth*0.25;
    
}
//  item的数量
- (NSUInteger)numberOfItemsInSegmentView:(XMFSegmentView *)segmentView {
    return self.timeArray.count-1;
}
//  点击item
- (void)segmentView:(XMFSegmentView *)segmentView didSelectItemsAtIndex:(NSUInteger)index {
    
    [self.dataArray removeAllObjects];
    LogInfo(@"index:%ld", index);
    self.page = 0;
    self.nsDateString= [NSString  stringWithFormat:@"%4ld-%@",self.year,self.timeArray[index]];
    self.nsDateString1 = [NSString stringWithFormat:@"%4ld-%@",self.year,self.timeArray[index+1]];
    
#pragma mark- 网络请求
    _proRequest3=[[FSNetworkManager sharedInstance]getAppSeckillProductPage:[NSString stringWithFormat:@"%d", self.page] andRow:[NSString stringWithFormat:@"%d", self.num] andStartTime:[NSString stringWithFormat:@"%@ 00:00:01", self.nsDateString] andEndTime:[NSString stringWithFormat:@"%@ 00:00:01", self.nsDateString1] andNetworkDelegate:self];
    [self.networkRequestArray addObject:_proRequest3];

    
    
//#pragma mark- 网络请求
//    FMNetworkRequest *proRequest=[[FSNetworkManager sharedInstance]getAppSeckillProductPage:@"0" andRow:@"10" andStartTime:@"2016-03-14 02:00:00" andEndTime:@"2016-03-14 22:00:00" andNetworkDelegate:self];
//    [self.networkRequestArray addObject:proRequest];
//    [self.dataArray removeAllObjects];
    
    LogInfo(@"index:%ld", index);
}
//  高亮的颜色
- (UIColor *)highlightColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor lightGrayColor];
}
//  标题字体颜色
- (UIColor *)fontColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor redColor];
}

@end
