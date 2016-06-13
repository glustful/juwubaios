//
//  MyCollectionHeader.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCollectionHeaderDelegate <NSObject>

- (void)doCollectionHeaderClick:(UIButton *)button;

@end

@interface MyCollectionHeader : UICollectionReusableView

@property (nonatomic, assign) id<MyCollectionHeaderDelegate> delegate;



@end



