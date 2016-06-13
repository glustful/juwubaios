//
//  HomeProductAreaCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeSortModel.h"//首页砖区

@class HomeProductDetailModel;

@protocol HomeProductAreaCellDelegate <NSObject>

- (void)productButtonDidTouchDown:(UIButton *)button withModel:(HomeProductDetailModel*)sortMod;

- (void)moreClickButtonWithModel:(HomeSortModel*)sortModel;

@end

@interface HomeProductAreaCell : UITableViewCell

@property (nonatomic, weak) id <HomeProductAreaCellDelegate> delegate;
@property(weak,nonatomic)IBOutlet UIButton *leftImgView;
@property(weak,nonatomic)IBOutlet UIButton *button1;
@property(weak,nonatomic)IBOutlet UILabel *priceLabel1;
@property(weak,nonatomic)IBOutlet UILabel *nameLabel1;
@property(weak,nonatomic)IBOutlet UIButton *button2;
@property(weak,nonatomic)IBOutlet UILabel *priceLabel2;
@property(weak,nonatomic)IBOutlet UILabel *nameLabel2;
@property(weak,nonatomic)IBOutlet UIButton *button3;
@property(weak,nonatomic)IBOutlet UILabel *priceLabel3;
@property(weak,nonatomic)IBOutlet UILabel *nameLabel3;
@property(weak,nonatomic)IBOutlet UIButton *button4;
@property(weak,nonatomic)IBOutlet UILabel *priceLabel4;
@property(weak,nonatomic)IBOutlet UILabel *nameLabel4;

@property (weak, nonatomic) IBOutlet UILabel *sortNameLabel;

@property (nonatomic, strong) NSMutableArray *dataArray;//四个模型数据的数组

@property (nonatomic, strong) HomeSortModel *sortModel;



- (void)customWithModel:(HomeSortModel *)model;




@end
