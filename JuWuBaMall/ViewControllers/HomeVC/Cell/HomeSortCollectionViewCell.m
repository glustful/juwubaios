//
//  HomeSortCollectionViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/5/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeSortCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation HomeSortCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)customWithYouGuessProduct:(YouGuessProduct *)guessModel
{
    self.titleLabel.text = guessModel.t_produce_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@元", guessModel.t_produce_shop_price];
    
    NSString *str = guessModel.t_produce_logo;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.imgView  sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];

}

- (void)customWithModel:(HomeProductDetailModel *)sortModel
{
    self.titleLabel.text = sortModel.produceName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@元", sortModel.producePrice];
    
    NSString *str = sortModel.produceLogo;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.imgView  sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    
}
@end
