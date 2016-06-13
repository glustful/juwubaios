//
//  ProductInfoWith3ColumnCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/2/3.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductInfoWith3ColumnCell.h"
#import "ProductDetailVC.h"
#import "UIButton+WebCache.h"

@implementation ProductInfoWith3ColumnCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



-(void)setYouGuessArray:(NSArray *)youGuessArray{
   
    if (youGuessArray.count>0) {
        
        NSUInteger count = (youGuessArray.count>3)?3:youGuessArray.count;
    
    _youGuessArray = youGuessArray;
    
    
    
        for (int i = 0; i<count;i++) {
        YouGuessProduct *model =youGuessArray[i];
        
        if (i == 0 )
        {
        _product1TitleLabel.text = model.t_produce_name ;
        _product1PriceLabel.text = model.t_produce_shop_price ;
            
         NSString *picUrl = [model.t_produce_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      [_product1ImageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:picUrl] forState:0  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];

        }
        // 产品2
        else if (i == 1)
        {
            _product2TitleLabel.text = model.t_produce_name ;
            _product2PriceLabel.text = model.t_produce_shop_price ;
            
            
            NSString *picUrl = [model.t_produce_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [_product2ImageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:picUrl] forState:0  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
            

        }
        // 产品3
        else if (i == 2)
        {
            _product3TitleLabel.text = model.t_produce_name ;
            _product3PriceLabel.text = model.t_produce_shop_price ;
            
            NSString *picUrl = [model.t_produce_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

               [_product3ImageButton sd_setBackgroundImageWithURL:[NSURL URLWithString:picUrl] forState:0  placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
        }
        
        

    }
        
        }
}
    

// 查看产品详情
- (IBAction)goProductDetailPageAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    YouGuessProduct *model =_youGuessArray[button.tag];

    
    ProductDetailVC *detailVC = [[ProductDetailVC alloc] initWithName:@""];
 
    detailVC.productId =model.t_produce_id;
    // 产品1
//    if (button.tag == 0 )
//    {
//        
//    }
//    // 产品2
//    else if (button.tag == 1)
//    {
//        
//    }
//    // 产品3
//    else if (button.tag == 2)
//    {
//        
//    }
    
    [_parentVC.navigationController pushViewController:detailVC animated:YES];
    
}

@end
