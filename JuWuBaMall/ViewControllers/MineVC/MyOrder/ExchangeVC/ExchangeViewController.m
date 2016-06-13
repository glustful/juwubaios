//
//  ExchangeViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ExchangeViewController.h"
#import "AfterServiceTableViewCell.h"
#import "ExchangeHeaderView.h"
#import "ApplyServiceViewController.h"
#import "HFloatMenuView.h"

@interface ExchangeViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, ApplyServiceConfirmDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UIView  *topView;//头视图
@property (nonatomic, strong) UISearchBar *searchBar;//搜索
@property(nonatomic,strong)UISearchDisplayController *searchDisplay;
@property (nonatomic, strong) UITableView *tableView;//订单列表
@property (nonatomic, strong) ExchangeHeaderView *headerView;//头标题
@property(nonatomic,strong)HFloatMenuView  *popView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *resultArray;
@property(nonatomic,strong)NSMutableArray *sectionArray;

@end

@implementation ExchangeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArray=[NSMutableArray array];
    _resultArray=[NSMutableArray array];
    
    [self setupRootViewSubs:self.view];
    [self  addNavRightItemWithImageName:@"ExchangedSetting"];
    
#pragma mark 测试数据
    OrderInfo *order1=[[OrderInfo alloc]init];
    order1.t_total_num=@"33";
    order1.t_produce_name=@"hhhhhhhh";
//    order1.t_produce_color=@"天蓝";
//    order1.t_produce_logo_image=@"http://www.91spj.com/e25fa641b78b79f4f2e9fbef31c2e0e3";
    order1.t_order_id=@"111";
    
    OrderInfo *order2=[[OrderInfo alloc]init];
    order2.t_total_num=@"33";
    order2.t_produce_name=@"nnnnnnnnnn";
//    order2.t_produce_color=@"天蓝";
//    order2.t_produce_logo_image=@"http://img2.jc001.cn/img/052/1179052/1204/124f8e5c6c6e9ce.jpg";
    order2.t_order_id=@"2222";
    
    OrderInfo *order3=[[OrderInfo alloc]init];
    order3.t_total_num=@"33";
    order3.t_produce_name=@"内墙砖";
//    order3.t_produce_color=@"天蓝";
//    order3.t_produce_logo_image=@"http://img2.jc001.cn/img/052/1179052/1204/124f8e5c6c6e9ce.jpg";
    order3.t_order_id=@"8888";
    
    OrderInfo *order4=[[OrderInfo alloc]init];
    order4.t_total_num=@"33";
    order4.t_produce_name=@"远方小地砖";
//    order4.t_produce_color=@"天蓝";
//    order4.t_produce_logo_image=@"http://tu.webps.cn/tb/img/4/T1FYudFjFaXXXXXXXX_%21%210-item_pic.jpg";
//    order4.t_order_id=@"9999";
    
    OrderInfo *order5=[[OrderInfo alloc]init];
    order5.t_total_num=@"33";
    order5.t_produce_name=@"中国瓷砖商城南鹰仿古砖";
