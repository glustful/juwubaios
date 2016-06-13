//
//  HomeProductAreaCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeProductAreaCell.h"
#import "HomeProductInfo.h"
#import "UIButton+WebCache.h"
#import "HomeProductDetailModel.h"

@implementation HomeProductAreaCell

- (void)awakeFromNib {
    // Initialization code
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)customWithModel:(HomeSortModel *)model
{
    self.sortModel = model;
    self.sortNameLabel.text = model.typeName;
    NSMutableArray * productArr = model.produces;
//    NSMutableArray * productArr = [NSJSONSerialization JSONObjectWithData:[String dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSDictionary *dic in productArr) {
        HomeProductDetailModel *model = [[HomeProductDetailModel alloc] initWithDictionary:dic];
        [tmpArray addObject:model];
    }
    
    [self initWithUIByArray:tmpArray];
}

- (void)initWithUIByArray:(NSMutableArray *)array
{
    for (int i = 0; i < array.count; i++) {
        HomeProductDetailModel *model = array[i];
        switch (i) {
            case 0:
                
        [self.button1 sd_setBackgroundImageWithURL:[NSURL URLWithString:model.produceLogo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
        self.priceLabel1.text = model.producePrice;
        self.nameLabel1.text = model.produceName;
                break;
            case 1:
                [self.button2 sd_setBackgroundImageWithURL:[NSURL URLWithString:model.produceLogo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
                self.priceLabel2.text = model.producePrice;
                self.nameLabel2.text = model.produceName;
                break;
            case 2:
                [self.button3 sd_setBackgroundImageWithURL:[NSURL URLWithString:model.produceLogo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
                self.priceLabel3.text = model.producePrice;
                self.nameLabel3.text = model.produceName;
                break;
            case 3:
                [self.button4 sd_setBackgroundImageWithURL:[NSURL URLWithString:model.produceLogo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
                self.priceLabel4.text = model.producePrice;
                self.nameLabel4.text = model.produceName;
                break;
                
                
            default:
                break;
        }

        
    }
}

- (IBAction)goProductDetailVCAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(productButtonDidTouchDown:withModel:)])
    {
        NSMutableArray *tmpArr = self.sortModel.produces;
        NSInteger indexRow = sender.tag-11;
        NSDictionary *tmpDic = tmpArr[indexRow];
        HomeProductDetailModel *model = [[HomeProductDetailModel alloc] initWithDictionary:tmpDic];

        [_delegate productButtonDidTouchDown:(UIButton *)sender withModel:model];
    }
}

- (IBAction)moreClickButton:(UIButton *)sender {
    
    [self.delegate moreClickButtonWithModel:self.sortModel];
    
}

@end
