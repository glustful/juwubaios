//
//  CityModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/16.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,strong)NSMutableArray *distristArray;
-(id)initWithDictionary:(NSDictionary*)dictionary;
@end
