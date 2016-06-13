//
//  SortGussTableViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/5/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SortGussTableViewCell.h"
#import "HomeSortCollectionViewCell.h"//和主页的分类砖区的cell一致
#import "ProductDetailVC.h"//商品详情页


@interface SortGussTableViewCell ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>



@end

@implementation SortGussTableViewCell

//- (NSMutableArray *)dataArray
//{
//    if (_dataArray) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)customWithArray:(NSMutableArray *)proArray
{
    self.dataArray = [NSMutableArray arrayWithCapacity:10];
//    YouGuessProduct *pro1 = proArray[0];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.myCollectionView.collectionViewLayout = layout;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    self.myCollectionView.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1];
    self.myCollectionView.pagingEnabled = YES;
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"HomeSortCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"HomeSortCollectionViewCell"];
    [self.dataArray addObjectsFromArray: proArray];

//    [self.myCollectionView reloadData];
    
}

#pragma  mark- collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    return self.rightDataArray.count;
    return self.dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == 0) {
    //        return CGSizeMake(self.collectionView.width-10, 120);
    //    }
    return CGSizeMake(self.myCollectionView.width*0.5-10, self.myCollectionView.height-10);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    return UIEdgeInsetsMake(2, 2, 2, 2);
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == 0) {
    //        ADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ADCollectionViewCell" forIndexPath:indexPath];
    //        return cell;
    //    }
    
    //    SortLeftModel *rightModel = self.rightDataArray[indexPath.row];
    
    HomeSortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSortCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    //    [cell customWithModel:rightModel];
    
    YouGuessProduct *gussModel = self.dataArray[indexPath.row];
    [cell customWithYouGuessProduct:gussModel];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    LogInfo(@"indexPath:%ld", indexPath.row);
    YouGuessProduct *gussModel = self.dataArray[indexPath.row];
    ProductDetailVC *detailVC = [[ProductDetailVC alloc] initWithName:@"商品详情页"];
    detailVC.productId = gussModel.t_produce_id;
    [self.carVC.navigationController pushViewController:detailVC animated:YES];
}


@end
