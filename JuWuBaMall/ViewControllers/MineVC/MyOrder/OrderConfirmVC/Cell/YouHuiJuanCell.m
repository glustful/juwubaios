//
//  YouHuiJuanCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "YouHuiJuanCell.h"

@implementation YouHuiJuanCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)reloadData:(NSString *)youHuiString
{
    if ([youHuiString isStringSafe]) {
        _youHuiInfoLabel.text = youHuiString;
    }
    else {
        _youHuiInfoLabel.text = @"无可用";
    }
}

@end
