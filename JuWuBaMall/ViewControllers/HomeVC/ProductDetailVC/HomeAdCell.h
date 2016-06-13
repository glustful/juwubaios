//
//  HomeAdCell.h
//  YunshangYoupin
//
//  Created by yanghua on 15/11/18.
//  Copyright © 2015年 hxyxt. All rights reserved.


#import <UIKit/UIKit.h>
@class AdInfo;
@protocol HomeAdCellDelegate
- (void)homeADPageClick:(NSString*)url index:(int)index;
@end

@interface HomeAdCell : UITableViewCell
@property(nonatomic,weak)id<HomeAdCellDelegate> delegate;
@property(nonatomic,strong)AdInfo*homeAdPageModel;


@property(nonatomic,strong)NSArray *AdPageData;

+(instancetype)cellWithTableView:(UITableView*)tableView;


@end
