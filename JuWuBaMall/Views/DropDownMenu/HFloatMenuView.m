//
//  HFloatMenuView.m
//  Hotel
//
//  Created by zhanglan on 14/12/18.
//  Copyright (c) 2014年 Qunar.com. All rights reserved.
//

#import "HFloatMenuView.h"
#import "UITableViewPlainCell.h"
#import "LineView.h"

#define DEGREES_TO_RADIANS(degrees)                 ((3.14159265359 * degrees)/ 180)
#define kHFloatMenuTableViewCellHeight              44
#define kHFloatMenuTableViewLineVMargin             0
#define kHFloatMenuTableViewWidth                   150


#define kHFloatMenuTableViewLabelFont               [UIFont systemFontOfSize:16]

@interface HFloatMenuView ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *menuTable;
    NSInteger selectedIndex;
}

@property (nonatomic, strong) UIControl *bgOverLay;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign, readwrite) HFloatMenuPosition floatMenuPosition;
@property (nonatomic, assign) CGPoint arrowShowPoint;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, assign) CGRect contentViewFrame;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HFloatMenuView
+ (instancetype)floatMenuView{
    return [[HFloatMenuView alloc] init];
}

- (instancetype)init{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        selectedIndex = NSNotFound;
        self.arrowSize = CGSizeMake(11.0, 5.0);
        self.cornerRadius = 4.0;
        self.backgroundColor = [UIColor clearColor];
        self.sideEdge = 5.0;
        self.maskType = HFloatMaskTypeNone;
        self.betweenAtViewAndArrowHeight = 4.0;
        self.bgColor = [UIColor colorWithHex:0x000000 alpha:0.7];
        
        menuTable = [[UITableView alloc]initWithFrame:CGRectZero];
        //CAShapeLayer
        menuTable.backgroundColor =  [UIColor clearColor];
        [menuTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        menuTable.bounces = NO;
        [menuTable setUserInteractionEnabled:YES];
        
        menuTable.delegate = self;
        menuTable.dataSource = self;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    return [self init];
}

- (void)_setup{
    CGRect frame = self.contentViewFrame;
    
    CGFloat frameMidx = self.arrowShowPoint.x-CGRectGetWidth(frame)*0.5;
    frame.origin.x = frameMidx;
    
    //we don't need the edge now
    CGFloat sideEdge = 0.0;
    if (CGRectGetWidth(frame)<CGRectGetWidth(self.containerView.frame)) {
        sideEdge = self.sideEdge;
    }
    
    //righter the edge
    CGFloat outerSideEdge = CGRectGetMaxX(frame)-CGRectGetWidth(self.containerView.bounds);
    if (outerSideEdge > 0) {
        frame.origin.x -= (outerSideEdge+sideEdge);
    }else {
        if (CGRectGetMinX(frame)<0) {
            frame.origin.x += fabs(CGRectGetMinX(frame))+sideEdge;
        }
    }
    
    self.frame = frame;
    
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    
    CGPoint anchorPoint;
    switch (self.floatMenuPosition) {
        case HFloatMenuPositionDown: {
            frame.origin.y = self.arrowShowPoint.y;
            anchorPoint = CGPointMake(arrowPoint.x/CGRectGetWidth(frame), 0);
        }
            break;
        case HFloatMenuPositionUp: {
            frame.origin.y = self.arrowShowPoint.y - CGRectGetHeight(frame) - self.arrowSize.height;
            anchorPoint = CGPointMake(arrowPoint.x/CGRectGetWidth(frame), 1);
        }
            break;
    }
    CGPoint HFM_lastAnchor = self.layer.anchorPoint;
    self.layer.anchorPoint = anchorPoint;
    self.layer.position = CGPointMake(self.layer.position.x+(anchorPoint.x-HFM_lastAnchor.x)*self.layer.bounds.size.width, self.layer.position.y+(anchorPoint.y-HFM_lastAnchor.y)*self.layer.bounds.size.height);
    
    frame.size.height += self.arrowSize.height;
    self.frame = frame;
    
}

- (void)setMenuArray:(NSArray *)menuArray{
    self.dataArray = menuArray;
    [menuTable setFrame:CGRectMake(0, 0, kHFloatMenuTableViewWidth, kHFloatMenuTableViewCellHeight*menuArray.count)];
}

- (void)setIconArray:(NSArray *)iconArray
{
    _iconArray = iconArray;
}

- (void)showAtPoint:(CGPoint)point inView:(UIView *)containerView{
    [self showAtPoint:point floatMenuPostion:HFloatMenuPositionDown withContentView:menuTable inView:containerView];
}

- (void)showAtView:(UIView *)atView inView:(UIView *)containerView{
    [self showAtView:atView floatMenuPostion:HFloatMenuPositionDown withContentView:menuTable inView:containerView];
}

- (void)showAtView:(UIView *)atView withContentView:(UIView *)contentView{
    [self showAtView:atView withContentView:contentView inView:[UIApplication sharedApplication].keyWindow];
}

- (void)showAtView:(UIView *)atView withContentView:(UIView *)contentView inView:(UIView *)containerView{
    [self showAtView:atView floatMenuPostion:HFloatMenuPositionDown withContentView:contentView inView:containerView];
}

- (void)showAtPoint:(CGPoint)point floatMenuPostion:(HFloatMenuPosition)position withContentView:(UIView *)contentView inView:(UIView *)containerView{
    NSAssert((CGRectGetWidth(contentView.bounds)>0&&CGRectGetHeight(contentView.bounds)>0), @"HFloatMenu contentView bounds.size should not be zero");
    NSAssert((CGRectGetWidth(containerView.bounds)>0&&CGRectGetHeight(containerView.bounds)>0), @"HFloatMenu containerView bounds.size should not be zero");
    NSAssert(CGRectGetWidth(containerView.bounds)>=CGRectGetWidth(contentView.bounds), @"HFloatMenu containerView width should be wider than contentView width");
    
    if (!self.bgOverLay) {
        self.bgOverLay = [[UIControl alloc] init];
        self.bgOverLay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    self.bgOverLay.frame = containerView.bounds;
    UIColor *maskColor;
    switch (self.maskType) {
        case HFloatMaskTypeNone:
            maskColor = [UIColor clearColor];
            break;
        case HFloatMaskTypeBlack:
            maskColor = [UIColor colorWithWhite:0.0 alpha:0.55] ;
            break;
        case HFLoatMaskTypeBlue:
            maskColor = [UIColor colorWithHex:0x4fc1e9 alpha:0.55];
        default:
            break;
    }
    
    self.bgOverLay.backgroundColor = maskColor;
    
    [containerView addSubview:self.bgOverLay];
    [self.bgOverLay addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.containerView = containerView;
    self.contentView = contentView;
    self.contentView.layer.cornerRadius = self.cornerRadius;
    self.contentView.layer.masksToBounds = YES;
    self.floatMenuPosition = position;
    self.arrowShowPoint = point;
    self.contentViewFrame = [containerView convertRect:contentView.frame toView:containerView];
    
    [self show];
}

- (void)showAtView:(UIView *)atView floatMenuPostion:(HFloatMenuPosition)position withContentView:(UIView *)contentView inView:(UIView *)containerView{
    CGFloat betweenArrowAndAtView = self.betweenAtViewAndArrowHeight;
    CGFloat contentViewHeight = CGRectGetHeight(contentView.bounds);
    CGRect atViewFrame = [containerView convertRect:atView.frame toView:containerView];
    
    BOOL upCanContain = CGRectGetMinY(atViewFrame) >= contentViewHeight+betweenArrowAndAtView;
    BOOL downCanContain = (CGRectGetHeight(containerView.bounds) - (CGRectGetMaxY(atViewFrame)+betweenArrowAndAtView)) >= contentViewHeight;
    NSAssert((upCanContain||downCanContain), @"HFloatMenu no place for the floatmenu show, check atView frame %@ check contentView bounds %@ and containerView's bounds %@", NSStringFromCGRect(atViewFrame), NSStringFromCGRect(contentView.bounds), NSStringFromCGRect(containerView.bounds));
    
    
    CGPoint atPoint = CGPointMake(CGRectGetMidX(atViewFrame), 0);
    HFloatMenuPosition fmP;
    if (upCanContain) {
        fmP = HFloatMenuPositionUp;
        atPoint.y = CGRectGetMinY(atViewFrame) - betweenArrowAndAtView;
    }else {
        fmP = HFloatMenuPositionDown;
        atPoint.y = CGRectGetMaxY(atViewFrame) + betweenArrowAndAtView;
    }
    
    // if they are all yes then it shows in the bigger container
    if (upCanContain && downCanContain) {
        CGFloat upHeight = CGRectGetMinY(atViewFrame);
        CGFloat downHeight = CGRectGetHeight(containerView.bounds)-CGRectGetMaxY(atViewFrame);
        BOOL useUp = upHeight > downHeight;
        
        //except you set outsider
        if (position!=0) {
            useUp = position == HFloatMenuPositionUp ? YES : NO;
        }
        if (useUp) {
            fmP = HFloatMenuPositionUp;
            atPoint.y = CGRectGetMinY(atViewFrame) - betweenArrowAndAtView;
        }else {
            fmP = HFloatMenuPositionDown;
            atPoint.y = CGRectGetMaxY(atViewFrame) + betweenArrowAndAtView;
        }
    }
    
    [self showAtPoint:atPoint floatMenuPostion:fmP withContentView:contentView inView:containerView];
}

- (void)layoutSubviews{
    [self _setup];
}

- (void)show{
    [self setNeedsDisplay];
    
    CGRect contentViewFrame = self.contentViewFrame;
    switch (_floatMenuPosition) {
        case HFloatMenuPositionUp:
            contentViewFrame.origin.y = 0.0;
            break;
        case HFloatMenuPositionDown:
            contentViewFrame.origin.y = self.arrowSize.height;
            break;
    }
    
    self.contentView.frame = contentViewFrame;
    self.contentView.userInteractionEnabled = YES;
    [self addSubview:self.contentView];
    [self.containerView addSubview:self];
    
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    //    if (0) {
    //        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    //            self.transform = CGAffineTransformIdentity;
    //        } completion:^(BOOL finished) {
    //            if (finished) {
    //                if (self.didShowHandler) {
    //                    self.didShowHandler();
    //                }
    //            }
    //        }];
    //    }else {
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.didShowHandler) {
                self.didShowHandler();
            }
        }
    }];
    //    }
}

