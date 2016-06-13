//
//  TableViewCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/16.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "TableViewCell.h"

#define IconHeight 200
#define TitleLabelHeight 20
#define PriceLabelHeight 15


@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

//构造界面
- (void)initUI
{
    //创建图片
    _iconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconImageView];
    
    //创建标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    //创建原价格
    _oldPrice = [[UILabel alloc]init];
    _oldPrice.font = [UIFont systemFontOfSize:12];
    _oldPrice.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_oldPrice];
    
    //创建团购价
    _groupPrice = [[UILabel alloc]init];
    _groupPrice.font = [UIFont systemFontOfSize:12];
    _groupPrice.textColor = [UIColor redColor];
    [self.contentView addSubview:_groupPrice];

    [self reloadUI];
    
}

- (void)reloadUI
{
    NSInteger cellXStart = 0;
    NSInteger cellYStart = 0;
    
    //图片
    _iconImageView.frame = CGRectMake(cellXStart, cellYStart, ScreenWidth, IconHeight);
    _iconImageView.image =[UIImage imageNamed:@"adErrorImage.png"];
    
    cellXStart = 5;
    cellYStart += _iconImageView.height;
    
    //标题
    _titleLabel.frame = CGRectMake(cellXStart, cellYStart, ScreenWidth-10, TitleLabelHeight);
    _titleLabel.text = @"中国瓷砖商城全抛釉地板瓷砖中国瓷砖商城全抛有仿大理石地砖瓷砖客厅800*800黄色";
    [_titleLabel sizeToFit];
    
    cellXStart = 5;
    cellYStart += _titleLabel.height+2;
    
    //原价
    _oldPrice.frame = CGRectMake(cellXStart, cellYStart, ScreenWidth*0.5-5, PriceLabelHeight);
    _oldPrice.text = @"总价：234.00元／套";
    
    cellXStart += _oldPrice.width+5;

    
    //现价
    _groupPrice.frame = CGRectMake(cellXStart, cellYStart, ScreenWidth*0.5-5, PriceLabelHeight);
    _groupPrice.text = @"优惠价：12.00元／套";
    
    
    
}











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
