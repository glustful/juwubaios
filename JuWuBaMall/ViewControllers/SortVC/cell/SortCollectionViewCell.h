//
//  SortCollectionViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/1/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortLeftModel.h"

@interface SortCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
/**
 *  左侧和右侧的数据类型一样，所以用一个模型（model）
 *
 *  @param rightModel nil
 */
- (void)customWithModel:(SortLeftModel *)rightModel;

@end
