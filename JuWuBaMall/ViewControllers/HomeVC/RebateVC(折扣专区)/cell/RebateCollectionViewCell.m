//
//  RebateCollectionViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "RebateCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation RebateCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)reloadCellDateWithProduct:(DiscountProduct*)product{
    _product=product;
    
    NSString *str = product.t_produce_logo;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

    [self.iconImage   sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    self.productName.text=product.t_produce_name;
    self.priceLabel.text=[NSString stringWithFormat:@"原价:%@元/%@",product.t_produce_shop_price,product.t_product_unit_value];
    self.discountLabel.text=[NSString stringWithFormat:@"现价:%@元/%@",product.t_product_discount_money,product.t_product_unit_value];
}

@end
