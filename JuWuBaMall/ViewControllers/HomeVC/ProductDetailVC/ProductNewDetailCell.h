//
//  ProductNewDetailCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetialModel.h"

@interface ProductNewDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;//标题
/**
 *  新老价格放在一起
 */
@property (nonatomic, strong) UILabel *priceLabel;
/**
 *  颜色
 */
@property (nonatomic, strong) UILabel *colorLabel;
/**
 *  选择颜色的button
 */
@property (nonatomic, strong) UIButton *colorButton;
/**
 *  尺寸
 */
@property (nonatomic, strong) UILabel *sizeLabel;
/**
 *  尺寸Button
 */
@property (nonatomic, strong) UIButton *sizeButton;
/**
 *  数量
 */
@property (nonatomic, strong) UILabel *countLabel;
/**
 *  ➖button
 */
@property (nonatomic, strong) UIButton *jianButton;
/**
 *  具体的数量label
 */
@property (nonatomic, strong) UILabel *countDetailLabel;
/**
 *  ➕button
 */
@property (nonatomic, strong) UIButton *jiaHaoButton;
/**
 *  库存
 */
@property (nonatomic, strong) UILabel *stockLabel;



/**
 *  刷新数据  重新布局
 *
 *  @param pModel 详情模型
 */
- (void)relayoutUI:(ProductDetialModel*)pModel;






@end
