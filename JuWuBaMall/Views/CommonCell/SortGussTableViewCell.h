//
//  SortGussTableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/5/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouGuessProduct.h"
#import "ShoppingCarVC.h"



@interface SortGussTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;//存放数据的数组

@property (nonatomic, strong) ShoppingCarVC *carVC;





- (void)customWithArray:(NSMutableArray *)proArray;



@end
