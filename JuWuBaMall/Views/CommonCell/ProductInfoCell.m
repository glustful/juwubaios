//
//  ProductInfoCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductInfoCell.h"
#import "ProductDetailVC.h"
#import <UIImageView+WebCache.h>

@implementation ProductInfoCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)customWithArray:(NSMutableArray *)proArray
{
    
    YouGuessProduct *pro1 = proArray[0];
    self.product1TitleLabel.text = pro1.t_produce_name;
    self.product1PriceLabel.text = [NSString stringWithFormat:@"¥:%@", pro1.t_produce_shop_price];
    [self.product1ImageButton.imageView sd_setImageWithURL:[NSURL URLWithString:pro1.t_produce_logo] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    
    YouGuessProduct *pro2 = proArray[1];
    self.product2TitleLabel.text = pro2.t_produce_name;
    
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:self.product2ImageButton.frame];
      [imgView2 sd_setImageWithURL:[NSURL URLWithString:pro2.t_produce_logo] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    [self.product2ImageButton addSubview:imgView2];
    
    self.product2PriceLabel.text = [NSString stringWithFormat:@"¥:%@", pro2.t_produce_shop_price];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:pro2.t_produce_logo] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];

}

// 收藏
- (IBAction)doCollectAction:(id)sender
{
    
}
// 查看产品详情
- (IBAction)goProductDetailPageAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    ProductDetailVC *detailVC = [[ProductDetailVC alloc] initWithName:@""];
    // 产品1
    if (button.tag == 0 )
    {
        
    }
    // 产品2
    else if (button.tag == 1)
    {
        
    }
    
    [_parentVC.navigationController pushViewController:detailVC animated:YES];
    
}



@end
