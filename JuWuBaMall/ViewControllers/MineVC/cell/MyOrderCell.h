//
//  MyOrderCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/13.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyOrderCellDelegate <NSObject>
- (void)myOrderCellButtonDidTouchDown:(UIButton *)button;

@end

@interface MyOrderCell : UITableViewCell

@property (nonatomic, strong) id <MyOrderCellDelegate> delegate;

@end
