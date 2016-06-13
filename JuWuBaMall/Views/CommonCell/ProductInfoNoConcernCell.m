//
//  ProductInfoNoConcernCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductInfoNoConcernCell.h"
#import "ProductDetailVC.h"

@implementation ProductInfoNoConcernCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

// 查看产品详情
- (IBAction)goProductDetailPageAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    ProductDetailVC *detailVC = [[ProductDetailVC alloc] initWithName:@""];
    // 产品1
    if (button.tag == 0 )
    {
        
    }
    // 产品2
    else if (button.tag == 1)
    {
        
    }
    
    [_parentVC.navigationController pushViewController:detailVC animated:YES];
    
}

@end
