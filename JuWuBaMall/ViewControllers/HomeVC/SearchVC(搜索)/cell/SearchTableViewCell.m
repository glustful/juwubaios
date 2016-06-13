//
//  SearchTableViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SearchTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation SearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)customWithModel:(SearchProductOrShopModel *)model
{
    self.titleLabel.text = model.t_produce_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@", model.t_produce_shop_price];
    self.companyName.text = [NSString stringWithFormat:@"店铺：%@", model.t_company_name];
    NSString *url = [model.t_produce_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.iconImgeView sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
}

@end
