//
//  HistoryListTableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/18.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryListTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton             *mb_deleteButton;
@property(nonatomic,assign)NSIndexPath          *mb_indexPath;
@property(nonatomic,strong)UILabel              *mb_label;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
