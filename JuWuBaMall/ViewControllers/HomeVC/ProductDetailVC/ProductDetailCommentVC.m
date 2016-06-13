//
//  ProductDetailCommentVC.m
//  JuWuBaMall
//
//  Created by yanghua on 16/5/1.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductDetailCommentVC.h"


#import "CommentHeadMode.h"

#import "ProductDetailVC.h"
#import "ProductDetailCell.h"
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
@interface ProductDetailCommentVC ()<UITableViewDelegate, UITableViewDataSource, HAdvertiseVIewDelegate,UMSocialUIDelegate,UITextFieldDelegate,TypeSeleteDelegete,CommentHeaderCellDelegate>
{
    
    UIView *bgview;
    CGPoint center;
    NSArray *sizearr;//型号数组
    NSArray *colorarr;//分类数组
    NSDictionary *stockarr;//商品库存量
    int goodsStock;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//
//@property (nonatomic, strong) NSMutableArray *adList;               // 广告数据
//@property (nonatomic, strong) HAdvertiseVIew *adView;           // 广告视图
//
//@property (nonatomic, strong) NSMutableArray *deatailImageArray;
//@property (nonatomic, strong) NSMutableArray *commentArray;//所有评论情况的评论数组，保护每个水平的
////当前评论数组
@property (nonatomic, strong) NSMutableArray *currentCommentArray;
//@property (nonatomic, strong) NSMutableArray *statusArr;//属性数值
//
@property (nonatomic, strong) CommentHeadMode*commentHeadModel;
////详情图文
//@property (nonatomic, strong)ProductDetialModel *productDetial;
//
////商品详情属性
//@property (nonatomic, strong)NSMutableArray *productStatus;
@end

@implementation ProductDetailCommentVC



- (void)dealloc
{
   
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

    //    //获得商品评价
    FMNetworkRequest *getProductRatedRequest=[[FSNetworkManager sharedInstance]getProductRatedByProductID:self.productId ?self.productId:@"b7657483-c46d-48a2-bb2c-b9177dc4bae6" networkDelegate:self];
    [self.networkRequestArray addObject:getProductRatedRequest];
    
    
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1+self.currentCommentArray .count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
        return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellId = @"CommentHeaderCell";
        CommentHeaderCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentHeaderCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[CommentHeaderCell class]])
                {
                    caseFieldNotificationCell = (CommentHeaderCell *)obj;
                }
            }
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"CommentHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            
        }  caseFieldNotificationCell.delegate=self;
          [ caseFieldNotificationCell customWithData:self.commentHeadModel];
        return caseFieldNotificationCell;
        
    }
    else {
       
        CommentCell *caseFieldNotificationCell = [CommentCell  cellWithTableView:tableView];
        
        
        if (self.currentCommentArray.count>0) {
            
        
        [caseFieldNotificationCell customWithModel:self.currentCommentArray[indexPath.section-1]];
        }
        
        return caseFieldNotificationCell;
        
    }
    return nil;
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
//     return nil;
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

//            return _adView;
//        }
//    }
    
    // 分割View
