//
//  SellersCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SellersCellClickDelegate <NSObject>

- (void)doSellersCellClick:(UIButton *)button;

@end

@interface SellersCell : UITableViewCell
@property (nonatomic, weak) id <SellersCellClickDelegate>delegate;

@end
