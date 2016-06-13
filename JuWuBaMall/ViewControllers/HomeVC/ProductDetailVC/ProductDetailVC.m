//
//  ProductDetailVC.m
//  JuWuBaMall
//
//  Created by yanghua on 16/5/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductDetailVC.h"
#import "ProductDetailCell.h"
#import "ProductDetailCommentCell.h"
#import "ProductDetailShopsCell.h"
#import "YouMaybeLikeCell.h"
#import "ProductInfoWith3ColumnCell.h"

#import "HAdvertiseVIew.h"
#import "AdInfo.h"

#import "ShoppingCarVC.h"
#import "ShopViewController.h"
#import "SelectSuggestionsPlatformVC.h"

#import "DeatailCell.h"

#import "CommentHeaderCell.h"
#import "CommentCell.h"
#import "UMSocial.h"
#import "ProductStatusModel.h"
#import "ProductDetialModel.h"
#import "ProductRated.h"
#import "TypeView.h"
#import "BuyCountView.h"
#import <Masonry.h>


#import "ProductDetailCommentVC.h"
#import "ProductDetailShowVC.h"
#import "ProductDetailStatuesVC.h"

#import "HorizonalTableViewController.h"
@interface ProductDetailVC ()<UMSocialUIDelegate>
{
    UIView *bgview;
    CGPoint center;
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;
}


//@property (weak, nonatomic) IBOutlet UIView *tableView;

@property (nonatomic, strong) NSMutableArray *adList;               // 广告数据
@property (nonatomic, strong) HAdvertiseVIew *adView;           // 广告视图

@property (nonatomic, strong) NSMutableArray *deatailImageArray;



@property (nonatomic, strong)  NSMutableArray *allCommentArray;//所有评价数据

@property (nonatomic, strong) NSMutableArray *statusArr;//属性数值


//详情图文
@property (nonatomic, strong)ProductDetialModel *productDetial;

//商品详情属性
@property (nonatomic, strong)NSMutableArray *productStatus;

@property (nonatomic, strong)HorizonalTableViewController *viewPager;

@property (nonatomic, strong)UISegmentedControl *segmentControl;

///获取到的详情id
@property (nonatomic ,copy)NSString *productDetailID;
///获取到的加到购物车商品数量
@property (nonatomic ,copy)NSString *productCount;
@property (nonatomic, strong) ProductStatusModel* userChosedProductStatusModel;
@end

@implementation ProductDetailVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _adView = nil;
}

- (NSMutableArray *)statusArr
{
    if (!_statusArr) {
        _statusArr = [NSMutableArray array];
    }
    return _statusArr;
}

- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];

    self.navigationItem.titleView = self.segmentControl;
    
}


-(UISegmentedControl *)segmentControl{
    if (!_segmentControl) {
    
    _segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"商品", @"详情", @"评论", nil]];
    _segmentControl.tintColor = [UIColor whiteColor];
    _segmentControl.frame = CGRectMake(0, 0, 190, 30);
    _segmentControl.selectedSegmentIndex = 0;
    NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    [_segmentControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateNormal];//设置文字属性
    [_segmentControl addTarget:self action:@selector(doSwitchItemAction:) forControlEvents:UIControlEventValueChanged];
         }
    return _segmentControl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    // topRightItem
    [self addNavRightItemWithImageName:@"editIcon"];
    
    // 1.监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productDetailID:) name:@"getProductDetailID"object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProductCount:) name:@"KGetProductCount"object:nil];
    
    self.productCount = @"1";
    self.allCommentArray = [[NSMutableArray alloc] init];

    
