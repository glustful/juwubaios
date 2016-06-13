//
//  AdInfo.m
//  ParentChildEducation
//
//  Created by zhanglan on 15/5/25.
//  Copyright (c) 2015年 lakeTechnology.com. All rights reserved.
//

#import "AdInfo.h"

@implementation AdInfo
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        self.newsId=dictionary[@"t_advertisement_id"];
        self.order=dictionary[@"t_advertisement_order"];
        self.imageUrl=dictionary[@"t_advertisement_images"];
        self.t_advertisement_href=dictionary[@"t_advertisement_href"];
    }
    return self;
}
@end
