
//  Created by zhanglan on 16/2/2.
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
#import "AdPageView.h"
#import "HomeAdCell.h"
#import "ProductDetailCommentVC.h"
#import "ProductDetailShowVC.h"

#import "HorizonalTableViewController.h"
#import "ProductDetailStatuesVC.h"
#import <MWPhotoBrowser.h>
#import "ProductDetailStatuesModel.h"
#import "YouGuessProduct.h"
#import "NSString+Extent.h"
#import "ProductDetailCommentHeaderCell.h"

@interface ProductDetailStatuesVC ()<UITableViewDelegate, UITableViewDataSource, AdPageViewDelegate,UMSocialUIDelegate,HomeAdCellDelegate,TypeSeleteDelegete,MWPhotoBrowserDelegate >
{
    UIView *bgview;
    CGPoint center;
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *adList;               // 广告数据
//@property (nonatomic, strong) AdPageView *adView;           // 广告视图

@property (nonatomic, strong) NSMutableArray *deatailImageArray;
@property (nonatomic, strong) NSMutableArray *allCommentArray;
@property (nonatomic, strong) NSMutableArray *statusArr;//属性数值

//轮播图数组
@property (nonatomic, strong) NSMutableArray*imageUrlArray;
@property (nonatomic, strong) NSMutableArray*photos;


//详情图文
@property (nonatomic, strong)ProductDetialModel *productDetial;

//商品详情属性
@property (nonatomic, strong)NSMutableArray *productStatus;
@property (nonatomic, strong)NSString* productDetailID;

//商品详情规格选择属性模型
@property (nonatomic, strong)ProductDetailStatuesModel *productDetailStatuesModel;
//用户当前选择的详情属性模型
@property (nonatomic, strong) ProductStatusModel* userChosedProductStatusModel;

@property(strong,nonatomic)NSMutableArray *youGuessArray;


@property(strong,nonatomic)FMNetworkRequest *getPhoneProductStatusRequest;
@end


@implementation ProductDetailStatuesVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:self.getPhoneProductStatusRequest];
    
    
//    _adView = nil;
}

- (NSMutableArray *)statusArr
{
    if (!_statusArr) {
        _statusArr = [NSMutableArray array];
    }
    return _statusArr;
}

- (NSMutableArray *)youGuessArray
{
    if (!_youGuessArray) {
        _youGuessArray = [NSMutableArray array];
    }
    return _youGuessArray;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 重置titleView
//    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"商品", @"详情", @"评论", nil]];
//    segmentControl.tintColor = [UIColor whiteColor];
//    segmentControl.frame = CGRectMake(0, 0, 190, 30);
//    segmentControl.selectedSegmentIndex = 0;
//    NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
//                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
//    [segmentControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateNormal];//设置文字属性
//    [segmentControl addTarget:self action:@selector(doSwitchItemAction:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = segmentControl;
//    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
     self.imageUrlArray= [NSMutableArray array];
     self.allCommentArray= [NSMutableArray array];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
 
    _tableView.showsVerticalScrollIndicator=NO;
    // 1.监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productDetailID:) name:@"getProductDetailID"object:nil];

    //获得商品详情属性信息
    self.getPhoneProductStatusRequest=[[FSNetworkManager sharedInstance]getPhoneProductStatusProductID:self.productId networkDelegate:self];
    [self.networkRequestArray addObject:self.getPhoneProductStatusRequest];
    NSLog(@"%@",self.productId);
    
    [[BaseAlert sharedInstance] showLodingWithMessage:@"加载中..."];

    //获得商品评价
    FMNetworkRequest *getProductRatedRequest=[[FSNetworkManager sharedInstance]getProductRatedByProductID:self.productId networkDelegate:self];
    [self.networkRequestArray addObject:getProductRatedRequest];

    
#pragma mark 猜你喜欢
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]guessByIDRequestWitht_user_id:[[GlobalSetting sharedInstance]gUser].t_user_id len:10 networkDelegate:self];//
    [self.networkRequestArray  addObject:request];
    
}


//- (void)doRightItemAction:(UIButton *)button
//{
//    
//    [super doCommonRightItemAction:button];
//    
//}

