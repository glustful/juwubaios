//
//  BrowHistoryCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/1/19.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowHistoryCell : UITableViewCell

@property(weak,nonatomic)IBOutlet UIImageView *heagImg;
@property(weak,nonatomic)IBOutlet UILabel  *titleLabel;
@property(weak,nonatomic)IBOutlet UILabel  *colorLabel;
@property(weak,nonatomic)IBOutlet UILabel  *measureLabel;
@property(weak,nonatomic)IBOutlet UILabel  *priceLabel;
@property(weak,nonatomic)IBOutlet UILabel  *discountLabel;


@end