//    UIImageView *sepeartorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//    sepeartorView.image = [UIImage imageNamed:@"SepartorLine"];
//    return sepeartorView;
    return nil;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //    if (_queryType == eProductType) {
    //        if (indexPath.section == 0)
    //        {
    //
    //
    //            return [self cellHightWithModel:self.statusArr];
    //        }
    //        else if (indexPath.section == 1)
    //        {
    //            return 400;
    //        }
    //        else if (indexPath.section == 2)
    //        {
    //            return 183;
    //        }
    //        else if (indexPath.section == 3)
    //        {
    //            if (indexPath.row == 0)
    //            {
    //                YouMaybeLikeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:@"YouMaybeLikeCell"];
    //
    //                if (caseFieldNotificationCell)
    //                {
    //                    [caseFieldNotificationCell setNeedsUpdateConstraints];
    //                    [caseFieldNotificationCell updateConstraintsIfNeeded];
    //
    //                    CGFloat height = caseFieldNotificationCell.height;
    //                    return height;
    //                }
    //                else
    //                {
    //                    return 0;
    //                }
    //            }
    //            else
    //            {
    //                ProductInfoWith3ColumnCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:@"ProductInfoWith3ColumnCell"];
    //
    //                if (caseFieldNotificationCell)
    //                {
    //                    [caseFieldNotificationCell setNeedsUpdateConstraints];
    //                    [caseFieldNotificationCell updateConstraintsIfNeeded];
    //
    //                    CGFloat height = caseFieldNotificationCell.height;
    //                    return height;
    //                }
    //                else
    //                {
    //                    return 0;
    //                }
    //            }
    //        }
    //
    //    }
    //    else if (_queryType == eDetailType)
    //    {
    //        //        DeatailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeatailCell"];
    //        //
    //        //        if (cell)
    //        //        {
    //        //            [cell setNeedsUpdateConstraints];
    //        //            [cell updateConstraintsIfNeeded];
    //        //
    //        //            CGFloat height = cell.height;
    //
    //        //            return height;
    //
    //        return self.tableView.height;
    //        //        }
    //    }
    //    else if (_queryType == eCommentType)
    //    {
    if (indexPath.section == 0) {
        CommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentHeaderCell"];
        
        if (cell)
        {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            CGFloat height = cell.height;
            
            return height;
        }
    }
    else {
        
        
        ProductRated*model=  self.currentCommentArray[indexPath.row];
        [model  caculateHeight];
        return model.height;
        //            CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        //
        //            if (cell)
        //            {
        ////                [cell setNeedsUpdateConstraints];
        ////                [cell updateConstraintsIfNeeded];
        //
        //                CGFloat height = cell.height;
        //
        //                return height;
        //            }
        
    }
    //    }
    return 218;
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
    
    
    return 0.05;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (_queryType == eProductType || _queryType == eCommentType) {
//        return 20;
//    }
    return 10;
}

#pragma mark -- commentHeaderCellDelegate
- (void)commentHeaderCellDelegateButtonDidTouchCommentLeave:(NSInteger)commentLeave{
    
    
    [self  choceseCurrentCommentList:commentLeave];
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

    ///商品评价
    //    else
    if ([fmNetworkRequest.requestName isEqualToString:kRequest_getProductRatedByProductId])
    {
//        NSMutableArray *allcommentArray= [NSMutableArray array];
//        self.commentArray= [NSMutableArray array];
        
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ProductRated class]]){
            
            NSMutableArray *allcommentArray= [NSMutableArray array];
            [allcommentArray addObject: fmNetworkRequest.responseData];
            [self handleCommentDataWithAllcommentArray:allcommentArray];
            
        }
        if(fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]){
            
            NSLog(@"%@",fmNetworkRequest.responseData);
            
        [self handleCommentDataWithAllcommentArray:fmNetworkRequest.responseData];
     
        }
    }
    
    
}




-(void) handleCommentDataWithAllcommentArray:(NSMutableArray*)allCommentArray{
    
    //   把评价数据传给详情页
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"KAllCommentArray" object:self userInfo:@{@"AllCommentArray":allCommentArray}];
    
    
     //NSMutableArray *allcommentArray= allCommentArray;
    NSMutableArray *goodcommentArray = [NSMutableArray array];
    NSMutableArray *neutralArray = [NSMutableArray array];
    NSMutableArray *badArray = [NSMutableArray array];
    
    for (ProductRated*model in allCommentArray) {
        
        switch ([model.t_rated_level integerValue] ) {
            case 0:
                [badArray addObject:model];
                break;
            case 1:
                [neutralArray addObject:model];
                break;
            case 2:
                [ goodcommentArray addObject:model];
                break;
            default:
                break;
        }
    }
    self.commentHeadModel = [[CommentHeadMode alloc]init];
    self.commentHeadModel.allcommentArray = allCommentArray;
    self.commentHeadModel.goodcommentArray = goodcommentArray;
    self.commentHeadModel.neutralArray = neutralArray;
    self.commentHeadModel.badArray = badArray;
    //   // 选择当前评论水平
    [ self choceseCurrentCommentList:0];
    

}

-(void) choceseCurrentCommentList:(NSInteger)level{
    
    
    
    switch (level) {
        case 0:
            self.currentCommentArray = self.commentHeadModel.allcommentArray;

            break;
        case 1:
            self.currentCommentArray = self.commentHeadModel.goodcommentArray;
            break;
        case 2:
             self.currentCommentArray = self.commentHeadModel.neutralArray;
            
            break;
        case 3:
             self.currentCommentArray = self.commentHeadModel.badArray;
          
            break;
            
        default:
            break;
    }
    
        [self.tableView reloadData];

    
}








@end
