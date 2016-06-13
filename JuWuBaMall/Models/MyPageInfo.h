//
//  MyPageInfo.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/5.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPageInfo : NSObject
@property (nonatomic, assign)NSInteger attention_product;
@property (nonatomic, assign)NSInteger attention_shop;
@property (nonatomic, assign)NSInteger browse_records;
@property (nonatomic,assign)NSInteger coupons;
@property (nonatomic,assign)NSInteger  integral;

-(id)initWithDictionary:(NSDictionary*)dictionary;


@end
