//
//  AreaInfo.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface AreaInfo : FMBean

@property(nonatomic,strong)NSString *t_province_city;
@property(nonatomic,strong)NSString *t_province_name;
@property(nonatomic,strong)NSString *t_province_district;
@property(nonatomic,strong)NSString *t_province_id;
@property(nonatomic,strong)NSString *t_province_type;

-(id)initWithDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionaryValue;

@end
