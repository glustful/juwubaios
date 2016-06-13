//
//  SortDetailViewController.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/26.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

/**
 *  分类详情
 */
#import "BaseVC.h"


typedef NS_ENUM(NSInteger, MySortStatusType)
{
    eMySortStatus_HomePage,      // 主页
    eMySortStatus_SortPage  // 分类
};
@interface SortDetailViewController : BaseVC
@property (nonatomic, assign) MySortStatusType sortStatus;

@property (nonatomic, copy) NSString *typeID;//商品的类型


@end
