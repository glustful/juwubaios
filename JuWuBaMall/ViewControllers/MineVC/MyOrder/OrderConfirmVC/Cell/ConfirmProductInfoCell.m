//
//  ConfirmProductInfoCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ConfirmProductInfoCell.h"
#import <UIImageView+WebCache.h>

@implementation ConfirmProductInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadataWithOrederInfo:(FSBShoppingCarInfo *)carInfo
{
    
    self.shopNameLabel.text = carInfo.t_shop_name;


//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:productInfo.t_produce_logo]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
//    self.nameLabel.text = productInfo.t_produce_name;
//    self.sizeLabel.text = productInfo.t_product_attribute_value;
//    self.colorLabel.text = productInfo.t_produce_detail_grandsun_value;
//    self.priceLabel.text = productInfo.t_shop_car_goodsamount;
//    self.countLabel.text = productInfo.t_shop_car_purchasequantity;

//        
//        FSBShoppingCarProductInfo *productInfo = carInfo.productArray[0];
//        [self.imgView sd_setImageWithURL:[NSURL URLWithString:productInfo.t_produce_logo]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
//        self.titleLabel.text = productInfo.t_produce_name;
//        self.sizeLabel.text = productInfo.t_product_attribute_value;
//        self.colorLabel.text = productInfo.t_produce_detail_grandsun_value;
//        self.priceLabel.text = productInfo.t_shop_car_goodsamount;
//        self.countLabel.text = productInfo.t_shop_car_purchasequantity;


   

    
    

    

    
}

- (void)customWithModel:(FSBShoppingCarProductInfo *)proModel
{
    NSString *str =  proModel.t_produce_logo;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
    self.nameLabel.text = proModel.t_produce_name;
    self.sizeLabel.text = [NSString stringWithFormat:@"%@: %@", proModel.t_product_attribute_name, proModel.t_product_attribute_value];
    self.colorLabel.text = [NSString stringWithFormat:@"%@: %@",proModel.t_product_attribute_sun_name,proModel.t_product_attribute_sun_value];
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@",proModel.t_shop_car_goodsamount];
    self.countLabel.text = [NSString stringWithFormat:@"数量：%@", proModel.t_shop_car_purchasequantity];
    self.shopNameLabel.text = proModel.t_shop_name;

}



@end
