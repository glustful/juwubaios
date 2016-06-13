//
//  CommentCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/13.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductRated.h"
@interface CommentCell : UITableViewCell
- (void)customWithModel:(ProductRated *)comment;
- (CGFloat)cellHight:(ProductRated *)comment;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) UIImageView *portrait;
@property (nonatomic, strong) UILabel *authorLabel;

@property (nonatomic, strong) UIImageView *rated_level1;
@property (nonatomic, strong) UIImageView *rated_level2;
@property (nonatomic, strong) UIImageView *rated_level3;

@property (nonatomic, strong) UILabel *timeLabel;
//@property (nonatomic, strong) UILabel *appclientLabel;
@property (nonatomic, strong) UILabel *contentLabel;
//@property (nonatomic, strong) UIView *repliesView;
@property (nonatomic, strong) UIButton *zanBtn;
@property (nonatomic, strong) UIButton *repliesbtn;

@property (nonatomic, copy) BOOL (^canPerformAction)(UITableViewCell *cell, SEL action);
@property (nonatomic, copy) void (^deleteObject)(UITableViewCell *cell);

//- (void)setContentWithComment:(OSCComment *)comment;
- (void)copyText:(id)sender;
- (void)deleteObject:(id)sender;



@end
