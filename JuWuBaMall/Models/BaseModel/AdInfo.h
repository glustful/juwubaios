//
//  AdInfo.h
//  ParentChildEducation
//
//  Created by zhanglan on 15/5/25.
//  Copyright (c) 2015年 lakeTechnology.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdInfo : NSObject

@property (nonatomic, strong) NSNumber *newsId;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, strong) NSString *imageUrl;
@property(nonatomic,strong)NSString *t_advertisement_href;

-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
