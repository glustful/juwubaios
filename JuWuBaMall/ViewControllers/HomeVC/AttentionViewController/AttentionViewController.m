//
//  AttentionViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//




#import "AttentionViewController.h"

#import "AttentionTableViewCell.h"
#import "AttentionShopTableViewCell.h"
//#import "Attention.h"

//店铺页面
#import "ShopViewController.h"
//商品详情
#import "ProductDetailVC.h"
#define segmentWidth  100
#define segmentHeight 30


typedef NS_ENUM(NSInteger, ButtonsTag)
{
    defaultButton = 1,
    reducePriceButton,
    saleButton,
    selectedButton,
    
    
};

@interface AttentionViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
     NSLock *_lock;
}
@property (nonatomic, strong) UIView *topView;// 顶部视图
@property (nonatomic, strong) UITableView *tableableView;//列表

@property (nonatomic, assign) long lastButtonTag;

@property (nonatomic, strong) UIButton *shopButton;//商品按钮
@property (nonatomic, strong) UIButton *storeButton;//商铺按钮

@property (nonatomic, assign) BOOL shopIsSelected;//选中商品
@property (nonatomic, assign) BOOL storeIsSelected;//选中店铺

@property (nonatomic, strong) NSMutableArray *attentionTmpDataArray;//店铺的数组
@property (nonatomic, strong) NSMutableArray *attentionDataArray;//商品的数组

@property (nonatomic, strong) Attention *myAttention;
@property (nonatomic, strong) AttentionStoreModel *myStoreAttention;

@property (nonatomic, strong) FMNetworkRequest *request;
@property (nonatomic, strong) FMNetworkRequest *request1;

@end

@implementation AttentionViewController

- (NSMutableArray *)attentionTmpDataArray
{
    if (!_attentionTmpDataArray) {
        _attentionTmpDataArray = [NSMutableArray array];
    }
    return _attentionTmpDataArray;
}

- (NSMutableArray *)attentionDataArray
{
    if (!_attentionDataArray) {
        _attentionDataArray = [NSMutableArray array];
    }
    return _attentionDataArray;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.isMineShopAttention == YES) {
        //网络请求
        _request1 = [[FSNetworkManager sharedInstance]queryAttentionShopListWithUserId:[[GlobalSetting sharedInstance]gUser].t_user_id netWorkDelegate:self];
        [self.networkRequestArray addObject:_request1];
    }else{
        

        
    _request = [[FSNetworkManager sharedInstance]queryAttentionProductListWithUserId:[[GlobalSetting sharedInstance]gUser].t_user_id netWorkDelegate:self];
        [self.networkRequestArray addObject:_request];

    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request];
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request1];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupRootViewSubs:self.view];
    
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
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getAttentionPList]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSMutableArray class]]) {
            self.attentionDataArray = fmNetworkRequest.responseData;
            [self.tableableView reloadData];
            //        for (NSDictionary *tmpDic in self.attentionTmpDataArray) {
            //            [self.attentionDataArray addObject:[Attention modelWithDictionay:tmpDic]];
            //        }
            //        LogInfo(@"加载数据：%@", _attentionTmpDataArray);
            //把优惠券信息加载到tableView上
            //        [self.tableableView  reloadData];
        }else{
            [self.attentionDataArray removeAllObjects];
  
//            self.myAttention = fmNetworkRequest.responseData;
            [self.attentionDataArray addObject:fmNetworkRequest.responseData];
            [self.tableableView reloadData];
        }        
    }
    else if([fmNetworkRequest.requestName isEqualToString:kRequest_User_getAttentionSList]){
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            
            self.attentionTmpDataArray = fmNetworkRequest.responseData;

            [self.tableableView reloadData];

        }else{
            [self.attentionTmpDataArray removeAllObjects];
            [self.attentionTmpDataArray addObject:fmNetworkRequest.responseData];
            [self.tableableView reloadData];
        }
    }

}