//    // 初始化
//    _adList = [[NSMutableArray alloc] init];
//    _deatailImageArray = [[NSMutableArray alloc] init];
//    [_deatailImageArray addObject:@"111"];
//    [_deatailImageArray addObject:@"111"];
//    
//    _commentArray = [[NSMutableArray alloc] init];
//    [_commentArray addObject:@"111"];
//    [_commentArray addObject:@"111"];
//    [_commentArray addObject:@"111"];
//    [_commentArray addObject:@"111"];
//    
//    
//#warning 造数据
//    AdInfo *adInfo1 = [[AdInfo alloc] init];
//    adInfo1.imageUrl = @"http:\\img.test.fangstar.net\\probe\\pub\\app_customer_avatar\\customer_avatar_girl_2.png@";
//    
//    AdInfo *adInfo2 = [[AdInfo alloc] init];
//    adInfo2.imageUrl = @"http:\\img.test.fangstar.net\\probe\\pub\\app_customer_avatar\\customer_avatar_girl_2.png@";
//    
//    AdInfo *adInfo3 = [[AdInfo alloc] init];
//    adInfo3.imageUrl = @"http:\\img.test.fangstar.net\\probe\\pub\\app_customer_avatar\\customer_avatar_girl_2.png@";
//    
//    [_adList addObject:adInfo1];
//    [_adList addObject:adInfo2];
//    [_adList addObject:adInfo3];
    
 
    
//
//    FMNetworkRequest *getPhoneProductStatusRequest=[[FSNetworkManager sharedInstance]getPhoneProductStatusProductID:self.productId? self.productId :@"efddd636-deb6-4040-8711-22b993f0ae48" networkDelegate:self];
//    [self.networkRequestArray addObject:getPhoneProductStatusRequest];
    
    
//    //获得商品详情信息
//    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getProductDetailWithProductID:@"213qwqe" networkDelegate:self];
//    [self.networkRequestArray addObject:request];
    

//    //    //获得商品评价
//    FMNetworkRequest *getProductRatedRequest=[[FSNetworkManager sharedInstance]getProductRatedByProductID:@"34235245245" networkDelegate:self];
//    [self.networkRequestArray addObject:getProductRatedRequest];

   // NSLog(@"%@",self.productId );
    //获得商品评价
//    FMNetworkRequest *getProductRatedRequest=[[FSNetworkManager sharedInstance]getProductRatedByProductID:self.productId networkDelegate:self];
//    [self.networkRequestArray addObject:getProductRatedRequest];
//
    
    /**
//     这些数据应该从服务器获得 没有服务器我就只能先写死这些数据了
//     */
//    sizearr = [[NSArray alloc] initWithObjects:@"S",@"M",@"L",@"k",@"M",@"L",@"k",nil];
//    colorarr = [[NSArray alloc] initWithObjects:@"蓝色",@"红色",@"湖蓝色",@"咖啡色",@"蓝色",@"红色",@"蓝色",@"红色",nil];
//    NSString *str = [[NSBundle mainBundle] pathForResource: @"stock" ofType:@"plist"];
//    stockarr = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:str]];
    
    [self initNewVC];

}


- (void)initNewVC{
    

    ProductDetailCommentVC*productDetailCommentVC = [[ProductDetailCommentVC alloc]initWithName:@""];
    productDetailCommentVC.productId = self.productId;
    
    ProductDetailShowVC*productDetailShowVC = [[ProductDetailShowVC alloc]initWithName:@""];
    productDetailShowVC.productId = self.productId;

    ProductDetailStatuesVC*newProductStatuesDetailVC = [[ProductDetailStatuesVC alloc]initWithName:@""];
    newProductStatuesDetailVC.productId = self.productId;
    
 _viewPager = [[HorizonalTableViewController alloc] initWithViewControllers:@[newProductStatuesDetailVC,productDetailShowVC,productDetailCommentVC]];
    
    CGFloat height =ScreenHeight - 50 - 64;
    _viewPager.view.frame = CGRectMake(0, 0, ScreenWidth, height);
    
    [self addChildViewController:_viewPager];
    [self.view addSubview:_viewPager.view];
    
 
       __weak __typeof (self) weakSelf = self;
    _viewPager.scrollView = ^(CGFloat offsetRatio, NSUInteger focusIndex, NSUInteger animationIndex) {
    __strong __typeof(weakSelf)strongSelf = weakSelf;

         strongSelf.segmentControl.selectedSegmentIndex = focusIndex;
        
    };

}

- (void)doRightItemAction:(UIButton *)button
{

    [super doCommonRightItemAction:button];

}

- (void)doSwitchItemAction:(UISegmentedControl *)control
{
    _queryType = control.selectedSegmentIndex;
    
    
    [_viewPager scrollToViewAtIndex:control.selectedSegmentIndex];
//    switch (control.selectedSegmentIndex) {
//        case 0:
//        {
//            
//            
//            break;
//        }
//        case 1:
//        {
//            break;
//        }
//        case 2:
//        {
//            break;
//        }
//        default:
//            break;
//    }

}





