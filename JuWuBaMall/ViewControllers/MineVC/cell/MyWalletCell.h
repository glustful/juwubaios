//
//  MyWalletCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyWalletCellDelegate <NSObject>
- (void)MyWalletCellButtonDidTouchDown:(UIButton *)button;

@end

@interface MyWalletCell : UITableViewCell

@property (nonatomic, weak) id <MyWalletCellDelegate> delegate;
@property (nonatomic,weak)IBOutlet UILabel *discountJuanLabel;
@property (nonatomic,weak)IBOutlet UILabel *integralLable;


@end
