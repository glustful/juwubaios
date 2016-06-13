//
//  HomeVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeVC.h"
#import "HAdvertiseVIew.h"
#import "AdInfo.h"
#import "ShopInfo.h"
#import "ProductInfo.h"
#import "AdPageView.h"
#import "CustomButton.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeProductInfo.h"

// new
#import "HomeFounctionCell.h"
#import "SellersCell.h"
#import "HomeMiddleAdCell.h"
//#import "HomeProductAreaCell.h"
#import "HomeSortTableViewCell.h"

//我的收藏
#import "AttentionViewController.h"

//品牌馆
#import "BrandPavilionVC.h"
//团购
#import "GroupBuyingController.h"

// 秒杀
#import "SeckillViewController.h"

// 二级页面
#import "NewProductInMarketVC.h"
#import "ProductDetailVC.h"
#import "ShoppingCarVC.h"
#import "SortVC.h"
#import "PlatDiscountQuanVC.h"//平台优惠券
#import "FindingBrickVC.h"//找砖

#import "BusinessEnterViewController.h"//商家入驻
#import "RebateViewController.h"//折扣专区
#import "HotSaleViewController.h"//热卖
#import "SaleViewController.h"//促销专区
#import "CombinViewController.h"//组合专区
#import "BusinessEnterViewController.h"//商家入驻
#import "AdvertisementDeatilVC.h"

#import "SearchViewController.h"//搜索界面
#import "SweepViewController.h"//扫描二维码

#import "SortDetailViewController.h"//分类详情的列表  与分类的公用一个界面

#import "HomeProductDetailModel.h"//二级模型
#import "AFNetworking.h"

#define kTableHeaderHeight                  150

#define HomeProductAreaCellIdentifier  @"HomeSortTableViewCell"

@interface HomeVC ()<UITextFieldDelegate, UIScrollViewDelegate,AdPageViewDelegate , UITableViewDataSource, UITableViewDelegate, HomeFounctionCellDelegate, HomeSortTableViewCellDetele, SellersCellClickDelegate, HomeMiddleAdCellDelegate>

@property (nonatomic, strong) NSMutableArray *adList;// 广告数据
@property (nonatomic, strong) NSMutableArray*adImageList; // 广告地址数据

@property (nonatomic, strong) NSMutableArray *functionTitlesArray;  // 功能title
@property (nonatomic, strong) NSMutableArray *functionIconsArray;   // 功能icon
@property (nonatomic, strong) NSMutableArray *shopsList;            // 商家数据
@property (nonatomic, strong) NSMutableArray *productsList;         // 产品数据

@property (nonatomic, strong)  AdPageView*adView;           // 广告视图
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;






@property (nonatomic, strong) FMNetworkRequest *request;
@property (nonatomic, strong) FMNetworkRequest *allProductRequest;



@end

@implementation HomeVC

- (void)dealloc
{
    _adView = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //    [UIApplication sharedApplication].statusBarHidden = YES;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    //    [UIApplication sharedApplication].statusBarHidden = NO;
    
//    //取消网络加载
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_request];
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:_allProductRequest];


}




- (NSMutableArray *)productsList
{
    if (!_productsList) {
        _productsList = [[NSMutableArray alloc]init];
    }
    return _productsList;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self versionUpdate];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeSortTableViewCell" bundle:nil] forCellReuseIdentifier:HomeProductAreaCellIdentifier];
    
    [_tableView setShowsVerticalScrollIndicator:NO];
    
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.showsHorizontalScrollIndicator = YES;
  
    
    _request = [[FSNetworkManager sharedInstance]adListByPositionRequestWithadPsition:@"1" networkDelegate:self];
    [self.networkRequestArray addObject:_request];
    
#pragma mark 获得首页砖区列表
    [[BaseAlert sharedInstance] showLodingWithMessage:@"加载中"];
    _allProductRequest=[[FSNetworkManager sharedInstance]getPhoneHomePageProductNetworkDelegate:self];
    [self.networkRequestArray addObject:_allProductRequest];