- (IBAction)doGoShoppingCarAction:(id)sender
{
    ShoppingCarVC *shoppingCarVC = [[ShoppingCarVC alloc] initWithName:@"购物车"];
    [self.navigationController pushViewController:shoppingCarVC animated:YES];
}

// 进入店铺
- (IBAction)doGoShopPageAction:(id)sender
{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"敬请期待" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alert show];
    ShopViewController *svc = [[ShopViewController alloc] initWithName:@"商品店铺"];
    [self.navigationController pushViewController:svc animated:YES];
    
}



- (IBAction)createAttention:(id)sender {
    
    if ([[GlobalSetting sharedInstance] loginStatus]==NO) {
        
        [self goLoginPage];
        
    }else{
    
        
        //38ec8f11-45a2-42f6-9ab0-268a5e8d67d1
        //68280939-016f-4bb0-ad0c-441151871cda
      //获取系统当前时间
        
//        NSDate*currentDate=[NSDate date];
//        NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];  //输出currentDateString @"2016-01-22"
//        NSString*currentDateString=[dateFormatter stringFromDate:currentDate];
    
        NSLog(@"%@",self.productDetailID); //fe3bef81-b54b-422f-a0d7-470e84f452c4
        NSLog(@"%@",self.productId);//5288f64a-cbce-42e2-9bd9-cf103a840a17
    FMNetworkRequest *attentionRequest=[[FSNetworkManager sharedInstance] createAttentionWithCreatetime:@"" attentionHerf:@"tmdjk" attentionId:self.productDetailID  attentionMoney:self.userChosedProductStatusModel.t_produce_detail_shop_price attentiontitle:self.userChosedProductStatusModel.t_produce_name attentionType:@"1" produceId:self.productDetailID shopId:@"" userId:[[GlobalSetting sharedInstance] gUser].t_user_id networkDelegate:self];
    [self.networkRequestArray addObject:attentionRequest];
        
    }
    
}


#pragma mark - 选择建议通道
- (IBAction)goSelectSuggestPlatformPageAction:(id)sender
{
    
    [self shareClick];
    //    SelectSuggestionsPlatformVC *selectVC = [[SelectSuggestionsPlatformVC alloc] initWithName:@"选择通道"];
    //    [self.navigationController pushViewController:selectVC animated:YES];
}

#pragma mark - 加入购物车
- (IBAction)doAddShoppingCarAction:(id)sender
{
    
    if ([[GlobalSetting sharedInstance] loginStatus]==NO) {
       
        [self goLoginPage];
        
    }else{
    
        if ([self.productCount integerValue]>[self.userChosedProductStatusModel.t_product_stock integerValue]) {
             [[BaseAlert sharedInstance] showMessage:@"抱歉库存不足够，不能加到购物车"];
            return;
        }
        
    [[BaseAlert sharedInstance]showMessage:@"加入购物车中..."];
    //获取系统当前时间
    NSDate*currentDate=[NSDate date];
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];  //输出currentDateString @"2016-01-22"
    NSString*currentDateString=[dateFormatter stringFromDate:currentDate];
   

    
NSString* shopAmount = [NSString stringWithFormat:@"%@",self.userChosedProductStatusModel.t_produce_detail_shop_price];
NSString* payAmount = [NSString stringWithFormat:@"%f",[self.productCount intValue]* [self.userChosedProductStatusModel.t_produce_detail_shop_price floatValue]];
    /*
     T_SHOP_CAR_PURCHASEQUANTITY 购买数量
    T_SHOP_CAR_MERCHANDISEDISCOUNTS  商品折扣
    T_SHOP_CAR_GOODSAMOUNT  商品金额
    T_SHOP_CAR_PAYMENTAMOUNT  支付金额
     */
        
    NSLog(@"id是%@",self.productDetailID); //e0bfa8b4-41c8-4b51-a938-864985f72fcb
        NSLog(@"id是%@",self.userChosedProductStatusModel.t_discount); //e0bfa8b4-41c8-4b51-a938-864985f72fcb

    FMNetworkRequest *request = [[FSNetworkManager sharedInstance] addToShoppingCarRequestWithUserId: [[GlobalSetting sharedInstance] gUser].t_user_id t_produce_id:self.productDetailID t_shop_car_createtime:currentDateString t_shop_car_goodsamount:shopAmount t_shop_car_id:[self uuidString]  t_shop_car_merchandisediscounts:self.userChosedProductStatusModel.t_discount t_shop_car_paymentamount:payAmount t_shop_car_purchasequantity:self.productCount networkDelegate:self];
    
    [self.networkRequestArray addObject:request];
    }
}



