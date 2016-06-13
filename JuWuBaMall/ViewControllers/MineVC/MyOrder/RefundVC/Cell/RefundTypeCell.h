//
//  RefundTypeCell.h
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefundVC.h"

typedef NS_ENUM(NSInteger, RefoundType)
{
    eNotWantType,       // 多拍/拍错/不想要
    eNoHasProductType,  // 缺货
    
};
@interface RefundTypeCell : UITableViewCell<UIActionSheetDelegate>

@property (nonatomic, weak) RefundVC *parentVC;
@property (nonatomic, assign) RefoundType refoundType;

@end
