//
//  ReceiveAddressCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReceivveAddressCellDelegate <NSObject>

-(void)receiveAddressCellDelegate;

@end


@class BaseVC;
@interface ReceiveAddressCell : UITableViewCell

@property(nonatomic,strong)OrderInfo *orderInfo;

@property(nonatomic,weak)IBOutlet UIImageView *productImg;
@property(nonatomic,weak)IBOutlet UILabel *productName;
@property(nonatomic,weak)IBOutlet UILabel *colorLabel;
@property(nonatomic,weak)IBOutlet UILabel *measureLabel;
@property(nonatomic,weak)IBOutlet UILabel *numberLabel;
@property(nonatomic,weak)IBOutlet UILabel *productPrice;


@property(nonatomic,weak)IBOutlet UILabel *receiveNameLabel;
@property(nonatomic,weak)IBOutlet UILabel *receivePhoneLable;
@property(nonatomic,weak)IBOutlet UILabel *receiveAddressLabel;


@property(nonatomic,strong) BaseVC *presentVC;
@property(nonatomic,strong)id<ReceivveAddressCellDelegate>delegate;
@property(nonatomic,strong)AddressInfo *addressInfo;

-(void)reloadataWithOrederInfo:(OrderInfo*)orderInfo;

-(void)reloadReceivingAddresswithAddressInfo:(AddressInfo*)addressInfo;


@end
