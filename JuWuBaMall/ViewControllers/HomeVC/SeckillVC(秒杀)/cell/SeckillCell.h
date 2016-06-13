//
//  SeckillCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillModel.h"



@interface SeckillCell : UITableViewCell
/**
 *  产品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *productIcon;
/**
 *  产品名
 */
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
/**
 *  颜色和尺寸
 */
@property (weak, nonatomic) IBOutlet UILabel *colorAndSize;
/**
 *  原价
 */
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
/**
 *  秒杀价
 */
@property (weak, nonatomic) IBOutlet UILabel *seckillPrice;
/**
 *  剩余产品件数
 */
@property (weak, nonatomic) IBOutlet UILabel *residueProduct;
/**
 *   立即抢购按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *nowSeckillButton;

@property (weak, nonatomic) IBOutlet UIButton *seckillButton;

- (void)customWithModel:(SeckillModel *)model;

@end
