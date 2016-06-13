//
//  RefundTypeCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "RefundTypeCell.h"


@implementation RefundTypeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)doSelectRefundTypeAction:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"多拍/拍错/不想要", @"缺货", nil];
    [actionSheet showInView:_parentVC.view];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _parentVC.refoundType = buttonIndex;
}

@end
