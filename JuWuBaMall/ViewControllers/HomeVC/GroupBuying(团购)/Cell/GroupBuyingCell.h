//
//  GroupBuyingCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectGroupProductModel.h"

@interface GroupBuyingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productIcon;
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *colorAndSize;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *groupPrice;

- (void)customWithModel:(SelectGroupProductModel *)groupModel;

@end
