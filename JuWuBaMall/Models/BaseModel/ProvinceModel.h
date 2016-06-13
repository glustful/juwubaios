//
//  ProvinceModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/16.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject

@property(nonatomic,strong)NSString *provinceName;
@property(nonatomic,strong)NSString *provinceID;
@property(nonatomic,strong)NSMutableArray *cityArray;
-(id)initWithDictionary:(NSDictionary*)dictionary;


@end
