//
//  HomeSortModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/20.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface HomeSortModel : FMBean
/**
 *  类型ID
 */
@property (nonatomic, strong) NSString *typeID;
/**
 *  类型名称
 */
@property (nonatomic, strong) NSString *typeName;
/**
 *  类型图片
 */
@property (nonatomic, strong) NSString *typeImage;
/**
    类型下的商品
 */
@property (nonatomic, strong) NSMutableArray *produces;

-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
