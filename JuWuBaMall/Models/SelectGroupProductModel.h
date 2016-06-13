//
//  SelectGroupProductModel.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/15.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

/**
 *  团购列表接口
 */
#import "FMBean.h"

@interface SelectGroupProductModel : FMBean
@property (nonatomic, strong) NSString *tGroupPurchaseProductId;//产品id
@property (nonatomic, strong) NSString *tProduceName;//名称
@property (nonatomic, strong) NSString *groupProductColor;//颜色
@property (nonatomic, strong) NSString *groupProductSize;//尺寸
@property (nonatomic, strong) NSString *groupProductUnit;//单位
@property (nonatomic, strong) NSString *tGroupPurchaseDiscount;//折扣
@property (nonatomic, strong) NSString *tGroupPurchaseMoney;//原价
@property (nonatomic, strong) NSString *tGroupPurchasePicture;//图片
@property (nonatomic, strong) NSString *tGroupPurchaseProductCount;//数量
@property (nonatomic, strong) NSString *tGroupShopId;//店铺

@property (nonatomic, strong) SelectGroupProductModel *selectModel;


-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;

+ (instancetype)selectGroupProductWithDictionay:(NSDictionary *)dictionary;


@end