//
    // 初始化
    _adList = [[NSMutableArray alloc] init];
     _adImageList= [[NSMutableArray alloc] init];
    _shopsList = [[NSMutableArray alloc] init];


        // 各功能数据配置
    _functionTitlesArray = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"新品上市", @"促销活动", @"我的收藏", @"品牌馆", @"团购", @"秒杀", @"找砖", @"优惠券", nil]];
    _functionIconsArray = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"NewProductInMarket", @"QuickSaleAction", @"MyCollection", @"BRAND", @"groupBuyingIcon", @"seckillIcon", @"FindBrickIcon", @"discountCouponIcon", nil]];    

}

- (void)versionUpdate
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    NSLog(@"版本%@",currentVersion);
    NSString *update = @"http://itunes.apple.com/search";
    NSMutableDictionary *updateDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    updateDic[@"term"] = @"中国瓷砖商城";
    updateDic[@"entity"] = @"software";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session POST:update parameters:updateDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *result = responseObject;
//        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:str options:0 error:nil];
                NSArray *array = result[@"results"];
                if (array.count ) {
                    NSDictionary *dict = array[0];
                    NSString *updateURL = dict[@"trackViewUrl"];
                    NSString *verson = dict[@"version"];
                    if (currentVersion.integerValue == verson.integerValue) {
//                        [self showTextString:@"当前为最新版本" withTime:1];
                    }else{
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"有新版本，是否去更新" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *canle     = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                        UIAlertAction *sure        = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
                            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:updateURL]];
        
                        }];
                        [alert addAction:canle];
                        [alert addAction:sure];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}



#pragma mark - HAdvertiseVIewDelegate
// 点击图片的操作
- (void)imageClickReturn:(NSNumber *)newsId{
    NSInteger number=[newsId integerValue];
    AdInfo *ad=_adList[number];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"敬请期待" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
//    AdvertisementDeatilVC *detailVC=[[AdvertisementDeatilVC alloc]initWithName:@"广告详情"];
//    detailVC.adinfo=ad;
//    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 5;
    return 4;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 功能Cell
    if (section == 0)
    {
        if (_functionIconsArray.count > 0)
        {
            NSInteger row = ceil(_functionIconsArray.count/4.0);
            return row;
        }
        
        return 2;
    }else if (section == 3){
        return self.productsList.count;
    }
    
    // 其他只有一行
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // =======================================================================
    // 功能入口cell
    // =======================================================================
    if (indexPath.section == 0)
    {
        static NSString *cellId;
        if (indexPath.row == 0)
        {
            cellId = @"HomeFounctionCell_1";
        }
        else
        {
            cellId = @"HomeFounctionCell_2";
        }
        
        HomeFounctionCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeFounctionCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[HomeFounctionCell class]])
                {
                    caseFieldNotificationCell = (HomeFounctionCell *)obj;
                }
            }
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"HomeFounctionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
        }
        
        if (indexPath.row == 0)
        {
            
            [caseFieldNotificationCell customWithImageArray:self.functionIconsArray andTitleArray:self.functionTitlesArray andRow:1];
            
            caseFieldNotificationCell.cellRow = 1;
            caseFieldNotificationCell.delegate = self;
            
        }
//
        if (indexPath.row == 1)
        {
            
            [caseFieldNotificationCell customWithImageArray:self.functionIconsArray andTitleArray:self.functionTitlesArray andRow:2];
            
            caseFieldNotificationCell.cellRow = 2;
            caseFieldNotificationCell.delegate = self;
        }
        return caseFieldNotificationCell;
    }
    
    // =======================================================================
    // 商家入驻
    // =======================================================================
    if (indexPath.section == 1)
    {
        static NSString *cellId = @"SellersCell";
        SellersCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SellersCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[SellersCell class]])
                {
                    caseFieldNotificationCell = (SellersCell *)obj;
                }
            }
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"SellersCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
        }
        caseFieldNotificationCell.delegate = self;
        
        return caseFieldNotificationCell;
    }
    
    // =======================================================================
    // 中间广告位
    // =======================================================================
    if (indexPath.section == 2)
    {
        static NSString *cellId = @"HomeMiddleAdCell";
        HomeMiddleAdCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeMiddleAdCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[HomeMiddleAdCell class]])
                {
                    caseFieldNotificationCell = (HomeMiddleAdCell *)obj;
                }
            }
            
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"HomeMiddleAdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
        }
        caseFieldNotificationCell.delegate = self;
        return caseFieldNotificationCell;
    }
    
    // =======================================================================
    // 产品专区
    // =======================================================================
    if (indexPath.section == 3)
    {
        //static NSString *cellId = @"HomeProductAreaCell";
        HomeSortTableViewCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:HomeProductAreaCellIdentifier forIndexPath:indexPath];
        
