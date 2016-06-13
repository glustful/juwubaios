//
//  CommentHeaderCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/13.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentHeadMode;

@protocol CommentHeaderCellDelegate <NSObject>

- (void)commentHeaderCellDelegateButtonDidTouchCommentLeave:(NSInteger)commentLeave;

@end

@interface CommentHeaderCell : UITableViewCell

@property (nonatomic, weak) id <CommentHeaderCellDelegate> delegate;

- (void)customWithData:(CommentHeadMode*)Data;
@end
