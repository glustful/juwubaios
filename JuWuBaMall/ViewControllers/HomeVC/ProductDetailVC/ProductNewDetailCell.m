//
//  ProductNewDetailCell.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductNewDetailCell.h"

#define cellXStart    10

@implementation ProductNewDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
- (void)creatUI
{
    /**
     *  商品标题
     */
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    /**
     *  商品价格
     */
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    self.priceLabel.numberOfLines = 0;
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];
    
    /**
     *  颜色
     */
    self.colorLabel = [[UILabel alloc]init];
    self.colorLabel.font = [UIFont systemFontOfSize:14];
    self.colorLabel.numberOfLines = 0;
    self.colorLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.colorLabel];
    
    /**
     *  颜色按钮
     */
    self.colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.colorButton setBackgroundImage:[UIImage imageNamed:@"ActionBack_Comment.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.colorButton];
    
    /**
     *  尺寸
     */
    self.sizeLabel = [[UILabel alloc]init];
    self.sizeLabel.font = [UIFont systemFontOfSize:14];
    self.sizeLabel.numberOfLines = 0;
    self.sizeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.sizeLabel];
    
    /**
     *  尺寸按钮
     */
    self.sizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sizeButton setBackgroundImage:[UIImage imageNamed:@"ActionBack_Comment.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.sizeButton];
    
    /**
     *  数量
     */
    self.countLabel = [[UILabel alloc]init];
    self.countLabel.font = [UIFont systemFontOfSize:14];
    self.countLabel.numberOfLines = 0;
    self.countLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.countLabel];
    
    /**
     *  ➖button
     */
    self.jianButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.jianButton setBackgroundImage:[UIImage imageNamed:@"ActionBack_Comment.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.jianButton];
    
    /**
     *  具体数量Label
     */
    self.countDetailLabel = [[UILabel alloc]init];
    self.countDetailLabel.font = [UIFont systemFontOfSize:14];
    self.countDetailLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ActionBack_Comment.png"]];
    self.countDetailLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.countDetailLabel];
    
    /**
     *  ➕button
     */
    self.jiaHaoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.jiaHaoButton setBackgroundImage:[UIImage imageNamed:@"ActionBack_Comment.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.jiaHaoButton];
    
    /**
     *  库存
     */
    self.stockLabel = [[UILabel alloc]init];
    self.stockLabel.font = [UIFont systemFontOfSize:14];
    self.stockLabel.numberOfLines = 0;
    self.stockLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.stockLabel];
}



- (void)relayoutUI:(ProductDetialModel *)pModel
{
    //标题
    self.titleLabel.text = pModel.t_product_name;
    self.titleLabel.frame = CGRectMake(cellXStart, 5, ScreenWidth-20, 35);
    self.titleLabel.textColor = [UIColor blackColor];
    [self.titleLabel sizeToFit];
    
    //价格
    self.priceLabel.text = @"原价：111.0元／片    现价：110.0元／片";
    self.priceLabel.frame = CGRectMake(cellXStart, self.titleLabel.bottom, ScreenWidth-cellXStart*2, 15);
    self.priceLabel.textColor = [UIColor redColor];
    
    //颜色
    self.colorLabel.text = @"颜色:";
    self.colorLabel.frame =CGRectMake(cellXStart, self.priceLabel.bottom, 40, 20);
    
    //颜色button
    NSMutableArray *colorTitleArray = [[NSMutableArray alloc]initWithObjects:@"红色", @"黄色", @"黑色", @"蓝色", @"紫色", nil];
    
    NSInteger xSpace = 10;
    NSInteger ySpace = 10;
    NSInteger widthButton = (ScreenWidth-110-2*xSpace)*0.33;
    NSInteger heightButton = 20;
    for (int i = 0; i<5; i++) {
        UIButton *colorTemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [colorTemButton setTitle:colorTitleArray[i] forState:UIControlStateNormal];
        if (i<3) {
                  colorTemButton.frame = CGRectMake(self.colorLabel.right+30+i*(10+widthButton), self.colorLabel.top, widthButton, heightButton);
        }else{
                  colorTemButton.frame = CGRectMake(self.colorLabel.right+30+(i-3)*(10+widthButton), self.colorLabel.top+heightButton+ySpace, widthButton, heightButton);
        }
        colorTemButton.tag = 100+i;
        [colorTemButton addTarget:self action:@selector(selectColorButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:colorTemButton];
        
    }
    
}

//点击事件
- (void)selectColorButton:(UIButton *)button
{
    
}

- (void)initWithUI
{

    [self initWithUILabel:self.titleLabel];
    [self initWithUILabel:self.colorLabel];
    [self initWithUILabel:self.sizeLabel];
    [self initWithUILabel:self.countLabel];
    [self initWithUILabel:self.countDetailLabel];
    [self initWithUILabel:self.stockLabel];
    
    [self initWithCountLabel:self.countDetailLabel];

    [self initWithButton:self.colorButton];
    [self initWithButton:self.sizeButton];
    [self initWithButton:self.jianButton];
    [self initWithButton:self.jiaHaoButton];
    
}

- (void)initWithCountLabel:(UILabel *)countLabel
{
    self.countDetailLabel = [[UILabel alloc]init];
    self.countDetailLabel.font = [UIFont systemFontOfSize:14];
    self.countDetailLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ActionBack_Comment.png"]];
    self.countDetailLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.countDetailLabel];

}

- (void)initWithUILabel:(UILabel *)currentLabel
{
   
        currentLabel=[[UILabel alloc]init];
        currentLabel.font = [UIFont systemFontOfSize:14];
        currentLabel.numberOfLines = 0;
        currentLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:currentLabel];
   
}

- (void)initWithButton:(UIButton *)currentButton
{
    self.colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.colorButton setBackgroundImage:[UIImage imageNamed:@"ActionBack_Comment.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.colorButton];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
