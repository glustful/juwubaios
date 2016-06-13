//
//  JxbAdPageView.h
//  JxbAdPageView
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/11.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdPageViewDelegate <NSObject>
- (void)click:(int)index;
@end

@interface AdPageView : UIView
@property(nonatomic,weak)id<AdPageViewDelegate> delegate;



//二选一，初始化方法
@property (nonatomic,strong)NSArray *imgNameArr;

- (instancetype)initWithAds:(NSArray*)imgNameArr;
@end