//    order5.t_produce_color=@"天蓝";
//    order5.t_produce_logo_image=@"http://www.91spj.com/e25fa641b78b79f4f2e9fbef31c2e0e3";
    order5.t_order_id=@"4444098000";
    
    [_dataArray  addObject:order1];
    [_dataArray  addObject:order2];
    [_dataArray  addObject:order3];
    [_dataArray  addObject:order4];
    [_dataArray  addObject:order5];
    
}
-(void)doRightItemAction:(UIButton *)button{
    [self  doCommonRightItemAction:button];
}
- (void)setupRootViewSubs:(UIView *)viewParent
{
    NSInteger rootXStart = 0;
    NSInteger rootYStart = 0;
    
    //头视图
//    if (!_topView) {
//        _topView = [[UIView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, ScreenWidth, 60)];
//        [viewParent addSubview:_topView];
//        //[self setupTopViewSubs:_topView];
//    }
    
//    //重置坐标
//    rootXStart = 0;
//    rootYStart += _topView.height;
    
    //搜索框视图
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, ScreenWidth, 40)    ];
    searchView.backgroundColor = [UIColor colorWithRed:232/255.0f green:230/255.0f blue:229/255.0f alpha:1];
    [viewParent addSubview: searchView];
    [self setupSearchViewSubs:searchView];
    
    //重置坐标
    rootXStart = 0;
    rootYStart += searchView.height;
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, ScreenWidth, ScreenHeight-rootYStart-40)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ExchangedCellSeperator"]]];
        [viewParent addSubview:_tableView];
    }
    [_tableView registerNib:[UINib nibWithNibName:@"ExchangeHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"ExchangeHeaderView"];

    //重置坐标
    rootXStart = 0;
    rootYStart += self.tableView.height;
    
    //底部视图
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, ScreenWidth, ScreenHeight-rootYStart)];
    [viewParent addSubview:bottomView];
    [self setupBottomViewSubs:bottomView];
}
//设置底部视图子控件
- (void)setupBottomViewSubs:(UIView *)viewParent
{
    //设置背景
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, viewParent.height)];
    backImageView.image = [UIImage imageNamed:@"ExchangedTopView"];
    [viewParent addSubview:backImageView];
    
    //设置中心线
    UIImageView *centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.5-1, 10, 1, 20)];
    centerImageView.image = [UIImage imageNamed:@"ExchangedBottomView"];
    [viewParent addSubview:centerImageView];
  
    //设置按钮－进度查询－售后帮助
    UIButton *query = [UIButton buttonWithType:UIButtonTypeCustom];
    [query setTitle:@"进度查询" forState:UIControlStateNormal];
    query.titleLabel.font = [UIFont systemFontOfSize:13];
    query.frame = CGRectMake(ScreenWidth*0.25-30, 10, 60, 20);
    [query addTarget:self action:@selector(doQueryAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewParent addSubview:query];
    
    UIButton *serve = [UIButton buttonWithType:UIButtonTypeCustom];
    [serve setTitle:@"售后帮助" forState:UIControlStateNormal];
    serve.titleLabel.font = [UIFont systemFontOfSize:13];
    serve.frame = CGRectMake(ScreenWidth*0.75-30, 10, 60, 20);
    [serve addTarget:self action:@selector(doServeAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewParent addSubview:serve];

    
    
}
//进度查询
- (void)doQueryAction:(UIButton *)button
{
    
}
//售后帮助
- (void)doServeAction:(UIButton *)button
{
    
}
#pragma mark - UISearchDisplayControllerdelegate
//搜索内容改变 并且刷新结果集内容的时候执行的方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    //处理搜索内容
    //清空上次搜索内容
    [_resultArray removeAllObjects];
    //判断当前搜索类型
    for (OrderInfo *order in _dataArray)
    {
        NSString *name=order.t_order_id;
        
        //判断name字符串是否包含搜索字符串的内容
        NSRange range=[name rangeOfString:searchString];
        if (range.location!=NSNotFound)
        {
            [_resultArray addObject:order];
        }
    }
    for (OrderInfo *order in _dataArray) {
        NSString *name=order.t_produce_name;
        NSRange range=[name rangeOfString:searchString];
        if (range.location!=NSNotFound) {
            [_resultArray  addObject:order];
        }
    }
    
    return YES;
}