//        if (caseFieldNotificationCell == nil)
//        {
//            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeProductAreaCell" owner:self options:nil];
//            for(id obj in nib)
//            {
//                if([obj isKindOfClass:[HomeProductAreaCell class]])
//                {
//                    caseFieldNotificationCell = (HomeProductAreaCell *)obj;
//                }
//            }
//            
//       
//            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//            // cell 复用
//            [tableView registerNib:[UINib nibWithNibName:@"HomeProductAreaCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
//        }
        
        caseFieldNotificationCell.delegate = self;

        HomeSortModel *model = self.productsList[indexPath.row];
        [caseFieldNotificationCell customWithModel:model];

        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

        return caseFieldNotificationCell;
    }

    
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    // 分割View
    UIImageView *sepeartorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    sepeartorView.image = [UIImage imageNamed:@"SepartorLine"];
    return sepeartorView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
//        if (_adList && _adList.count > 0)
//        {
//            if (_adView == nil)
//            {
//                _adView = [[HAdvertiseVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kTableHeaderHeight)];
//                _adView.delegate = self;
//            }
        
        if (_adView == nil)
        {
            
            _adView= [[AdPageView alloc]init];
            _adView.delegate = self;
            _adView.frame = CGRectMake(0, 0, ScreenWidth, kTableHeaderHeight);
            //
            
        }

          [_adView  setImgNameArr :_adImageList];
//            [_adView setDataSource:_adList];
        
//        }
//        else
//        {
//            _adView = nil;
//        }
//        
        return _adView;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 功能入口
    if (indexPath.section == 0) {
        return 132;
    }
    // 商家入驻
    else if (indexPath.section == 1) {
        return 215;
    }
    // 中间广告
    else if (indexPath.section == 2) {
        return 50;
    }
    // 产品专区
    else if (indexPath.section == 3) {
        return 360;
    }
 
    return 132;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
//        if (_adList && _adList.count > 0)
//        {
            return kTableHeaderHeight;
       // }
    }
    
    return 0.005;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - HomeFounctionCellDelegate
