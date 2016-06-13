//
//  PlatDiscountQuanNoCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "PlatDiscountQuanNoCell.h"

@implementation PlatDiscountQuanNoCell

- (void)awakeFromNib {
    // Initialization code
    _productImg.layer.masksToBounds=YES;
    _productImg.layer.cornerRadius=5;
    _pricelabel.layer.masksToBounds=YES;
    _pricelabel.layer.cornerRadius=5;
    _conditiionLabel.layer.masksToBounds=YES;
    _conditiionLabel.layer.cornerRadius=5;
    NSString *str=_pricelabel.text;
    NSRange range=[str rangeOfString:@"￥"];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:str];
    //设置字体的大小
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    _pricelabel.attributedText = string;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
