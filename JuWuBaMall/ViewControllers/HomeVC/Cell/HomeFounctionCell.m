//
//  HomeFounctionCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeFounctionCell.h"

@implementation HomeFounctionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)goFounctionPageAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(homeFounctionCellButtonDidTouchDown:withRow:)])
    {
        [_delegate homeFounctionCellButtonDidTouchDown:(UIButton *)sender withRow:_cellRow];
    }
    
}

- (void)customWithImageArray:(NSMutableArray *)imgArray andTitleArray:(NSMutableArray *)titleArr andRow:(NSInteger)cellRow
{
    if (cellRow == 1) {
        [self.imageView_1 setImage:[UIImage imageNamed:imgArray[0]]];
        [self.imageView_2 setImage:[UIImage imageNamed:imgArray[1]]];
        [self.imageView_3 setImage:[UIImage imageNamed:imgArray[2]]];
        [self.imageView_4 setImage:[UIImage imageNamed:imgArray[3]]];
        
        [self.label_1 setText:titleArr[0]];
        [self.label_2 setText:titleArr[1]];
        [self.label_3 setText:titleArr[2]];
        [self.label_4 setText:titleArr[3]];

    }else{
        [self.imageView_1 setImage:[UIImage imageNamed:imgArray[4]]];
        [self.imageView_2 setImage:[UIImage imageNamed:imgArray[5]]];
        [self.imageView_3 setImage:[UIImage imageNamed:imgArray[6]]];
        [self.imageView_4 setImage:[UIImage imageNamed:imgArray[7]]];
        
        [self.label_1 setText:titleArr[4]];
        [self.label_2 setText:titleArr[5]];
        [self.label_3 setText:titleArr[6]];
        [self.label_4 setText:titleArr[7]];

    }
   
    
}

@end
