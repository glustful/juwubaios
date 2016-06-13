//
//  MyGuessYouLikeCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyGuessYouLikeCell.h"
#import "ProductDetailVC.h"
#import <UIImageView+WebCache.h>

@implementation MyGuessYouLikeCell

- (void)awakeFromNib {
    // Initialization code
    _dataArray=[NSMutableArray array];
    
    UICollectionViewFlowLayout  *layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.itemSize=CGSizeMake((ScreenWidth-40)/3, 170);
    layout.sectionInset=UIEdgeInsetsMake(0, 5, 5, 5);
    
    _myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, 200) collectionViewLayout:layout];
    _myCollectionView.backgroundColor=[UIColor whiteColor];
    _myCollectionView.dataSource=self;
    _myCollectionView.delegate=self;
//    _myCollectionView.showsHorizontalScrollIndicator=NO;
    _myCollectionView.alwaysBounceHorizontal = YES;
    _myCollectionView.pagingEnabled = YES;
    [self addSubview:_myCollectionView];
    
  
    
    
    [_myCollectionView  registerClass:[UICollectionViewCell  class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}
#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,(ScreenWidth-40)/3, 180)];
    backView.backgroundColor=[UIColor whiteColor];
    [cell addSubview:backView];
    YouGuessProduct *product=[_dataArray objectAtIndex:indexPath.row];
    
    UIImageView *logoImg=[[UIImageView alloc]init];
    logoImg.frame=CGRectMake(0, 0, 100, 100);
    NSString *url = [product.t_produce_logo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [logoImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"adErrorImage"]];
    [backView  addSubview:logoImg];
    
    UILabel *messageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, logoImg.bottom+5, logoImg.width, 40)];
    messageLabel.text=product.t_produce_name;
    messageLabel.textAlignment=NSTextAlignmentLeft;
    messageLabel.numberOfLines=0;
    messageLabel.font=[UIFont systemFontOfSize:15];
    [backView addSubview:messageLabel];
    
    
    UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, messageLabel.bottom+5, logoImg.width, 25)];
    priceLabel.text=[NSString stringWithFormat:@"￥%@/片",product.t_produce_shop_price];
    priceLabel.font=[UIFont systemFontOfSize:15];
    priceLabel.textColor=[UIColor redColor];
    [backView addSubview:priceLabel];
    
//    product.t_produce_id=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    return cell;
}
-(void)doGoToDetailViewAction:(UIButton*)button{
    ProductDetailVC *newProduct = [[ProductDetailVC alloc] initWithName:@""];
    [_parentVC.navigationController pushViewController:newProduct animated:YES];
}
#pragma mark UICollectionViewDelegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.myCollectionView deselectItemAtIndexPath:indexPath animated:YES];
     YouGuessProduct *prod=_dataArray[indexPath.row];
    ProductDetailVC *newProduct = [[ProductDetailVC alloc] initWithName:@"商品详情页"];
    newProduct.productId = prod.t_produce_id;
    [_parentVC.navigationController pushViewController:newProduct animated:YES];
    [collectionView  deselectItemAtIndexPath:indexPath animated:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
