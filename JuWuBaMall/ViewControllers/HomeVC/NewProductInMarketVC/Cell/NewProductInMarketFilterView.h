//
//  NewProductInMarketFilterView.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewNewProductInMarketFilterViewDelegate <NSObject>

-(void)NewProductInMarketFilterViewDelegateWithButton:(UIButton*)button;

@end

@interface NewProductInMarketFilterView : UIView
@property (weak, nonatomic) IBOutlet CustomButton *CompsiteButton;
@property(weak,nonatomic)id<NewNewProductInMarketFilterViewDelegate>delegate;

@end
