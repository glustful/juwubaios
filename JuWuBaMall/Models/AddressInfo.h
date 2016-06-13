//
//  AddressInfo.h
//  JuWuBaMall
//
//  Created by JWB on 16/3/10.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface AddressInfo : FMBean
@property(nonatomic,strong)NSString *t_is_default_address;//默认收货地址
@property(nonatomic,strong)NSString *t_receipt_area;//所在地区
@property(nonatomic,strong)NSString *t_user_id;//用户ID
@property(nonatomic,strong)NSString *t_receipt_streetaddress;//街道地址
@property(nonatomic,strong)NSString *t_receipt_phone;//收货人电话号码
@property(nonatomic,strong)NSString *t_receipt_zip_code;//邮编
@property(nonatomic,strong)NSString *t_receipt_name;//收货人姓名
@property(nonatomic,strong)NSString *t_receipt_id;//收货人ID
//@property(nonatomic,assign)BOOL isHaved;//判断是否已有地址


-(id)initWithDictionary:(NSDictionary*)dict;
-(NSDictionary*)dictionaryValue;


@end
