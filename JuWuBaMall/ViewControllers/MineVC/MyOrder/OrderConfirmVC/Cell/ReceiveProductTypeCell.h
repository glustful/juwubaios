//
//  ReceiveProductTypeCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/8.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LogisticsFeeType)
{
    ereceivePayType,    // 到付
    eownGetType,        // 自提
};

@protocol ReceiveProductTypeCellDelegate <NSObject>

- (void)sendType:(NSString *)type;

@end

@interface ReceiveProductTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *receivePayButton;
@property (weak, nonatomic) IBOutlet UIButton *ownGetButton;

@property (nonatomic, assign) NSInteger logisticsFeeType;

@property (nonatomic, strong) id<ReceiveProductTypeCellDelegate> delegate;

@end
