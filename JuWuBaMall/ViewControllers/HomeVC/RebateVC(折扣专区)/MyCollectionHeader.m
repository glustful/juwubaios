//
//  MyCollectionHeader.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyCollectionHeader.h"


@implementation MyCollectionHeader

- (void)awakeFromNib{

}

- (IBAction)buttonClick:(UIButton *)sender {
    
    UIButton *temButton = (UIButton *)[self viewWithTag:11];
    [temButton setTitleColor:[UIColor colorWithRed:155/255.0f green:153/255.0f blue:157/255.0f alpha:1] forState:UIControlStateNormal];
    static NSInteger buttonTag;
    if (buttonTag) {
    UIButton *button = (UIButton *)[self viewWithTag:buttonTag];
    [button setTitleColor:[UIColor colorWithRed:155/255.0f green:153/255.0f blue:157/255.0f alpha:1] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.delegate doCollectionHeaderClick:sender];
    buttonTag = sender.tag;
}

@end