//- (void)doSwitchItemAction:(UISegmentedControl *)control
//{
//    _queryType = control.selectedSegmentIndex;
//    
//    [_tableView reloadData];
//    
//    switch (control.selectedSegmentIndex) {
//        case 0:
//        {
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
//}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
//    if (_queryType == eProductType) {
    
    
    if (section == 2) {
        
    
        return self.allCommentArray.count>3?4:self.allCommentArray.count+1;
    }
    if (section == 4) {
            return 2;
        }

   return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_queryType == eProductType) {
        // 产品详情cell
    NSInteger section = indexPath.section;
    //    NSInteger row = indexPath.row;
    if (section == 0){
        
        HomeAdCell *cell = [HomeAdCell cellWithTableView:tableView];
        if (self.imageUrlArray.count>0) {
        NSLog(@"%@",self.imageUrlArray);
            cell.AdPageData = self.imageUrlArray;
            cell.delegate = self;
        }
        return cell;
    }
    else if (indexPath.section == 1)
    {
          //            static NSString *cellId = @"ProductDetailCell";
            //            ProductDetailCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
            //
            //            if (caseFieldNotificationCell == nil) {
            //                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailCell" owner:self options:nil];
            //                for(id obj in nib)
            //                {
            //                    if([obj isKindOfClass:[ProductDetailCell class]])
            //                    {
            //                        caseFieldNotificationCell = (ProductDetailCell *)obj;
            //                    }
            //                }
            //
            //                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            //
            //                // cell 复用
            //                [tableView registerNib:[UINib nibWithNibName:@"ProductDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            //
            //            }
            ProductDetailCell *caseFieldNotificationCell = [ProductDetailCell cellWithTableView:tableView];
            [caseFieldNotificationCell customWithModel:self.productDetailStatuesModel];
        
            
            return caseFieldNotificationCell;
        }
        // 产品评论
        else if (indexPath.section == 2)
        {
            
            
            if (indexPath.row==0) {
            static NSString *cellId = @"ProductDetailCommentHeaderCell";
            ProductDetailCommentHeaderCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if (caseFieldNotificationCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailCommentHeaderCell" owner:self options:nil];
                for(id obj in nib)
                {
                    if([obj isKindOfClass:[ProductDetailCommentHeaderCell class]])
                    {
                        caseFieldNotificationCell = (ProductDetailCommentHeaderCell *)obj;
                    }
                }
                
                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                // cell 复用
                [tableView registerNib:[UINib nibWithNibName:@"ProductDetailCommentHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                
            }
            
            return caseFieldNotificationCell;
            
            
            }else{
                
                ProductDetailCommentCell *caseFieldNotificationCell = [ProductDetailCommentCell  cellWithTableView:tableView];
                
                
                if (self.allCommentArray.count>0) {
                    
                    
            [caseFieldNotificationCell customWithModel:self.allCommentArray[indexPath.row-1]];
                }
                
                return caseFieldNotificationCell;
                
        }
        
        }  // 店铺
        else if (indexPath.section == 3)
        {
            static NSString *cellId = @"ProductDetailShopsCell";
            ProductDetailShopsCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if (caseFieldNotificationCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailShopsCell" owner:self options:nil];
                for(id obj in nib)
                {
                    if([obj isKindOfClass:[ProductDetailShopsCell class]])
                    {
                        caseFieldNotificationCell = (ProductDetailShopsCell *)obj;
                    }
                }
                
                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                // cell 复用
                [tableView registerNib:[UINib nibWithNibName:@"ProductDetailShopsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                
            }
            
            caseFieldNotificationCell.parentVC = self;
            
            return caseFieldNotificationCell;
        }
        else if (indexPath.section == 4)
        {
            // 热卖商品头部说明
            if (indexPath.row == 0)
            {
                static NSString *cellId = @"YouMaybeLikeCell";
                YouMaybeLikeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if (caseFieldNotificationCell == nil) {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YouMaybeLikeCell" owner:self options:nil];
                    for(id obj in nib)
                    {
                        if([obj isKindOfClass:[YouMaybeLikeCell class]])
                        {
                            caseFieldNotificationCell = (YouMaybeLikeCell *)obj;
                        }
                    }
                    
                    caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    // cell 复用
                    [tableView registerNib:[UINib nibWithNibName:@"YouMaybeLikeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                    
                }
                
                return caseFieldNotificationCell;
            }
            // 产品图片流
            else
            {
                static NSString *cellId = @"ProductInfoWith3ColumnCell";
                ProductInfoWith3ColumnCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
                
                if (caseFieldNotificationCell == nil) {
                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductInfoWith3ColumnCell" owner:self options:nil];
                    for(id obj in nib)
                    {
                        if([obj isKindOfClass:[ProductInfoWith3ColumnCell class]])
                        {
                            caseFieldNotificationCell = (ProductInfoWith3ColumnCell *)obj;
                        }
                    }
                    
                    caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    // cell 复用
                    [tableView registerNib:[UINib nibWithNibName:@"ProductInfoWith3ColumnCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                    
                }
                caseFieldNotificationCell.youGuessArray =self.youGuessArray;
                caseFieldNotificationCell.parentVC = self;
                
                return caseFieldNotificationCell;
            }
            
        }
   
else{
    return nil;
}
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    if (_queryType == eProductType || _queryType == eCommentType) {
        // 分割View
        UIImageView *sepeartorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        sepeartorView.image = [UIImage imageNamed:@"SepartorLine"];
        return sepeartorView;
//    }
//    else {
//        return nil;
//    }
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
////    if (_queryType == eProductType) {
//        if (section == 0)
//        {
//            
////            AdInfo *adInfo3 = [[AdInfo alloc] init];
////            adInfo3.imageUrl = @"NewAddressContact";
////
//            
//            
////      ProductStatusModel*model = self.productDetailStatuesModel.typeArray[0];
////       NSString*imag = model.t_product_img ;
//        
////            if (_adList && _adList.count > 0)
////            {
//                if (_adView == nil)
//                {
//                    
//                    _adView= [[AdPageView alloc]init];
//                    _adView.delegate = self;
//                    _adView.frame = CGRectMake(0, 0, ScreenWidth, 200);
////
//                   
//                }
//
////              _adView = [[HAdvertiseVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240)];
////                    _adView.delegate = self;
//                
////                }
////            _imageUrlArray= [NSMutableArray array];
////            
////            for (AdInfo*imageModel in _adList) {
////                
////                NSString *imageUrl = [NSString stringWithFormat:@"%@",imageModel.imageUrl];
////                [_imageUrlArray addObject:imageUrl];
////                NSLog(@"image--是%@",imageUrl);
////            }
////
//                          [_adView  setImgNameArr :_adList];
////                [_adView setDataSource:_adList animationDuration:5];
//            
//            }
//            else
//            {
//                _adView = nil;
//            }
//            
//            return _adView;
////        }
////    }
//    
////    return nil;
//}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    if (_queryType == eProductType) {
    if (indexPath.section == 0)
    {
        return  200;
    }
        else if (indexPath.section == 1)
        {
            
            CGFloat productName_H  = [self.userChosedProductStatusModel.t_produce_name  heightWithText:self.userChosedProductStatusModel.t_produce_name font: [UIFont systemFontOfSize:15] width:ScreenWidth-5*2]+10;
            CGFloat productPrice_H  = [ self.userChosedProductStatusModel.t_produce_shop_price  heightWithText:self.userChosedProductStatusModel.t_produce_shop_price font: [UIFont systemFontOfSize:15] width:ScreenWidth-5*2]+10;
            
            CGFloat hight =10+ productName_H+productPrice_H+self.productDetailStatuesModel.cellHight;
         
       
        return  self.userChosedProductStatusModel?hight:200;
        }
        else if (indexPath.section == 2)
        {
            
            if (indexPath.row==0) {
                
                ProductDetailCommentHeaderCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailCommentHeaderCell"];
                
                if (caseFieldNotificationCell)
                {
                    [caseFieldNotificationCell setNeedsUpdateConstraints];
                    [caseFieldNotificationCell updateConstraintsIfNeeded];
                    
                    CGFloat height = caseFieldNotificationCell.height;
                    return height;
                }
                else
                {
                    return 0;
                }
            }else {
                
            if (self.allCommentArray.count>0) {
                
        ProductRated*model=  self.allCommentArray[indexPath.row-1];
                [model  caculateHeight];
                
       CGFloat  height=[model.t_rated_content heightWithText:model.t_rated_content font:[UIFont boldSystemFontOfSize:15.0] width:ScreenWidth-2*8]+40+4*8;
                return height;
            }
            return 0.05;
        }
            }
        else if (indexPath.section == 3)
        {
            return 183;
        }
        else if (indexPath.section == 4)
        {
            if (indexPath.row == 0)
            {
                YouMaybeLikeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:@"YouMaybeLikeCell"];
                
                if (caseFieldNotificationCell)
                {
                    [caseFieldNotificationCell setNeedsUpdateConstraints];
                    [caseFieldNotificationCell updateConstraintsIfNeeded];
                    
                    CGFloat height = caseFieldNotificationCell.height;
                    return height;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                ProductInfoWith3ColumnCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:@"ProductInfoWith3ColumnCell"];
                
                if (caseFieldNotificationCell)
                {
                    [caseFieldNotificationCell setNeedsUpdateConstraints];
                    [caseFieldNotificationCell updateConstraintsIfNeeded];
                    
                    CGFloat height = caseFieldNotificationCell.height;
                    return height;
                }
                else
                {
                    return 0;
                }
            }
        }
        
//    }
//    else if (_queryType == eDetailType)
//    {
        //        DeatailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeatailCell"];
        //
        //        if (cell)
        //        {
        //            [cell setNeedsUpdateConstraints];
        //            [cell updateConstraintsIfNeeded];
        //
        //            CGFloat height = cell.height;
        
        //            return height;
        
//        return self.tableView.height;
//        //        }
//    }
//    else if (_queryType == eCommentType)
//    {
//        if (indexPath.section == 0) {
//            CommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentHeaderCell"];
//            
//            if (cell)
//            {
//                [cell setNeedsUpdateConstraints];
//                [cell updateConstraintsIfNeeded];
//                
//                CGFloat height = cell.height;
//                
//                return height;
//            }
//        }
//        else {
//            
//            
//            ProductsRated*model=  self.commentArray[indexPath.row];
//            [model  caculateHeight];
//            return model.height;
//            //            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
//            //
//            //            if (cell)
//            //            {
//            ////                [cell setNeedsUpdateConstraints];
//            ////                [cell updateConstraintsIfNeeded];
//            //
//            //                CGFloat height = cell.height;
//            //
//            //                return height;
//            //            }
//            
//        }
//    }
    return 0.05;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
////    if (_queryType == eProductType) {
//        if (section == 0)
//        {
////            if (_adList && _adList.count > 0)
////            {
//                return 200;
////            }
//        }
//    }
    
    
    return 0.005;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section ==0||section ==4) {
        return 0.05;
    }
        return 20;
}





#pragma mark - HAdvertiseVIewDelegate
// 点击图片的操作
//- (void)imageClickReturn:(NSNumber *)newsId
//{
//    
//}
//#pragma mark - 加入购物车
//- (IBAction)doAddShoppingCarAction:(id)sender
//{
//    [[BaseAlert sharedInstance]showMessage:@"加载中..."];
//    
//    FMNetworkRequest *request = [[FSNetworkManager sharedInstance] addToShoppingCarRequestWithUserId:[[GlobalSetting sharedInstance] gUser].t_user_id t_produce_id:@"13567487844" t_shop_car_createtime:@"2016-01-22T14:35:37+08:00" t_shop_car_goodsamount:@"322" t_shop_car_id:nil t_shop_car_merchandisediscounts:@"333" t_shop_car_paymentamount:@"222" t_shop_car_purchasequantity:@"3" networkDelegate:self];
//    [self.networkRequestArray addObject:request];
//}

#pragma mark - 网络请求回调
- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance] dismiss];
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getPhoneProductStatus])
    {
    
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
    {
        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
        
        
    }
    }
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    
//    if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_AddToShoppingCar])
//    {
//        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
//        {
//            [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
//        }
//    }
//    else
        if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_getPhoneProductStatus])
    {
        LogInfo(@"%@",fmNetworkRequest.responseData);
        
        //        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductStatusModel class]]){
        //            NSDictionary *dic = fmNetworkRequest.requestData;
        
        self.productStatus = fmNetworkRequest.responseData;
        
        
    self.productDetailStatuesModel =  [self  handleDataWith:self.productStatus];
        
        [[BaseAlert sharedInstance] dismiss];
        
        [self.tableView reloadData];
        
    }
    
    ///商品评价
    //    else
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductRatedByProductId])
    {
        //        NSMutableArray *allcommentArray= [NSMutableArray array];
        //        self.commentArray= [NSMutableArray array];
        
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductRated class]]){
            
            NSMutableArray *allcommentArray= [NSMutableArray array];
            [allcommentArray addObject: fmNetworkRequest.responseData];
            
            self.allCommentArray =allcommentArray;
            [self.tableView reloadData];
//            [self handleCommentDataWithAllcommentArray:allcommentArray];
            
        }
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]){
            
            NSLog(@"%@",fmNetworkRequest.responseData);
               self.allCommentArray =fmNetworkRequest.responseData;
              [self.tableView reloadData];

//            [self handleCommentDataWithAllcommentArray:fmNetworkRequest.responseData];
            
        }
    }
    
    
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_GuessByID]) {
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            [self.youGuessArray addObjectsFromArray:fmNetworkRequest.responseData];
            
            [_tableView  reloadData];
        }
    }
    
    
    
    
