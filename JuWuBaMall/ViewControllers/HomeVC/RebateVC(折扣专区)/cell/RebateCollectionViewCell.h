//
//  RebateCollectionViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RebateCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak)IBOutlet UIImageView *iconImage;
@property(nonatomic,weak)IBOutlet UILabel *productName;
@property(nonatomic,weak)IBOutlet UILabel *priceLabel;
@property(nonatomic,weak)IBOutlet UILabel *discountLabel;
@property(nonatomic,strong)DiscountProduct  *product;

-(void)reloadCellDateWithProduct:(DiscountProduct*)product;

@end
