//
//  NewProductReusableView.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  TitleButton;


@protocol NewProductReusableViewDelegate <NSObject>

- (void)doCollectionHeaderClick:(TitleButton *)button;

@end

@interface NewProductReusableView : UICollectionReusableView

@property(nonatomic,weak)id<NewProductReusableViewDelegate>delegate;



@end

@interface TitleButton : UIButton

@property(assign,nonatomic)NSInteger buttonClickCount;

@end