//    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductDetial])
//    {
//        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductsRated class]]){
//            
//            self.productDetial=fmNetworkRequest.responseData;
//            
//            
//        }
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
//            [self.tableView reloadData];
//        }
//        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]){
//            
//            self.commentArray = fmNetworkRequest.responseData  ;
//            
//            [self.tableView reloadData];
//        }
//    }
//    
  
    
   

}



//
//
//#pragma mark --分享
//
//- (void)shareClick {
//    //    if (gpDetail.id.length <= 0) {
//    //        return;
//    //    }
//    
//    //    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_BASE, [NSString stringWithFormat:URL_GraphicDetail, gpDetail.id, gpDetail.type]];
//    //
//    //    NSString *titleStr = gpDetail.title;
//    //    NSString *descStr = gpDetail.subTitle;
//    //     UMSocialUrlResource *res = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:[NSString stringWithFormat:@"%@%@", URL_BASE, gpDetail.cover]];
//    NSString *urlStr = @"http://www.baidu.com";
//    NSString *titleStr =@"我是测试数据的";
//    NSString *descStr = @"我是中国瓷砖商城，详细的说我就是说瓷砖老大";
//    UMSocialUrlResource *res = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url: @"http://img1.imgtn.bdimg.com/it/u=524667967,2954926626&fm=206&gp=0.jpg"];
//    
//    
//    
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStr;
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = titleStr;
//    [UMSocialData defaultData].extConfig.wechatSessionData.urlResource = res;
//    
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = titleStr;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.urlResource = res;
//    
//    [UMSocialData defaultData].extConfig.qqData.urlResource = res;
//    [UMSocialData defaultData].extConfig.qqData.url = urlStr;
//    [UMSocialData defaultData].extConfig.qqData.title = titleStr;
//    
//    [UMSocialData defaultData].extConfig.qzoneData.url = urlStr;
//    [UMSocialData defaultData].extConfig.qzoneData.title = titleStr;
//    [UMSocialData defaultData].extConfig.qzoneData.urlResource = res;
//    
//    UMSocialTencentData * tencentData = [[UMSocialTencentData alloc] init];
//    tencentData.urlResource = res;
//    tencentData.title = titleStr;
//    tencentData.shareText = [NSString stringWithFormat:@"%@\n%@",descStr.length > 0? descStr: @"", urlStr];
//    [UMSocialData defaultData].extConfig.tencentData = tencentData;
//    
//    [UMSocialData defaultData].extConfig.smsData.urlResource = res;
//    [UMSocialData defaultData].extConfig.smsData.shareText = [NSString stringWithFormat:@"%@\n%@\n%@", titleStr, descStr.length > 0? descStr: @"", urlStr];
//    
//    [UMSocialData defaultData].extConfig.emailData.title = titleStr;
//    [UMSocialData defaultData].extConfig.emailData.urlResource = res;
//    [UMSocialData defaultData].extConfig.emailData.shareText = [NSString stringWithFormat:@"%@\n%@",descStr.length > 0? descStr: @"", urlStr];
//    
//    //点击分享
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UmengAppkey
//                                      shareText: [NSString stringWithFormat:@"%@\n%@",descStr.length > 0? descStr: @"", urlStr] shareImage:[UIImage imageNamed:@"icon"]shareToSnsNames:[NSArray arrayWithObjects:UMShareToTencent,UMShareToWechatTimeline, UMShareToWechatSession, UMShareToQQ, UMShareToQzone, UMShareToSms, UMShareToEmail, nil]
//                                       delegate:self];//UMShareToSina,
//}
//
//#pragma mark -UMSocialUIDelegate
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
//    if (response.responseCode == UMSResponseCodeSuccess) {
//        [[BaseAlert sharedInstance] showMessage:@"分享成功"];
//    }else {
//        [[BaseAlert sharedInstance] showMessage:response.message];
//    }
//}
//
//
//
//
//
//
//


