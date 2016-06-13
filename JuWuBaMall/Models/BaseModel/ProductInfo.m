//
//  ProductInfo.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductInfo.h"

@implementation ProductInfo
-(id)initWithDictionary:(NSDictionary*)dictionary{
    self=[super init];
    if (self) {
        self.imageUrl=dictionary[@"t_produce_logo"];
        self.prodcutName=dictionary[@"t_produce_name"];
        self.prodcutPrice=dictionary[@"t_produce_shop_price"];
        self.productId=dictionary[@"t_produce_id"];
    }
    return self;
}
@end
