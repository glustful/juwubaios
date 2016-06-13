//
//  DeatailCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/13.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "DeatailCell.h"
#import "ProductDetialModel.h"

@interface DeatailCell ()
@property (strong, nonatomic) UIWebView *detailView;

@end
@implementation DeatailCell

//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"DeatailCell";
    
    DeatailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DeatailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化操作
        
        // 2.初始化子控件
//        [self setupSubviews];
        
    }return self;
}

-(UIWebView *)detailView{
    if(!_detailView){
        _detailView = [[UIWebView alloc]init];
        [self.contentView addSubview:_detailView];
    }
    return _detailView;
    
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.detailView.frame = self.bounds;
}


- (void)customWithModel:(ProductDetialModel *)model{
    if (model.t_produce_details) {
      
        NSString *style = @"img{width:100%; float:left;} .div_con{width:100%;  float:left;  position:relative;} .div_href{ position:absolute;}";
        NSString*  htmlstr = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"><style>%@</style></head><body>%@</body></html>",style,model.t_produce_details];
        [self.detailView loadHTMLString:htmlstr baseURL:[NSURL URLWithString:KHostUrl]];
    }
    
}
@end
