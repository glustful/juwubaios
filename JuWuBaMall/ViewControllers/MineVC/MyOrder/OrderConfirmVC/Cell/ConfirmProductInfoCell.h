//
//  ConfirmProductInfoCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBShoppingCarInfo.h"
#import "FSBShoppingCarProductInfo.h"


@interface ConfirmProductInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

- (void)reloadataWithOrederInfo:(FSBShoppingCarInfo *)carInfo;
- (void)customWithModel:(FSBShoppingCarProductInfo *)proModel;

@end
