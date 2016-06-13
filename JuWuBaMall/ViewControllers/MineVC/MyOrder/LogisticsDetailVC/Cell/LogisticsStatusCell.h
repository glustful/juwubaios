//
//  LogisticsStatusCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneNumberDelegate <NSObject>

- (void)phoneNumberClick:(UIButton *)button;

@end

@interface LogisticsStatusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *driverName;
@property (weak, nonatomic) IBOutlet UILabel *carType;
@property (weak, nonatomic) IBOutlet UILabel *carLicence;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumber;

@property (nonatomic, strong) id<PhoneNumberDelegate>  delegate;

@end
