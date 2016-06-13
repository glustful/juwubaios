
//
//  BuyCountView.m
//  AddShoppingCart
//
//  Created by jwb on 16/3/23.
//  Copyright © 2016年 yanghua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyCountView : UIView<UITextFieldDelegate>
@property(nonatomic, retain)UILabel *lb;
@property(nonatomic, retain)UIButton *bt_reduce;
@property(nonatomic, retain)UITextField *tf_count;
@property(nonatomic, retain)UIButton *bt_add;
@end