#pragma mark -图片浏览器
- (void)showImage:(NSUInteger)index{

    self.photos = [NSMutableArray array];

    
    for (NSString*urlStr in self.imageUrlArray) {
         [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:urlStr]]];
    }
    

BOOL displayActionButton = NO;
BOOL displaySelectionButtons = NO;
BOOL displayNavArrows = YES;
BOOL enableGrid = YES;
BOOL startOnGrid = NO;

MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
browser.displayActionButton = displayActionButton;//分享按钮,默认是
browser.displayNavArrows = displayNavArrows;//左右分页切换,默认否
browser.displaySelectionButtons = displaySelectionButtons;//是否显示选择按钮在图片上,默认否
browser.alwaysShowControls = displaySelectionButtons;//控制条件控件 是否显示,默认否
browser.zoomPhotosToFill = YES;//是否全屏,默认是
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
browser.wantsFullScreenLayout = YES;//是否全屏
#endif
browser.enableGrid = enableGrid;//是否允许用网格查看所有图片,默认是
browser.startOnGrid = startOnGrid;//是否第一张,默认否
browser.enableSwipeToDismiss = YES;
[browser showNextPhotoAnimated:YES];
[browser showPreviousPhotoAnimated:YES];
[browser setCurrentPhotoIndex:index];
//browser.photoTitles = @[@"000",@"111",@"222",@"333"];//标题

