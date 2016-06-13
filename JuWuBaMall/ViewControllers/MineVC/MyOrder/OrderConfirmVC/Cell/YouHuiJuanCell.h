//
//  YouHuiJuanCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouHuiJuanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *youHuiInfoLabel;

- (void)reloadData:(NSString *)youHuiString;

@end