- (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

#pragma mark - 网络请求回调
- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];
    
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
    {
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
    }
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_AddToShoppingCar])
    {
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
        {
            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        }
    }
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_createAttention])
    {
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
        {
            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        }
    }
    
    
    
//    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getPhoneProductStatus])
//    {
//        LogInfo(@"%@",fmNetworkRequest.responseData);
//        
//        //        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductStatusModel class]]){
//        //            NSDictionary *dic = fmNetworkRequest.requestData;
//        
//        self.productStatus = fmNetworkRequest.responseData;
//        
//    
//        
//
//        
//    }
//
    
}
    
    
    
//    
//#pragma mark - 网络请求回调
//- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
//    {
//        [[BaseAlert sharedInstance] dismiss];
//        
//        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
//        {
//            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
//        }
//    }
//    
//- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
//    {
//        [[BaseAlert sharedInstance] dismiss];
//        
//        ///商品评价
//        //    else
//        if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductRatedByProductId]){
//
//            if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductRated class]]){
//                
//        
//                [self.allCommentArray addObject: fmNetworkRequest.responseData];
//                
//            }
//            if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]){
//                
//                NSLog(@"%@",fmNetworkRequest.responseData);
//                self.allCommentArray =fmNetworkRequest.responseData;
//                
//            }
//        }
//        
//        
//    }
//    
//
//    
    
    
    
    
    
    
//    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getPhoneProductStatus])
//    {
//        LogInfo(@"%@",fmNetworkRequest.responseData);
//        
////        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductStatusModel class]]){
////            NSDictionary *dic = fmNetworkRequest.requestData;
//       
//    self.productStatus = fmNetworkRequest.responseData;
//            
//        [self.tableView reloadData];
////        }
//        
//    }
//    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductDetial])
//    {
//        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductsRated class]]){
//        
//        self.productDetial=fmNetworkRequest.responseData;
//           
//            
//    }
//   
//    }
    
    
//    ///商品评价
//    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductRatedByProductId])
//    {
//        self.commentArray= [NSMutableArray array];
//        
//        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductsRated class]]){
//            
//            [self.commentArray addObject: fmNetworkRequest.responseData];
//            
//              [self.tableView reloadData];
//        }
//        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]){
//            
//            self.commentArray = fmNetworkRequest.responseData  ;
//            
//              [self.tableView reloadData];
//        }
//    }

   
//}





#pragma mark --分享

