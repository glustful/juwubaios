//
//  NewProductReusableView.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "NewProductReusableView.h"

@implementation NewProductReusableView

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)buttonClick:(TitleButton *)sender {
    UIButton *tempButton = (UIButton *)[self viewWithTag:11];
    [tempButton setTitleColor:[UIColor colorWithRed:155/255.0f green:153/255.0f blue:157/255.0f alpha:1] forState:UIControlStateNormal];
    
    static NSInteger buttonTag;
    if (buttonTag) {
        UIButton *button = (UIButton *)[self viewWithTag:buttonTag];
        [button setTitleColor:[UIColor colorWithRed:155/255.0f green:153/255.0f blue:157/255.0f alpha:1] forState:UIControlStateNormal];
        button.userInteractionEnabled = YES;
    }
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.userInteractionEnabled = YES;
    [self.delegate doCollectionHeaderClick:sender];
    buttonTag = sender.tag;
}


@end


@implementation TitleButton

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
      self.buttonClickCount=0;
    }
    return self;
}

@end
