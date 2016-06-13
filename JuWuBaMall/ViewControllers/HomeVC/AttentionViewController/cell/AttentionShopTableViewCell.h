//
//  AttentionShopTableViewCell.h
//  JuWuBaMall
//
//  Created by JWB on 16/1/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionStoreModel.h"

@interface AttentionShopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAttentionLabel;

@property (nonatomic, strong) NSString *attention_id;


- (void)customWithModel:(AttentionStoreModel *)at;


@end
