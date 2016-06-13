//
//  LogisticsStatusCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "LogisticsStatusCell.h"

@implementation LogisticsStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)phoneNumClick:(UIButton *)sender {
    
    [self.delegate phoneNumberClick:sender];
    
}

@end
