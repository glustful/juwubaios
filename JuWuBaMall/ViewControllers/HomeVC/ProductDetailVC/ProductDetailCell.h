//
//  ProductDetailCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/2/2.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailVC.h"
#import "ProductStatusModel.h"
#import "ProductDetailStatuesModel.h"
@interface ProductDetailCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)customWithModel:(ProductDetailStatuesModel *)model;
@end
