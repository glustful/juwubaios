//
//  ShopTableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/2/27.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopAttentionCount;

@property (weak, nonatomic) IBOutlet UIButton *buttonTitleLabel1;
@property (weak, nonatomic) IBOutlet UIButton *buttonTitleLabel2;
@property (weak, nonatomic) IBOutlet UIButton *buttonTitleLabel3;
@property (weak, nonatomic) IBOutlet UIButton *buttonTitleLabel4;
@property(weak,nonatomic)IBOutlet UILabel *quality_scoreLabel;
@property(weak,nonatomic)IBOutlet UILabel *compare_qualityLabel;
@property(weak,nonatomic)IBOutlet UILabel *server_scoreLabel;
@property(weak,nonatomic)IBOutlet UILabel *compare_serverLabel;
@property(weak,nonatomic)IBOutlet UILabel *speed_scoreLabel;
@property(weak,nonatomic)IBOutlet UILabel *compare_speedLabel;

@end
