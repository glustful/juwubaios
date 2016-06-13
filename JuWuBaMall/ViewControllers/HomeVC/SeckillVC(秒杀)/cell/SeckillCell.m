//
//  SeckillCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SeckillCell.h"
#import <UIImageView+WebCache.h>

@implementation SeckillCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)customWithModel:(SeckillModel *)model
{
    NSString *str = model.t_product_img;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
     [self.productIcon sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
    self.productTitle.text = model.t_produce_name;
    self.colorAndSize.text = [NSString stringWithFormat:@"颜色：%@ 尺寸：%@", model.t_product_value, model.t_product_value1];
    self.oldPrice.text = [NSString stringWithFormat:@"¥：%@元／%@", model.t_produce_detail_shop_price, model.t_product_value2];
    self.seckillPrice.text = [NSString stringWithFormat:@"¥：%@元／%@", model.t_seckill_price, model.t_product_value2];
    self.residueProduct.text = [NSString stringWithFormat:@"剩余：%@件", model.t_product_stock];
    
    int countProduct = [model.t_product_stock intValue];
    if (countProduct<300) {
        [self.seckillButton setTitle:@"抢购完毕" forState:UIControlStateNormal];
        [self.seckillButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
