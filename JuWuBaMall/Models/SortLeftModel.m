//
//  SortLeftModel.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/5.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SortLeftModel.h"
#import "DTApiBaseBean.h"

@implementation SortLeftModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
      
    DTAPI_DICT_ASSIGN_STRING(t_check_status, @"");
    DTAPI_DICT_ASSIGN_STRING(t_ptype_img, @"");
    DTAPI_DICT_ASSIGN_STRING(t_produce_sale_num, @"");
    DTAPI_DICT_ASSIGN_STRING(t_product_type_id, @"");
    DTAPI_DICT_ASSIGN_STRING(t_product_typedescription, @"");
    DTAPI_DICT_ASSIGN_STRING(t_product_typename, @"");
    DTAPI_DICT_ASSIGN_STRING(t_sort, @"");
    DTAPI_DICT_ASSIGN_STRING(p_id, @"");
    DTAPI_DICT_ASSIGN_STRING(is_product_attention, @"");


    }
    
    return self;
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *md=[NSMutableDictionary dictionary];
    
    DTAPI_DICT_EXPORT_BASICTYPE(t_check_status);
    DTAPI_DICT_EXPORT_BASICTYPE(t_ptype_img);
    DTAPI_DICT_EXPORT_BASICTYPE(t_produce_sale_num);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_type_id);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_typedescription);
    DTAPI_DICT_EXPORT_BASICTYPE(t_product_typename);
    DTAPI_DICT_EXPORT_BASICTYPE(t_sort);
    DTAPI_DICT_EXPORT_BASICTYPE(is_product_attention);
    DTAPI_DICT_EXPORT_BASICTYPE(p_id);

    return md;

}


@end