- (void)shareClick {
    //    if (gpDetail.id.length <= 0) {
    //        return;
    //    }
    
    //    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_BASE, [NSString stringWithFormat:URL_GraphicDetail, gpDetail.id, gpDetail.type]];
    //
    //    NSString *titleStr = gpDetail.title;
    //    NSString *descStr = gpDetail.subTitle;
    //     UMSocialUrlResource *res = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", URL_BASE, gpDetail.cover]];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.zgczsc.com/PC_good_detail.html?product_id=%@",self.productId];
    NSString *titleStr =@"中国瓷砖商城";
    NSString *descStr = [NSString stringWithFormat:@"中国瓷砖商城,商品：%@",self.userChosedProductStatusModel.t_produce_name];
    UMSocialUrlResource *res = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url: @"http://img1.imgtn.bdimg.com/it/u=524667967,2954926626&fm=206&gp=0.jpg"];
    
    
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStr;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = titleStr;
    [UMSocialData defaultData].extConfig.wechatSessionData.urlResource = res;
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = titleStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.urlResource = res;
    
    [UMSocialData defaultData].extConfig.qqData.urlResource = res;
    [UMSocialData defaultData].extConfig.qqData.url = urlStr;
    [UMSocialData defaultData].extConfig.qqData.title = titleStr;
    
    [UMSocialData defaultData].extConfig.qzoneData.url = urlStr;
    [UMSocialData defaultData].extConfig.qzoneData.title = titleStr;
    [UMSocialData defaultData].extConfig.qzoneData.urlResource = res;
    
    UMSocialTencentData *tencentData = [[UMSocialTencentData alloc] init];
    tencentData.urlResource = res;
    tencentData.title = titleStr;
    tencentData.shareText = [NSString stringWithFormat:@"%@\n%@",descStr.length > 0? descStr: @"", urlStr];
    [UMSocialData defaultData].extConfig.tencentData = tencentData;
    
    [UMSocialData defaultData].extConfig.smsData.urlResource = res;
    [UMSocialData defaultData].extConfig.smsData.shareText = [NSString stringWithFormat:@"%@\n%@\n%@", titleStr, descStr.length > 0? descStr: @"", urlStr];
    
    [UMSocialData defaultData].extConfig.emailData.title = titleStr;
    [UMSocialData defaultData].extConfig.emailData.urlResource = res;
    [UMSocialData defaultData].extConfig.emailData.shareText = [NSString stringWithFormat:@"%@\n%@",descStr.length > 0? descStr: @"", urlStr];
    
    //点击分享
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText: [NSString stringWithFormat:@"%@\n%@",descStr.length > 0? descStr: @"", urlStr] shareImage:[UIImage imageNamed:@"icon"]shareToSnsNames:[NSArray arrayWithObjects:UMShareToTencent,UMShareToWechatTimeline, UMShareToWechatSession, UMShareToQQ, UMShareToQzone, UMShareToSms, UMShareToEmail, nil]
                                       delegate:self];//UMShareToSina,
}

#pragma mark -UMSocialUIDelegate
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    if (response.responseCode == UMSResponseCodeSuccess) {
        [[BaseAlert sharedInstance] showMessage:@"分享成功"];
    }else {
        [[BaseAlert sharedInstance] showMessage:response.message];
    }
}








#pragma mark --计算cell的高度


//
//-(CGFloat)singTypeViewHightBysource:(NSArray *)arr
//{
//    float upX = 10;
//    float upY = 40;
//    for (int i = 0; i<arr.count; i++) {
//        NSString *str = [arr objectAtIndex:i] ;
//        
//        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
//        CGSize size = [str sizeWithAttributes:dic];
//        //NSLog(@"%f",size.height);
//        if ( upX > (self.view.frame.size.width-20 -size.width-35)) {
//
//            upX = 10;
//            upY += 30;
//        }
//    
//        upX+=size.width+35;
//    }
//    
//    upY +=30;
//
//    
////    self.height = upY+11;
//   
//    return upY+11;
//}


//
//- (CGFloat)cellHightWithModel:(NSArray *)modelArray{
//    
//    
//    NSMutableArray *product_first_type_value_array =[NSMutableArray array];
//    NSMutableArray *product_second_type_value_array =[NSMutableArray array];
//    NSMutableArray *product_thread_type_value_array =[NSMutableArray array];
//    for (ProductStatusModel*model in modelArray) {
//        
//        [product_first_type_value_array addObject:        model.t_product_first_type_value];
//        [product_second_type_value_array addObject:       model.t_product_second_type_value];
//        [product_thread_type_value_array addObject:       model.t_product_thread_type_value];
//        
//        
//    }
//
//  CGFloat typecolor =   [self  singTypeViewHightBysource:product_first_type_value_array];
//  CGFloat typesize  =   [self  singTypeViewHightBysource:product_second_type_value_array];
//  CGFloat typethread      =   [self  singTypeViewHightBysource:product_thread_type_value_array];
//  CGFloat cellHight =  typecolor+typethread+typesize+70+50+50;
//    return cellHight;
//}
//

#pragma mark --获取商品详情id
-(void)productDetailID:(NSNotification*)notification{

     self.userChosedProductStatusModel =notification.userInfo[@"productStatueModel"];
     self.productDetailID =notification.userInfo[@"productDetailID"];
    NSLog(@"%@" , self.productDetailID);
    NSLog(@"%@" , self.userChosedProductStatusModel.t_discount);

}



#pragma mark --获取添加商品库存数
-(void)getProductCount:(NSNotification*)notification{
//    KGetProductCount" object:self userInfo:@{@"productCount
    self.productCount =notification.userInfo[@"productCount"];
    NSLog(@"数量是%@",self.productCount);
}



@end
