//
//  MyGuessYouLikeCell.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "YouGuessProduct.h"


@interface MyGuessYouLikeCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) BaseVC *parentVC;
@property(nonatomic,strong) UICollectionView *myCollectionView;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end
