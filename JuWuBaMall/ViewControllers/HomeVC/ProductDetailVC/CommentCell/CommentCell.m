//
//  CommentCell.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/13.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "CommentCell.h"
#import "ProductRated.h"
//#import "OSCComment.h"
//#import "Utils.h"
//#import "Config.h"
//#import "AppDelegate.h"

#import <Masonry.h>
#import "NSString+Extent.h"
CGFloat gap = 8;
@interface CommentCell ()

@property (nonatomic, strong) UIView *currentContainer;
@property (nonatomic, strong) UIView *line;
@end



@implementation CommentCell



+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
        static NSString *ID = @"CommentCell";
        
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
        }
        return cell;
    }

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initSubviews];
//        [self setLayout];
    }
    
    return self;
}

- (void)initSubviews
{
    self.portrait = [UIImageView new];
    self.portrait.contentMode = UIViewContentModeScaleAspectFit;
    self.portrait.userInteractionEnabled = YES;
    self.portrait.backgroundColor = [UIColor grayColor];
    
    self.portrait.layer.cornerRadius = 20.0;
    self.portrait.layer.masksToBounds = YES;
    [self.contentView addSubview:self.portrait];
    
    self.authorLabel = [UILabel new];
    self.authorLabel.font = [UIFont boldSystemFontOfSize:14];
    self.authorLabel.textColor = [UIColor lightGrayColor];
    self.authorLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:self.authorLabel];
   
    
    self.rated_level1 = [UIImageView new];
    self.rated_level1.contentMode = UIViewContentModeScaleAspectFit;
    self.rated_level1.userInteractionEnabled = YES;
    //    [self.portrait setCornerRadius:5.0];
    [self.contentView addSubview:self.rated_level1];

    
    self.rated_level2 = [UIImageView new];
    self.rated_level2.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.rated_level2];
    
    
    self.rated_level3 = [UIImageView new];
    self.rated_level3.contentMode = UIViewContentModeScaleAspectFit;
      [self.contentView addSubview:self.rated_level3];
   
    self.line = [UIView new];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.line];

    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.timeLabel];
    
    
//    self.zanBtn = [UIButton new];
//    self.zanBtn.backgroundColor = [UIColor whiteColor];
//    [self.zanBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    self.zanBtn.layer.cornerRadius = 5.0;
//    self.zanBtn.layer.masksToBounds = YES;
//    self.zanBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.zanBtn.layer.borderWidth = 0.5;
    
//    [self.contentView addSubview:self.zanBtn];

//    self.repliesbtn = [UIButton new];
//    self.repliesbtn.layer.cornerRadius = 5.0;
//    self.repliesbtn.layer.masksToBounds = YES;
//
//    [self.repliesbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    self.repliesbtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.repliesbtn.layer.borderWidth = 0.5;
//    
//    
//    [self.repliesbtn setBackgroundColor:[UIColor whiteColor]];
//    [self.contentView addSubview:self.repliesbtn];

    
    
//    self.appclientLabel = [UILabel new];
//    self.appclientLabel.font = [UIFont systemFontOfSize:12];
//    self.appclientLabel .textAlignment = NSTextAlignmentLeft;
//    self.appclientLabel.textColor = [UIColor grayColor];
//    [self.contentView addSubview:self.appclientLabel];
//    
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:self.contentLabel];
}



- (void)customWithModel:(ProductRated *)comment{
   
    self.portrait.frame = CGRectMake(gap, gap, 40, 40);
    self.portrait.image = [UIImage imageNamed:@"adErrorImage"];
    self.authorLabel.frame = CGRectMake(CGRectGetMaxX(self.portrait.frame)+gap, gap, 75, 40);
    
     self.line.frame = CGRectMake(0,CGRectGetMaxY(self.authorLabel.frame)+gap/2, ScreenWidth, 0.5);
    
    self.rated_level1.frame = CGRectMake(gap,CGRectGetMaxY(self.authorLabel.frame)+ gap, 20, 20);
    self.rated_level2.frame = CGRectMake(CGRectGetMaxX(self.rated_level1.frame)+4,CGRectGetMaxY(self.authorLabel.frame)+ gap, 20, 20);

    self.rated_level3.frame = CGRectMake(CGRectGetMaxX(self.rated_level2.frame)+4,CGRectGetMaxY(self.authorLabel.frame)+ gap, 20, 20);
    
    self.rated_level3.frame = CGRectMake(CGRectGetMaxX(self.rated_level2.frame)+4,CGRectGetMaxY(self.authorLabel.frame)+ gap, 20, 20);
    
    self.rated_level1.image = [UIImage imageNamed:@"CommentStar"];
    self.rated_level2.image = [UIImage imageNamed:@"CommentStar"];
    self.rated_level3.image = [UIImage imageNamed:@"CommentStar"];
    switch ([comment.t_rated_level intValue]) {
        case 0:
        self.rated_level1.image = [UIImage imageNamed:@"star"];
            break;
        case 1:
            self.rated_level1.image = [UIImage imageNamed:@"star"];
            self.rated_level2.image = [UIImage imageNamed:@"star"];
            break;
        case 2:
            self.rated_level1.image = [UIImage imageNamed:@"star"];
            self.rated_level2.image = [UIImage imageNamed:@"star"];
            self.rated_level3.image = [UIImage imageNamed:@"star"];
            break;
        default:
            break;
    }
    
    
  
    self.contentLabel.frame = CGRectMake(gap, CGRectGetMaxY(self.rated_level1.frame)+ gap, ScreenWidth-2*gap, [comment.t_rated_content heightWithText:comment.t_rated_content font:[UIFont boldSystemFontOfSize:15.0] width:ScreenWidth-2*gap]);
    self.timeLabel.frame = CGRectMake(gap, CGRectGetMaxY(self.contentLabel.frame)+ gap, 45, 20);
    
    self.timeLabel.frame = CGRectMake(gap, CGRectGetMaxY(self.contentLabel.frame)+ gap,  (ScreenWidth-2*gap), 20);
    
//    self.zanBtn.frame = CGRectMake(gap, CGRectGetMaxY(self.timeLabel.frame)+ gap, (ScreenWidth-3*gap)/2, 30);
//    
//    [self.zanBtn setTitle:@"点赞" forState:UIControlStateNormal];
//    self.repliesbtn.frame = CGRectMake(CGRectGetMaxX(self.zanBtn.frame)+gap, CGRectGetMaxY(self.timeLabel.frame)+ gap, (ScreenWidth-3*gap)/2, 30);
//    [self.repliesbtn setTitle:@"回复" forState:UIControlStateNormal];

    self.portrait.image = [UIImage imageNamed:@""];
    self.contentLabel.text =comment.t_rated_content;
    

    self.authorLabel.text =comment.t_product_rated_id ;
    self.timeLabel.text =[NSString stringWithFormat:@"购买日期：%@",comment.t_rated_createtime ];
    
 
}

//- (void)setLayout{
//    
//    
//
//   
//    
// }


-(void)layoutSubviews{
    
    
    [super layoutSubviews];
//    self.height = CGRectGetMaxY(self.repliesbtn.frame);
}
#pragma mark - 处理长按操作

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return _canPerformAction(self, action);
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)copyText:(id)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:_contentLabel.text];
}

- (void)deleteObject:(id)sender
{
    _deleteObject(self);
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