- (void)homeFounctionCellButtonDidTouchDown:(UIButton *)button withRow:(NSInteger)row;
{
    // ===================================================
    // 第一行
    // ===================================================
    
    if (row == 1)
    {
        switch (button.tag)
        {
                // @"新品上市"
            case 1:
            {
                NewProductInMarketVC *newProduct = [[NewProductInMarketVC alloc] initWithName:@"新品上市"];
                
                [self.navigationController pushViewController:newProduct animated:YES];
            }
                break;
                // @"促销活动"
            case 2:
            {
                SaleViewController *newProduct = [[SaleViewController alloc] initWithName:@"促销活动"];
                
                [self.navigationController pushViewController:newProduct animated:YES];
            }
                break;
                // 我的收藏
            case 3:
            {
                
                AttentionViewController *attenProduct = [[AttentionViewController alloc] initWithName:@"我的收藏"];
                [self.navigationController pushViewController:attenProduct animated:YES];
            }
                break;
                // 品牌馆
            case 4:
            {
                //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能待实现" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                //                [alertView show];
                BrandPavilionVC *brandPavilinoVC=[[BrandPavilionVC alloc]initWithName:@"品牌馆"];
                [self.navigationController  pushViewController:brandPavilinoVC animated:YES];
                
            }
                break;
            default:
                break;
                
        }
    }
    // ===================================================
    // 第二行
    // ===================================================
    else if (row == 2)
    {
        switch (button.tag)
        {
                // @"团购"
            case 1:
            {
                //                SortVC *newProduct = [[SortVC alloc] initWithName:@"分类"];
                //                [self.navigationController pushViewController:newProduct animated:YES];

                //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能待实现" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                //                [alertView show];
                
                
                GroupBuyingController *groupBuyVC = [[GroupBuyingController alloc] initWithName:@"团购"];
                [self.navigationController pushViewController:groupBuyVC animated:YES];
                
                //                GroupBuyingViewController *groupBuyVC = [[GroupBuyingViewController alloc] initWithName:@"团购"];
                //                [self.navigationController pushViewController:groupBuyVC animated:YES];
                
                
                
                
            }
                break;
                // @"秒杀"
            case 2:
            {
                //                ShoppingCarVC *newProduct = [[ShoppingCarVC alloc] initWithName:@"购物车"];
                //                newProduct.pageType = eChildPage;
                //
                //                [self.navigationController pushViewController:newProduct animated:YES];
                SeckillViewController *seckillVC = [[SeckillViewController alloc] initWithName:@"秒杀"];
                [self.navigationController pushViewController:seckillVC animated:YES];
            }
                break;
                // 找砖
            case 3:
            {
                //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能待实现" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                //                [alertView show];
                FindingBrickVC  *findingBrickVC=[[FindingBrickVC alloc]initWithName:@"找砖"];
                [self.navigationController pushViewController:findingBrickVC animated:YES];
            }
                break;
                // 优惠券
            case 4:
            {
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"敬请期待" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                                [alertView show];
//                PlatDiscountQuanVC *platDiscountVC=[[PlatDiscountQuanVC alloc]initWithName:@"优惠券"];
//                [self.navigationController pushViewController:platDiscountVC animated:YES];
            }
                break;
            default:
                break;
                
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_searchTextField isFirstResponder]) {
        [_searchTextField resignFirstResponder];
    }
}

