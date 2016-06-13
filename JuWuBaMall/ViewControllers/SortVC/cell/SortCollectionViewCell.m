//
//  SortCollectionViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SortCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface SortCollectionViewCell ()

@end
@implementation SortCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)customWithModel:(SortLeftModel *)rightModel
{
    
    NSString *str = rightModel.t_ptype_img;
    //将url转码
    NSString *url = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    self.title.text = rightModel.t_product_typename;
}



/**
 *  for (int i = 0; i < 4; i++)
 {
 NSInteger yStart = spaceYStart;
 
 ProductInfo *productInfo = [[ ProductInfo alloc] init];
 productInfo.prodcutName = @"金瑞内墙砖（10片/件/29.5kg)优等品";
 productInfo.prodcutPrice = @"56.00元";
 
 if (i==0 || i==2) {
 
 if (isIPhone4 || isIPhone5) {
 spaceXStart = ScreenWidth-76*2-5*2;
 }
 else if (isIPhone6Plus) {
 spaceXStart = ScreenWidth-76*2-30*2;
 }
 else {
 spaceXStart = ScreenWidth-76*2-20*2;
 }
 }
 else {
 if (isIPhone4 || isIPhone5) {
 spaceXStart = ScreenWidth-76-5;
 }
 else if (isIPhone6Plus) {
 spaceXStart = ScreenWidth-76-30;
 }
 else {
 spaceXStart = ScreenWidth-76-20;
 }
 }
 
 if (i==0 || i==1) {

 */
@end
