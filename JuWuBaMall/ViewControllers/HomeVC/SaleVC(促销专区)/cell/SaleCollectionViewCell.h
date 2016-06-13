//
//  SaleCollectionViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaleCollectionViewCell : UICollectionViewCell

@property(weak,nonatomic)IBOutlet UIImageView *icomImg;
@property(weak,nonatomic)IBOutlet UILabel *priceLabel;
@property(weak,nonatomic)IBOutlet UILabel *promotionLabel;
@property(weak,nonatomic)IBOutlet UILabel *nameLabel;

@end
