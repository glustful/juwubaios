//
//  HomeSortCollectionViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/5/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeProductDetailModel.h"//首页砖区分类模型
#import "YouGuessProduct.h"//猜你喜欢模型


@interface HomeSortCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


- (void)customWithModel:(HomeProductDetailModel *)sortModel;

- (void)customWithYouGuessProduct:(YouGuessProduct *)guessModel;


@end
