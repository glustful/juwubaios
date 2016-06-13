//
//  CatFlowLayout.h
//  CatFlowlayout
//
//  Created by IOS on 16/1/5.
//  Copyright © 2016年 Cat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatFlowLayout : UICollectionViewFlowLayout

@property (nonatomic , assign) CGFloat naviHeight;//默认为64.0,
@property (nonatomic , assign) int itemNum;//第几个item的头部悬浮
@property (nonatomic , assign) BOOL allItems;//是否全部悬浮，默认全部悬浮

@end
