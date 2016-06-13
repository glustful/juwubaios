//
//  OrderDetailLogisticsCell_WaitingReceive.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "OrderDetailLogisticsCell_WaitingReceive.h"
#import "LogisticsDetailVC.h"

@implementation OrderDetailLogisticsCell_WaitingReceive

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)doGoViewLogisticsDetailAction:(id)sender
{
    LogisticsDetailVC *logisticsDetailVC = [[LogisticsDetailVC alloc] initWithName:@"物流详情"];
    [_parentVC.navigationController pushViewController:logisticsDetailVC animated:YES];
}

- (void)reloadWithModel:(AddressInfo *)receModel
{
    self.receiveNameLabel.text = receModel.t_receipt_name;
    self.receivePhoneLabel.text = receModel.t_receipt_phone;
    self.receiveAddressLabel.text = [NSString stringWithFormat:@"%@ %@", receModel.t_receipt_area, receModel.t_receipt_streetaddress];
}

@end
