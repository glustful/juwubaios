//
//  ProductDetailShopsCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/2/3.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductDetailShopsCell.h"
#import "ShopViewController.h"
#import "SelectSuggestionsPlatformVC.h"

@implementation ProductDetailShopsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)doGoShopPageAction:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"敬请期待" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
//    ShopViewController *svc = [[ShopViewController alloc] init];
//    [_parentVC presentViewController:svc animated:YES completion:nil];
    
}

#pragma mark - 选择建议通道
- (IBAction)goSelectSuggestPlatformPageAction:(id)sender
{
    SelectSuggestionsPlatformVC *selectVC = [[SelectSuggestionsPlatformVC alloc] initWithName:@"选择通道"];
    [_parentVC.navigationController pushViewController:selectVC animated:YES];
}
@end
