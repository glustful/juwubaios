//
//  ProductDetailShowVC.h
//  JuWuBaMall
//
//  Created by yanghua on 16/5/1.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BaseVC.h"
#import "ProductDetialModel.h"
@interface ProductDetailShowVC : BaseVC

@property (strong, nonatomic)  UIWebView *detailView;
@property (copy, nonatomic) NSString* productId;
@property (copy, nonatomic) NSString*productDetailID;
@end
