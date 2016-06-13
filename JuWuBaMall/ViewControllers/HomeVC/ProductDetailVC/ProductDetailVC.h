//
//  ProductDetailVC.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/2/2.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BaseVC.h"

typedef NS_ENUM(NSInteger, QueryType) {
    eProductType,
    eDetailType,
    eCommentType
};

@interface ProductDetailVC : BaseVC

@property (nonatomic, copy) NSString *productNum; // 产品数量
@property (nonatomic, assign) NSInteger queryType;

@property (nonatomic, copy)NSString* productId;///商品ID
@end
