//
//  ProvinceModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/16.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        self.provinceID=dictionary[@"id"];
        self.provinceName=dictionary[@"省"];
        self.cityArray=dictionary[@"市集合"];
    }
    return self;
}
@end
