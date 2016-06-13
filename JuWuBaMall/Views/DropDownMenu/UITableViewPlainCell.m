//
//  UITableViewPlainCell.m
//  CommonFramework
//
//  Created by zhanglan on 14-2-27.
//  Copyright (c) 2014年 Qunar.com. All rights reserved.
//

#import "UITableViewPlainCell.h"

@implementation UITableViewPlainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _bottomLineWidth = -1;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
