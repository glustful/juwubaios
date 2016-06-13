//
//  WXPayObject.h
//  JuWuBaMall
//
//  Created by yanghua on 16/4/22.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FMBean.h"

@interface WXPayObject : FMBean
//appid = wx5a30d26abd8ef6e1;
//"err_code" = "OUT_TRADE_NO_USED";
//"err_code_des" = "\U5546\U6237\U8ba2\U5355\U53f7\U91cd\U590d";
//"mch_id" = 1311043801;
//"nonce_str" = 4TscqMrsdyeojsZN;
//"result_code" = FAIL;
//"return_code" = SUCCESS;
//"return_msg" = OK;
//sign = 9DCC254A5F650BE8D99E4C7A68D94F48;
//
//@property (nonatomic, strong) NSString *appid;
//@property (nonatomic, strong) NSString *err_code;
//@property (nonatomic, strong) NSString *err_code_des;
//@property (nonatomic, strong) NSString *mch_id;
//@property (nonatomic, strong) NSString *nonce_str;
//@property (nonatomic, strong) NSString *result_code;
//@property (nonatomic, strong) NSString *return_code;
//@property (nonatomic, strong) NSString *return_msg;




/*
PayReq* req             = [[PayReq alloc] init];

req.openID              = [signdict objectForKey:@"appid"];
req.partnerId           = [signdict objectForKey:@"partnerid"];
req.prepayId            = [signdict objectForKey:@"prepayid"];
req.nonceStr            = [signdict objectForKey:@"noncestr"];
NSString *time =          [signdict objectForKey:@"timestamp"];
req.timeStamp           = time.intValue;
req.package             = [signdict objectForKey:@"package"];
req.sign                = [signdict objectForKey:@"sign"];

 */


@property (nonatomic, copy) NSString *appid;
/** 商家向财付通申请的商家id */
@property (nonatomic, copy) NSString *partnerid;
/** 预支付订单 */
@property (nonatomic, copy) NSString *prepayid;
/** 随机串，防重发 */
@property (nonatomic, copy) NSString *noncestr;
/** 时间戳，防重发 */
@property (nonatomic, copy) NSString *timestamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, copy) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, copy) NSString *sign;


-(id)initWithDictionary:(NSDictionary*)dict;

-(NSDictionary*)dictionaryValue;


@end
