//
//  DetailViewController.h
//  JuWuBaMall
//
//  Created by JWB on 16/2/27.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "ShopInfo.h"

@interface DetailViewController : BaseVC

@property(strong,nonatomic)ShopInfo *shopInfo;

@end
