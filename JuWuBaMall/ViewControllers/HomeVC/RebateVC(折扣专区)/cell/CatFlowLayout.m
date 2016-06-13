//
//  CatFlowLayout.m
//  CatFlowlayout
//
//  Created by IOS on 16/1/5.
//  Copyright © 2016年 Cat. All rights reserved.
//

#import "CatFlowLayout.h"

@implementation CatFlowLayout

-(id)init
{
    self = [super init];
    if (self){
        _naviHeight = 64.0;
        _itemNum = 0;
        _allItems = YES;
    }
    return self;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *superMutArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSMutableIndexSet *headerSections = [NSMutableIndexSet indexSet];
    //遍历数组，把所有没有header的section加入数组。
    for (UICollectionViewLayoutAttributes *attri in superMutArray){
        if ([attri.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
            break;
        }
        if (attri.representedElementCategory == UICollectionElementCategoryCell){
            [headerSections addIndex:attri.indexPath.section];
        }
    }
    //把离开屏幕被系统回收的section重新加到数组
    for(int i = 0;i < headerSections.count;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:i];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (attri){
            [superMutArray addObject:attri];
        }
    }
    
    for (UICollectionViewLayoutAttributes *attri in superMutArray){
        
        if([attri.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
            //判断是否全选，或者指定那个section悬浮
            NSInteger numItemSection;
            if (_allItems == YES){
                numItemSection = [self.collectionView numberOfItemsInSection:attri.indexPath.section];
            }else {
                if (_itemNum == attri.indexPath.section){
                    numItemSection = [self.collectionView numberOfItemsInSection:attri.indexPath.section];
                }else{
                    numItemSection = 0;
                }
            }
            //获取第一个跟最后一个item的信息
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attri.indexPath.section];
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:(numItemSection - 1) inSection:attri.indexPath.section];
            UICollectionViewLayoutAttributes *firstAttri ;
            UICollectionViewLayoutAttributes *lastAttri ;
            
            if (numItemSection > 0){
                firstAttri = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                lastAttri = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
            }else {
                firstAttri = [[UICollectionViewLayoutAttributes alloc]init];
                CGFloat y = CGRectGetMaxY(attri.frame) + self.sectionInset.top;
                firstAttri.frame = CGRectMake(0, y , 0, 0);
                lastAttri = firstAttri;
            }
            
            CGRect headerRect = attri.frame;
            //滑动到那个地方停止
            CGFloat offSet = self.collectionView.contentOffset.y + _naviHeight;
            //改变header的frame
            CGFloat headerY = firstAttri.frame.origin.y - headerRect.size.height - self.sectionInset.top;
            CGFloat MaxY = MAX(offSet, headerY);
            CGFloat headerMissY = CGRectGetMaxY(lastAttri.frame) + self.sectionInset.bottom - headerRect.size.height;
            headerRect.origin.y = MIN(MaxY, headerMissY);
            attri.frame = headerRect;
            attri.zIndex = 100;
            
        }
    }
    return  [NSArray arrayWithArray:superMutArray];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}

@end