[self.navigationController pushViewController:browser animated:NO];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id )photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}


#pragma mark --计算cell的高度
-(CGFloat)singTypeViewHightBysource:(NSArray *)arr
{
    float upX = 10;
    float upY = 40;
    for (int i = 0; i<arr.count; i++) {
        NSString *str = [arr objectAtIndex:i] ;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
        CGSize size = [str sizeWithAttributes:dic];
        //NSLog(@"%f",size.height);
        if ( upX > (self.view.frame.size.width-20 -size.width-35)) {
            
            upX = 10;
            upY += 30;
        }
        
        upX+=size.width+35;
    }
    
    upY +=30;
    
    return upY+11;
}


#pragma mark -商品详情选择视图操作



//#pragma mark-method
//-(void)initview
//{
//    /**
//     *  商品信息页面内容
//     */
//    
//    
//    UIButton *btn_add= [UIButton buttonWithType:UIButtonTypeCustom];
//    btn_add.frame = CGRectMake(100, 80,200, 50);
//    [btn_add setTitleColor:[UIColor whiteColor] forState:0];
//    btn_add.titleLabel.font = [UIFont systemFontOfSize:20];
//    [btn_add setTitle:@"加入购物车" forState:0];
//    btn_add.backgroundColor = [UIColor redColor];
//    btn_add.layer.cornerRadius = 4;
//    btn_add.layer.borderColor = [UIColor clearColor].CGColor;
//    btn_add.layer.borderWidth = 1;
//    [btn_add.layer setMasksToBounds:YES];
//    [btn_add addTarget:self action:@selector(btnselete) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn_add];
//    //
////    [self initChoseView];
//}
/**
 *  初始化弹出视图
// */
//-(void)initChoseView
//{
//    
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    //选择尺码颜色的视图
//    choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
//    [window addSubview:choseView];
//    
//    //尺码
//    choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, choseView.frame.size.width, 50) andDatasource:sizearr :@"尺码"];
//    choseView.sizeView.delegate = self;
//    [choseView.mainscrollview addSubview:choseView.sizeView];
//    choseView.sizeView.frame = CGRectMake(0, 0, choseView.frame.size.width, choseView.sizeView.height);
//    //颜色分类
//    choseView.colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, 50) andDatasource:colorarr :@"颜色分类"];
//    choseView.colorView.delegate = self;
//    [choseView.mainscrollview addSubview:choseView.colorView];
//    choseView.colorView.frame = CGRectMake(0, choseView.sizeView.frame.size.height, choseView.frame.size.width, choseView.colorView.height);
//    //购买数量
//    choseView.countView.frame = CGRectMake(0, choseView.colorView.frame.size.height+choseView.colorView.frame.origin.y, choseView.frame.size.width, 50);
//    choseView.mainscrollview.contentSize = CGSizeMake(self.view.frame.size.width, choseView.countView.frame.size.height+choseView.countView.frame.origin.y);
//    
//    choseView.lb_price.text = @"¥100";
//    choseView.lb_stock.text = @"库存100000件";
//    choseView.lb_detail.text = @"请选择 尺码 颜色分类";
//    [choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [choseView.bt_sure addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    
//    //点击黑色透明视图choseView会消失
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//    [choseView.alphaiView addGestureRecognizer:tap];
//    //点击图片放大图片
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
//    choseView.img.userInteractionEnabled = YES;
//    [choseView.img addGestureRecognizer:tap1];
//}
/**
 *  此处嵌入浏览图片代码
 */

- (void)homeADPageClick:(NSString*)url index:(int)index{

    [self showImage:index];
    NSLog(@"放大图片");
    
}

//-(void)showBigImage:(UITapGestureRecognizer *)tap
//{
//    NSLog(@"放大图片");
//}
/**
 *  点击按钮弹出
 */
