//
//  AttentionTableViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "AttentionTableViewCell.h"
#import <UIImageView+WebCache.h>


@implementation AttentionTableViewCell

- (void)awakeFromNib {

    
}

- (void)customWithModel:(Attention *)att
{
    self.titleLabel.text = att.t_produce_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@", att.t_produce_detail_shop_price];
    self.colorLabel.text = [NSString stringWithFormat:@"%@：%@",att.t_produce_detail_grandsun_name, att.t_produce_detail_grandsun_value];
    self.sizeLabel.text  = [NSString stringWithFormat:@"%@：%@", att.t_product_attribute_name, att.t_product_attribute_value];
    
    NSString *imgUrl = att.t_product_img;
    if ([imgUrl containsString:@"|"]) {
        NSArray *imgArr = [imgUrl componentsSeparatedByString:@"|"];
        for (int i = 0; i<imgArr.count; i++) {
            if ([imgArr[i] containsString:@"http"]) {
                //将url转码
                NSString *url = [imgArr[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [self.iconImage sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
                break;
            }
        }
       
    }else{
        NSString *url = [imgUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

         [self.iconImage sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
    }
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
