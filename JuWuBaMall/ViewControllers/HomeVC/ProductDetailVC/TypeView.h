
//
//  TypeView.m
//  AddShoppingCart
//
//  Created by jwb on 16/3/23.
//  Copyright © 2016年 yanghua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TypeSeleteDelegete <NSObject>

-(void)btnindex:(int) tag view:(UIView*)view;


@end
@interface TypeView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,retain) id<TypeSeleteDelegete> delegate;

-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename;
@end