- (void)dismiss{
    //self.animationOut
    if (self.superview) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        } completion:^(BOOL finished) {
            if (finished) {
                [self.contentView removeFromSuperview];
                [self.bgOverLay removeFromSuperview];
                [self removeFromSuperview];
                if (self.didDismissHandler) {
                    self.didDismissHandler();
                }
            }
        }];
    }
}


- (void)drawRect:(CGRect)rect{
    UIBezierPath *arrow = [[UIBezierPath alloc] init];
    UIColor *contentColor = self.contentView.backgroundColor ?self.bgColor : [UIColor whiteColor];
    //the point in the ourself view coordinator
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    
    switch (self.floatMenuPosition) {
        case HFloatMenuPositionDown: {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, 0)];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x+self.arrowSize.width*0.5, self.arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, self.arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, self.arrowSize.height+self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(270.0) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, CGRectGetHeight(self.bounds)-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
            [arrow addArcWithCenter:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds)-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, self.arrowSize.height+self.cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(self.cornerRadius, self.arrowSize.height+self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x-self.arrowSize.width*0.5, self.arrowSize.height)];
        }
            break;
        case HFloatMenuPositionUp: {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, CGRectGetHeight(self.bounds))];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x-self.arrowSize.width*0.5, CGRectGetHeight(self.bounds)-self.arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds)-self.arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds)-self.arrowSize.height-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(90.0) endAngle:DEGREES_TO_RADIANS(180.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, self.cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(270.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, 0)];
            [arrow addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(270.0) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.arrowSize.height-self.cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)-self.cornerRadius, CGRectGetHeight(self.bounds)-self.arrowSize.height-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90.0) clockwise:YES];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x+self.arrowSize.width*0.5, CGRectGetHeight(self.bounds)-self.arrowSize.height)];
        }
            
            break;
    }
    [contentColor setFill];
    [arrow fill];
}

