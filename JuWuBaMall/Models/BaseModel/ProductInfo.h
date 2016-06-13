//
//  ProductInfo.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductInfo : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *prodcutName;
@property (nonatomic, strong) NSString *prodcutPrice;

-(id)initWithDictionary:(NSDictionary*)dictionary;

@end
