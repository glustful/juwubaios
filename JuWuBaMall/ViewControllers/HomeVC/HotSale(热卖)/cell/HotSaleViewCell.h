//
//  HotSaleViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotSaleViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productIcon;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end
