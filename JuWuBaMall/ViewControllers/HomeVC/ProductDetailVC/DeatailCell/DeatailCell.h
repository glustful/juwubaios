//
//  DeatailCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/13.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetialModel.h"
@interface DeatailCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)customWithModel:(ProductDetialModel *)model;

@end
