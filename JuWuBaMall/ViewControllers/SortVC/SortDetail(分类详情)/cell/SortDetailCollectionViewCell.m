//
//  SortDetailCollectionViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/26.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SortDetailCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation SortDetailCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)customWithModel:(SortProductModel *)sortModel
{
    self.titleLabel.text = sortModel.t_produce_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@元", sortModel.t_produce_shop_price];
    NSString *str = sortModel.t_produce_logo;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.imgView  sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    
}

@end
