//
//  ShopDetailTableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/2/27.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UIImageView *detailIcon;
@property (weak, nonatomic) IBOutlet UILabel *detailText;

@end