#pragma mark--首页轮播
- (void)click:(int)index{
    
    
}
#pragma mark - 进入产品详情   delegate
- (void)productDidTouchDownwithModel:(HomeProductDetailModel *)sortMod
{
    HomeProductDetailModel *model = sortMod;
    
    ProductDetailVC *productDetailVC = [[ProductDetailVC alloc] initWithName:@"商品详情页"];
    
    productDetailVC.productId = model.produceID;
    
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

#pragma mark- 更多进入商品列表  delegate
- (void)moreClickButtonWithModel:(HomeSortModel *)sortModel
{
    NSString *titleName = sortModel.typeName;
    NSString *typeId = sortModel.typeID;
    SortDetailViewController *moreVC = [[SortDetailViewController alloc]initWithName:titleName];
    moreVC.typeID = typeId;
    moreVC.sortStatus = eMySortStatus_HomePage;
    [self.navigationController pushViewController:moreVC animated:YES];
}

#pragma mark- 商家入驻
- (void)doSellersCellClick:(UIButton *)button
{
    
    
    NSInteger buttonTag = button.tag;
    switch (buttonTag) {
        case 11:
        {
            LogInfo(@"商家入驻");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"敬请期待" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
//            BusinessEnterViewController *busineseVC = [[BusinessEnterViewController alloc]initWithName:@"商家入驻"];
//            [self.navigationController pushViewController:busineseVC animated:YES];
            
        }
            break;
        case 12:{
            LogInfo(@"折扣专区");
          
            RebateViewController *rebateVC = [[RebateViewController alloc] initWithName:@"折扣专区"];
            [self.navigationController pushViewController:rebateVC animated:YES];
        }
            break;
        case 13:{
            LogInfo(@"促销");
            SaleViewController *saleVC = [[SaleViewController alloc]initWithName:@"促销专区"];
            [self.navigationController pushViewController:saleVC animated:YES];
        }
            break;
        case 14:
        {
            LogInfo(@"热卖");
            HotSaleViewController *hotSaleVC = [[HotSaleViewController alloc] initWithName:@"热卖产品"];
            [self.navigationController pushViewController:hotSaleVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark- 商品组合
- (void)doHomeMiddleAdCellClick:(UIButton *)button
{
    LogInfo(@"商品组合页面");
    
    CombinViewController *combin = [[CombinViewController alloc]initWithName:@"组合专区"];
    [self.navigationController pushViewController:combin animated:YES];
}
#pragma mark 网络回调
-(void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest{
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
        
        if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getPhoneHomePageProduct]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];

      NSArray *array =[[FMStorageManager sharedInstance] fetchArrayForFileName:kRequest_User_getPhoneHomePageProduct];
        
        
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (NSDictionary *tmpDic in array) {
            HomeSortModel *homeSortModel = [[HomeSortModel alloc]initWithDictionary:tmpDic];
            [tmpArray addObject:homeSortModel];
            
        }
        
        self.productsList = tmpArray;
        [self.tableView reloadData];
        
    }
        
        
#pragma mark -轮播广告
        if ([fmNetworkRequest.requestName isEqualToString:kRequest_adListByPosition]) {
          
            NSArray *array =[[FMStorageManager sharedInstance] fetchArrayForFileName:kRequest_adListByPosition];
            
            NSMutableArray *dataArray=[NSMutableArray array];
            
            for (NSDictionary *tmpDic in array) {
                AdInfo *ad=[[AdInfo alloc]initWithDictionary:tmpDic];
                [dataArray addObject:ad];
            }
            
            
            [_adList removeAllObjects];
            [_adImageList removeAllObjects];
            
            for (AdInfo *object in dataArray) {
                [_adImageList addObject: object.imageUrl];
            }
            [_adList  addObjectsFromArray:dataArray];
            [_tableView  reloadData];
      
 
        
        }
        
        
        
        
    }
}
-(void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
  if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getPhoneHomePageProduct]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
       
            
            self.productsList = fmNetworkRequest.responseData;
            [self.tableView reloadData];
        }
    }else  if ([fmNetworkRequest.requestName isEqualToString:kRequest_adListByPosition]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            
            
            
            [_adList removeAllObjects];
            [_adImageList removeAllObjects];
            for (AdInfo *object in fmNetworkRequest.responseData) {
                [_adImageList addObject: object.imageUrl];
            }
            [_adList  addObjectsFromArray:fmNetworkRequest.responseData];
            [_tableView  reloadData];
        }
    }
    
        
    
}






//- (void)versionUpdate
//{
//    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
//
//    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
//
//    NSLog(@"版本%@",currentVersion);
//    NSString *update = @"http://itunes.apple.com/search";
//    NSMutableDictionary *updateDic = [[NSMutableDictionary alloc] initWithCapacity:0];
//    updateDic[@"term"] = @"中国瓷砖商城";
//    updateDic[@"entity"] = @"software";
//    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
//    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [manger POST:update parameters:updateDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//
//        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        NSArray *array = result[@"results"];
//        if (array.count ) {
//            NSDictionary *dict = array[0];
//            NSString *updateURL = dict[@"trackViewUrl"];
//            NSString *verson = dict[@"version"];
//            if (currentVersion.integerValue == verson.integerValue) {
//                //                [self showTextString:@"当前为最新版本" withTime:1];
//            }else{
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否去更新" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *canle     = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//                UIAlertAction *sure        = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:updateURL]];
//
//                }];
//                [alert addAction:canle];
//                [alert addAction:sure];
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//        }
//
//
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//
//    }];
//
//}


- (IBAction)searchProductOrShopsClick:(UIButton *)sender {
    SearchViewController *search = [[SearchViewController alloc]initWithName:@"搜索"];
    
    [self.navigationController pushViewController:search animated:YES];
}


- (IBAction)scanClick:(UIButton *)sender {
    
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



@end
