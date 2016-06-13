//
//  HomeFounctionCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeFounctionCellDelegate <NSObject>

- (void)homeFounctionCellButtonDidTouchDown:(UIButton *)button withRow:(NSInteger)row;

@end

@interface HomeFounctionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_1;
@property (weak, nonatomic) IBOutlet UILabel *label_2;
@property (weak, nonatomic) IBOutlet UILabel *label_3;
@property (weak, nonatomic) IBOutlet UILabel *label_4;

@property (weak, nonatomic) IBOutlet UIImageView *imageView_1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_4;

@property (nonatomic, assign) NSInteger cellRow;  // 1:行1 2：行2

@property (nonatomic, weak) id <HomeFounctionCellDelegate> delegate;

- (void)customWithImageArray:(NSMutableArray *)imgArray andTitleArray:(NSMutableArray *)titleArr andRow:(NSInteger)cellRow;

@end
