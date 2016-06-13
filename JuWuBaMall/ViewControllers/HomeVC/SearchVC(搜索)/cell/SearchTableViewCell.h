//
//  SearchTableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchProductOrShopModel.h"

@interface SearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgeView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyName;

- (void)customWithModel:(SearchProductOrShopModel *)model;

@end