//-(void)btnselete
//{
//    
//    [UIView animateWithDuration: 0.35 animations: ^{
//        //        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
//        //        bgview.center = CGPointMake(self.view.center.x, self.view.center.y-50);
//        choseView.center = self.view.center;
//        choseView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    } completion: nil];
//    
//    
//}
///**
// *  点击半透明部分或者取消按钮，弹出视图消失
// */
//-(void)dismiss
//{
//    center.y = center.y+self.view.frame.size.height;
//    [UIView animateWithDuration: 0.35 animations: ^{
//        choseView.frame =CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
//        
//        //        bgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//        //        bgview.center = self.view.center;
//    } completion: nil];
//    
////}
//#pragma mark-typedelegete
//-(void)btnindex:(int)tag
//{
//    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
//    if (choseView.sizeView.seletIndex >=0&&choseView.colorView.seletIndex >=0) {
//        //尺码和颜色都选择的时候
//        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
//        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
//        choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[stockarr objectForKey: size] objectForKey:color]];
//        choseView.lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
//        choseView.stock =[[[stockarr objectForKey: size] objectForKey:color] intValue];
//        
//        [self reloadTypeBtn:[stockarr objectForKey:size] :colorarr :choseView.colorView];
//        [self reloadTypeBtn:[stockarr objectForKey:color] :sizearr :choseView.sizeView];
//        NSLog(@"%d",choseView.colorView.seletIndex);
//        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
//    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex == -1)
//    {
//        //尺码和颜色都没选的时候
//        choseView.lb_price.text = @"¥100";
//        choseView.lb_stock.text = @"库存100000件";
//        choseView.lb_detail.text = @"请选择 尺码 颜色分类";
//        choseView.stock = 100000;
//        //全部恢复可点击状态
//        [self resumeBtn:colorarr :choseView.colorView];
//        [self resumeBtn:sizearr :choseView.sizeView];
//        
//    }else if (choseView.sizeView.seletIndex ==-1&&choseView.colorView.seletIndex >= 0)
//    {
//        //只选了颜色
//        NSString *color =[colorarr objectAtIndex:choseView.colorView.seletIndex];
//        //根据所选颜色 取出该颜色对应所有尺码的库存字典
//        NSDictionary *dic = [stockarr objectForKey:color];
//        [self reloadTypeBtn:dic :sizearr :choseView.sizeView];
//        [self resumeBtn:colorarr :choseView.colorView];
//        choseView.lb_stock.text = @"库存100000件";
//        choseView.lb_detail.text = @"请选择 尺码";
//        choseView.stock = 100000;
//        
//        choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",choseView.colorView.seletIndex+1]];
//    }else if (choseView.sizeView.seletIndex >= 0&&choseView.colorView.seletIndex == -1)
//    {
//        //只选了尺码
//        NSString *size =[sizearr objectAtIndex:choseView.sizeView.seletIndex];
//        //根据所选尺码 取出该尺码对应所有颜色的库存字典
//        NSDictionary *dic = [stockarr objectForKey:size];
//        [self resumeBtn:sizearr :choseView.sizeView];
//        [self reloadTypeBtn:dic :colorarr :choseView.colorView];
//        choseView.lb_stock.text = @"库存100000件";
//        choseView.lb_detail.text = @"请选择 颜色分类";
//        choseView.stock = 100000;
//        
//        //        for (int i = 0; i<colorarr.count; i++) {
//        //            int count = [[dic objectForKey:[colorarr objectAtIndex:i]] intValue];
//        //            //遍历颜色字典 库存为零则改尺码按钮不能点击
//        //            if (count == 0) {
//        //                UIButton *btn =(UIButton *) [choseView.colorView viewWithTag:100+i];
//        //                btn.enabled = NO;
//        //            }
//        //        }
//        
//    }
//}
////恢复按钮的原始状态
//-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
//{
//    for (int i = 0; i< arr.count; i++) {
//        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
//        btn.enabled = YES;
//        btn.selected = NO;
//        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
//        [btn setTitleColor:[UIColor blackColor] forState:0];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        if (view.seletIndex == i) {
//            btn.selected = YES;
//            [btn setBackgroundColor:[UIColor redColor]];
//        }
//    }
//}
////根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
//-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
//{
//    for (int i = 0; i<arr.count; i++) {
//        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
//        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
//        btn.selected = NO;
//        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
//        //库存为零 不可点击
//        if (count == 0) {
//            btn.enabled = NO;
//            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
//        }else
//        {
//            btn.enabled = YES;
//            [btn setTitleColor:[UIColor blackColor] forState:0];
//        }
//        //根据seletIndex 确定用户当前点了那个按钮
//        if (view.seletIndex == i) {
//            btn.selected = YES;
//            [btn setBackgroundColor:[UIColor redColor]];
//        }
//    }
//}

