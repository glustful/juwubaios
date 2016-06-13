//
//  HomeMiddleAdCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeMiddleAdCell.h"

@implementation HomeMiddleAdCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    [self.delegate doHomeMiddleAdCellClick:sender];
}




@end
