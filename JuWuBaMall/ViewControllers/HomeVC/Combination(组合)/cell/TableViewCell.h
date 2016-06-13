//
//  TableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/16.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;//标题的label
@property (nonatomic, strong) UIImageView *iconImageView;//产品的图片
@property (nonatomic, strong) UILabel *oldPrice;//产品的原价
@property (nonatomic, strong) UILabel *groupPrice;//产品的团购价

//- (void)reloadUI:(NSDictionary *)info;


@end
