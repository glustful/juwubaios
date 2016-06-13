//
//  IntegralInfo.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface IntegralInfo : FMBean

@property(nonatomic,strong)NSString *t_point_avaliable_value;
@property(nonatomic,strong)NSString *t_point_detail_createtime;
@property(nonatomic,strong)NSString *t_point_detail_end_time;
@property(nonatomic,strong)NSString *t_point_detail_records_info;
@property(nonatomic,strong)NSString *t_point_detail_type;
@property(nonatomic,strong)NSString *t_point_detail_value;
@property(nonatomic,strong)NSString *t_pointvalue_detail_id;
@property(nonatomic,strong)NSString *t_produce_id;
@property(nonatomic,strong)NSString *t_produce_logo;
@property(nonatomic,strong)NSString *t_produce_name;




-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
