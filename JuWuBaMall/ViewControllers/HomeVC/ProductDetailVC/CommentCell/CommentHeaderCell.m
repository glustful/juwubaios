//
//  CommentHeaderCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/13.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "CommentHeaderCell.h"
#import "CommentHeadMode.h"
@interface CommentHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *allComentNumb;

@property (weak, nonatomic) IBOutlet UILabel *goodComentNumb;
@property (weak, nonatomic) IBOutlet UILabel *mediumComentNumb;
@property (weak, nonatomic) IBOutlet UILabel *badComentNumb;

@property (weak, nonatomic) IBOutlet UIView *allComentView;
@property (weak, nonatomic) IBOutlet UIView *goodComentView;
@property (weak, nonatomic) IBOutlet UIView *MiddleView;
@property (weak, nonatomic) IBOutlet UIView *badView;

@end

@implementation CommentHeaderCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer*tapGesture0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    
    UITapGestureRecognizer*tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    UITapGestureRecognizer*tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    UITapGestureRecognizer*tapGesture3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    
    self.allComentView.tag = 0;
    self.goodComentView.tag = 1;
    self.MiddleView.tag = 2;
    self.badView.tag = 3;
    
    
    [self.allComentView addGestureRecognizer:tapGesture0];
    [self.goodComentView addGestureRecognizer:tapGesture1];
    [self.MiddleView addGestureRecognizer:tapGesture2];
    [self.badView addGestureRecognizer:tapGesture3];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)customWithData:(CommentHeadMode *)Data{
    

    
    self.allComentNumb.text = [NSString stringWithFormat:@"%@",@(Data.allcommentArray.  count)];
    self.goodComentNumb.text = [NSString stringWithFormat:@"%@",@(Data.goodcommentArray.count)];
    self.mediumComentNumb.text = [NSString stringWithFormat:@"%@",@(Data.neutralArray.count)];
    self.badComentNumb.text = [NSString stringWithFormat:@"%@",@(Data.badArray.count)];
}


-(void)Actiondo:(UIGestureRecognizer*)gestureRecognizer{
    
    
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(commentHeaderCellDelegateButtonDidTouchCommentLeave:)])
    {
        [_delegate commentHeaderCellDelegateButtonDidTouchCommentLeave:gestureRecognizer.view.tag];
    }
}

@end