//设置主子视图
- (void)setupRootViewSubs:(UIView *)viewParent
{
    NSInteger rootXStart = 0;
    NSInteger rootYStart = 0;
    
    _shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shopButton.frame = CGRectMake(ScreenWidth*0.5-60, rootYStart+5, 60, 35);
    [_shopButton setTitle:@"商品" forState:UIControlStateNormal];
    _shopButton.tag = 11;
    [_shopButton addTarget:self action:@selector(shopClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewParent addSubview:_shopButton];
    
    _storeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _storeButton.frame = CGRectMake(_shopButton.right, rootYStart+5, 60, 35);
    [_storeButton setTitle:@"商铺" forState:UIControlStateNormal];
    _storeButton.tag = 12;
    [_storeButton addTarget:self action:@selector(storeClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewParent addSubview:_storeButton];
    
    if (self.isMineShopAttention == YES) {
        [_shopButton setBackgroundImage:[UIImage imageNamed:@"Attention_Sell"] forState:UIControlStateNormal];
        [_shopButton setTitleColor:[UIColor colorWithRed:123/255.0f green:124/255.0f blue:125/255.0f alpha:1] forState:UIControlStateNormal];
        [_storeButton setBackgroundImage:[UIImage imageNamed:@"Attention_Top_Back"] forState:UIControlStateNormal];


    }else{
        self.shopIsSelected = YES;
        [_shopButton setBackgroundImage:[UIImage imageNamed:@"Attention_Top_Back"] forState:UIControlStateNormal];
        [_storeButton setBackgroundImage:[UIImage imageNamed:@"Attention_Sell"] forState:UIControlStateNormal];
        [_storeButton setTitleColor:[UIColor colorWithRed:123/255.0f green:124/255.0f blue:125/255.0f alpha:1] forState:UIControlStateNormal];

    }
 
    
    
    //重置坐标
    rootXStart = 0;
    rootYStart += _storeButton.height;
    
    //tableView
    if (!_tableableView) {
        _tableableView = [[UITableView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, ScreenWidth, ScreenHeight-rootYStart-64)];
        _tableableView.delegate = self;
        _tableableView.dataSource = self;
        
        
        [viewParent addSubview:_tableableView];
    }
    //    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    //    headerView.backgroundColor = [UIColor blueColor];
    //    _tableableView.tableHeaderView = headerView;
    
    [_tableableView registerNib:[UINib nibWithNibName:@"AttentionTableViewCell" bundle:nil] forCellReuseIdentifier:@"AttentionTableViewCell"];
    
    [_tableableView registerNib:[UINib nibWithNibName:@"AttentionShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"AttentionShopTableViewCell"];
    
}


/**
 *  点击商品
 *
 *  @param button 商品
 */
- (void)shopClick:(UIButton *)button
{


    /**
     *  网络请求
     */
    FMNetworkRequest *request = [[FSNetworkManager sharedInstance]queryAttentionProductListWithUserId:[[GlobalSetting sharedInstance]gUser].t_user_id netWorkDelegate:self];
    [self.networkRequestArray addObject:request];

    self.isMineShopAttention = NO;
    self.shopIsSelected = YES;
    self.storeIsSelected = NO;
    [button setBackgroundImage:[UIImage imageNamed:@"Attention_Top_Back"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *myButton = [self.view viewWithTag:12];
    [myButton setBackgroundImage:[UIImage imageNamed:@"Attention_Sell"] forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor colorWithRed:123/255.0f green:124/255.0f blue:125/255.0f alpha:1] forState:UIControlStateNormal];
    
    [self.tableableView reloadData];
    
}
//店铺
- (void)storeClick:(UIButton *)button
{

    //网络请求
    FMNetworkRequest *request1 = [[FSNetworkManager sharedInstance]queryAttentionShopListWithUserId:[[GlobalSetting sharedInstance]gUser].t_user_id netWorkDelegate:self];
    [self.networkRequestArray addObject:request1];

    
    self.isMineShopAttention = NO;
    self.shopIsSelected = NO;
    self.storeIsSelected = YES;
    [button setBackgroundImage:[UIImage imageNamed:@"Attention_Top_Back"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *myButton = [self.view viewWithTag:11];
    [myButton setBackgroundImage:[UIImage imageNamed:@"Attention_Sell"] forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor colorWithRed:123/255.0f green:124/255.0f blue:125/255.0f alpha:1] forState:UIControlStateNormal];
    
    [self.tableableView reloadData];
    
    
}



#pragma mark- tableViewdatasourace and tableViewDelegate代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.shopIsSelected) {
        return self.attentionDataArray.count;

    }
    return self.attentionTmpDataArray.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.shopIsSelected) {
        return 100;
    }
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //点击商品
    if (self.shopIsSelected) {
        AttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionTableViewCell" forIndexPath:indexPath];
        self.myAttention = self.attentionDataArray[indexPath.row];
        [cell customWithModel:self.myAttention];

        return cell;
    }
    // 点击商铺
    AttentionShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AttentionShopTableViewCell" forIndexPath:indexPath];
        self.myStoreAttention = self.attentionTmpDataArray[indexPath.row];
        [cell customWithModel:self.myStoreAttention];

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 20;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    //    headerView.image = [UIImage imageNamed:@"Attention_Seperator"];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:233/255.0f green:231/255.0f blue:227/255.0f alpha:1];
    return headerView;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    
    if (self.shopIsSelected) {//当选中的是商品
        
        Attention *proAtt = self.attentionDataArray[indexPath.row];
        ProductDetailVC *detailVC = [[ProductDetailVC alloc]initWithName:@"商品详情页"];
        detailVC.productId = proAtt.t_produce_id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        
        AttentionStoreModel *storeModel = self.attentionTmpDataArray[indexPath.row];
        ShopViewController *svc = [[ShopViewController alloc] initWithName:@"店铺"];
        svc.shopId = storeModel.t_shop_id;
        [self.navigationController pushViewController:svc animated:YES];

    }
    
}


//消除粘性
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


//删除操作 tableView的删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除函数
    [self deleteDataWithUserId:indexPath.row];
    if (self.shopIsSelected) {
        [self.attentionDataArray removeObjectAtIndex:indexPath.row];
    }else{
        [self.attentionTmpDataArray removeObjectAtIndex:indexPath.row];
    }

    
    NSLog(@"indexPath:%ld", indexPath.row);
    [self.tableableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#warning 没有完成的删除功能
//根据主键id删除某条数据
- (void)deleteDataWithUserId:(NSInteger)index
{
    [_lock lock];
    
    if (self.shopIsSelected) {
        Attention *proAtt = self.attentionDataArray[index];
#warning 网络请求，删除关注
        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] deleteAttentionId:proAtt.t_attention_id netWorkDelegate:self];
        [self.networkRequestArray addObject:request];

    }else{
        AttentionStoreModel *storeModel = self.attentionTmpDataArray[index];
        FMNetworkRequest *request = [[FSNetworkManager sharedInstance] deleteAttentionId:storeModel.t_attention_id netWorkDelegate:self];
        [self.networkRequestArray addObject:request];

    }
    
  
    
    [_lock unlock];
}



- (void)viewDidLayoutSubviews
{
    if ([self.tableableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableableView setLayoutMargins:UIEdgeInsetsZero];
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