//备备注！！！！*************************
//需要所有分类规格的数组
//和所有分类规格的  key --value ,key是属性值。value是按钮对应tag
//这字典和数组的一一对应。
- (ProductDetailStatuesModel*)handleDataWith:(NSMutableArray *)typeArray {

    
     NSMutableSet *product_first_type_value_Set   =  [[NSMutableSet alloc]init];
     NSMutableSet *product_second_type_value_Set  =  [[NSMutableSet alloc]init];
     NSMutableSet *product_thread_type_value_Set  =  [[NSMutableSet alloc]init];
    for (ProductStatusModel*model in typeArray) {
        
        if (!IsStrEmpty(model.t_product_first_type_value)) {
             [product_first_type_value_Set addObject:         model.t_product_first_type_value];
        }
       

        if (!IsStrEmpty(model.t_product_second_type_value)) {
            [product_second_type_value_Set addObject:       model.t_product_second_type_value];
            
        }if (!IsStrEmpty(model.t_product_thread_type_value)) {
            
            [product_thread_type_value_Set addObject:       model.t_product_thread_type_value];
            
        }

    }

        NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
        //一级属性
        NSArray *product_first_type_value_array = [product_first_type_value_Set sortedArrayUsingDescriptors:sortDesc];
        //二级属性
        NSArray *product_second_type_value_array = [product_second_type_value_Set sortedArrayUsingDescriptors:sortDesc];
        //三级属性
        NSArray *product_thread_type_value_array = [product_thread_type_value_Set sortedArrayUsingDescriptors:sortDesc];
        
        
        //一级属性key -value
        NSMutableDictionary *product_first_type_value_dic = [NSMutableDictionary dictionary];
        //一级属性key -value
        NSMutableDictionary *product_second_type_value_dic = [NSMutableDictionary dictionary];
        //一级属性key -value
        NSMutableDictionary *product_thread_type_value_dic = [NSMutableDictionary dictionary];
        
        
        for (int i = 0; i< product_first_type_value_array.count; i++) {
             
        [product_first_type_value_dic setValue:@(i) forKey:product_first_type_value_array[i]];
         }
        
        
        for (int i = 0; i< product_second_type_value_array.count; i++) {
            
            [product_second_type_value_dic setValue:@(i) forKey:product_second_type_value_array[i]];
        }
        
        for (int i = 0; i< product_thread_type_value_array.count; i++) {
            
            [product_thread_type_value_dic setValue:@(i) forKey:product_thread_type_value_array[i]];
        }
        

    ProductDetailStatuesModel*model = [[ProductDetailStatuesModel alloc]init];
    model.product_first_type_value_dic = product_first_type_value_dic;
    model.product_second_type_value_dic = product_second_type_value_dic;
    model.product_thread_type_value_dic =product_thread_type_value_dic;
    
    model.product_first_type_value_array = product_first_type_value_array;
    model.product_second_type_value_array = product_second_type_value_array;
    model.product_thread_type_value_array = product_thread_type_value_array;
    model.typeArray = typeArray;
    
    
    CGFloat typecolor;
    CGFloat typesize;
    CGFloat typethread;
    
    if (model.product_first_type_value_array.count>0) {
      typecolor =   [self  singTypeViewHightBysource:product_first_type_value_array];
    }
    if (model.product_second_type_value_array.count>0) {
      typesize = [self singTypeViewHightBysource:product_second_type_value_array];
    }
    
    if (model.product_thread_type_value_array.count>0) {
        
      typethread =[self  singTypeViewHightBysource:product_thread_type_value_array];
    }
    //这里只是出了标题和价格以外的高度。还需要加上标题价格和2个间隙才是真的高度
     model.cellHight = typecolor+typethread+typesize+50+30;
    
    return model;

}
/////默认进去页面是情况，
//-(void)test{
//
//    ProductStatusModel*model = [[ProductStatusModel alloc]init];
//        NSArray *typeArray = @[model,model,model,model,model,model,model,model];
//    
//    NSMutableArray *secondTypeArray = [NSMutableArray array];
//    NSMutableArray *thirdTypeArray  = [NSMutableArray array];
//  //
//    ProductStatusModel *chosesFirstModel = typeArray[0];
//    
//    ///进入页面多规格产品，都会在个属性下默认选择一个属性值
//    NSString *firstChocedValue  = chosesFirstModel.t_product_first_type_value;
//    NSString *secondChocedValue = chosesFirstModel.t_product_second_type_value;
//    NSString *thirdChocedValue  = chosesFirstModel.t_product_thread_type_value;
//    
//    
//    ///  1---2---3
//    for (ProductStatusModel*model in typeArray) {
//        //如果一级属性值相同的话，把二级属性值加到一个数组中
//        if ([model.t_product_first_type_value isEqualToString:firstChocedValue]) {
//          //  把二级属性值加到一个数组中,得到二级属性值可用数组
//            [secondTypeArray addObject:model.t_product_second_type_value];
//            
//        }
//        
//             //如果一，二级属性值相同的话，把三级属性值加到一个数组中
//        if ([model.t_product_first_type_value isEqualToString:firstChocedValue]&&[model.t_product_second_type_value isEqualToString:secondChocedValue]) {
//            //  把三级属性值加到一个数组中,得到三级属性值可用数组
//            [thirdTypeArray addObject:model.t_product_thread_type_value];
//            
//        }
//   
//    }
//
//}
//
//
//
//
//
//
//
///*
// 一级属性是必选！！！
// 默认进去页面后，自行选择改变一种规格属性，一级属性优先极高，
// 第一种情况:  选择一级属性，和test1情况一样，
// 第二种情况:  选择二级属性，一级属性优先高，最后是三级属性
// 
// 综合第一二三的情况，这2个可以归纳为一种
// 第三种情况:  选择三级属性，一级属性优先高，最后是二级属性
// 
// */
//-(void)test2{
//    
//    ProductStatusModel*model = [[ProductStatusModel alloc]init];
//    NSArray *typeArray = @[model,model,model,model,model,model,model,model];
//    
//    NSMutableArray *secondTypeArray = [NSMutableArray array];
//    NSMutableArray *thirdTypeArray = [NSMutableArray array];
//    
//    ///进入页面多规格产品，都会在个属性下默认选择一个属性值
//    NSString *firstChocedValue  =  @"红色";
//    NSString *secondChocedValue =  @"大的";
//    NSString *thirdChocedValue  =  @"重的";
//    
//    
//    ///  1---2---3
//    for (ProductStatusModel*model in typeArray) {
//        //如果一级属性值相同的话，把二级属性值加到一个数组中
//        if ([model.t_product_first_type_value isEqualToString:firstChocedValue]) {
//            //  把二级属性值加到一个数组中,得到二级属性值可用数组
//            [secondTypeArray addObject:model.t_product_second_type_value];
//            
//        }
//        
//        //如果一，二级属性值相同的话，把三级属性值加到一个数组中
//        if ([model.t_product_first_type_value isEqualToString:firstChocedValue]&[model.t_product_second_type_value isEqualToString:secondChocedValue]) {
//            //  把三级属性值加到一个数组中,得到三级属性值可用数组
//            [thirdTypeArray addObject:model.t_product_thread_type_value];
//            
//        }
//        
//    }
//    
//  
//}
//
//
//
//


