//
//  HomeMiddleAdCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeMiddleAdCellDelegate <NSObject>

- (void)doHomeMiddleAdCellClick:(UIButton *)button;

@end
@interface HomeMiddleAdCell : UITableViewCell
@property (nonatomic, weak) id<HomeMiddleAdCellDelegate> delegate;

@end
