//
//  ProductDetailShowVC.m
//  JuWuBaMall
//
//  Created by yanghua on 16/5/1.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductDetailShowVC.h"
#import "ProductDetialModel.h"
#import "ProductRated.h"

//
//  ProductDetailVC.m
//  JuWuBaMall
//
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


#import "ProductDetailCommentVC.h"
#import "ProductDetailShowVC.h"

#import "HorizonalTableViewController.h"
 @interface ProductDetailShowVC ()<UITableViewDelegate, UITableViewDataSource, HAdvertiseVIewDelegate,UMSocialUIDelegate,UITextFieldDelegate,TypeSeleteDelegete>
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
@property (nonatomic, strong) HAdvertiseVIew *adView;           // 广告视图

@property (nonatomic, strong) NSMutableArray *deatailImageArray;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSMutableArray *statusArr;//属性数值


//具体的详情图文;
@property (nonatomic, strong)ProductDetialModel *productDetial;

//详情图文数组
@property (nonatomic, strong)NSMutableArray *productDetialArray;

@property (copy, nonatomic) NSString*lastProductDetailID;//用于记录上次点击选择的详情id.
@property (nonatomic, strong)FMNetworkRequest *getProductDetailRequest;
@end




@implementation ProductDetailShowVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    
//    
//    
//    
//}


//-(UIWebView *)detailView{
//    if(!_detailView){
//        _detailView = [[UIWebView alloc]init];
//        [self.view addSubview:_detailView];
//    }
//    return _detailView;
//    
//    
//}

//
//- (void)customWithModel:(ProductDetialModel *)model{
//    
//    LogInfo(@"%@",model.t_produce_details);
//    NSString*  htmlstr = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"></head><body>%@</body></html>",model.t_produce_details];
//    [self.detailView loadHTMLString:htmlstr baseURL:[NSURL URLWithString:KHostUrl]];
//}
////
////
////
//#pragma mark - 网络请求回调
//- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
//{
//    [[BaseAlert sharedInstance] dismiss];
//    
//    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]])
//    {
//        [[BaseAlert sharedInstance] showMessage:fmNetworkRequest.responseData];
//    }
//}
//
//- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
//{
//    [[BaseAlert sharedInstance] dismiss];
//    
// if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductDetial])
//    {
//        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductsRated class]]){
//            
//            self.productDetial=fmNetworkRequest.responseData;
//            
//            
//        }
//        
//    }
//    
//    
//    
//    
//}
//














- (instancetype)init
{
    self = [super init];
    if (self) {
        // 1.监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productDetailID:) name:@"getProductDetailID"object:nil];
        
        
    }
    return self;
}
- (void)dealloc
{
  [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[FSNetworkManager sharedInstance] cancelNetworkRequest:self.getProductDetailRequest];
}

- (NSMutableArray *)statusArr
{
    if (!_statusArr) {
        _statusArr = [NSMutableArray array];
    }
    return _statusArr;
}


