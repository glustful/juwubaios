//
//  ProductDetailCommentVC.h
//  JuWuBaMall
//
//  Created by yanghua on 16/5/1.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BaseVC.h"


//typedef NS_ENUM(NSInteger, QueryType) {
//    eProductType,
//    eDetailType,
//    eCommentType
//};

@interface ProductDetailCommentVC : BaseVC

@property (nonatomic, copy) NSString *productNum; // 产品数量
@property (nonatomic, assign) NSInteger queryType;
@property (nonatomic, copy) NSString *productId;

@end
