//
//  HomeSortTableViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/5/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "HomeSortTableViewCell.h"
#import "HomeSortCollectionViewCell.h"
#import "HomeProductDetailModel.h"

@interface HomeSortTableViewCell ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
//@property (nonatomic, strong) NSMutableArray *dataArray;//四个模型数据的数组


@end
@implementation HomeSortTableViewCell

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     
    
}
- (void)customWithModel:(HomeSortModel *)model 
{
    static NSInteger countIndex = 0 ;
    [self.dataArray removeAllObjects];
    self.sortModel = model;
    self.sortNameLabel.text = model.typeName;
    
//    LogInfo(@"===========================================================================");
    NSMutableArray * productArr = model.produces;
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (NSDictionary *dic in productArr) {
        HomeProductDetailModel *tmpModel = [[HomeProductDetailModel alloc] initWithDictionary:dic];
        [tmpArr addObject:tmpModel];
    }
    
    
    [self.dataArray addObjectsFromArray: tmpArr];
    if (countIndex<_dataArray.count) {
    
        countIndex = _dataArray.count;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [self.myCollectionView setCollectionViewLayout:layout];

    }

    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    
//    self.myCollectionView.alwaysBounceVertical = YES;
    [self.myCollectionView reloadData];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"HomeSortCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"HomeSortCollectionViewCell"];
    
    
}



#pragma  mark- collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.rightDataArray.count;
    if (_dataArray.count>4) {
        return 4;
    }
//        LogInfo(@"===========================================================================");

    return _dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == 0) {
    //        return CGSizeMake(self.collectionView.width-10, 120);
    //    }
   
    return CGSizeMake(self.myCollectionView.width*0.5-10, self.myCollectionView.height*0.5-10);

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
    
    HomeSortCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSortCollectionViewCell" forIndexPath:indexPath];
    
//    HomeSortModel *sortModel = self.dataArray[indexPath.row];
//    NSMutableArray * productArr = self.sortModel.produces;
    //    NSMutableArray * productArr = [NSJSONSerialization JSONObjectWithData:[String dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    //    NSMutableArray *tmpArray = [NSMutableArray array];
//    for (NSDictionary *dic in productArr) {
//        HomeProductDetailModel *model = [[HomeProductDetailModel alloc] initWithDictionary:dic];
//            [cell customWithModel:model];
//    }
    
    HomeProductDetailModel *model = _dataArray[indexPath.row];
//    HomeProductDetailModel *model = [[HomeProductDetailModel alloc] initWithDictionary:tmpDic];
    
//    NSLog(@"modelName;%@", model.produceName);
    [cell customWithModel:model];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeProductDetailModel *detailModel = _dataArray[indexPath.row];
    [self.delegate productDidTouchDownwithModel:detailModel];
    
   
//    SortLeftModel *rightModel = self.rightDataArray[indexPath.row];
//    NSString *pid = rightModel.t_product_type_id;
//    NSString *pName = rightModel.t_product_typename;
//    
//    //    if (indexPath.row != 0) {
//    //        SortCollectionViewCell *cell = (SortCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    SortDetailViewController *sortVC = [[SortDetailViewController alloc]initWithName:pName];
//    sortVC.typeID = pid;
//    [self.navigationController pushViewController:sortVC animated:YES];
    
    
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//  
//  return CGSizeMake( 0,0 );
//}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)moreClickButton:(UIButton *)sender {
    
    [self.delegate moreClickButtonWithModel:self.sortModel];
    
}

//-(void)dealloc
//{
//    
//}


@end