-(NSMutableArray *)productDetialArray{
    
    
    if (!_productDetialArray) {
        _productDetialArray = [NSMutableArray array];
    }
    return _productDetialArray;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
       }


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//self.productId? self.productId :@"@"99f1802b-93ea-4dd0-b2ef-b99252255a6e""
//        //获得商品详情信息
   self.getProductDetailRequest=[[FSNetworkManager sharedInstance]getProductDetailWithProductID:self.productId  networkDelegate:self];
    [self.networkRequestArray addObject:self.getProductDetailRequest];
    

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (_queryType == eProductType) {
//        return 4;
//    }
//    else if (_queryType == eDetailType) {
//        return 1;
//    }
//    else if (_queryType == eCommentType) {
//        return 1+_commentArray.count;
//    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
//    if (_queryType == eProductType) {
//        if (section == 3) {
//            return 2;
//        }
//    }
//    else if (_queryType == eDetailType) {
//        return 1;
//    }
//    
//    else if (_queryType == eCommentType) {
//        return 1;
//        
//    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    if (_queryType == eProductType) {
//        // 产品详情cell
//        if (indexPath.section == 0)
//        {
//            //            static NSString *cellId = @"ProductDetailCell";
//            //            ProductDetailCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
//            //
//            //            if (caseFieldNotificationCell == nil) {
//            //                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailCell" owner:self options:nil];
//            //                for(id obj in nib)
//            //                {
//            //                    if([obj isKindOfClass:[ProductDetailCell class]])
//            //                    {
//            //                        caseFieldNotificationCell = (ProductDetailCell *)obj;
//            //                    }
//            //                }
//            //
//            //                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            //
//            //                // cell 复用
//            //                [tableView registerNib:[UINib nibWithNibName:@"ProductDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
//            //
//            //            }
//            ProductDetailCell *caseFieldNotificationCell = [ProductDetailCell cellWithTableView:tableView];
//            [caseFieldNotificationCell customWithModel:self.productStatus];
//            
//            
//            return caseFieldNotificationCell;
//        }
//        // 产品评论
//        else if (indexPath.section == 1)
//        {
//            static NSString *cellId = @"ProductDetailCommentCell";
//            ProductDetailCommentCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
//            
//            if (caseFieldNotificationCell == nil) {
//                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailCommentCell" owner:self options:nil];
//                for(id obj in nib)
//                {
//                    if([obj isKindOfClass:[ProductDetailCommentCell class]])
//                    {
//                        caseFieldNotificationCell = (ProductDetailCommentCell *)obj;
//                    }
//                }
//                
//                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                
//                // cell 复用
//                [tableView registerNib:[UINib nibWithNibName:@"ProductDetailCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
//                
//            }
//            
//            return caseFieldNotificationCell;
//        }
//        
//        // 店铺
//        else if (indexPath.section == 2)
//        {
//            static NSString *cellId = @"ProductDetailShopsCell";
//            ProductDetailShopsCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
//            
//            if (caseFieldNotificationCell == nil) {
//                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailShopsCell" owner:self options:nil];
//                for(id obj in nib)
//                {
//                    if([obj isKindOfClass:[ProductDetailShopsCell class]])
//                    {
//                        caseFieldNotificationCell = (ProductDetailShopsCell *)obj;
//                    }
//                }
//                
//                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                
//                // cell 复用
//                [tableView registerNib:[UINib nibWithNibName:@"ProductDetailShopsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
//                
//            }
//            
//            caseFieldNotificationCell.parentVC = self;
//            
//            return caseFieldNotificationCell;
//        }
//        else if (indexPath.section == 3)
//        {
//            // 热卖商品头部说明
//            if (indexPath.row == 0)
//            {
//                static NSString *cellId = @"YouMaybeLikeCell";
//                YouMaybeLikeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
//                
//                if (caseFieldNotificationCell == nil) {
//                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YouMaybeLikeCell" owner:self options:nil];
//                    for(id obj in nib)
//                    {
//                        if([obj isKindOfClass:[YouMaybeLikeCell class]])
//                        {
//                            caseFieldNotificationCell = (YouMaybeLikeCell *)obj;
//                        }
//                    }
//                    
//                    caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                    
//                    // cell 复用
//                    [tableView registerNib:[UINib nibWithNibName:@"YouMaybeLikeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
//                    
//                }
//                
//                return caseFieldNotificationCell;
//            }
//            // 产品图片流
//            else
//            {
//                static NSString *cellId = @"ProductInfoWith3ColumnCell";
//                ProductInfoWith3ColumnCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
//                
//                if (caseFieldNotificationCell == nil) {
//                    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductInfoWith3ColumnCell" owner:self options:nil];
//                    for(id obj in nib)
//                    {
//                        if([obj isKindOfClass:[ProductInfoWith3ColumnCell class]])
//                        {
//                            caseFieldNotificationCell = (ProductInfoWith3ColumnCell *)obj;
//                        }
//                    }
//                    
//                    caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                    
//                    // cell 复用
//                    [tableView registerNib:[UINib nibWithNibName:@"ProductInfoWith3ColumnCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
//                    
//                }
//                
//                caseFieldNotificationCell.parentVC = self;
//                
//                return caseFieldNotificationCell;
//            }
//            
//        }
//    }
//    else if (_queryType == eDetailType) {

        DeatailCell *caseFieldNotificationCell = [DeatailCell  cellWithTableView:tableView];
        caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [ caseFieldNotificationCell customWithModel:self.productDetial];
        
        return caseFieldNotificationCell;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//    if (_queryType == eProductType || _queryType == eCommentType) {
//        // 分割View
//        UIImageView *sepeartorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//        sepeartorView.image = [UIImage imageNamed:@"SepartorLine"];
//        return sepeartorView;
//    }
//    else {
        return nil;
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (_queryType == eProductType) {
//        if (section == 0)
//        {
//            if (_adList && _adList.count > 0)
//            {
//                if (_adView == nil)
//                {
//                    _adView = [[HAdvertiseVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 240)];
//                    _adView.delegate = self;
//                    
//                }
//                
//                [_adView setDataSource:_adList animationDuration:5];
//                
//            }
//            else
//            {
//                _adView = nil;
//            }
//            
//            return _adView;
//        }
//    }
//    
    return nil;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

        return self.tableView.height;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (_queryType == eProductType) {
//        if (section == 0)
//        {
//            if (_adList && _adList.count > 0)
//            {
//                return 240;
//            }
//        }
//    }
    
    
    return 0.005;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
//    if (_queryType == eProductType || _queryType == eCommentType) {
//        return 20;
//    }
    
    return 0.005;
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

        if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductDetial]){
      
            if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductDetialModel class]]){
              [self.productDetialArray  removeAllObjects];
              [self.productDetialArray  addObject:fmNetworkRequest.responseData];
            
                
                 [self showProductDetial];
        }
        
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]){
            
            self.productDetialArray=fmNetworkRequest.responseData;
            NSLog(@"%@", self.productDetialArray);
            
            [self showProductDetial];
//           self.productDetial= self.productDetialArray[0];
//            [self.tableView reloadData];
            
        }
    }

    
}


-(void)showProductDetial{
    
    if (!IsStrEmpty(self.productDetailID)) {
       
        
        
        for (ProductDetialModel*object in  self.productDetialArray) {
            
            
            if ([object.t_product_detail_id isEqualToString: self.productDetailID]) {
                
                
                
                self.productDetial= object;
                [self.tableView reloadData];
            }
            
        }
        
    }
}

#pragma mark --获取商品详情id
-(void)productDetailID:(NSNotification*)notification{
    
//    self.userChosedProductStatusModel =notification.userInfo[@"productStatueModel"];
    self.productDetailID =notification.userInfo[@"productDetailID"];
     NSLog(@"productDetailID --%@",self.productDetailID);
    NSLog(@"self.productDetialArray --%@",self.productDetialArray);
    
    for (ProductDetialModel*object in  self.productDetialArray) {
      
        
        if ([object.t_product_detail_id isEqualToString: self.productDetailID]) {
         
            
            if (![self.productDetailID isEqualToString:self.lastProductDetailID]) {
               
                  self.productDetial= object;
                  self.lastProductDetailID =self.productDetailID;
                 [self.tableView reloadData];
                }
            
        }
    
    }


    
}





@end