- (void)setupHFloatMenuSubs:(UIView *)viewParent inSize:(CGSize *)pViewSize andIndex:(NSInteger)index{
    // 子窗口高宽
    NSInteger spaceXStart = 10;
    NSInteger spaceXEnd = pViewSize->width;
    NSInteger spaceYStart = 0;
    
    if (viewParent != nil)
    {
        // 图标
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(spaceXStart, (kHFloatMenuTableViewCellHeight-17)/2, 18, 17)];
        [iconImageView setImage:[UIImage imageNamed:[_iconArray objectAtIndex:index]]];
        
        [viewParent addSubview:iconImageView];
        
        spaceXStart += 18;
        spaceXStart += 8;
        
        // title
        UILabel *buttonLabel = [[UILabel alloc] initWithFont:kHFloatMenuTableViewLabelFont andText:[_dataArray objectAtIndex:index]];
        [buttonLabel setTextColor:[UIColor whiteColor]];
        [viewParent addSubview:buttonLabel];
        [buttonLabel setTextAlignment:NSTextAlignmentLeft];
        [buttonLabel setFrame:CGRectMake(spaceXStart, spaceYStart, pViewSize->width-spaceXStart, kHFloatMenuTableViewCellHeight)];
        [buttonLabel setHidden:NO];
    }
    
    spaceYStart += kHFloatMenuTableViewCellHeight;
    
    if (index < [_dataArray count]-1) {
        // 分割线
        spaceYStart -= 1;
        LineView *separatorView = [[LineView alloc] initDottedWithFrame:CGRectMake(kHFloatMenuTableViewLineVMargin, spaceYStart, spaceXEnd - kHFloatMenuTableViewLineVMargin*2, 0.5)];
        [separatorView setIsDotted:NO];
        [separatorView setArrayColor:[NSArray arrayWithObject:[UIColor colorWithHex:0x686868 alpha:1.0]]];
        [separatorView setAlpha:1];
        //保存
        [viewParent addSubview:separatorView];
        [viewParent sendSubviewToBack:separatorView];
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger curSection = 0;
    
    if (section ==  curSection) {
        return [_dataArray count];
    }
    curSection++;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect parentFrame = [tableView frame];
    
    NSString *reusedIdentifier = @"HFloatMenuCCID";
    UITableViewPlainCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedIdentifier];
    if (cell == nil){
        cell = [[UITableViewPlainCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:reusedIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBottomLineWidth:0];
    }
    // 初始化contentView
    CGSize contentViewSize = CGSizeMake(parentFrame.size.width, kHFloatMenuTableViewCellHeight);
    [[cell contentView] setFrame:CGRectMake(0, 0, contentViewSize.width, contentViewSize.height)];
    [self setupHFloatMenuSubs:[cell contentView] inSize:&contentViewSize andIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHFloatMenuTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(menuSelectedAtIndex:)]) {
        [_delegate menuSelectedAtIndex:indexPath.row];
        [self dismiss];
    }
}

@end
