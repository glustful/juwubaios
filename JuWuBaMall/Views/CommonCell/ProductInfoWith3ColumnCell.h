//
//  ProductInfoWith3ColumnCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/2/3.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "YouGuessProduct.h"
@interface ProductInfoWith3ColumnCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *product1TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *product2TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *product3TitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *product1PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *product2PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *product3PriceLabel;

@property (weak, nonatomic) IBOutlet UIView *product1View;
@property (weak, nonatomic) IBOutlet UIView *product2View;
@property (weak, nonatomic) IBOutlet UIView *product3View;

@property (weak, nonatomic) IBOutlet UIButton *product1ImageButton;
@property (weak, nonatomic) IBOutlet UIButton *product2ImageButton;
@property (weak, nonatomic) IBOutlet UIButton *product3ImageButton;

@property (nonatomic, weak) BaseVC *parentVC;
@property (strong, nonatomic) NSArray *youGuessArray;

@end
