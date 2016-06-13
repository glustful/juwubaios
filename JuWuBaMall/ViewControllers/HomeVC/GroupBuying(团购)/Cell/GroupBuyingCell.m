//
//  GroupBuyingCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "GroupBuyingCell.h"
#import <UIImageView+WebCache.h>

@implementation GroupBuyingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)customWithModel:(SelectGroupProductModel *)groupModel
{
    self.productTitle.text = groupModel.tProduceName;
    self.colorAndSize.text = [NSString stringWithFormat:@"颜色:%@  尺寸:%@", groupModel.groupProductColor, groupModel.groupProductSize];
    self.oldPrice.text = [NSString stringWithFormat:@"原价:%@/%@",groupModel.tGroupPurchaseMoney, groupModel.groupProductUnit];
    float groupPrice = [groupModel.tGroupPurchaseMoney floatValue] * [groupModel.tGroupPurchaseDiscount floatValue];
    self.groupPrice.text = [NSString stringWithFormat:@"团购价:%.2f/%@", groupPrice, groupModel.groupProductUnit];
    
    NSString *str = groupModel.tGroupPurchasePicture;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.productIcon sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    
}

@end
