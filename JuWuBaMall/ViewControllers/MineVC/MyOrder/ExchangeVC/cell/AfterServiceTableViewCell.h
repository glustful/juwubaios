//
//  AfterServiceTableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/1/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ApplyServiceConfirmDelegate <NSObject>

- (void)applyServiceConfirmClickWithCell:(UITableViewCell *)cell button:(UIButton*)button;

@end

@interface AfterServiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorAndSize;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *afterServiceButton;
@property(strong,nonatomic) OrderInfo *orderInfo;

@property (nonatomic, assign) id<ApplyServiceConfirmDelegate>delegate;

- (IBAction)apllyServe:(UIButton *)sender;

-(void)reloadCellData:(OrderInfo*)order;

@end
