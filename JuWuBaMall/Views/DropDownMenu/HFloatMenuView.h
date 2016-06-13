
/************************************************************************
 *Copyright (c) 2015 fangstar. All rights reserved.
 *FileName:     HFloatMenuView.h
 *Author:       zhanglan
 *Date:         15/11/18
 *Description:  下拉菜单
 *Others:
 *History:
 ************************************************************************/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HFloatMaskType)
{
    HFloatMaskTypeNone = 1,
    HFloatMaskTypeBlack ,
    HFLoatMaskTypeBlue,
};

typedef NS_ENUM(NSUInteger, HFloatMenuPosition) {
    HFloatMenuPositionUp = 1,
    HFloatMenuPositionDown,
};

typedef void (^HFloatMenuSelectedHandle)(NSInteger selectedIndex);

@protocol HFloatMenuDelegate <NSObject>

@optional
- (void)menuSelectedAtIndex:(NSInteger)index;

@end


@interface HFloatMenuView : UIView

@property (nonatomic, weak) id <HFloatMenuDelegate> delegate;

@property (nonatomic, assign, readonly) HFloatMenuPosition floatMenuPosition;
@property (nonatomic, assign) CGSize arrowSize;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) HFloatMaskType maskType;
@property (nonatomic, assign) CGFloat betweenAtViewAndArrowHeight;
@property (nonatomic, assign) CGFloat sideEdge;
@property (nonatomic, strong) UIColor *bgColor;        //背景色

@property (nonatomic, copy) HFloatMenuSelectedHandle selectedHandle;
@property (nonatomic, copy) dispatch_block_t didShowHandler;
@property (nonatomic, copy) dispatch_block_t didDismissHandler;

@property (nonatomic, strong) NSArray *iconArray;   // ICON

+ (instancetype)floatMenuView;

- (instancetype)init;

- (void)setMenuArray:(NSArray *)menuArray;

- (void)showAtPoint:(CGPoint)point inView:(UIView *)containerView;

- (void)showAtView:(UIView *)atView inView:(UIView *)containerView;

- (void)dismiss;

@end
