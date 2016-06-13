//
//  SortDetailCollectionViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/26.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortProductModel.h"//分类商品模型


@interface SortDetailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (void)customWithModel:(SortProductModel *)sortModel;

@end
