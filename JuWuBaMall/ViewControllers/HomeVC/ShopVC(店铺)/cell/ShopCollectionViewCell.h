//
//  ShopCollectionViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/2/26.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopAttentionCount;

@property (weak, nonatomic) IBOutlet UIButton *buttonTitleLabel1;
@property (weak, nonatomic) IBOutlet UIButton *buttonTitleLabel2;
@property (weak, nonatomic) IBOutlet UIButton *buttonTitleLabel3;
@property (weak, nonatomic) IBOutlet UIButton *buttonTitleLabel4;

- (IBAction)shopAttionClick:(UIButton *)sender;









@end
