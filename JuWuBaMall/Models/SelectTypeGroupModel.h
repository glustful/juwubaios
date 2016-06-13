//
//  SelectTypeGroupModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

/**
 *  团购类型接口
 */
#import "FMBean.h"

@interface SelectTypeGroupModel : FMBean
@property (nonatomic, strong) NSString *t_product_typename;
@property(nonatomic,strong)   NSString *t_product_type_id;

-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