//****************************************************************



//备备注！！！！*************************
//需要所有分类规格的数组
//和所有分类规格的  key --value ,key是属性值。value是按钮对应tag
//这字典和数组的一一对应。

//tag 是上级属性的值
//typeValueArray是本组属性所有列表、


//
//
////选择一级属性下，二级属性列表操作
//- (void)choeseFirstType:(NSInteger) tag withFirstTypeValueArray:(NSArray*)firstTypeArray secondTypedic:(NSDictionary*)secondTypedic allArray:(NSArray*)allArray  :(TypeView *)view{
//
//     NSString *firstChocedValue   = firstTypeArray[tag];
//    
//     for (int i = 0; i<allArray.count; i++) {
//         
//         ProductStatusModel*model =allArray[i];
//        //如果一级属性值相同的话，
//    if ([model.t_product_first_type_value isEqualToString:firstChocedValue]) {
//
//        ///取出可选按钮tag
//        NSInteger btntag = [[secondTypedic objectForKey:model.t_product_second_type_value] intValue];
//        
//        UIButton *btn =(UIButton *)[view viewWithTag:btntag];
//        //设置按钮未选中状态
//        btn.selected = NO;
//        //设置可以选择按钮颜色
//       [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
//        
//        }
//
//        
//  
//     }
//
//}
//    
//         //选择一级和二级属性下，三级属性列表操作
//- (void)choesefirstType:(NSInteger) firstTag secondType:(NSInteger) secondTag  firstTypeValueArray:(NSArray*)firstTypeArray SecondTypeValueArray:(NSArray*)secondTypeArray thirdTypedic:(NSDictionary*)thirdTypedic allArray:(NSArray*)allArray  :(TypeView *)view{
//             
//               NSString *firstChocedValue      =  firstTypeArray[firstTag];
//               NSString *secondChocedValue     =  secondTypeArray[secondTag];
//             for (int i = 0; i<allArray.count; i++) {
//                 
//             ProductStatusModel*model =allArray[i];
//                 //如果一级属性值相同的话，
//    if ([model.t_product_first_type_value isEqualToString:firstChocedValue]&&[model.t_product_second_type_value isEqualToString:secondChocedValue]) {
//                     
//                     ///取出可选按钮tag
//                     NSInteger btntag = [[thirdTypedic objectForKey:model.t_product_thread_type_value] intValue];
//                     
//                     UIButton *btn =(UIButton *)[view viewWithTag:btntag];
//                     //设置按钮未选中状态
//                     btn.selected = NO;
//                     //设置可以选择按钮颜色
//                     [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
//        
//                 }
//                 
//                 
//             }
//
//
//}




#pragma mark --获取某一组图片数据，图片处理

-(NSMutableArray*)handlePictureArrayWith:(NSString*)pictStr {
    NSLog(@"%@",pictStr);
    NSArray *array = [pictStr componentsSeparatedByString:@"|"];
    NSMutableArray *usedArray = [NSMutableArray array];

    for (NSString*pic in array) {
        if ((!IsStrEmpty(pic)&&[pic hasSuffix:@".jpg"])||(!IsStrEmpty(pic)&&[pic hasSuffix:@".png"])) {
        
               NSString *picUrl = [pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            [usedArray addObject: picUrl];
        }
    }

    return usedArray;
}


//#pragma mark --接受通知--获取商品详情id
//-(void)getAllCommentArray:(NSNotification*)notification{
//    
//    NSLog(@"%@",notification.userInfo[@"AllCommentArray"]);
//    self.allCommentArray =notification.userInfo[@"AllCommentArray"];
//    [self.tableView reloadData];
//
//}


#pragma mark --接受通知--获取商品详情id
-(void)productDetailID:(NSNotification*)notification{
    
    NSLog(@"%@",notification.userInfo[@"productDetailID"]);
    self.productDetailID =notification.userInfo[@"productDetailID"];
    
   
    self.userChosedProductStatusModel =notification.userInfo[@"productStatueModel"];

    self.imageUrlArray = [self handlePictureArrayWith:self.userChosedProductStatusModel.t_product_img];
    NSLog(@"---:%@",self.imageUrlArray);
    
     [self.tableView reloadData];

}

@end
