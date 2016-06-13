//
//  SellersCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SellersCell.h"


@implementation SellersCell

- (void)awakeFromNib {
    
    
    
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)buttonClick:(id)sender {

    [self.delegate doSellersCellClick:(UIButton *)sender];
}




@end
