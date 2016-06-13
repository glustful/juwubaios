//
//  CommentHeadMode.h
//  JuWuBaMall
//
//  Created by yanghua on 16/5/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface CommentHeadMode : FMBean

@property (strong ,nonatomic)NSMutableArray *allcommentArray;
@property (strong ,nonatomic)NSMutableArray *goodcommentArray;
@property (strong ,nonatomic)NSMutableArray *neutralArray;
@property (strong ,nonatomic)NSMutableArray *badArray;

@end