#pragma mark- tabelViewDataSource And tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_tableView) {
        return _dataArray.count;
    }
    return _resultArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 订单相关cell
    static NSString *cellId = @"AfterServiceTableViewCell";
    AfterServiceTableViewCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (caseFieldNotificationCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AfterServiceTableViewCell" owner:self options:nil];
        for(id obj in nib)
        {
            if([obj isKindOfClass:[AfterServiceTableViewCell class]])
            {
                caseFieldNotificationCell = (AfterServiceTableViewCell *)obj;
            }
        }
        
        // cell 复用
        [tableView registerNib:[UINib nibWithNibName:@"AfterServiceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
        
    }

    caseFieldNotificationCell.delegate = self;
    caseFieldNotificationCell.afterServiceButton.tag=indexPath.row;
    if (tableView==_tableView) {
        OrderInfo *order=_dataArray[indexPath.row];
        [caseFieldNotificationCell reloadCellData:order];
    }else{
        OrderInfo *order=_resultArray[indexPath.row];
        [caseFieldNotificationCell reloadCellData:order];
    }
    return caseFieldNotificationCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    imageView.image = [UIImage imageNamed:@"ExchangedSeperator"];
    return imageView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderIdentifier = @"header";
    
    UITableViewHeaderFooterView *myHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!myHeader) {
        myHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderIdentifier];
        myHeader.frame = CGRectMake(0, 0, ScreenWidth, 50);
        UIView *backView = [[UIView alloc]initWithFrame:myHeader.frame];
        backView.backgroundColor = [UIColor whiteColor];
        [myHeader addSubview:backView];
        
        UIButton *btnUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnUp setTag:101];
        [btnUp setTitle:@"交易成功" forState:UIControlStateNormal];
        [btnUp setFrame:CGRectMake((tableView.frame.size.width - 70), 0, 60, 30)];
        btnUp.titleLabel.font = [UIFont systemFontOfSize:13];
        [btnUp setTitleColor:[UIColor colorWithRed:214/255.0f green:68/255.0f blue:44/255.0f alpha:1]  forState:UIControlStateNormal];
        btnUp.tag=1;
        [myHeader addSubview:btnUp];
        
        UILabel *orderNumber = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, ScreenWidth-btnUp.width-5, 20)];
        orderNumber.text = @"订单编号：12345678901234567890";
        orderNumber.font = [UIFont systemFontOfSize:11];
        orderNumber.textColor = [UIColor blackColor];
        orderNumber.tag=2;
        [myHeader addSubview:orderNumber];
        
        UILabel *orderDate = [[UILabel alloc]initWithFrame:CGRectMake(5, orderNumber.bottom, orderNumber.width, 20)];
        orderDate.text = @"订单日期：2013-23-12 20:23:11";
        orderDate.font = [UIFont systemFontOfSize:11];
        orderDate.textColor = [UIColor colorWithRed:183/255.0f green:184/255.0f blue:186/255.0f alpha:1];
        orderDate.tag=3;
        [myHeader addSubview:orderDate];
        
        UIImageView *seperator = [[UIImageView alloc]initWithFrame:CGRectMake(0, myHeader.height-1, ScreenWidth, 1)];
        seperator.image = [UIImage imageNamed:@"ExchangedCellSeperator"];
        [myHeader addSubview:seperator];
    }
    UILabel *orderNumber=[myHeader viewWithTag:2];
    
    UILabel *orderDate=[myHeader viewWithTag:3];
    OrderInfo *orderInfo=_dataArray[section];
    orderNumber.text=[NSString stringWithFormat:@"订单编号:%@",orderInfo.t_order_id];
    
    orderDate.text=[NSString stringWithFormat:@"订单时间:%@",@"2016-4-16"];
    
    return myHeader;
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

- (void)setupSearchViewSubs:(UIView *)viewParent
{
    
    // 搜索
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, viewParent.width, viewParent.height)];
    _searchBar.placeholder=@"商品名称、订单编号";
    [viewParent  addSubview:_searchBar];
    _searchDisplay=[[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    _searchDisplay.delegate=self;
    _searchDisplay.searchResultsDataSource=self;
    _searchDisplay.searchResultsDelegate=self;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //消除粘性
    UITableView *tableview = (UITableView *)scrollView;
    CGFloat sectionHeaderHeight = 50;
    CGFloat sectionFooterHeight = 20;
    CGFloat offsetY = tableview.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)   {
        
        tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight)   {
        tableview.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);         }else if (offsetY >= tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight && offsetY <= tableview.contentSize.height - tableview.frame.size.height)   {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(tableview.contentSize.height - tableview.frame.size.height - sectionFooterHeight), 0);
        }

}

//售后申请的点击代理方法
- (void)applyServiceConfirmClickWithCell:(UITableViewCell *)cell button:(UIButton*)button
{
    ApplyServiceViewController *asvc = [[ApplyServiceViewController alloc]initWithName:@"申请售后服务"];
    OrderInfo  *orderInfo=_dataArray[button.tag];
    asvc.orderInfo=orderInfo;
    [self.navigationController pushViewController:asvc animated:YES];
}


@end
