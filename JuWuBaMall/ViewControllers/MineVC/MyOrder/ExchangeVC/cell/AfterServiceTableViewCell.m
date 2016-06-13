//
//  AfterServiceTableViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "AfterServiceTableViewCell.h"
#import "ApplyServiceViewController.h"
#import <UIImageView+WebCache.h>

@interface AfterServiceTableViewCell ()

@end
@implementation AfterServiceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)apllyServe:(UIButton *)sender {

    if (_delegate && [_delegate respondsToSelector:@selector(applyServiceConfirmClickWithCell:button:)]) {
        [self.delegate applyServiceConfirmClickWithCell:self button:(UIButton*)sender];
    }
}
-(void)reloadCellData:(OrderInfo*)order{
    _orderInfo=order;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:order.t_product_img] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    self.titleLabel.text=order.t_produce_name;
    self.colorAndSize.text=[NSString stringWithFormat:@"颜色：%@     尺寸：%@",order.t_product_thread_type_value,@"1000*800"];
    self.countLabel.text= [NSString stringWithFormat:@"数量：%@",order.t_total_num];;
}
@end
