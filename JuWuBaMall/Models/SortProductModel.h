//
//  SortProductModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/29.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface SortProductModel : FMBean
@property (nonatomic, strong) NSString *is_product_attention;
@property (nonatomic, strong) NSString *t_check_status;
@property (nonatomic, strong) NSString *t_produce_id;
@property (nonatomic, strong) NSString *t_produce_logo;
@property (nonatomic, strong) NSString *t_produce_name;
@property (nonatomic, strong) NSString *t_produce_sale_num;
@property (nonatomic, strong) NSString *t_produce_shop_price;
@property (nonatomic, strong) NSString *t_shop_id;
@property (nonatomic, strong) NSString *t_sort;

//@property (nonatomic, copy) NSString *produceLogo;
//@property (nonatomic, copy) NSString *produceName;
//@property (nonatomic, copy) NSString *producePrice;
//@property (nonatomic, copy) NSString *produceID;
//@property (nonatomic, copy) NSString *produceName;




-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

@end
