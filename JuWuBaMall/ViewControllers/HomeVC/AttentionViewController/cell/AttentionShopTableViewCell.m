//
//  AttentionShopTableViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "AttentionShopTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation AttentionShopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)customWithModel:(AttentionStoreModel *)at
{

    self.shopTitleLabel.text = at.t_shop_name;
    self.attention_id = at.t_attention_id;
    self.shopAttentionLabel.text = at.t_attention_createtime;
    
    NSString *str = at.t_shop_logo;
//    if ([str containsString:@"|"]) {
//       NSArray *arr = [str componentsSeparatedByString:@"|"];
//        for (int i = 0; i<arr.count; i++) {
//            if (arr[i] != nil) {
//                //将url转码
//                NSString *url = [arr[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                
//                [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
//                break;
//            }
//        }
//    }else{
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
//    }
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
