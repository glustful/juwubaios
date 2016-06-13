//
//  CityModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/16.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        self.cityID=dictionary[@"id"];
        self.cityName=dictionary[@"市"];
        self.distristArray=dictionary[@"县集合"];
    }
    return self;
}
@end
