
/****************************************************
 *Copyright (c) 2015 fangstar. All rights reserved.
 *FileName:     OrderDetailLogisticsCell_WaitingReceive.h
 *Author:       zhanglan
 *Date:         16/3/4.
 *Description:  待收货-物流cell
 *Others:
 *History:
 ****************************************************/

#import <UIKit/UIKit.h>
#import "BaseVC.h"

#import "AddressInfo.h"//地址model

@interface OrderDetailLogisticsCell_WaitingReceive : UITableViewCell

@property (nonatomic, weak) BaseVC *parentVC;
@property(nonatomic,weak)IBOutlet UILabel *namelabel;
@property(nonatomic,weak)IBOutlet UILabel *phoneLable;
@property(nonatomic,weak)IBOutlet UILabel *codeLabel;

@property(nonatomic,weak)IBOutlet UILabel *receiveNameLabel;
@property(nonatomic,weak)IBOutlet UILabel *receivePhoneLabel;
@property(nonatomic,weak)IBOutlet UILabel *receiveAddressLabel;

- (void)reloadWithModel:(AddressInfo *)receModel;

@end
