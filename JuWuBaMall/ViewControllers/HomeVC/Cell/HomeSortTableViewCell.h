//
//  HomeSortTableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/5/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSortModel.h"//首页砖区


@class HomeProductDetailModel;

@protocol HomeSortTableViewCellDetele <NSObject>

- (void)productDidTouchDownwithModel:(HomeProductDetailModel*)sortMod;

- (void)moreClickButtonWithModel:(HomeSortModel*)sortModel;

@end
@interface HomeSortTableViewCell : UITableViewCell
@property (nonatomic, weak) id <HomeSortTableViewCellDetele> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *sortNameLabel;

@property (nonatomic, strong) NSMutableArray *dataArray;//存放四个商品的数据的数组

@property (nonatomic, strong) HomeSortModel *sortModel;



- (void)customWithModel:(HomeSortModel *)model;




@end
