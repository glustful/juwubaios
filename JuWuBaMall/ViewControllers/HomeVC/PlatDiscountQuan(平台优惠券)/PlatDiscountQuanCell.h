//
//  PlatDiscountQuanCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlatDiscountQuanCellDelegate <NSObject>

-(void)didButtonClick:(UIButton*)button;

@end

@interface PlatDiscountQuanCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UIImageView *productImg;
@property(nonatomic,strong)IBOutlet UILabel *pricelabel;
@property(nonatomic,strong)IBOutlet UILabel *conditiionLabel;
@property(nonatomic,strong)IBOutlet UILabel *timeLabel;
@property(nonatomic,strong)IBOutlet UIButton *rightButton;

@property(nonatomic,strong)IBOutlet UIButton *rowImgButton;
@property(nonatomic,weak)id<PlatDiscountQuanCellDelegate>delegate;

@end
