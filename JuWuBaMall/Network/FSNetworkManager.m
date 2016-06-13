//
//  FSNetworkManager.m
//  fangStar
//
//  Created by XuLei on 15/5/19.
//  Copyright (c) 2015年 HomelandStar. All rights reserved.
//

#import "FSNetworkManager.h"
#import "NSString+md5plus.h"
#import "Attention.h"
#import "AttentionStoreModel.h"
#import "OrderInfo.h"
#import "DiscountJuan.h"
#import "AdInfo.h"
#import "ProductInfo.h"
#import "MyPageInfo.h"
#import "ShopInfo.h"
#import "HomeProductInfo.h"
#import "SelectTypeGroupModel.h"//获取团购
#import "SelectGroupProductModel.h"//获取团购列表
#import "SeckillModel.h"
#import "SellProductModel.h"//热销
#import "SortLeftModel.h"//左侧分类
#import "HomeSortModel.h"//首页砖区
#import "ProductStatusModel.h"//商品详情页的属性信息模型
#import "SearchProductOrShopModel.h"//搜索
#import "SortProductModel.h"//查询更多同类产品

#import "ProductDetialModel.h"
#import "ProductRated.h"
#import "WXPayObject.h"

#import "OrderNewModel.h"//新的订单的模型
#import "OrderReceiveModel.h"//待收货的模型




@implementation FSNetworkManager

#pragma mark - 回调数据处理
-(BOOL)filter:(FMNetworkRequest*)networkRequest
{
    BOOL ret = NO;
    
    if (networkRequest.isSkipFilterRequest)
    {
        return YES;
    }
    
    NSString *responseString = networkRequest.responseData;
    
       LogInfo(@"\n\n%@ 返回xml数据:\n%@\n\n", networkRequest.requestName, responseString);
    
    // 返回的数据格式化为xml
    NSString *responseStringFormat = [responseString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    NSString *xmlResponseString = [responseStringFormat stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
#warning 暂时不去下面注释，待需求确定，看是否后端有数据压缩情况。
    
    LogInfo(@"\n\n%@ 返回xml数据:\n%@\n\n", networkRequest.requestName, xmlResponseString);
    
    if (!xmlResponseString || xmlResponseString.length == 0)
    {
        networkRequest.responseData = @"内容不存在";
        return NO;
    }
    

    
#pragma mark 银联支付
   if ([networkRequest.requestName isEqualToString:kRequest_User_UnionPay])
    {
        NSLog(@"%@",xmlResponseString);
        if (xmlResponseString) {
        
        if (xmlResponseString) {
            //字条串是否包含有某字符串
        if ([xmlResponseString rangeOfString:@"</br>tn="].location != NSNotFound) {
           
            NSRange range = [xmlResponseString rangeOfString:@"</br>tn="];
            NSString *ccc = [ xmlResponseString substringFromIndex:range.location+range.length];
            
            NSArray *array = [ccc componentsSeparatedByString:@"</br>"];
           if (array.count>0) {
               
                NSString *tn = array[0];
               NSLog(@"%@",tn);
                networkRequest.responseData= tn;

                return YES;
            }else{
                
                networkRequest.responseData=@"银联支付失败";
                
            }
                  } else {
                      
                      networkRequest.responseData=@"银联支付失败";

        }
            

            }
        }
        
    }
    

    
    
    
  /////////////////////////////////
    
    id retObj = [NSDictionary dictionaryWithXMLString:xmlResponseString];
    if (!retObj)
    {
        networkRequest.responseData = @"亲，服务器君开了个小差，请稍后再试";
        return NO;
    }
    
#pragma mark - 登录
    if ([networkRequest.requestName isEqualToString:kRequest_User_Login])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:userLoginResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:userLoginResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            // 错误
                            if ([[returnDic allKeys] containsObject:@"resultCode"] && [[returnDic objectForKey:@"resultCode"] integerValue] == 1)
                            {
                                if ([[returnDic allKeys] containsObject:@"msg"])
                                {
                                    networkRequest.responseData = [returnDic objectForKey:@"msg"];
                                }
                                else
                                {
                                    networkRequest.responseData = @"服务器开小差了，请稍后再试！";
                                }
                            }
                            // 成功
                            else{
                                User *user = [[User alloc] initWithDictionary:[dic objectForKey:@"return"]];
                                networkRequest.responseData = user;
                            }
                            return YES;
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"输入错误或用户不存在，请输入有效账号登录";
                }
            }
            else
            {
                networkRequest.responseData = @"输入错误或用户不存在，请输入有效账号登录";
            }
        }
    }
#pragma mark - 注册
    else if ([networkRequest.requestName isEqualToString:kRequest_User_Register])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:userRegistryResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:userRegistryResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            // 错误
                            if ([[returnDic allKeys] containsObject:@"resultCode"] && [[returnDic objectForKey:@"resultCode"] integerValue] == 1)
                            {
                                if ([[returnDic allKeys] containsObject:@"msg"])
                                {
                                    networkRequest.responseData = [returnDic objectForKey:@"msg"];
                                }
                                else
                                {
                                    networkRequest.responseData = @"服务器开小差了，请稍后再试！";
                                }
                                
                            }
                            // 成功
                            else
                            {
                                User *user = [[User alloc] initWithDictionary:[dic objectForKey:@"return"]];
                                networkRequest.responseData = user;
                            }
                            
                            return YES;
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"注册失败";
                }
            }
            else
            {
                networkRequest.responseData = @"注册失败";
            }
        }
    }
#pragma mark 发送短信
    else if ([networkRequest.requestName isEqualToString:kRequest_User_sendPhoneMessage])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:sendPhoneMessageResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:sendPhoneMessageResponse"];
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"])
                        {
                            NSString *returnDic = [dic objectForKey:@"return"];
                            
                            // 成功(返回小写的success表示成功)
                            if ([[returnDic lowercaseString] isEqualToString:@"success"])
                            {
                                networkRequest.responseData = @"短信发送成功";
                                return YES;
                            }else if([[returnDic lowercaseString]isEqualToString:@"lose"]){
                                networkRequest.responseData=@"手机号不正确";
                                return YES;
                            }
                            else
                            {
                                networkRequest.responseData = @"获取失败";
                                return YES;
                            }
                            
//                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 重置密码
    else if ([networkRequest.requestName isEqualToString:kRequest_User_ResetPassword])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:userResetPasswordResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:userResetPasswordResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            
                            for (NSDictionary *dic in returnDic)
                            {
                                User *user = [[User alloc] initWithDictionary:dic];
                                networkRequest.responseData=user;
                            }
                            
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"重置密码失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"重置密码失败";
                }
            }
            else
            {
                networkRequest.responseData = @"重置密码失败";
            }
        }
    }
#pragma mark - 查询用户详细信息
    else if ([networkRequest.requestName isEqualToString:kRequest_User_QueryUserBasicInfo])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getUserBasicInfoResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getUserBasicInfoResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            
                            
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            User *user = [[User alloc] initWithDictionary:returnDic];
                            networkRequest.responseData = user;
                            
                            return YES;
                        }
                        else{
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                    
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 我的
    else if ([networkRequest.requestName isEqualToString:kRequest_GetPageInfo])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getMyPageInfoResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getMyPageInfoResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            
                            
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            MyPageInfo *user = [[MyPageInfo alloc] initWithDictionary:returnDic];
                            networkRequest.responseData = user;
                            
                            return YES;
                        }
                        else{
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark - 修改用户信息
    else if ([networkRequest.requestName isEqualToString:kRequest_User_ModifyUserBasicInfo])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:userUpdateInfoResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:userUpdateInfoResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            User *user = [[User alloc] initWithDictionary:returnDic];
                            networkRequest.responseData = user;
                            
                            return YES;
                        }
                        else{
                            networkRequest.responseData = @"修改失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"修改失败";
                }
            }
            else
            {
                networkRequest.responseData = @"修改失败";
            }
        }
        
    }
    
#pragma mark - 根据用户ID查询订单列表
//    else if ([networkRequest.requestName isEqualToString:kRequest_user_gettOrderByUserId])
//    {
//        if ([retObj isKindOfClass:[NSDictionary class]])
//        {
//            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
//            {
//                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:queryByUserIDResponse"])
//                {
//                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:queryByUserIDResponse"];
//                    
//                    if (dic && [[dic allKeys] containsObject:@"return"])
//                    {
//                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]] && [[dic objectForKey:@"return"] count] > 0)
//                        {
//                            NSArray *returnDic = [dic objectForKey:@"return"];
//                            
//                            NSMutableArray *orderList = [[NSMutableArray alloc] init];
//                            
//                            for (NSDictionary *dic in returnDic) {
//                                OrderInfo *user = [[OrderInfo alloc] initWithDictionary:dic];
//                                
//                                [orderList addObject:user];
//                            }
//                            networkRequest.responseData = orderList;
//                            
//                            return YES;
//                        }
//                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
//                            NSDictionary *dict=dic[@"return"];
//                            OrderInfo *order=[[OrderInfo alloc]initWithDictionary:dict];
//                            networkRequest.responseData=order;
//                            return YES;
//                        }
//                    }
//                }
//                else
//                {
//                    networkRequest.responseData = @"获取失败";
//                }
//            }
//            else
//            {
//                networkRequest.responseData = @"获取失败";
//            }
//        }
//     }
#pragma mark  取消订单
    else if ([networkRequest.requestName isEqualToString:kRequest_User_CancelOrder])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:cancelOrderResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:cancelOrderResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] isKindOfClass:[NSString class]])
                        {
                            NSString *returnDic = [dic objectForKey:@"return"];
                            
                            // 成功
                            if ([[returnDic lowercaseString] isEqualToString:@"true"])
                            {
                                networkRequest.responseData = @"取消成功";
                            }
                            else
                            {
                                networkRequest.responseData = @"失败";
                            }
                            
                            return YES;
                        }
                        else
                        {
                            networkRequest.responseData = @"失败";
                        }
                    }
                    else
                    {
                        networkRequest.responseData = @"失败";
                    }
                }
                else
                {
                    networkRequest.responseData = @"失败";
                }
            }
            else
            {
                networkRequest.responseData = @"失败";
            }
        }
    }
    
//#pragma mark 根据订单类型和用户ID获得订单的信息
//    else if ([networkRequest.requestName isEqualToString:kRequest_User_getOrderProductByOrderTypeAndUserId])
//    {
//        if ([retObj isKindOfClass:[NSDictionary class]])
//        {
//            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
//            {
//                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getOrderCollectingGoods"])
//                {
//                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getOrderCollectingGoods"];
//                    
//                    if (dic && [[dic allKeys] containsObject:@"return"])
//                    {
//                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]])
//                        {
//                            NSDictionary *returnDic = [dic objectForKey:@"return"];
//                            
//                            OrderNewModel *orderModel = [[OrderNewModel alloc]initWithDictionary:returnDic];
//                            networkRequest.responseData = orderModel;
//                            return YES;
//                            
//                        }
//                        else
//                        {
//                            NSMutableArray *arrDic = [dic objectForKey:@"return"];
//                            NSMutableArray *tmpArr = [NSMutableArray array];
//                            for (NSMutableDictionary *tmpDic in arrDic) {
//                                OrderNewModel *orderModel = [[OrderNewModel alloc]initWithDictionary:tmpDic];
//                                [tmpArr addObject:orderModel];
//                            }
//                            networkRequest.responseData = tmpArr;
//                            return YES;
//                            
//                        }
//                    }
//                    else
//                    {
//                        networkRequest.responseData = @"暂无订单";
////                        return YES;
//
//                    }
//                }
//                else
//                {
//                    networkRequest.responseData = @"获取订单列表失败";
//                }
//            }
//            else
//            {
//                networkRequest.responseData = @"获取订单列表失败";
//            }
//        }
//    }
    
    
#pragma mark 根据订单类型和用户ID获得订单的信息
    else if ([networkRequest.requestName isEqualToString:kRequest_User_getOrderProductByOrderTypeAndUserId])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getOrderProductByOrderTypeAndUserIdV2Response"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getOrderProductByOrderTypeAndUserIdV2Response"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"]  && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]])
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            OrderNewModel *orderModel = [[OrderNewModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = orderModel;
                            return YES;
                            
                        }
                        else if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] isKindOfClass:[NSArray class]])
                        {
                            NSMutableArray *arrDic = [dic objectForKey:@"return"];
                            NSMutableArray *tmpArr = [NSMutableArray array];
                            for (NSMutableDictionary *tmpDic in arrDic) {
                                OrderNewModel *orderModel = [[OrderNewModel alloc]initWithDictionary:tmpDic];
                                [tmpArr addObject:orderModel];
                            }
                            networkRequest.responseData = tmpArr;
                            return YES;
                            
                        }
                    }
                    else
                    {
                        networkRequest.responseData = @"亲、还没有订单哦😢";
                        //                        return YES;
                        
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取订单列表失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取订单列表失败";
            }
        }
    }
 
#pragma mark    根据用户id和订单id查询订单相关信息  在待付款里面的点击接口
    else if ([networkRequest.requestName isEqualToString:kRequest_User_selectOrderbyOrderidAndUserid])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getOrderbyOrderidAndUseridV2Response"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getOrderbyOrderidAndUseridV2Response"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]])
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            OrderReceiveModel *orderModel = [[OrderReceiveModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = orderModel;
                            return YES;
                            
                        }
                        else if( [[dic objectForKey:@"return"] isKindOfClass:[NSArray class]])
                        {
                            NSMutableArray *arrDic = [dic objectForKey:@"return"];
                            NSMutableArray *tmpArr = [NSMutableArray array];
                            for (NSMutableDictionary *tmpDic in arrDic) {
                                OrderReceiveModel *orderModel = [[OrderReceiveModel alloc]initWithDictionary:tmpDic];
                                [tmpArr addObject:orderModel];
                            }
                            networkRequest.responseData = tmpArr;
                            return YES;
                        }
                    }
                    else
                    {
                        networkRequest.responseData = @"亲、还没有订单哦😢";
                        //                        return YES;
                        
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取订单列表失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取订单列表失败";
            }
        }
    }
    
#pragma mark 获取待收货订单接口
    else if ([networkRequest.requestName isEqualToString:kRequest_User_getOrderCollectingGoods])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getOrderCollectingGoodsV2Response"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getOrderCollectingGoodsV2Response"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]])
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            OrderReceiveModel *orderModel = [[OrderReceiveModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = orderModel;
                            return YES;
                            
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]])
                        {
                            NSMutableArray *arrDic = [dic objectForKey:@"return"];
                            NSMutableArray *tmpArr = [NSMutableArray array];
                            for (NSMutableDictionary *tmpDic in arrDic) {
                                OrderReceiveModel *orderModel = [[OrderReceiveModel alloc]initWithDictionary:tmpDic];
                                [tmpArr addObject:orderModel];
                            }
                            networkRequest.responseData = tmpArr;
                            return YES;
                            
                        }
                    }
                    else
                    {
                        networkRequest.responseData = @"亲、还没有订单哦😢";
                        //                        return YES;
                        
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取订单列表失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取订单列表失败";
            }
        }
    }

#pragma mark 根据用户ID分页获得用户所有订单
    else if ([networkRequest.requestName isEqualToString:kRequest_User_getOrderProductByUserIdCount])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getOrderProductByOrderUserIdResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getOrderProductByOrderUserIdResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]])
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            OrderNewModel *orderModel = [[OrderNewModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = orderModel;
                            return YES;
                            
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]])
                        {
                            NSMutableArray *arrDic = [dic objectForKey:@"return"];
                            NSMutableArray *tmpArr = [NSMutableArray array];
                            for (NSMutableDictionary *tmpDic in arrDic) {
                                OrderNewModel *orderModel = [[OrderNewModel alloc]initWithDictionary:tmpDic];
                                [tmpArr addObject:orderModel];
                            }
                            networkRequest.responseData = tmpArr;
                            return YES;
                            
                        }
                    }
                    else
                    {
                        networkRequest.responseData = @"亲、还没有订单哦😢";
                        //                        return YES;
                        
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取订单列表失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取订单列表失败";
            }
        }
    }
    
    /**
     *  6月1日订单新加入的接口
     */
#pragma mark 根据用户ID分页获得用户所有订单
    else if ([networkRequest.requestName isEqualToString:kRequest_User_findAllOrderByUderId])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:findAllOrderByUderIdResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:findAllOrderByUderIdResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]])
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            OrderNewModel *orderModel = [[OrderNewModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = orderModel;
                            return YES;
                            
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]])
                        {
                            NSMutableArray *arrDic = [dic objectForKey:@"return"];
                            NSMutableArray *tmpArr = [NSMutableArray array];
                            for (NSMutableDictionary *tmpDic in arrDic) {
                                OrderNewModel *orderModel = [[OrderNewModel alloc]initWithDictionary:tmpDic];
                                [tmpArr addObject:orderModel];
                            }
                            networkRequest.responseData = tmpArr;
                            return YES;
                            
                        }
                    }
                    else
                    {
                        networkRequest.responseData = @"亲、还没有订单哦😢";
                        return YES;
                        
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取订单列表失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取订单列表失败";
            }
        }
    }
    
    
    
#pragma mark-  加入购物车
    else if ([networkRequest.requestName isEqualToString:kRequest_User_AddToShoppingCar])
    {
        LogInfo(@"%@",retObj);
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:addToShoppingCarResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:addToShoppingCarResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] isKindOfClass:[NSString class]])
                        {
                            NSString *returnDic = [dic objectForKey:@"return"];
                            // 成功
                            if ([[returnDic lowercaseString] isEqualToString:@"true"])
                            {
                                networkRequest.responseData = @"亲，加到购物车了";
                            }
                            else
                            {
                                networkRequest.responseData = @"加入购物车失败";
                            }
                            return YES;
                        }
                        else
                        {
                            networkRequest.responseData = @"加入购物车失败";
                        }
                    }
                    else
                    {
                        networkRequest.responseData = @"加入购物车失败";
                    }
                }
                else
                {
                    networkRequest.responseData = @"加入购物车失败";
                }
            }
            else
            {
                networkRequest.responseData = @"加入购物车失败";
            }
        }
        
    }
#pragma mark  通过用户ID查询购物车（by userid）
    else if ([networkRequest.requestName isEqualToString:kRequest_User_SelectShopCarByUserId])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:selectShopCarByUserIdResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:selectShopCarByUserIdResponse"];

                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]])
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            networkRequest.responseData=returnDic;
                            return YES;

                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                            NSMutableArray *returnArr = [dic objectForKey:@"return"];
                            networkRequest.responseData = returnArr;
                            return YES;
                        }
                    }
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
    
#pragma mark 删除购物车内某个商品
    else if ([networkRequest.requestName isEqualToString:kRequest_User_clearShoppingCar])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:clearShoppingCarsResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:clearShoppingCarsResponse"];
                    
                            NSString *returnStr = [dic objectForKey:@"return"];
                            networkRequest.responseData=returnStr;
                            return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }

    
#pragma mark - 查询购物车
#warning todo 待后端修改
    else if ([networkRequest.requestName isEqualToString:kRequest_User_SelectShopCar])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:selectShopCarResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:selectShopCarResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"]&& [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]])
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *array=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic)
                            {
                                FSBShoppingCarProductInfo *productInfo=[[FSBShoppingCarProductInfo alloc]initWithDictionary:dic];
                                [array addObject:productInfo];
                            }
                            networkRequest.responseData=array;
                            return YES;
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]){
                            NSDictionary *tmpDic = [dic objectForKey:@"return"];
                            FSBShoppingCarProductInfo *productInfo=[[FSBShoppingCarProductInfo alloc]initWithDictionary:tmpDic];
                            networkRequest.responseData = productInfo;
                        
                        }
                    }
                    
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 新增收货地址
    else if ([networkRequest.requestName isEqualToString:kRequest_User_AddBuyerAddress])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:userAddBuyerAddressResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:userAddBuyerAddressResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] isKindOfClass:[NSString class]])
                        {
                            NSString *returnDic = [dic objectForKey:@"return"];
                            
                            // 成功(大写的SUCCESS表示成功)
                            if ([[returnDic uppercaseString] isEqualToString:@"SUCCESS"])
                            {
                                networkRequest.responseData = @"添加成功";
                            }
                            else
                            {
                                networkRequest.responseData = @"添加失败";
                            }
                            
                            return YES;
                        }
                        else
                        {
                            networkRequest.responseData = @"添加失败";
                        }
                    }
                    else
                    {
                        networkRequest.responseData = @"添加失败";
                    }
                }
                else
                {
                    networkRequest.responseData = @"添加失败";
                }
            }
            else
            {
                networkRequest.responseData = @"添加失败";
            }
        }
    }
#pragma mark 用户列出所有收货地址
    else if ([networkRequest.requestName isEqualToString: kRequest_User_AllReceiveAddress])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:ListReceiveAddrResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:ListReceiveAddrResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            //                            NSArray *returnDic = [dic objectForKey:@"return"];
                            //
                            //                            NSMutableArray *array=[[NSMutableArray alloc]init];
                            //
                            //                            for (NSDictionary *dic in returnDic)
                            //                            {
                            //                                AddressInfo  *address = [[AddressInfo alloc] initWithDictionary:dic];
                            //                                [array  addObject:address];
                            //                            }
                            //                            networkRequest.responseData=array;
                            //                            return YES;
                            
                            
                            if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                                NSDictionary *returnDic = [dic objectForKey:@"return"];
                                AddressInfo *att = [[AddressInfo alloc]initWithDictionary:returnDic];
                                networkRequest.responseData = att;
                                return YES;
                            }else{
                                NSMutableArray *returnDic = [dic objectForKey:@"return"];
                                
                                
                                NSMutableArray *tmpDataArr = [NSMutableArray array];
                                
                                for (NSDictionary *dic in returnDic) {
                                    AddressInfo *att = [[AddressInfo alloc]initWithDictionary:dic];
                                    [tmpDataArr addObject:att];
                                    
                                }
                                networkRequest.responseData = tmpDataArr;
                                
                                
                                return YES;
                            }
                            
                        }
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *dataDic=[dic objectForKey:@"return"];
                            AddressInfo *address=[[AddressInfo alloc]initWithDictionary:dataDic];
                            networkRequest.responseData=address;
                            return YES;
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
    
#pragma mark 查找用户默认的收货地址
    else if ([networkRequest.requestName isEqualToString:kRequest_user_defaultAddress])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getDefaultAddrResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getDefaultAddrResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSDictionary *tmpDic = [dic objectForKey:@"return"];
                      
                            AddressInfo *user = [[AddressInfo alloc] initWithDictionary:tmpDic];
             
                            networkRequest.responseData = user;
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 设置该地址为用户的默认地址
    else if ([networkRequest.requestName isEqualToString:kRequest_User_setDefaultAddress])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:setToDefaultAddrResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:setToDefaultAddrResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
//                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
//                        {
                            NSString *returnDic = [dic objectForKey:@"return"];
                            
                            // 成功
                            if ([[returnDic uppercaseString] isEqualToString:@"SUCCESS"])
                            {
                                networkRequest.responseData = @"设置成功";
                            }
                            else
                            {
                                networkRequest.responseData = @"设置失败";
                            }
                            
                            return YES;
//                        }
//                        else {
//                            networkRequest.responseData = @"设置失败";
//                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"设置失败";
                }
            }
            else
            {
                networkRequest.responseData = @"设置失败";
            }
        }
        
    }
    
#pragma mark 修改收货地址
    else if ([networkRequest.requestName isEqualToString:kRequest_User_ChangeAddress])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:changeAddrResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:changeAddrResponse"];
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"])
                        {
                            NSString *returnDic = [dic objectForKey:@"return"];
                            
                            // 成功(返回大写的SUCCESS表示成功)
                            if ([[returnDic uppercaseString] isEqualToString:@"SUCCESS"])
                            {
                                networkRequest.responseData = @"修改成功";
                            }
                            else
                            {
                                networkRequest.responseData = @"修改失败";
                            }
                            
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"修改失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"修改失败";
                }
            }
            else
            {
                networkRequest.responseData = @"修改失败";
            }
        }
        
    }
#pragma mark 删除一条收货地址
    else if ([networkRequest.requestName isEqualToString:kRequest_User_DeleteAddress])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:deleteAddrResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:deleteAddrResponse"];
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"])
                        {
                            NSString *returnDic = [dic objectForKey:@"return"];
                            
                            // 成功(返回大写的SUCCESS表示成功)
                            if ([[returnDic uppercaseString] isEqualToString:@"SUCCESS"])
                            {
                                networkRequest.responseData = @"删除成功";
                            }
                            else
                            {
                                networkRequest.responseData = @"删除失败";
                            }
                            
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"删除失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"删除失败";
                }
            }
            else
            {
                networkRequest.responseData = @"删除失败";
            }
        }
        
    }
#pragma mark 根据ID获取优惠券信息
    else if ([networkRequest.requestName isEqualToString:kRequest_GetElectronicVolumeOfUser])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getElectronicVolumeOfUserResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getElectronicVolumeOfUserResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *array=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic)
                            {
                                DiscountJuan *discount=[[DiscountJuan alloc]initWithDictionary:dic];
                                [array addObject:discount];
                            }
                            networkRequest.responseData=array;
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 获得所有优惠券
    else if ([networkRequest.requestName isEqualToString:KRequest_GetAllElectronicVolume])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getAllElectronicVolumeResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAllElectronicVolumeResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]]) {
                            
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *array=[NSMutableArray array];
                            for (NSDictionary *tmpDic in returnDic)
                            {
                                DiscountJuan *discount=[[DiscountJuan alloc]initWithDictionary:tmpDic];
                                [array addObject:discount];
                            }
                            networkRequest.responseData=array;
                            return YES;
                        }else if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]){
                            NSDictionary *tmpDic = [dic objectForKey:@"return"];
                            DiscountJuan *discount=[[DiscountJuan alloc]initWithDictionary:tmpDic];
                            networkRequest.responseData=discount;
                            return YES;

                        }

                   
                      
                    }
                    networkRequest.responseData = @"没有优惠券哦亲😢";
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 获得优惠券详情
    else if ([networkRequest.requestName isEqualToString:kRequest_GetElectronicVolumeDetail])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:geTElectricVolumeDetailResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:geTElectricVolumeDetailResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            
                            for (NSDictionary *dic in returnDic)
                            {
                                DiscountJuan *discount=[[DiscountJuan alloc]initWithDictionary:dic];
                                networkRequest.responseData=discount;
                            }
                            
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 新增优惠券
    else if ([networkRequest.requestName isEqualToString:kRequest_AddElectronicVolume])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:addElectronicVolumeResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:addElectronicVolumeResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [dic objectForKey:@"return"] )
                        {
                            NSString *returnDic = [dic objectForKey:@"return"];
                            
                            // 成功(小写的true表示成功)
                            if ([[returnDic lowercaseString] isEqualToString:@"true"])
                            {
                                networkRequest.responseData = @"领取成功";
                            }
                            else
                            {
                                networkRequest.responseData = @"领取失败";
                            }
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"领取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"领取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"领取失败";
            }
        }
    }
#pragma mark 获得可用优惠券
    else if ([networkRequest.requestName isEqualToString:kRequest_GetPossibleElectronicVolume])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getPossibleElectronicVolumeResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getPossibleElectronicVolumeResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"]&&[[dic objectForKey:@"return"]count]>0)
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]])
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *array=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic)
                            {
                                DiscountJuan *discount=[[DiscountJuan alloc]initWithDictionary:dic];
                                [array addObject:discount];
                            }
                            networkRequest.responseData=array;
                            return YES;
                        }else if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic=[dic objectForKey:@"return"];
                            DiscountJuan *juan=[[DiscountJuan alloc]initWithDictionary:returnDic];
                            networkRequest.responseData=juan;
                            return YES;
                        }
                    }
                     networkRequest.responseData = @"亲、没有优惠券哦";
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 积分列表
    else if ([networkRequest.requestName isEqualToString:kRequest_User_QueryItegralList])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getAllPointValueOutResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAllPointValueOutResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]&&[[dic objectForKey:@"return"]count ]>0)
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *array=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic)
                            {
                                IntegralInfo *intrgral=[[IntegralInfo alloc]initWithDictionary:dic];
                                [array addObject:intrgral];
                            }
                            networkRequest.responseData=array;
                            return YES;
                        }
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic=[dic objectForKey:@"return"];
                            IntegralInfo *juan=[[IntegralInfo alloc]initWithDictionary:returnDic];
                            networkRequest.responseData=juan;
                            return YES;
                        }
                    }
                    
                    networkRequest.responseData = @"暂无积分";
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 积分收入列表
    else if ([networkRequest.requestName isEqualToString:kRequest_User_GetPointValueIN])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getPointValueInResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getPointValueInResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]&&[[dic objectForKey:@"return"]count ]>0)
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *array=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic)
                            {
                                IntegralInfo *intrgral=[[IntegralInfo alloc]initWithDictionary:dic];
                                [array addObject:intrgral];
                            }
                            networkRequest.responseData=array;
                            return YES;
                        }
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic=[dic objectForKey:@"return"];
                            IntegralInfo *juan=[[IntegralInfo alloc]initWithDictionary:returnDic];
                            networkRequest.responseData=juan;
                            return YES;
                        }
                    }
                    
                    networkRequest.responseData = @"暂无积分";


                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 积分支出列表
    else if ([networkRequest.requestName isEqualToString:kRequest_User_GetPointValueOut])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getPointValueOutResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getPointValueOutResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]&&[[dic objectForKey:@"return"]count ]>0)
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *array=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic)
                            {
                                IntegralInfo *intrgral=[[IntegralInfo alloc]initWithDictionary:dic];
                                [array addObject:intrgral];
                            }
                            networkRequest.responseData=array;
                            return YES;
                        }
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic=[dic objectForKey:@"return"];
                            IntegralInfo *juan=[[IntegralInfo alloc]initWithDictionary:returnDic];
                            networkRequest.responseData=juan;
                            return YES;
                        }
                    }
                    
                    networkRequest.responseData = @"亲、还没有积分哦😢";

                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 可用积分
#pragma mark 获得即将过期积分时间
    
    
#pragma mark 所有地区信息
    else if ([networkRequest.requestName isEqualToString:kRequest_QueryAllProvince])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:phoneGetTProvinceResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:phoneGetTProvinceResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"])
                        {
                            NSString *dataString = [dic objectForKey:@"return"];
                            NSDictionary *dataDic=[NSJSONSerialization  JSONObjectWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                            NSArray *array=dataDic[@"provice"];
                            networkRequest.responseData=array;
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 所有地区版本信息
    else if ([networkRequest.requestName isEqualToString:Krequest_QueryProvince])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getProviceNameCodeResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getProviceNameCodeResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"])
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            networkRequest.responseData=returnDic;
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }

    
#pragma mark 品牌列表
    else if ([networkRequest.requestName isEqualToString:kRequest_TpBrandList])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:selectPbrandInfoResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:selectPbrandInfoResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            NSMutableArray *dataArray=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic) {
                                Brand *brand=[[Brand alloc]initWithDictionary:dic];
                                [dataArray addObject:brand];
                            }
                            networkRequest.responseData=dataArray;
                            
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                    networkRequest.responseData = @"亲、暂时还没有品牌哦😢";
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 品牌关注人数
    else if ([networkRequest.requestName isEqualToString:kRequest_SelectBrand_attentionNum])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:selectBrand_attention_numResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:selectBrand_attention_numResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"])
                        {
                            NSString *number =[dic objectForKey:@"return"];
                            
                            networkRequest.responseData=number;
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 品牌列出部分商品
    else if ([networkRequest.requestName isEqualToString:kRequest_getBrandProduct])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getBrandLibraryProductResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getBrandLibraryProductResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"]&& [[dic objectForKey:@"return"] count] > 0)
                        {
                            
                            if([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]]){
                                NSMutableArray *returnDic = [dic objectForKey:@"return"];
                                
                                NSMutableArray *dataArray=[NSMutableArray array];
                                for (NSDictionary *dic in returnDic) {
                                    SortProductModel *product=[[SortProductModel alloc]initWithDictionary:dic];
                                    [dataArray addObject:product];
                                }
                                networkRequest.responseData=dataArray;
                                
                                return YES;

                            }else  if([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]){
                                NSDictionary *dicTmp = [dic objectForKey:@"return"];
                                 SortProductModel *product=[[SortProductModel alloc]initWithDictionary:dicTmp];
                                
                                
                                networkRequest.responseData = product;
                                return YES;
                            }
                            
                        }
                        else {
                            networkRequest.responseData = @"亲、该品牌没有商品了哦😢";
                            return YES;
                        }
                    }
                    
                    networkRequest.responseData = @"暂无商品";
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
    
#pragma mark 店铺
    else if ([networkRequest.requestName isEqualToString:kRequest_ShopInfo])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getPhoneShopDetailPageResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getPhoneShopDetailPageResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            ShopInfo *shop=[[ShopInfo alloc]initWithDictionary:returnDic];
                            networkRequest.responseData=shop;
                            return YES;
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 新闻
    else if ([networkRequest.requestName isEqualToString:kRequest_getNewsInfo])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getNewsInfoResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getNewsInfoResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]] )
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSLog(@"%@",returnDic);
                            
                            NSMutableArray *dataArray=[NSMutableArray array];
                            for (NSDictionary *tmpDic in returnDic) {
                                NewsInfo *news=[[NewsInfo alloc]initWithDictionary:tmpDic];
                                [dataArray addObject:news];
                                
                            }
                            networkRequest.responseData=dataArray;
                            return YES;
                        }else if([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                           NSDictionary *returnDic=dic[@"return"];
                           NewsInfo *news=[[NewsInfo alloc]initWithDictionary:returnDic];
                           networkRequest.responseData=news;
                           return YES;
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"亲、还没有新闻哦😢";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 广告
    else if ([networkRequest.requestName isEqualToString:kRequest_AdvertisementList])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:adListResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:adListResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                                NSArray *returnDic = [dic objectForKey:@"return"];
                                NSMutableArray *dataArray=[NSMutableArray array];
                                for (NSDictionary *tmpDic in returnDic) {
                                    AdInfo *ad=[[AdInfo alloc]initWithDictionary:tmpDic];
                                    [dataArray addObject:ad];
                                }
                                networkRequest.responseData=dataArray;
                                return YES;

                            }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]){
                                
                                NSDictionary *tmpDic = [dic objectForKey:@"return"];
                                AdInfo *ad=[[AdInfo alloc]initWithDictionary:tmpDic];
                                networkRequest.responseData = ad;
                                return YES;
                            }
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
    
#pragma mark 获得指定位置的广告
    else if ([networkRequest.requestName isEqualToString:kRequest_adListByPosition])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:adListByPositionResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:adListByPositionResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                                NSArray *returnDic = [dic objectForKey:@"return"];
                                
                            [[FMStorageManager sharedInstance] storeArray:returnDic withFileName:kRequest_adListByPosition];
                                
                             NSMutableArray *dataArray=[NSMutableArray array];
                               
                                for (NSDictionary *tmpDic in returnDic) {
                                    AdInfo *ad=[[AdInfo alloc]initWithDictionary:tmpDic];
                                    [dataArray addObject:ad];
                                }
                                networkRequest.responseData=dataArray;
                                return YES;
                                
                            }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]){
                                
                              
                                
                                NSMutableArray *dataArray=[NSMutableArray array];
                                
                                NSDictionary *tmpDic = [dic objectForKey:@"return"];
                                AdInfo *ad=[[AdInfo alloc]initWithDictionary:tmpDic];
                                [dataArray addObject:ad];
                                
                                [[FMStorageManager sharedInstance] storeArray:dataArray withFileName:kRequest_adListByPosition];
                                networkRequest.responseData = ad;
                                return YES;
                            }
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }

    
#pragma mark 分类左侧列表
    else if ([networkRequest.requestName isEqualToString:kRequest_getAllPCAllProduct])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getAllPCAllProductDetialTypeResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAllPCAllProductDetialTypeResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            
                            if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]) {
                                NSArray *returnDic = [dic objectForKey:@"return"];
                                NSMutableArray *dataArray=[NSMutableArray array];
                                for (NSDictionary *tmpDic in returnDic) {
                                    HomeProductInfo *product=[[HomeProductInfo alloc]initWithDictionary:tmpDic];
                                    [dataArray addObject:product];
                                }
                                 networkRequest.responseData=dataArray;
                                return YES;

                            }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]){
                                NSDictionary *tmpDic = [dic objectForKey:@"return"];
                                HomeProductInfo *product=[[HomeProductInfo alloc]initWithDictionary:tmpDic];
                                networkRequest.responseData = product;
                                return YES;
                            }
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                    
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
    
#pragma mark 查询更多分类产品
    else if ([networkRequest.requestName isEqualToString:kRequest_getAppProductByTypePid])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getAppProductByTypePidResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAppProductByTypePidResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"]&& [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([dic objectForKey:@"return"] )
                        {
                            if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                                NSDictionary *returnDic = [dic objectForKey:@"return"];
                                SortProductModel *att = [[SortProductModel alloc]initWithDictionary:returnDic];
                                networkRequest.responseData = att;
                                return YES;
                            }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                                NSMutableArray *returnDic = [dic objectForKey:@"return"];
                                NSMutableArray *tmpDataArr = [NSMutableArray array];
                                for (NSDictionary *dic in returnDic) {

                                    SortProductModel *att = [[SortProductModel alloc]initWithDictionary:dic];
                                    [tmpDataArr addObject:att];
                                    
                                }
                                networkRequest.responseData = tmpDataArr;
                                
                                return YES;
                            }
                            
                        }
                        else
                        {
                            networkRequest.responseData = @"亲、没有商品了哦😢";
                            return YES;
                        }
                    }
                    networkRequest.responseData = @"亲、没有商品了哦😢";
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败2";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败1";
            }
        }
        
    }
#pragma mark 查询小分类产品 （分类页面的小分类接口）
    else if ([networkRequest.requestName isEqualToString:kRequest_appselectproductByTypeId])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:appselectproductByTypeIdResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:appselectproductByTypeIdResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"]&& [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([dic objectForKey:@"return"] )
                        {
                            if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                                NSDictionary *returnDic = [dic objectForKey:@"return"];
                                SortProductModel *att = [[SortProductModel alloc]initWithDictionary:returnDic];
                                networkRequest.responseData = att;
                                return YES;
                            }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                                NSMutableArray *returnDic = [dic objectForKey:@"return"];
                                NSMutableArray *tmpDataArr = [NSMutableArray array];
                                for (NSDictionary *dic in returnDic) {
                                    
                                    SortProductModel *att = [[SortProductModel alloc]initWithDictionary:dic];
                                    [tmpDataArr addObject:att];
                                    
                                }
                                networkRequest.responseData = tmpDataArr;
                                
                                return YES;
                            }
                            
                        }
                        else
                        {
                            networkRequest.responseData = @"亲、没有商品了哦😢";
                            return YES;
                        }
                    }
                    networkRequest.responseData = @"亲、没有商品了哦😢";
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败2";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败1";
            }
        }
        
    }

    
#pragma mark 猜你喜欢
    else if ([networkRequest.requestName isEqualToString:kRequest_GuessByID])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:guessByIdResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:guessByIdResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            
                            if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                                NSArray *returnDic = [dic objectForKey:@"return"];
                                NSMutableArray *dataArray=[NSMutableArray array];
                                for (NSDictionary *tmpDic in returnDic) {
                                    YouGuessProduct *product=[[YouGuessProduct alloc]initWithDictionary:tmpDic];
                                    [dataArray addObject:product];
                                }
                                networkRequest.responseData=dataArray;
                                return YES;

                            }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]){
                                NSDictionary *tmpDic = [dic objectForKey:@"return"];
                                YouGuessProduct *product=[[YouGuessProduct alloc]initWithDictionary:tmpDic];
                                networkRequest.responseData = product;
                                return YES;
                            }
                        }
                     
                    }
                     networkRequest.responseData = @"还没有猜你喜欢的商品哦亲😢";
                    return YES;

                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 新品上市
    else if ([networkRequest.requestName isEqualToString:kRequest_GetNewProduct])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getNewProductResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getNewProductResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            
                            if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                                NSArray *returnDic = [dic objectForKey:@"return"];
                                NSMutableArray *dataArray=[NSMutableArray array];
                                for (NSDictionary *dic in returnDic) {
                                    //新品的模型和获得更多分类信息的模型一样，cell也一样，故用同一个
                                    SortProductModel *product=[[SortProductModel alloc]initWithDictionary:dic];
                                    [dataArray addObject:product];
                                    networkRequest.responseData=dataArray;
                                }
                                return YES;

                            }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]){
                                NSDictionary *tmpDic = [dic objectForKey:@"return"];
                                  SortProductModel *product=[[SortProductModel alloc]initWithDictionary:tmpDic];
                                networkRequest.responseData = product;
                                return YES;
                            }
                        }
                    }
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
    
    
    
#pragma mark 创建关注
    else if([networkRequest.requestName isEqualToString:kRequest_User_createAttention])
    {
        
        NSLog(@"%@",retObj);
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:createAttentionResponse"]) {
                    
                   NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:createAttentionResponse"];

                    if ([[dic allKeys]containsObject:@"return"]) {
                    
                    NSString *tmpDic = @"添加关注成功";
                   networkRequest.responseData = tmpDic;
                    return YES;
                    }else{
                        
                        networkRequest.responseData = @"添加关注失败";
                    }
                
                
                
                }
                else
                {
                    networkRequest.responseData = @"添加关注失败";
                }
                
            }
            else
            {
                networkRequest.responseData = @"添加关注失败";
            }
        }
    }
    
    
  
    
    
    
#pragma mark 关注商品的列表
    else if ([networkRequest.requestName isEqualToString:kRequest_User_getAttentionPList])
    {
        
        NSLog(@"%@",retObj);
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getAttentionPListResponse"]) {
                    
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAttentionPListResponse"];
                    
                    
                    if (dic && [dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count]>0) {
                        
                        
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            Attention *att = [[Attention alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = att;
                            return YES;
                        }else  if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                            NSMutableArray *returnDic = [dic objectForKey:@"return"];
                            
                            
                            NSMutableArray *tmpDataArr = [NSMutableArray array];
                            
                            for (NSDictionary *dic in returnDic) {
                                //                            LogInfo(@"店铺关注：%@", dic);
                                Attention *att = [[Attention alloc]initWithDictionary:dic];
                                [tmpDataArr addObject:att];
                                
                            }
                            networkRequest.responseData = tmpDataArr;
                            
                            
                            return YES;
                        }
                        
                        return YES;
                        
                    }
                    else{
                        networkRequest.responseData = @"亲、还没有关注的商品哦😢";
                        LogInfo(@"没有关注的商品");
                        
                    }
                    
                }
                else
                {
                    networkRequest.responseData = @"获取关注列表失败";
                    LogInfo(@"获取失败2");
                    
                }
            }
            else
            {
                networkRequest.responseData = @"获取关注列表失败";
                LogInfo(@"获取失败1");
                
            }
            
        }
    }
#pragma mark 关注店铺的列表
    else if ([networkRequest.requestName isEqualToString:kRequest_User_getAttentionSList])
    {
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getAttentionSListResponse"]) {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAttentionSListResponse"];
                    if (dic && [dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0) {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            AttentionStoreModel *att = [[AttentionStoreModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = att;
                            return YES;
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                            NSMutableArray *returnDic = [dic objectForKey:@"return"];
                            
                            NSMutableArray *tmpDataArr = [NSMutableArray array];
                            
                            for (NSDictionary *dic in returnDic) {
                                AttentionStoreModel *att = [[AttentionStoreModel alloc]initWithDictionary:dic];
                                [tmpDataArr addObject:att];
                                
                            }
                            networkRequest.responseData = tmpDataArr;
                            
                            
                            return YES;
                        }
                        
                    }
                   
                        networkRequest.responseData = @"亲、还没有关注的店铺哦😢";
                    
                }
                else
                {
                    networkRequest.responseData = @"获取关注店铺列表失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取关注店铺列表失败";
            }
        }
    }
    
#pragma mark 删除关注
        else if([networkRequest.requestName isEqualToString:kRequest_User_deleteAttention])
        {
            if ([retObj isKindOfClass:[NSDictionary class]]) {
                if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                    if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:deleteAttentionResponse"]) {
                         NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:deleteAttentionResponse"];
                        
                        NSString *tmpDic = dic[@"return"];
                        networkRequest.responseData = tmpDic;
                        return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取删除关注失败";
                }
    
            }
                else
                {
                    networkRequest.responseData = @"获取删除关注失败";
                }
            }
        }
    
    
#pragma mark 搜索
    else if ([networkRequest.requestName isEqualToString:kRequest_getProductOrShopByBlurName])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getProductOrShopByBlurNameResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getProductOrShopByBlurNameResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"]&& [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]] )
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *dataArray=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic) {
                                SearchProductOrShopModel *search=[[SearchProductOrShopModel alloc]initWithDictionary:dic];
                                [dataArray addObject:search];
                                networkRequest.responseData=dataArray;
                            }
                            return YES;
                            
                        }else if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *ReturnDic=[dic objectForKey:@"return"];
                            SearchProductOrShopModel *search=[[SearchProductOrShopModel alloc]initWithDictionary:ReturnDic];
                             networkRequest.responseData=search;
                            return YES;
                        }
                        
                    }
                    networkRequest.responseData = @"亲、没有搜索到结果哦😢";
//                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败2";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败1";
            }
        }
        
    }

#pragma mark 热销
    else if ([networkRequest.requestName isEqualToString:kRequest_HotSaleProduct])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getHotProductResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getHotProductResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]])
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *dataArray=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic) {
                                SellProductModel *product=[[SellProductModel alloc]initWithDictionary:dic];
                                [dataArray addObject:product];
                                networkRequest.responseData=dataArray;
                            }
                            return YES;
                        }
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *dicc=dic[@"return"];
                            SellProductModel *model=[[SellProductModel alloc]initWithDictionary:dicc];
                            networkRequest.responseData=model;
                            LogInfo(@"kkk%@",networkRequest.responseData);
                            return YES;
                        }
                    }
                    
                    networkRequest.responseData = @"亲、没有热卖的产品了哦😢";
                    return YES;

                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
#pragma mark 所有促销信息
    else if ([networkRequest.requestName isEqualToString:kRequest_getAppPromotion])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getAppPromotionResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAppPromotionResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0)
                    {
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]])

                        {

                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *dataArray=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic) {
                                PromotionProduct *product=[[PromotionProduct alloc]initWithDictionary:dic];
                                [dataArray addObject:product];
                            }
                            networkRequest.responseData=dataArray;
                            return YES;

                        }else if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *ReturnDic=[dic objectForKey:@"return"];
                            PromotionProduct *product=[[PromotionProduct alloc]initWithDictionary:ReturnDic];
                            networkRequest.responseData=product;
                            return YES;
                        }
      
                    }
                    networkRequest.responseData = @"亲、没有促销的产品了哦😢";
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }

#pragma mark 团购类型接口
    else if ([networkRequest.requestName isEqualToString:kRequest_selectTypeGroup])
    {
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:selectTypeGroupResponse"]) {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:selectTypeGroupResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"])
                        {
                            NSString *stringDic=dic[@"return"];
                            NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:[stringDic dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers  error:nil];
                            
                            NSString *arrString=[dataDic objectForKey:@"data"];
                            if (!arrString) {
                                networkRequest.responseData = @"获取团购信息失败";
                                return YES;
                            }
                            NSArray *array = [NSJSONSerialization JSONObjectWithData:[arrString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                            NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                            for (NSDictionary *dic in array) {
                                SelectTypeGroupModel *typeMode = [[SelectTypeGroupModel alloc] initWithDictionary:dic];
                                [dataArray addObject:typeMode];
                            }
                             networkRequest.responseData=dataArray;
                              return YES;
                        }
                        
                    }
                    networkRequest.responseData = @"亲、没有团购的商品了哦😢！";
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取团购分类信息失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取团购分类信息失败";
            }
        }
    }
#pragma mark 团购信息接口
    else if ([networkRequest.requestName isEqualToString:kRequest_selectGroupProduct])
    {
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys]containsObject:@"ns2:selectGroupProductResponse"]) {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:selectGroupProductResponse"];
                    if (dic && [[dic allKeys] containsObject:@"return"]) {
                        NSString *stingDic = [dic objectForKey:@"return"];
                        
                        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:[stingDic dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                        
                        NSString *arrStr = [dataDic objectForKey:@"data"];
                        if ([arrStr isEqualToString:@"[]"]) {
                            networkRequest.responseData = @"亲、没有团购的商品了哦😢！";
                            return YES;
                        }else{
                            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:[arrStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                            
                            NSMutableArray *tmpArr = [NSMutableArray array];
                            for (NSDictionary *dic in dataArr) {
//                                SelectGroupProductModel *groupPro = [SelectGroupProductModel selectGroupProductWithDictionay:dic];
                                                            SelectGroupProductModel *groupPro = [[SelectGroupProductModel alloc] initWithDictionary:dic];
                                [tmpArr addObject:groupPro];
                            }
                            networkRequest.responseData=tmpArr;
                            return YES;

                        }
                        
                    }
                    networkRequest.responseData = @"亲、没有团购的商品了哦😢！";
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取团购列表信息失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取团购列表信息失败";
            }
        }
    }
#pragma mark 秒杀
    else if ([networkRequest.requestName isEqualToString:kRequest_getAppSeckillProduct])
    {
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys]containsObject:@"ns2:getAppSeckillProductResponse"]) {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAppSeckillProductResponse"];
                    
                    if (dic && [dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count]>0) {
                        
                        
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            SeckillModel *seck = [[SeckillModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = seck;
                            return YES;
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                            NSMutableArray *returnDic = [dic objectForKey:@"return"];
                            
                            
                            NSMutableArray *tmpDataArr = [NSMutableArray array];
                            
                            for (NSDictionary *dic in returnDic) {
                                SeckillModel *seck = [[SeckillModel alloc]initWithDictionary:dic];
                                [tmpDataArr addObject:seck];
                                
                            }
                            networkRequest.responseData = tmpDataArr;
                            return YES;
                        }
                        
                        return YES;
                    }
                    networkRequest.responseData = @"亲、没有秒杀的商品了哦😢";
                    return YES;
           
                    
                }
                else
                {
                    networkRequest.responseData = @"获取秒杀列表失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取秒杀列表失败";
            }
        }
        
    }
        

#pragma mark 折扣专区
    else if ([networkRequest.requestName isEqualToString:kRequest_discountProduct])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getDiscountProductResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getDiscountProductResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] )
                    {
                        if ([dic objectForKey:@"return"]){
                            NSString *String=[dic objectForKey:@"return"];
                            NSDictionary *returnDic=[NSJSONSerialization JSONObjectWithData:[String dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                            NSMutableArray *array=[[NSMutableArray alloc]init];
                            array=returnDic[@"data"];
                            if (array.count == 0) {
                                networkRequest.responseData = @"亲、没有折扣的商品了哦😢";
                                return YES;
                            }else{
                                networkRequest.responseData=array;
                                return YES;
                            }
                        }
                    }
                    
                    networkRequest.responseData = @"没有折扣的商品了哦亲😢";
                    return YES;
                    
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }

#pragma mark 组合
    else if ([networkRequest.requestName isEqualToString:kRequest_getAppCombinationList])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getAppCombinationLimitResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getAppCombinationLimitResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"] && [[dic objectForKey:@"return"] count] > 0 )
                    {
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]] )
                            
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *dataArray=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic) {
                                CombinationProduct *product=[[CombinationProduct alloc]initWithDictionary:dic];
                                [dataArray addObject:product];
                            }
                            networkRequest.responseData=dataArray;
                            return YES;
                            
                        }else if ([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *ReturnDic=[dic objectForKey:@"return"];
                            CombinationProduct *product=[[CombinationProduct alloc]initWithDictionary:ReturnDic];
                            networkRequest.responseData=product;
                            return YES;
                        }
                    }
                      networkRequest.responseData = @"暂无商品";
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
   
#pragma mark 获得分类左侧列表  获得商品的大分类列表
    else if ([networkRequest.requestName isEqualToString:kRequest_selectFirstType])
    {
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:selectFirstTypeResponse"]) {
                    
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:selectFirstTypeResponse"];
                    
                    if (dic && [dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0) {
                        
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            SortLeftModel *att = [[SortLeftModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = att;
                            return YES;
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                            NSMutableArray *returnDic = [dic objectForKey:@"return"];
                            
                            NSMutableArray *tmpDataArr = [NSMutableArray array];
                            
                            
                            
                            for (NSDictionary *dic in returnDic) {
                                
                                SortLeftModel *att = [[SortLeftModel alloc]initWithDictionary:dic];
                                [tmpDataArr addObject:att];
                                
                            }
                            networkRequest.responseData = tmpDataArr;
                            
                            
                            return YES;
                        }
                        
                    }

                    else
                    {
                        networkRequest.responseData = @"获取左侧分类失败";
                    }

                }
                else
                {
                    networkRequest.responseData = @"获取左侧分类失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取左侧分类失败";
            }
        }
    }
    
#pragma mark 获得分类右侧列表  获得大分类的子分类列表
    else if ([networkRequest.requestName isEqualToString:kRequest_selectSecondType])
    {
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:selectSecondTypeResponse"]) {
                    
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:selectSecondTypeResponse"];
                    
                    if (dic && [dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0) {
                        
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            SortLeftModel *att = [[SortLeftModel alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = att;
                            return YES;
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                            NSMutableArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *tmpDataArr = [NSMutableArray array];
                            for (NSDictionary *dic in returnDic) {
                                SortLeftModel *att = [[SortLeftModel alloc]initWithDictionary:dic];
                                [tmpDataArr addObject:att];
                            }
                            networkRequest.responseData = tmpDataArr;
                            
                            
                            return YES;
                        }
                        
                    }
                    
                    return YES;
                    
                }
                else
                {
                    networkRequest.responseData = @"获取右侧分类失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取右侧分类失败";
            }
        }
    }
    
#pragma mark 首页砖区分类
    else if ([networkRequest.requestName isEqualToString:kRequest_User_getPhoneHomePageProduct])
    {
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getPhoneHomePageProductResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getPhoneHomePageProductResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"]){
                            NSString *String=[dic objectForKey:@"return"];
                            NSDictionary *returnDic=[NSJSONSerialization JSONObjectWithData:[String dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
                            NSMutableArray *array=[[NSMutableArray alloc]init];
                            array=returnDic[@"type"];
                         
                       [[FMStorageManager sharedInstance] storeArray:array withFileName:kRequest_User_getPhoneHomePageProduct];
                            
                            
                            NSMutableArray *tmpArray = [NSMutableArray array];
                            for (NSDictionary *tmpDic in array) {
                                HomeSortModel *homeSortModel = [[HomeSortModel alloc]initWithDictionary:tmpDic];
                                [tmpArray addObject:homeSortModel];
                                
                            }
                            
                            
                            networkRequest.responseData=tmpArray;
                            return YES;
                        }
                    }
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
        }
        
    }
    
#pragma mark 获得商品详情页的属性信息
    else if ([networkRequest.requestName isEqualToString:kRequest_User_getPhoneProductStatus])
    {
        
        LogInfo(@"%@",retObj);

        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getPhoneProductStatusResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getPhoneProductStatusResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            LogInfo(@"%@",returnDic);
                            
                            
                            NSMutableArray *tmpDataArr = [NSMutableArray array];

                            ProductStatusModel *status = [[ProductStatusModel alloc]initWithDictionary:returnDic];
                            [tmpDataArr addObject:status];
                            networkRequest.responseData = tmpDataArr;
                         return YES;
                        }else{
                            NSMutableArray *returnDic = [dic objectForKey:@"return"];
                            
                            
                            NSMutableArray *tmpDataArr = [NSMutableArray array];
                            
                            
                            LogInfo(@"%@",returnDic);

                            
                            
                for (NSDictionary *dic in returnDic) {
        ProductStatusModel *status = [[ProductStatusModel alloc]initWithDictionary:dic];
                [tmpDataArr addObject:status];
                                
                            }
            networkRequest.responseData = tmpDataArr;
                            
                            
                            return YES;
                        }
                        

                    }
                    
                    
                    
                    
                }
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取失败";
            }
            
              networkRequest.responseData = @"获取详情失败";
        }
          networkRequest.responseData = @"获取失败";
    }

 
    
    
#pragma mark 获得商品详情页的详细图文展示
    else if ([networkRequest.requestName isEqualToString:kRequest_getProductDetial])
    {
        LogInfo(@"%@",retObj);
        
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getProductDetialResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getProductDetialResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                              LogInfo(@"%@",returnDic);
                            
            ProductDetialModel *productDetial = [[ProductDetialModel alloc]initWithDictionary:returnDic];

        if (returnDic && [[returnDic allKeys] containsObject:@"t_produce_details"]){
            
            if ([[returnDic objectForKey:@"t_produce_details"] isKindOfClass:[NSDictionary class]]) {
                   
                NSDictionary *produceDetails = [returnDic objectForKey:@"t_produce_details"];
                            LogInfo(@"%@",produceDetails);
                
                NSString*produceDetailsStr = [produceDetails XMLString];
                LogInfo(@"%@",produceDetailsStr);
                productDetial.t_produce_details =produceDetailsStr;
                           }
                
                }
                            
//           NSString*produceDetailsStr = [produceDetails XMLString];
//            LogInfo(@"%@",produceDetailsStr);
//            productDetial.t_produce_details =produceDetailsStr;
            networkRequest.responseData = productDetial;
                
                            return YES;
                        }
                        
    if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]] && [[dic objectForKey:@"return"] count] > 0)
    {
        NSArray *returnDic = [dic objectForKey:@"return"];
        
        
        NSMutableArray *dataArray=[NSMutableArray array];
        for (NSDictionary *dic in returnDic) {
            
            ProductDetialModel *productDetial = [[ProductDetialModel alloc]initWithDictionary:dic];
            
            
            if (dic && [[dic allKeys] containsObject:@"t_produce_details"]){
                
                if ([[dic objectForKey:@"t_produce_details"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *produceDetails = [dic objectForKey:@"t_produce_details"];
            
            NSString*produceDetailsStr = [produceDetails XMLString];
            LogInfo(@"%@",produceDetailsStr);
            
            productDetial.t_produce_details =produceDetailsStr;
                }else{
            
                networkRequest.responseData = @"获取图文详情失败";
   
                }
            }else{
                    
                    networkRequest.responseData = @"获取图文详情失败";
                    
                }

            
            
            [dataArray addObject:productDetial];
          
        }
          networkRequest.responseData=dataArray;
        return YES;
        
    }
        else
            {
                networkRequest.responseData = @"获取图文详情失败";
            }
            
        }
                    
                    else
                    {
                        networkRequest.responseData = @"获取图文详情失败";
                    }
                    
                    
                }
                else
                {
                    networkRequest.responseData = @"获取图文详情失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取图文详情失败";
            }
        }
        
    }
   
    
    
#pragma mark  商品评价
    else if ([networkRequest.requestName isEqualToString:kRequest_getProductRatedByProductId])
    {
        
        LogInfo(@"%@",retObj);
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:getProductRatedByProductIdResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:getProductRatedByProductIdResponse"];
                    
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([[dic objectForKey:@"return"]isKindOfClass:[NSArray class]] && [[dic objectForKey:@"return"] count] > 0)
                        {
                            NSArray *returnDic = [dic objectForKey:@"return"];
                            
                            
                            NSMutableArray *dataArray=[NSMutableArray array];
                            for (NSDictionary *dic in returnDic) {
                                ProductRated *productsRated=[[ProductRated alloc]initWithDictionary:dic];
                                [dataArray addObject:productsRated];
                                networkRequest.responseData=dataArray;
                            }
                            return YES;
                        }
                        if([[dic objectForKey:@"return"]isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic=dic[@"return"];
                            ProductRated *productsRated=[[ProductRated alloc]initWithDictionary:returnDic];
                            networkRequest.responseData=productsRated;
                            return YES;
                        }
                    }
                    return YES;
                }
                else
                {
                    networkRequest.responseData = @"获取商品评价失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取商品评价失败";
            }
        }
        
    }
    
    
    
    
    
#pragma mark- 订单  根据订单对应用户ID查询得到订单信息
    else if([networkRequest.requestName isEqualToString:kRequest_user_gettOrderByUserId])
    {
        if ([retObj isKindOfClass:[NSDictionary class]]) {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"]) {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:gettOrderByUserIdResponse"]) {
                    
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:gettOrderByUserIdResponse"];
                    if (dic && [dic objectForKey:@"return"] && [[dic objectForKey:@"return"] count] > 0) {
                        
                        if ([[dic objectForKey:@"return"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            OrderInfo *att = [[OrderInfo alloc]initWithDictionary:returnDic];
                            networkRequest.responseData = att;
                            return YES;
                        }else if ([[dic objectForKey:@"return"] isKindOfClass:[NSArray class]]){
                            NSMutableArray *returnDic = [dic objectForKey:@"return"];
                            NSMutableArray *tmpDataArr = [NSMutableArray array];
                            for (NSMutableDictionary *dic in returnDic) {
                                OrderInfo *att = [[OrderInfo alloc]initWithDictionary:dic];
                                [tmpDataArr addObject:att];
                            }
                            networkRequest.responseData = tmpDataArr;
                            return YES;
                        }
                        
                        
                    }
                    else
                    {
                        networkRequest.responseData = @"亲、获取失败😭";
                    }
                    
                }
                else
                {
                    networkRequest.responseData = @"获取订单列表失败";
                }
            }
            else
            {
                networkRequest.responseData = @"获取订单列表失败";
            }
        }
    }

#pragma mark --------------------------支付方式
#pragma mark  微信支付
    else if ([networkRequest.requestName isEqualToString:kRequest_User_WeixinPay])
    {
        LogInfo(@"%@",retObj);
        
        if ([retObj isKindOfClass:[NSDictionary class]])
        {
            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
            {
                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:wechatPageResponse"])
                {
                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:wechatPageResponse"];
                    if (dic && [[dic allKeys] containsObject:@"return"])
                    {
                        if ([dic objectForKey:@"return"])
                        {
                            
                            
                            
                            
                            NSDictionary *returnDic = [dic objectForKey:@"return"];
                            
                            if (returnDic && [[returnDic allKeys] containsObject:@"xml"])
                            {
                                if ([returnDic objectForKey:@"xml"])
                                {
                                    
                                    NSDictionary *wxpayDic = [returnDic objectForKey:@"xml"];
                                    NSLog(@"%@",wxpayDic);
                                    WXPayObject *wxPayObject = [[WXPayObject alloc]initWithDictionary:wxpayDic];
                                    
                                    networkRequest.responseData = wxPayObject;
        return YES;
                            
                                }
                                else
                                {
                                    networkRequest.responseData = @"获取失败";
                                }
                                
                            }
                            else
                            {
                                networkRequest.responseData = @"获取失败";
                            }
                            
                    }else{
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                    
                    else
                    {
                        networkRequest.responseData = @"获取失败";
                    }
                    
                        
                        }
                        else {
                            networkRequest.responseData = @"获取失败";
                        }
                    }
                
                else
                {
                    networkRequest.responseData = @"获取失败";
                }
            }
  
    
    }
    
    
    
    
//    
//    
//#pragma mark 银联支付
//    else if ([networkRequest.requestName isEqualToString:kRequest_User_UnionPay])
//    {
//        if ([retObj isKindOfClass:[NSDictionary class]])
//        {
//            if (retObj && [[retObj allKeys] containsObject:@"soap:Body"])
//            {
//                
//                NSLog(@"%@",retObj);
//                
//                if ([retObj objectForKey:@"soap:Body"] && [[[retObj objectForKey:@"soap:Body"] allKeys] containsObject:@"ns2:poetPayAPPResponse"])
//                {
//                    NSDictionary *dic = [[retObj objectForKey:@"soap:Body"] objectForKey:@"ns2:poetPayAPPResponse"];
//                    
//                    if (dic && [[dic allKeys] containsObject:@"return"])
//                    {
//                        if ([dic objectForKey:@"return"]){
//                            NSString *String=[dic objectForKey:@"return"];
//                            
//                            
//                            NSLog(@"%@",String);
////                            NSDictionary *returnDic=[NSJSONSerialization JSONObjectWithData:[String dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
////                            NSMutableArray *array=[[NSMutableArray alloc]init];
////                            array=returnDic[@"type"];
////                            
////                            NSMutableArray *tmpArray = [NSMutableArray array];
////                            for (NSDictionary *tmpDic in array) {
////                                HomeSortModel *homeSortModel = [[HomeSortModel alloc]initWithDictionary:tmpDic];
////                                [tmpArray addObject:homeSortModel];
////                                
////                            }
////                            
////                            
////                            networkRequest.responseData=tmpArray;
//                            return YES;
//                        }
//                    }
//                }
//                else
//                {
//                    networkRequest.responseData = @"银联支付获取失败";
//                }
//            }
//            else
//            {
//                networkRequest.responseData =@"银联支付获取失败";
//            }
//        }
//        
//    }
//
    


    
    
    
    
    
    
    return ret;
}









#pragma mark-----------------------------------------
#pragma mark ---------------接口实现------------------
#pragma mark-----------------------------------------


#pragma mark - 登录
/**
 *  登录
 *
 *  @param t_user_id           用户id
 *  @param t_membership_gradle 会员等级
 *  @param t_user_name         用户名
 *  @param t_user_password     用户密码
 *  @param t_user_phone        用户手机号
 *  @param t_user_type         用户类型
 *  @param t_user_value        用户积分
 *  @param networkDelegate     代理
 *
 *  @return 请求结果
 */
- (FMNetworkRequest *)loginRequestWithUserId:(NSString *)t_user_id
                         t_membership_gradle:(NSInteger)t_membership_gradle
                                 t_user_name:(NSString *)t_user_name
                             t_user_password:(NSString *)t_user_password
                                t_user_phone:(NSInteger)t_user_phone
                                 t_user_type:(NSInteger)t_user_type
                                t_user_value:(NSInteger)t_user_value
                             networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>\n"     // ---参数开始
                             
                             "<msg></msg>\n"                                        //
                             "<resultCode></resultCode>\n"                          //
                             "<t_user_avatar></t_user_avatar>\n"                    //
                             "<t_membership_gradle></t_membership_gradle>\n"        // 会员等级
                             "<t_user_id></t_user_id>\n"                            // 用户ID
                             "<t_user_name></t_user_name>\n"                        // 用户名
                             "<t_user_password>%@</t_user_password>\n"              // 用户密码
                             "<t_user_phone>%ld</t_user_phone>\n"                   // 用户电话
                             "<t_user_type></t_user_type>\n"                        // 用户类型
                             "<t_user_value></t_user_value>\n"                      // 用户积分
                             
                             "</arg0>\n"     // ---参数结束
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_login, t_user_password, (long)t_user_phone, kRequestMethod_login];
    
    return [self addWebserviceRequestMethod:kRequest_User_Login baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark - 注册接口
/**
 *  注册
 *
 *  @param t_user_id           用户id
 *  @param t_membership_gradle 会员等级
 *  @param t_user_name         用户名
 *  @param t_user_password     用户密码
 *  @param t_user_phone        用户手机号
 *  @param t_user_type         用户类型
 *  @param t_user_value        用户积分
 *  @param networkDelegate     代理
 *
 *  @return 请求结果
 */
- (FMNetworkRequest *)registerRequestWithUserId:(NSString *)t_user_id t_membership_gradle:(int)t_membership_gradle t_user_name:(NSString *)t_user_name t_user_password:(NSString *)t_user_password t_user_phone:(NSString *)t_user_phone t_user_type:(int)t_user_type t_user_value:(int)t_user_value networkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>\n"     // ---参数开始
                             
                             "<msg></msg>\n"                                        //
                             "<resultCode></resultCode>\n"                          //
                             "<t_user_avatar></t_user_avatar>\n"                    // 用户名
                             "<t_user_id>%@</t_user_id>\n"                            // 用户ID
                             "<t_membership_gradle>%d</t_membership_gradle>\n"        // 会员等级
                             "<t_user_name>%@</t_user_name>\n"                        // 用户名
                             "<t_user_password>%@</t_user_password>\n"              // 用户密码
                             "<t_user_phone>%@</t_user_phone>\n"                   // 用户电话
                             "<t_user_type>%d</t_user_type>\n"                        // 用户类型
                             "<t_user_value>%d</t_user_value>\n"                      // 用户积分
                             
                             "</arg0>\n"     // ---参数结束
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_Register, t_user_id,t_membership_gradle, t_user_name, t_user_password, t_user_phone,t_user_type,t_user_value, kRequestMethod_Register];
    
    return [self addWebserviceRequestMethod:kRequest_User_Register baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark - 发送短信
/**
 *  发送短信
 *
 *  @param t_user_phone    手机号
 *  @param message         消息
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)sendPhoneMessageRequestWithUserPhone:(NSString *)t_user_phone
                                                   message:(NSString *)message
                                           networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.phonemessage.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<sendMessage>%@</sendMessage>\n"          // 消息
                             "<phoneNumbser>%@</phoneNumbser>\n"        // 手机号
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_sendPhoneMessage, message, t_user_phone, kRequestMethod_sendPhoneMessage];
    
    return [self addWebserviceRequestMethod:kRequest_User_sendPhoneMessage baseUrl:kApiPhoneUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark - 重置密码
/**
 *  重置密码
 * @param t_membership_gradle 会员等级
 * @param t_user_id  用户ID
 *@param  t_user_name  用户名
 *@param  t_user_password 用户密码
 *@param  t_user_phone    用户电话
 *@param  t_user_type  用户类型
 *@param  t_user_value  用户积分
 *  @param networkDelegate 代理
 *
 *  @return 请求结果
 */
- (FMNetworkRequest *)resetPasswordRequestWitht_membership_gradle:(NSInteger)t_membership_gradle  t_user_id:(NSString*)t_user_id t_user_name:(NSString*)t_user_name  t_user_password:(NSString*)t_user_password   t_user_phone:(NSInteger)t_user_phone   t_user_type:(NSInteger)t_user_type t_user_value:(NSInteger)t_user_value
                                                  networkDelegate:(id <FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>\n"     // ---参数开始
                             
                             "<msg></msg>\n"                                        //
                             "<resultCode></resultCode>\n"                          //
                             "<t_user_avatar></t_user_avatar>\n"                    // 用户名
                             "<t_membership_gradle>%ld</t_membership_gradle>\n"        // 会员等级
                             "<t_user_id>%@</t_user_id>\n"                            // 用户ID
                             "<t_user_name>%@</t_user_name>\n"                        // 用户名
                             "<t_user_password>%@</t_user_password>\n"              // 用户密码
                             "<t_user_phone>%ld</t_user_phone>\n"                   // 用户电话
                             "<t_user_type>%ld</t_user_type>\n"                        // 用户类型
                             "<t_user_value>%ld</t_user_value>\n"                      // 用户积分
                             
                             "</arg0>\n"     // ---参数结束
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_ResetPassword,(long)t_membership_gradle,t_user_id,t_user_name,t_user_password,(long)t_user_phone,(long)t_user_type,(long)t_user_value, kRequestMethod_ResetPassword];
    
    return [self addWebserviceRequestMethod:kRequest_User_ResetPassword baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark - 查询用户信息
/**
 *  查询用户信息
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 请求结果
 */
- (FMNetworkRequest *)queryUserInfoRequestWitht_user_id:(NSString*)t_user_id networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<t_user_id>%@</t_user_id>\n"                            // 用户ID
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_QueryUserInfo, t_user_id, kRequestMethod_QueryUserInfo];
    
    return [self addWebserviceRequestMethod:kRequest_User_QueryUserInfo baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl]  soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark - 查询用户详细信息
/**
 *  查询用户基本信息
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 请求结果
 */
- (FMNetworkRequest *)queryUserBasicInfoRequestWithUserId:(NSString *)t_user_id
                                          networkDelegate:(id <FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<t_user_id>%@</t_user_id>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",kRequestMethod_QueryUserBasicInfo, t_user_id, kRequestMethod_QueryUserBasicInfo];
    return [self addWebserviceRequestMethod:kRequest_User_QueryUserBasicInfo baseUrl:[NSString  stringWithFormat:@"%@user",kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark -修改用户信息
/**
 *  @param t_user_id       用户id
 */
-(FMNetworkRequest*)updateUserInfoRequestWithUserID:(NSString *)t_user_id andPhone:(NSString *)phone andSex:(NSString *)sex andBirthDay:(NSString *)birDay networkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>\n"     // ---参数开始
                             "<t_birthday>%@</t_birthday>\n"                            //
                             "<t_email></t_email>\n"                                  //
                             "<t_identity></t_identity>\n"                            //
                             "<t_nickname></t_nickname>\n"                            //
                             "<t_phone>%@</t_phone>\n"                                  //
                             "<t_realname></t_realname>\n"                            //
                             "<t_sex>%@</t_sex>\n"                                      //
                             
                             "<t_user_id>%@</t_user_id>\n"                            // 用户ID
                             
                             "</arg0>\n"     // ---参数结束
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_ModifyUserBasicInfo, birDay, phone, sex,  t_user_id, kRequestMethod_ModifyUserBasicInfo];
    
    return [self addWebserviceRequestMethod:kRequest_User_ModifyUserBasicInfo baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark - 查询订单列表
/**
 *  查询订单列表
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)queryOrderListRequestWithUserId:(NSString *)t_user_id
                                            orderType:(NSInteger)orderType
                                      networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<userID>%@</userID>\n"        // 用户ID
                             "<orderType>%ld</orderType>\n"  // 订单类型 （0，待付款 1，待发货 2，待收货 3，待评价, 4，退款 ,5、全部订单）
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_QueryOrderList, t_user_id, (long)orderType, kRequestMethod_QueryOrderList];
    
    return [self addWebserviceRequestMethod:kRequest_User_QueryOrderList baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark - 取消订单
/**
 *  取消订单
 *
 *  @param orderID       订单id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)cancelOrderRequestWithOrderID:(NSString *)orderID
                                    networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<orderID>%@</orderID>\n"                            // 订单ID
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_CancelOrder, orderID, kRequestMethod_CancelOrder];
    
    return [self addWebserviceRequestMethod:kRequest_User_CancelOrder baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 根据用户ID得到订单列表
/**
 *  订单信息
 *
 *  @param userID       订单id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
-(FMNetworkRequest*)gettOrderByUserId:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<t_user_id>%@</t_user_id>\n"                            // 订单ID
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_gettOrderByUserId, userID, kRequestMethod_gettOrderByUserId];
    
    return [self addWebserviceRequestMethod:kRequest_user_gettOrderByUserId baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 查询指定用户所有已支付未发货的订单
-(FMNetworkRequest*)GetUserUndeliverOrdersByUserIdWithUserID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<userID>%@</userID>\n"                            // 订单ID
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_GetUserUndeliverOrdersByUserId, userID, kRequestMethod_GetUserUndeliverOrdersByUserId];
    
    return [self addWebserviceRequestMethod:kRequest_user_getUserUndeliverOrdersByUserId baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 删除所有订单信息
-(FMNetworkRequest*)deleteAllOrderRequestWithUserID:(NSString*)userID etworkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<userID>%@</userID>\n"                            // 订单ID
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_DeleteAllOrder, userID, kRequestMethod_DeleteAllOrder];
    
    return [self addWebserviceRequestMethod:kRequesr_User_DeleteAllOrder baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 查询一段时间内的订单
-(FMNetworkRequest*)QueryByOrderUserIDAndTimeRequestWithuserID:(NSString*)userID  beginTime:(NSString*)beginTime networkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<userID>%@</userID>\n"                            // 订单ID
                             "<beginTime>%@</beginTime>\n"
                             "<pageNo>2</pageNo>\n"
                             "<pageSize>2</pageSize>\n"
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_QueryByOrderUserIDAndTime, userID,beginTime ,kRequestMethod_QueryByOrderUserIDAndTime];
    
    return [self addWebserviceRequestMethod:kRequest_user_queryByOrderUserIDAndTime baseUrl:korderManagerUrl soapMessage:soapMessage delegate:delegate];
}
#pragma mark 根据订单ID查询订单信息
-(FMNetworkRequest*)queryOrderMessageRequestWithOrderID:(NSString*)orderID networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<orderID>%@</orderID>\n"                            // 订单ID
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",kRequestMethod_queryOrderMessage,orderID,kRequestMethod_queryOrderMessage];
    
    return [self addWebserviceRequestMethod:kRequest_User_QueryOrderMessageByID baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 更新订单状态
-(FMNetworkRequest*)UpdateOrderStatusRequestWitht_order_id:(NSString*)t_order_id t_order_type:(NSString*)t_order_type networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<t_order_id>%@</t_order_id>\n"                            // 订单ID
                             "<t_order_type>%@</t_order_type>\n"
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",
                             kRequestMethod_UpdateStatus,t_order_id,t_order_type,kRequestMethod_UpdateStatus];
    
    return [self addWebserviceRequestMethod:kRequest_User_UpdateStatus baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 新增一条订单详情消息
- (FMNetworkRequest *)insertOrderDetailAmountDue:(NSString *)due andBuyeraddress:(NSString *)address andPhone:(NSString *)phone andNum:(NSString *)num andOrderDetailId:(NSString *)orderDetailId andPayment:(NSString *)payment andOrderId:(NSString *)orderId andProduceNumber:(NSString *)produceNum andSellerAddress:(NSString *)sellerAddress andSellerphone:(NSString *)sellerPhone andTotalMoney:(NSString *)totalMoney andProduceDetailId:(NSString *)produceDetailId andProductBrand:(NSString *)productBrand andProductColor:(NSString *)productColor andProductSize:(NSString *)productSize andReceipAddress:(NSString *)receipAddress andReceipId:(NSString *)receipId andReceivingmode:(NSString *)receivingmode andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<tOrderDetail>\n"
                             "<t_order_amoutn_due>%@</t_order_amoutn_due>\n"
                             "<t_order_buyeraddress></t_order_buyeraddress>\n"
                             "<t_order_buyerphone></t_order_buyerphone>\n"
                             "<t_order_deliver_num>%@</t_order_deliver_num>\n"
                             "<t_order_detail_id>%@</t_order_detail_id>\n"
                             "<t_order_final_payment>%@</t_order_final_payment>\n"
                             "<t_order_id>%@</t_order_id>\n"
                             "<t_order_produce_number>%@</t_order_produce_number>\n"
                             "<t_order_selleraddress>%@</t_order_selleraddress>\n"
                             "<t_order_sellerphone>%@</t_order_sellerphone>\n"
                             "<t_order_total_money>%@</t_order_total_money>\n"
                             "<t_produce_detail_id>%@</t_produce_detail_id>\n"
                             "<t_product_band>%@</t_product_band>\n"
                             "<t_product_color>%@</t_product_color>\n"
                             "<t_product_size>%@</t_product_size>\n"
                             "<t_receip_address></t_receip_address>\n"
                             "<t_receipt_id>%@</t_receipt_id>\n"
                             "<t_receivingmode>%@</t_receivingmode>\n"
                             "</tOrderDetail>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_insertOrderDetail,due, num, orderDetailId, payment, orderId, produceNum, sellerAddress, sellerPhone, totalMoney, produceDetailId, productBrand, productColor, productSize, receipId,receivingmode, kRequestMethod_insertOrderDetail];
    
    return [self addWebserviceRequestMethod:kRequest_User_insertOrderDetail baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
    
}

#pragma mark 新增一条订单信息
- (FMNetworkRequest *)insertOrderWithDeliverNum:(NSString *)deliverNum andCreateTime:(NSString *)createtime andPayment:(NSString *)payment andOrderId:(NSString *)orderId andState:(NSString *)state andType:(NSString *)type andProduceId:(NSString *)produceId andShopId:(NSString *)shopId andTotalNum:(NSString *)totalNum andUserId:(NSString *)userId andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<tOrder>\n"
                             "<t_deliver_num>%@</t_deliver_num>\n"
                             "<t_order_createtime>%@</t_order_createtime>\n"
                             "<t_order_final_payment>%@</t_order_final_payment>\n"
                             "<t_order_id>%@</t_order_id>\n"
                             "<t_order_state>%@</t_order_state>\n"
                             "<t_order_type>%@</t_order_type>\n"
                             "<t_produce_id>%@</t_produce_id>\n"
                             "<t_shop_id>%@</t_shop_id>\n"
                             "<t_total_num>%@</t_total_num>\n"
                             "<t_user_id>%@</t_user_id>\n"
                             "</tOrder>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_insertOrder, deliverNum, createtime, payment, orderId, state, type, produceId, shopId, totalNum, userId, kRequestMethod_insertOrder];
     return [self addWebserviceRequestMethod:kRequest_User_insertOrder baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}


//#pragma mark 通过用户id和订单类型 查询订单内商品信息
//- (FMNetworkRequest *)getOrderProductByUserId:(NSString *)t_user_id andType:(NSString *)type andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
//{
//    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
//                             "<soapenv:Header/>\n"
//                             "<soapenv:Body>\n"
//                             "<%@>\n"
//                             "<userid>%@</userid>\n"
//                             "<type>%@</type>\n"
//                             "</%@>\n"
//                             "</soapenv:Body>\n"
//                             "</soapenv:Envelope>\n", kRequestMethod_getOrderProductByUserIdAndType, t_user_id, type,kRequestMethod_getOrderProductByUserIdAndType];
//     return [self addWebserviceRequestMethod:kRequest_User_getOrderProductByUserIdAndType baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
//}

#pragma mark 通过用户ID和订单类型得到订单列表
- (FMNetworkRequest *)getOrderProductByUserId:(NSString *)t_user_id andOrderType:(NSString *)type andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<userid>%@</userid>\n"
                             "<type>%@</type>\n"
                             "<page>0</page>\n"
                             "<rows>10</rows>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_getOrderProductByOrderTypeAndUserId, t_user_id, type , kRequestMethod_getOrderProductByOrderTypeAndUserId];
    
        return [self addWebserviceRequestMethod:kRequest_User_getOrderProductByOrderTypeAndUserId baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 获取待收货订单
- (FMNetworkRequest *)getOrderCollectingGoods:(NSString *)t_user_id andOrderType:(NSString *)type andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<userid>%@</userid>\n"
                             "<type>%@</type>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_getOrderCollectingGoods, t_user_id, type , kRequestMethod_getOrderCollectingGoods];
    
    return [self addWebserviceRequestMethod:kRequest_User_getOrderCollectingGoods baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}




#pragma mark 查询用户待收货的订单接口
- (FMNetworkRequest *)selectToBeShippedOrderByUserId:(NSString *)t_user_id andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<userid>%@</userid>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_selectToBeShippedOrderByUserId, t_user_id, kRequestMethod_selectToBeShippedOrderByUserId];
    
    return [self addWebserviceRequestMethod:kRequest_User_selectToBeShippedOrderByUserId baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 根据用户id和订单id查询订单相关信息
- (FMNetworkRequest *)selectOrderbyOrderid:(NSString *)orderID  andUserId:(NSString *)t_user_id andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<orderid>%@</orderid>\n"
                             "<userid>%@</userid>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_selectOrderbyOrderidAndUserid, orderID, t_user_id, kRequestMethod_selectOrderbyOrderidAndUserid];
    
    return [self addWebserviceRequestMethod:kRequest_User_selectOrderbyOrderidAndUserid baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 根据用户ID分页获得用户的订单
- (FMNetworkRequest *)getOrderProductByUserIdCountWithUserId:(NSString *)t_user_id andPage:(NSString *)page andRow:(NSString *)row andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<userid>%@</userid>\n"
                             "<page>%@</page>\n"
                             "<rows>%@</rows>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_getOrderProductByUserIdCount, t_user_id, page, row, kRequestMethod_getOrderProductByUserIdCount];
    
    return [self addWebserviceRequestMethod:kRequest_User_getOrderProductByUserIdCount baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];

}



/**
 订单新加入的方法
 */

#pragma mark 根据用户ID查询所有订单
- (FMNetworkRequest *)findAllOrderByUderId:(NSString *)t_user_id andPage:(NSString *)page andRow:(NSString *)row andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<userId>%@</userId>\n"
                             "<page>%@</page>\n"
                             "<rows>%@</rows>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_findAllOrderByUderId, t_user_id, page, row, kRequestMethod_findAllOrderByUderId];
    
    return [self addWebserviceRequestMethod:kRequest_User_findAllOrderByUderId baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
    
}

#pragma mark 根据订单号查询订单详情
- (FMNetworkRequest *)findAllDetailByOrderIDFromProductDetialType:(NSString *)t_user_id andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.order.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<userid>%@</userid>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_findAllDetailByOrderIDFromProductDetialType, t_user_id, kRequestMethod_findAllDetailByOrderIDFromProductDetialType];
    
    return [self addWebserviceRequestMethod:kRequest_User_findAllDetailByOrderIDFromProductDetialType baseUrl:korderManagerUrl soapMessage:soapMessage delegate:networkDelegate];
    
}

#pragma mark - 查询购物车
/**
 *  查询购物车
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)queryShoppingCarListRequestWithUserId:(NSString *)t_user_id
                                            networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.shoppingCar.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<t_user_id>%@</t_user_id>\n"                            // 用户ID
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_SelectShopCar, t_user_id, kRequestMethod_SelectShopCar];
    
    return [self addWebserviceRequestMethod:kRequest_User_SelectShopCar baseUrl:kShoppingCarUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark  查询购物车通过用户id
/**
 *  查询购物车
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)queryShoppingCarByUserIdRequestWithUserId:(NSString *)t_user_id
                                                networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.shoppingCar.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<t_user_id>%@</t_user_id>\n"                            // 用户ID
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_SelectShopCarByUserId, t_user_id, kRequestMethod_SelectShopCarByUserId];
    
    return [self addWebserviceRequestMethod:kRequest_User_SelectShopCarByUserId baseUrl:kShoppingCarUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark  加入购物车
/**
 *  加入购物车
 *
 *  @param t_user_id                       用户id
 *  @param t_produce_id                    商品ID
 *  @param t_shop_car_createtime           购物车创建时间
 *  @param t_shop_car_goodsamount          商品金额
 *  @param t_shop_car_id                   购物车ID
 *  @param t_shop_car_merchandisediscounts 商品折扣
 *  @param t_shop_car_paymentamount        支付金额
 *  @param t_shop_car_purchasequantity     购买数量
 *  @param networkDelegate                 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)addToShoppingCarRequestWithUserId:(NSString *)t_user_id
                                           t_produce_id:(NSString *)t_produce_id
                                  t_shop_car_createtime:(NSString *)t_shop_car_createtime
                                 t_shop_car_goodsamount:(NSString *)t_shop_car_goodsamount
                                          t_shop_car_id:(NSString *)t_shop_car_id
                        t_shop_car_merchandisediscounts:(NSString *)t_shop_car_merchandisediscounts
                               t_shop_car_paymentamount:(NSString *)t_shop_car_paymentamount
                            t_shop_car_purchasequantity:(NSString *)t_shop_car_purchasequantity
                                        networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
  
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.shoppingCar.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>\n"     // ---参数开始
                             
                            "<t_product_detail_id>%@</t_product_detail_id>\n"        // 产品id
                             
                             "<t_shop_car_createtime>%@</t_shop_car_createtime>\n"        // 产品id
                             "<t_shop_car_goodsamount>%@</t_shop_car_goodsamount>\n"        // 产品id
                             "<t_shop_car_id>%@</t_shop_car_id>\n"        // 产品id
                             "<t_shop_car_merchandisediscounts>%@</t_shop_car_merchandisediscounts>\n"        // 产品id
                             "<t_shop_car_paymentamount>%@</t_shop_car_paymentamount>\n"        // 产品id
                             "<t_shop_car_purchasequantity>%@</t_shop_car_purchasequantity>\n"        // 产品id
                             "<t_user_id>%@</t_user_id>\n"                    // 用户ID
                             
                             "</arg0>\n"     // ---参数结束
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_AddToShoppingCar, t_produce_id,  t_shop_car_createtime, t_shop_car_goodsamount, t_shop_car_id, t_shop_car_merchandisediscounts, t_shop_car_paymentamount, t_shop_car_purchasequantity, t_user_id, kRequestMethod_AddToShoppingCar];
    
    return [self addWebserviceRequestMethod:kRequest_User_AddToShoppingCar baseUrl:kShoppingCarUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 删除购物车内的某个商品
- (FMNetworkRequest *)clearShoppingCarWithShoppingCarID:(NSString *)shoppingCarID andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.shoppingCar.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<shoppingCarIDs>%@</shoppingCarIDs>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_clearShoppingCar, shoppingCarID, kRequestMethod_clearShoppingCar];
    return [self addWebserviceRequestMethod:kRequest_User_clearShoppingCar baseUrl:kShoppingCarUrl soapMessage:soapMessage delegate:networkDelegate];
}


//积分
#pragma mark- 积分查询
/**
 *  积分查询
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)queryItegralListRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.integral.juwuba.com/\">\n"
                             
                             "<soapenv:Body>"
                             "<%@>\n"       // 接口名
                             "<t_user_id>%@</t_user_id>\n"
                             
                             "</%@>\n"       // 接口名
                             
                             "</soapenv:Body>"
                             "</soapenv:Envelope>"
                             ,kRequestMethod_QueryItegralList, t_user_id, kRequestMethod_QueryItegralList];
    return [self addWebserviceRequestMethod:kRequest_User_QueryItegralList baseUrl:quaryItegralUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 将要过期积分,时间
- (FMNetworkRequest *)GetEndTimeItegralValueRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.integral.juwuba.com/\">\n"
                             "<soapenv:Body>"
                             "<%@>\n"       // 接口名
                             "<t_user_id>%@</t_user_id>\n"//用户ID
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>"
                             "</soapenv:Envelope>"
                             , kRequestMethod_GetEndTimeItegralValue, t_user_id, kRequestMethod_GetEndTimeItegralValue];
    return [self addWebserviceRequestMethod:kRequest_User_GetEndTimeItegralValue baseUrl:quaryItegralUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 获得可用积分
-(FMNetworkRequest*)getAvailableValueRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.integral.juwuba.com/\">\n"
                             "<soapenv:Body>"
                             "<%@>\n"       // 接口名
                             "<t_user_id>%@</t_user_id>\n"//用户ID
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>"
                             "</soapenv:Envelope>"
                             , kRequestMethod_GetAvailableValue, t_user_id, kRequestMethod_GetAvailableValue];
    return [self addWebserviceRequestMethod:kRequest_User_GetAvaliableValue baseUrl:quaryItegralUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 获得积分收入列表
-(FMNetworkRequest*)getPointValueInRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.integral.juwuba.com/\">\n"
                             "<soapenv:Body>"
                             "<%@>\n"       // 接口名
                             "<t_user_id>%@</t_user_id>\n"//用户ID
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>"
                             "</soapenv:Envelope>"
                             , kRequestMethod_GetPointValueIN, t_user_id, kRequestMethod_GetPointValueIN];
    return [self addWebserviceRequestMethod:kRequest_User_GetPointValueIN baseUrl:quaryItegralUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 获得积分支出列表
-(FMNetworkRequest*)getPointValueOutListRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.integral.juwuba.com/\">\n"
                             "<soapenv:Body>"
                             "<%@>\n"       // 接口名
                             "<t_user_id>%@</t_user_id>\n"//用户ID
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>"
                             "</soapenv:Envelope>"
                             , kRequestMethod_GetPointValueOut, t_user_id, kRequestMethod_GetPointValueOut];
    return [self addWebserviceRequestMethod:kRequest_User_GetPointValueOut baseUrl:quaryItegralUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark ----查找用户默认的收货地址
/**
 *  用户默认的收货地址
 *  @param t_user_id 用户ID
 *  @return
 */
-(FMNetworkRequest*)requestForUserDefauleAddressWithUserID:(NSString*)t_user_id  networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>%@</arg0>\n"       // 参数结束
                             "</%@>\n"           // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",kRequestMethod_DefaultAddress,t_user_id,kRequestMethod_DefaultAddress];
    return [self addWebserviceRequestMethod:kRequest_user_defaultAddress  baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark ---新增收货地址
/**
 *  新增收货地址
 *@param t_user_id           用户id
 *@param t_receipt_id        收货人ID
 *
 */
-(FMNetworkRequest*)requeatForAddBuyerAddressWithIsDefault:(NSString *)t_is_default andArea:(NSString *)area andId:(NSString *)receiptId andName:(NSString *)name andPhone:(NSString *)phone andStreetAddress:(NSString *)streetAddress andUserID:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    //将请求的字符串拼接起来
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>\n"     // ---参数开始
                             
                             "<t_is_default_address>%@</t_is_default_address>\n"      // 默认收货地址
                             "<t_receipt_area>%@</t_receipt_area>\n"                          // 区域
                             "<t_receipt_id>%@</t_receipt_id>\n"                    // 收货人ID
                             "<t_receipt_name>%@</t_receipt_name>\n"        // 收货人姓名
                             "<t_receipt_phone>%@</t_receipt_phone>\n"                            // 收货人电话
                             "<t_receipt_streetaddress>%@</t_receipt_streetaddress>\n"                                                 // 收货人街道地址
                             "<t_receipt_zip_code></t_receipt_zip_code>\n"    //邮政编码
                             "<t_user_id>%@</t_user_id>\n"     // 用户ID
                             "</arg0>\n"     // ---参数结束
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_InfoAddress, t_is_default, area,   receiptId, name, phone, streetAddress, t_user_id,kRequestMethod_InfoAddress];
    //返回webService请求
    return [self addWebserviceRequestMethod:kRequest_User_AddBuyerAddress baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark ---用户列出所有收货地址
/**
 *  用户列出所有收货地址
 *@param t_user_id  用户id
 */
-(FMNetworkRequest*)requeatForAddBuyerAddressWithUserID:(NSString*)t_user_id  networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    //将请求的字符串拼接起来
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>%@</arg0>\n"     // ---参数开始
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",kRequestMethod_AllReceiveAddress,t_user_id,kRequestMethod_AllReceiveAddress];
    return [self addWebserviceRequestMethod:kRequest_User_AllReceiveAddress baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark ---设置改地址为用户的默认地址
/**
 *  设置该地址为用户的默认地址
 *  @param arg0  用户ID
 *  @param arg1  收货地址ID
 *  @return
 */
-(FMNetworkRequest*)requestForUserSetDefaultAddressWithArg0:(NSString*)arg0 arg1:(NSString*)arg1 networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>%@</arg0>\n"
                             "<arg1>%@</arg1>\n"
                             "</%@>\n"           // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",kRequestMethod_SetDefaultAddress,arg0,arg1,kRequestMethod_SetDefaultAddress];
    return [self addWebserviceRequestMethod:kRequest_User_setDefaultAddress  baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark ---修改收货地址
/**修改收货地址
 *  @param t_user_id     用户ID
 *  @param t_receipt_id  收货地址id
 *  @return
 */
-(FMNetworkRequest*)requestForUserChangeAddressWithUser_id:(NSString*)t_user_id  t_receipt_id:(NSString*)t_receipt_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    //将请求的字符串拼接起来
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>\n"     // ---参数开始
                             
                             "<t_is_default_address></t_is_default_address>\n"                                        // 默认收货地址
                             "<t_receipt_area></t_receipt_area>\n"                          // 区域
                             "<t_receipt_id>%@</t_receipt_id>\n"                    // 收货人ID
                             "<t_receipt_name></t_receipt_name>\n"        // 收货人姓名
                             "<t_receipt_phone></t_receipt_phone>\n"                            // 收货人电话
                             "<t_receipt_streetaddress></t_receipt_streetaddress>\n"                        // 收货人街道地址
                             "<t_receipt_zip_code>650220</t_receipt_zip_code>\n"              //邮政编码
                             "<t_user_id>%@</t_user_id>\n"                   // 用户ID
                             
                             "</arg0>\n"     // ---参数结束
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_ChangeDAddress,t_user_id, t_receipt_id,kRequestMethod_ChangeDAddress];
    //返回webService请求
    return [self addWebserviceRequestMethod:kRequest_User_ChangeAddress baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark ---删除一条收货地址
/**删除一条收货地址
 *  @param arg0   收货地址ID
 *  @return
 */
-(FMNetworkRequest*)requestForUserDeleteAddressWithArg0:(NSString*)arg0  networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             "<arg0>%@</arg0>\n"
                             "</%@>\n"           // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",kRequestMethod_DeleteAddress,arg0,kRequestMethod_DeleteAddress];
    return [self addWebserviceRequestMethod:kRequest_User_DeleteAddress  baseUrl:[NSString stringWithFormat:@"%@user", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark  ---根据ID获取优惠券信息
//根据ID获取优惠券信息
-(FMNetworkRequest*)requestFoGetElectronicVolumeOfUseWithArg0:(NSString*)arg0 networkDElegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.Electronicvolume.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<arg0>%@</arg0>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_getElectronicVolumeOfUser,arg0,kRequestMethod_getElectronicVolumeOfUser];
    return [self addWebserviceRequestMethod:kRequest_GetElectronicVolumeOfUser  baseUrl:kElectronicVolumeUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark ---获得所有优惠券
/** 获得所有优惠券
 *  @param  useID  用户ID
 */

-(FMNetworkRequest*)requestForGetAllElectronicvolumWithUseID:(NSString*)useID networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.Electronicvolume.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<useID>%@</useID>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetAllElectronicVolum,useID,kRequestMethod_GetAllElectronicVolum];
    return [self addWebserviceRequestMethod:KRequest_GetAllElectronicVolume  baseUrl:kElectronicVolumeUrl  soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 获得优惠券详情
/**
 *  获得优惠券详情
 *@param  electronicVolumeID  优惠券ID
 */
-(FMNetworkRequest*)requestForGetElectronicVolumeDetailWithelectronicVolumeID:(NSString*)electronicVolumeID networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:elec=\"http://electronicvolume.publicserivce.service.xiaohaixin.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<electronicVolumeID>%@</electronicVolumeID>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetElectronicVolumeDetail,electronicVolumeID,kRequestMethod_GetElectronicVolumeDetail];
    return [self addWebserviceRequestMethod:kRequest_GetElectronicVolumeDetail  baseUrl: kElectronicVolumeUrl  soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 新增优惠券
/**
 *新增优惠券
 *@param   t_electric_volume_id  电子券ID
 *@param   t_user_id            用户ID
 */
-(FMNetworkRequest*)requestForAddElectronicVolumWitht_electric_volume_id:(NSString*)t_electric_volume_id  t_user_id:(NSInteger)t_user_id   networkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.Electronicvolume.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<arg0>\n"
                           "<t_electric_volume_arrivedmoney>342</t_electric_volume_arrivedmoney>\n"
                           "<t_electric_volume_enddate>2016-01-21T10:15:31</t_electric_volume_enddate>\n"
                           "<t_electric_volume_id>%@</t_electric_volume_id>\n"
                           "<t_electric_volume_info>sss</t_electric_volume_info>\n"
                           "<t_electric_volume_iseffect>否</t_electric_volume_iseffect>\n"
                           "<t_electric_volume_startdate>2016-01-11T10:15:31</t_electric_volume_startdate>\n"
                           "<t_user_id>%ld</t_user_id>\n"
                           "</arg0>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",
                           kRequestMethod_AddElectronicVolume,t_electric_volume_id,(long)t_user_id,kRequestMethod_AddElectronicVolume];
    return [self addWebserviceRequestMethod:kRequest_AddElectronicVolume  baseUrl: kElectronicVolumeUrl soapMessage:soapMessage delegate:delegate];
}
#pragma mark 获得可用优惠券
/**
 *获得可用优惠券
 *@param   T_ELECTRIC_VOLUME_ISEFFECT  电子券可使用规则
 *@param   t_user_id            用户ID
 */
-(FMNetworkRequest*)requestForGetPossibleElectronicVolumeWithUseID:(NSString*)useID   possibleRule:(NSString*)possibleRule networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.Electronicvolume.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<useID>%@</useID>\n"
                           "<possibleRule>%@</possibleRule>"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetPossibleElectronicVolume,useID,possibleRule,kRequestMethod_GetPossibleElectronicVolume];
    return [self addWebserviceRequestMethod:kRequest_GetPossibleElectronicVolume  baseUrl:kElectronicVolumeUrl  soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 获得用户所有的优惠券
-(FMNetworkRequest*)getAllElectronicVolumeWithUseID:(NSString*)useID networkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
 
        NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                               "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                               "xmlns:view=\"http://view.Electronicvolume.juwuba.com/\">\n"
                               "<soapenv:Body>\n"
                               "<%@>\n"     // 接口名
                               "<useID>%@</useID>\n"
                               "</%@>\n"
                               "</soapenv:Body>\n"
                               "</soapenv:Envelope>\n",kRequestMethod_GetAllElectronicVolum,useID,kRequestMethod_GetAllElectronicVolum];
        return [self addWebserviceRequestMethod:KRequest_GetAllElectronicVolume  baseUrl:kElectronicVolumeUrl  soapMessage:soapMessage delegate:networkDelegate];

}


#pragma mark－ 广告
-(FMNetworkRequest*)requestForAdvertisementWithNetworkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.advertisement.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_AdvertisementList,kRequestMethod_AdvertisementList];
    return [self addWebserviceRequestMethod:kRequest_AdvertisementList  baseUrl:kAdvertisementUrl  soapMessage:soapMessage delegate:delegate];
}
#pragma mark 查询指定位置的广告
-(FMNetworkRequest*)adListByPositionRequestWithadPsition:(NSString*)adPsition networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.advertisement.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<adPsition>%@</adPsition>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMetthod_AdListByPosition,adPsition,kRequestMetthod_AdListByPosition];
    return [self addWebserviceRequestMethod:kRequest_adListByPosition  baseUrl:kAdvertisementUrl  soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark ---获取所有地区信息
-(FMNetworkRequest*)queryAllProvinceInfromationRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_QueryAllProvince,kRequestMethod_QueryAllProvince];
    return [self addWebserviceRequestMethod:kRequest_QueryAllProvince  baseUrl:kProvinceUrl  soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark -获得地区版本信息
-(FMNetworkRequest*)queryProvincceInfromationRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.user.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_QueryProvince,kRequestMethod_QueryProvince];
    return [self addWebserviceRequestMethod:Krequest_QueryProvince  baseUrl:kProvinceUrl  soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 品牌
-(FMNetworkRequest*)TPbrandListRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.brandlibrary.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_TPbrandList,kRequestMethod_TPbrandList];
    return [self addWebserviceRequestMethod:kRequest_TpBrandList  baseUrl:kBrandUrl  soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 查询关注品牌人数
-(FMNetworkRequest*)selectAttentionNumWithProductID:(NSString*)productID withNetworkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.brandlibrary.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<t_product_pbrand_id>%@</t_product_pbrand_id>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethos_selectAttenionNum,productID,kRequestMethos_selectAttenionNum];
    return [self addWebserviceRequestMethod:kRequest_SelectBrand_attentionNum  baseUrl:kBrandUrl  soapMessage:soapMessage delegate:delegate];
}
#pragma mark 品牌列出部分商品
-(FMNetworkRequest*)getBrandProductWithType:(NSInteger)type start:(NSInteger)start number:(NSInteger)number userID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.brandlibrary.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<type>%ld</type>\n"
                           "<start>%ld</start>\n"
                           "<num>%ld</num>\n"
                           "<t_produce_brand>d0e86dd4-5de2-4f02-b569-002c72c99dd7</t_produce_brand>\n"
                           "<useId>%@</useId>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_getBrandProduct,(long)type,(long)start,(long)number,userID,kRequestMethod_getBrandProduct];
    return [self addWebserviceRequestMethod:kRequest_getBrandProduct  baseUrl:kBrandUrl  soapMessage:soapMessage delegate:delegate];
}
#pragma mark 新闻
-(FMNetworkRequest*)getNewsInfoWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.news.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetNewsInfo,kRequestMethod_GetNewsInfo];
    return [self addWebserviceRequestMethod:kRequest_getNewsInfo  baseUrl: kApiNewsUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 猜你喜欢
-(FMNetworkRequest*)guessByIDRequestWitht_user_id:(NSString*)t_user_id len:(NSInteger)len networkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.guess.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<userId>%@</userId>\n"
                           "<len>%ld</len>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GuessByID,t_user_id,(long)len,kRequestMethod_GuessByID];
    return [self addWebserviceRequestMethod:kRequest_GuessByID  baseUrl: kApiGuessUrl soapMessage:soapMessage delegate:delegate];
}
#pragma mark 我的页面
-(FMNetworkRequest*)getMyPageInfoRequestWithuserID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.phone.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<useId>%@</useId>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetPageinfo,userID,kRequestMethod_GetPageinfo];
    return [self addWebserviceRequestMethod:kRequest_GetPageInfo  baseUrl: kMyPageInfoUrl soapMessage:soapMessage delegate:delegate];
}
#pragma mark 店铺信息
-(FMNetworkRequest*)getShopInfoRequestWithShopId:(NSString*)shopID  UserId:(NSString *)t_usr_id    netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.shopService.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<t_shop_id>%@</t_shop_id>\n"
                           "<t_user_id>%@</t_user_id>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetShopInfo,shopID,t_usr_id,kRequestMethod_GetShopInfo];
    return [self addWebserviceRequestMethod:kRequest_ShopInfo  baseUrl: kShopInfoUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 获得首页的产品类型
-(FMNetworkRequest*)getHomeProductsRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.product.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetHomeProducts,kRequestMethod_GetHomeProducts];
    return [self addWebserviceRequestMethod:kRequest_GetHomeProducts  baseUrl: kApiProductUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 根据商品ID获得商品详情
-(FMNetworkRequest*)getProductDetailWithProductID:(NSString*)t_produce_id networkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.product.juwuba.com/\">\n"
                          "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<product_id>%@</product_id>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetProductDetail,t_produce_id,kRequestMethod_GetProductDetail];
    return [self addWebserviceRequestMethod:kRequest_getProductDetial  baseUrl: kApiProductUrl soapMessage:soapMessage delegate:delegate];
    
}
#pragma mark 获得商品详情属性信息
- (FMNetworkRequest *)getPhoneProductStatusProductID:(NSString *)t_produce_id networkDelegate:(id<FMNetworkProtocol>)delegate
{
    NSString *soapMessage=[NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.product.juwuba.com/\">\n"
                           "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<id>%@</id>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_getPhoneProductStatus,t_produce_id,kRequestMethod_getPhoneProductStatus];
    
        return [self addWebserviceRequestMethod:kRequest_User_getPhoneProductStatus  baseUrl: kApiProductUrl soapMessage:soapMessage delegate:delegate];
}



#pragma mark 获得商品评价信息
- (FMNetworkRequest *)getProductRatedByProductID:(NSString *)t_produce_id networkDelegate:(id<FMNetworkProtocol>)delegate
{
    
//    
//    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:view="http://view.leavemsg.juwuba.com/">
//    <soapenv:Header/>
//    <soapenv:Body>
//    <view:getProductRatedByProductId>
//    <!--Optional:-->
//    <t_product_id>34235245245</t_product_id>
//    </view:getProductRatedByProductId>
//    </soapenv:Body>
//    </soapenv:Envelope>

    NSString *soapMessage=[NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.leavemsg.juwuba.com/\">\n"
                           "<soapenv:Header/>\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<t_product_id>%@</t_product_id>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_getProductRatedByProductId,t_produce_id,kRequestMethod_getProductRatedByProductId];
    
    return [self addWebserviceRequestMethod:kRequest_getProductRatedByProductId  baseUrl: kApiProductRatedUrl soapMessage:soapMessage delegate:delegate];
}
#pragma mark 新品上市
/**
 *@param type  查询类型
 *@param start 起始设置
 *@param  num  查询条数
 *@param  userID  用户ID
 */
-(FMNetworkRequest*)getNewProductWithType:(NSInteger)type start:(NSInteger)start num:(NSInteger)number userID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.product.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<type>%ld</type>\n"
                           "<start>%ld</start>\n"
                           "<num>%ld</num>\n"
                           "<useId>%@</useId>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetNewProduct,(long)type,(long)start,(long)number,userID,kRequestMethod_GetNewProduct];
    return [self addWebserviceRequestMethod:kRequest_GetNewProduct  baseUrl: kApiProductUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 折扣
-(FMNetworkRequest*)getDiscountProductRequestWithType:(NSInteger)type currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.product.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<type>%ld</type>\n"
                           "<currentPage>%ld</currentPage>\n"
                           "<pageSize>%ld</pageSize>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_disccountProduct,(long)type,(long)currentPage,(long)pageSize,kRequestMethod_disccountProduct];
    return [self addWebserviceRequestMethod:kRequest_discountProduct  baseUrl:kApiProductUrl  soapMessage:soapMessage delegate:networkDelegate];//kApiProductUrl//@"http://192.168.1.126:8080/Product/jwbservice/product"
}
#pragma mark 组合
-(FMNetworkRequest*)getAppCombinationListRequestWithpage:(NSInteger)page rows:(NSInteger)row NetworkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:sei=\"http://sei.service.sudorific.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "<page>%ld</page>\n"
                           "<rows>%ld</rows>\n"
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_getAppCombinationList,(long)page,(long)row,kRequestMethod_getAppCombinationList];
    return [self addWebserviceRequestMethod:kRequest_getAppCombinationList  baseUrl:kCombinationUrl  soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 秒杀
- (FMNetworkRequest *)getAppSeckillProductPage:(NSString *)page andRow:(NSString *)row andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sei=\"http://sei.service.sudorific.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<pag>%@</pag>\n"
                             "<row>%@</row>\n"
                             "<starttime>%@</starttime>\n"
                             "<endtime>%@</endtime>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>", kRequestMethod_getAppSeckillProduct, page, row, startTime, endTime, kRequestMethod_getAppSeckillProduct];
    return [self addWebserviceRequestMethod:kRequest_getAppSeckillProduct baseUrl:kSeckillProduct soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 获得首页显示的分类信息
-(FMNetworkRequest*)getTPTypeProductInfoRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.product.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetTpType,kRequestMethod_GetTpType];
    return [self addWebserviceRequestMethod:kRequest_getTpType  baseUrl: kApiProductUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 获得PC端首页布局
-(FMNetworkRequest*)getAllPCAllProductDetialTypeRequestWitNetworkDelegate:(id<FMNetworkProtocol>)delegate{
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                           "xmlns:view=\"http://view.product.juwuba.com/\">\n"
                           "<soapenv:Body>\n"
                           "<%@>\n"     // 接口名
                           "</%@>\n"
                           "</soapenv:Body>\n"
                           "</soapenv:Envelope>\n",kRequestMethod_GetAllPCAllProduct,kRequestMethod_GetAllPCAllProduct];
    return [self addWebserviceRequestMethod:kRequest_getAllPCAllProduct  baseUrl: kApiProductUrl soapMessage:soapMessage delegate:delegate];
}
#pragma mark- 关注的函数

#pragma mark -增加关注
-(FMNetworkRequest*)createAttentionWithCreatetime:(NSString *)createTime attentionHerf:(NSString *)attentionHerf attentionId :(NSString *)attentionId attentionMoney:(NSString *)attentionMoney attentiontitle:(NSString *)attentiontitle  attentionType:(NSString *)attentionType  produceId:(NSString *)produceId shopId:(NSString *)shopId userId:(NSString *)userId  networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    
    
    NSString *soapMessage=[NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.attention.juwuba.com/\">\n"
                 "<soapenv:Header/>\n"
                   "<soapenv:Body>\n"
                            "<%@>\n"   // 接口名
                      "<attention>\n"
//      "<t_attention_createtime>%@</t_attention_createtime>/n"
//            "<t_attention_herf>%@</t_attention_herf>/n"
//              "<t_attention_id>%@</t_attention_id>/n"
           "<t_attention_money>%@</t_attention_money>\n"
//           "<t_attention_title>%@</t_attention_title>/n"
            "<t_attention_type>%@</t_attention_type>\n"
                "<t_produce_id>%@</t_produce_id>\n"
//                   "<t_shop_id>%@</t_shop_id>/n"
                   "<t_user_id>%@</t_user_id>\n"
                     "</attention>\n"
                             "</%@>\n"  // 接口名
                  "</soapenv:Body>\n"
              "</soapenv:Envelope>\n",kRequestMethod_CreateAttention  ,attentionMoney,attentionType,produceId,userId,kRequestMethod_CreateAttention];
    
    return [self addWebserviceRequestMethod:kRequest_User_createAttention baseUrl: AttentionUrl soapMessage:soapMessage delegate:networkDelegate];
    
}




#pragma mark 查看关注商品列表
- (FMNetworkRequest *)queryAttentionProductListWithUserId:(NSString *)t_user_id netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.attention.juwuba.com/\">\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<userID>%@</userID>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",kRequestMethod_GetAttentionPList, t_user_id, kRequestMethod_GetAttentionPList];
    return [self addWebserviceRequestMethod:kRequest_User_getAttentionPList baseUrl:AttentionUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 查看关注店铺的列表
- (FMNetworkRequest *)queryAttentionShopListWithUserId:(NSString *)t_usr_id netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.attention.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<userID>%@</userID>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_GetAttentionSList, t_usr_id, kRequestMethod_GetAttentionSList];
    return [self addWebserviceRequestMethod:kRequest_User_getAttentionSList baseUrl:AttentionUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 删除关注
- (FMNetworkRequest *)deleteAttentionId:(NSString *)attentionId netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.attention.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<attentionID>%@</attentionID>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_DeleteAttention, attentionId, kRequestMethod_DeleteAttention];
    
    return [self addWebserviceRequestMethod:kRequest_User_deleteAttention baseUrl:AttentionUrl soapMessage:soapMessage delegate:networkDelegate];
    
}

//#pragma mark- 查看收藏的商品
//- (FMNetworkRequest *)getCollectionPListUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate
//{
//    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.collection.juwuba.com/\">\n"
//                             "<soapenv:Header/>\n"
//                             "<soapenv:Body>\n"
//                             "<%@>\n"
//                             "<arg0>%@</arg0>\n"
//                             "</%@>\n"                            //接口名
//                             "</soapenv:Body>"
//                             "</soapenv:Envelope>",kRequestMethod_getCollectionPList, t_user_id, kRequestMethod_getCollectionPList];
//    
//    
//    return [self addWebserviceRequestMethod:kRequest_User_getCollectionPList baseUrl:CollectionUrl soapMessage:soapMessage delegate:networkDelegate];
//    
//}



#pragma mark- 分类信息列表
- (FMNetworkRequest *)requestForGetPTypeByPId:(NSString *)pId withStartRow:(NSInteger)startRow withPageNum:(NSInteger)pageNum networkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:prod=\"http://product.publicserivce.service.xiaohaixin.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<p_id>%@</p_id>\n"
                             "<startRow>%ld</startRow>\n"
                             "<pageNum>%ld</pageNum>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n""<soapenv:Envelope>\n",kRequestMethod_getPtypeByPid, pId, (long)startRow, (long)pageNum, kRequestMethod_getPtypeByPid];
    return [self addWebserviceRequestMethod:kRequest_User_getPtypeByPid baseUrl:ProductCategoryUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 获得同类产品的列表
- (FMNetworkRequest *)getAppProductByTypePid:(NSString *)typeId andTypes:(NSInteger)type andPage:(NSString *)page andRows:(NSString *)row andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.product.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<typepid>%@</typepid>\n"
                             "<types>%ld</types>\n"
                             "<page>%@</page>\n"
                             "<rows>%@</rows>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_getAppProductByTypePid, typeId,type, page, row, kRequestMethod_getAppProductByTypePid];
    return [self addWebserviceRequestMethod:kRequest_getAppProductByTypePid baseUrl:ProductCategoryUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 获得小分类产品列表
- (FMNetworkRequest *)appselectproductByTypeId:(NSString *)typeId andTypes:(NSInteger)type andPage:(NSString *)page andRows:(NSString *)row andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.product.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<typeid>%@</typeid>\n"
                             "<type>%ld</type>"
                             "<page>%@</page>\n"
                             "<rows>%@</rows>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_appselectproductByTypeId, typeId, type, page, row, kRequestMethod_appselectproductByTypeId];
    return [self addWebserviceRequestMethod:kRequest_appselectproductByTypeId baseUrl:ProductCategoryUrl soapMessage:soapMessage delegate:networkDelegate];

}

#pragma mark 分类    获得分类左侧列表
- (FMNetworkRequest *)getPCLeftProductDetailTypeNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.product.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@/>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_getPCLeftProductDetialType];
    return [self addWebserviceRequestMethod:kRequest_User_GetPCLeftProductDetialType baseUrl:kApiSortUrl soapMessage:soapMessage delegate:networkDelegate];
    
}

#pragma mark 获得商品的最大分类列表
- (FMNetworkRequest *)selectFirstTypeWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.product.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@/>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_selectFirstType];
    return [self addWebserviceRequestMethod:kRequest_selectFirstType baseUrl:kApiSortUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 获得最大分类的子分类
- (FMNetworkRequest *)selectSecondTypeWthPid:(NSString *)pId andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.product.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<pid>%@</pid>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_selectSecondType, pId, kRequestMethod_selectSecondType];
        return [self addWebserviceRequestMethod:kRequest_selectSecondType baseUrl:kApiSortUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark- 获得首页砖区
- (FMNetworkRequest *)getPhoneHomePageProductNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.product.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@/>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_getPhoneHomePageProduct];
    return [self addWebserviceRequestMethod:kRequest_User_getPhoneHomePageProduct baseUrl:kHomeSortUrl soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark- 热销
- (FMNetworkRequest *)querySelectedAllRequestType:(NSInteger)type start:(NSInteger)start num:(NSInteger)number userID:(NSString*)userID  NetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.hotband.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<type>%ld</type>\n"
                             "<start>%ld</start>\n"
                             "<num>%ld</num>\n"
                             "<useId>%@</useId>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_HotSaleProduct,(long)type,(long)start,(long)number,userID,kRequestMethod_HotSaleProduct];
    
    return [self addWebserviceRequestMethod:kRequest_HotSaleProduct baseUrl:HotSaleUrl soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 查询所有促销信息

-(FMNetworkRequest*)getAllPromotoiomProductRequestWithtype:(NSInteger)type start:(NSInteger)start num:(NSInteger)num networkDelegate:(id<FMNetworkProtocol>)networkDelegate{

    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sei=\"http://sei.service.sudorific.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<type>%ld</type>\n"
                             "<start>%ld</start>\n"
                             "<num>%ld</num>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_promotoionProduct,type,start,num,kRequestMethod_promotoionProduct];
    
    return [self addWebserviceRequestMethod:kRequest_getAppPromotion baseUrl:kPromotoionUrl soapMessage:soapMessage delegate:networkDelegate];

}

#pragma mark 团购类型接口
- (FMNetworkRequest *)getSelectTypeGroupNetWorkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sei=\"http://sei.service.sudorific.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@/>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>", kRequestMethod_selectTypeGroup];
    return [self addWebserviceRequestMethod:kRequest_selectTypeGroup baseUrl:IGroupPurchase soapMessage:soapMessage delegate:networkDelegate];
}
#pragma mark 团购信息接
- (FMNetworkRequest *)getSelectGroupProductTypeId:(NSString *)typeId andCurrentPage:(int)currentpage andPageSize:(int)pageSize andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sei=\"http://sei.service.sudorific.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<typeId>%@</typeId>\n"
                             "<currentPage>%d</currentPage>\n"
                             "<pageSize>%d</pageSize>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_selectGroupProduct, typeId, currentpage, pageSize, kRequestMethod_selectGroupProduct];
    return [self addWebserviceRequestMethod:kRequest_selectGroupProduct baseUrl:IGroupPurchase soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark 搜索
- (FMNetworkRequest *)getProductOrShopByBlurNameText:(NSString *)seartText andPage:(NSString *)page andRow:(NSString *)row andNetWorkDelegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.product.juwuba.com/\">\n"
                          "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<serch>%@</serch>\n"
                             "<pages>%@</pages>\n"
                             "<rows>%@</rows>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_getProductOrShopByBlurName, seartText, page, row, kRequestMethod_getProductOrShopByBlurName];
    return [self addWebserviceRequestMethod:kRequest_getProductOrShopByBlurName baseUrl:kApiProductUrl soapMessage:soapMessage delegate:networkDelegate];
}


#pragma mark- 日志信息
-(FMNetworkRequest*)insertLogRequestWithClientloginID:(NSString*)clientLoginID time:(NSString*)createTime loginID:(NSString*)loginID logMessage:(NSString*)logMsg userID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:view=\"http://view.log.juwuba.com/\">\n"
                             "<soapenv:Header/>\n"
                             "<soapenv:Body>\n"
                             "<%@>\n"
                             "<arg0>\n"
                             "<t_log_client_ip>%@</t_log_client_ip>\n"
                             "<t_log_createtime>%@</t_log_createtime>\n"
                             "<t_log_id>%@</t_log_id>\n"
                             "<t_log_message>%@</t_log_message>\n"
                             "<t_log_source>1</t_log_source>\n"
                             "<t_log_type>1</t_log_type>\n"
                             "<t_produce_id>122555555</t_produce_id>\n"
                             "<t_user_id>%@</t_user_id>\n"
                             "</arg0>\n"
                             "</%@>\n"
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n",kRequestMethod_insertLogSourceByIOS,clientLoginID,createTime,loginID,logMsg,userID,kRequestMethod_insertLogSourceByIOS];
    
    return [self addWebserviceRequestMethod:kRequest_insertLogSourceByIOS baseUrl:kLogUrl soapMessage:soapMessage delegate:networkDelegate];
}



#pragma mark - 支付相关
#pragma mark - 勿修改


#pragma mark - 支付宝支付
/**
 *  支付宝支付
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)openIAlipayRequestByOrderID:(NSString *)t_user_id
                                          orderID:(NSString *)orderID
                                        orderName:(NSString *)orderName
                                       orderMoney:(NSString *)orderMoney
                                   produceManager:(NSString *)produceManager
                                       produceURL:(NSString *)produceURL
                                  networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:shop=\"http://shoppingcar.buyerservice.service.xiaohaixin.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<orderID>%@</orderID>\n"   // 订单ID
                             "<orderName>%@</orderName>\n"   // 订单名称
                             "<orderMoney>%@</orderMoney>\n"   // 金额
                             "<produceManager>%@</produceManager>\n"   // 产品描述
                             "<produceURL>%@</produceURL>\n"   // 产品URL
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_AliPay, orderID, orderName, orderMoney, produceManager, produceURL, kRequestMethod_AliPay];
    
    return [self addWebserviceRequestMethod:kRequest_User_AliPay baseUrl:[NSString stringWithFormat:@"%@alipay", kApiBaseUrl] soapMessage:soapMessage delegate:networkDelegate];

}



#pragma mark - 银联支付
/**
 *  银联支付
 *
 *  @param orderID    订单id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)openUnopayRequestByOrderID:(NSString *)orderID
                                      orderMoney:(NSString *)orderMoney
                                 networkDelegate:(id <FMNetworkProtocol>)networkDelegate
{

    
    
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.unionpay.juwuba.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<orderID>%@</orderID>\n"   // 订单ID
                             "<money>%@</money>\n"   // 金额
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_UnionPay, orderID, orderMoney, kRequestMethod_UnionPay];
    
    return [self addWebserviceRequestMethod:kRequest_User_UnionPay baseUrl:@"http://www.zgczsc.com/UnionPay/jwbservice/unionpay" soapMessage:soapMessage delegate:networkDelegate];
}

#pragma mark - 微信支付
/**
 *  微信支付
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */

- (FMNetworkRequest *)weixinPayRequestByOrderID:(NSString *)orderID
                                     customerID:(NSString *)customerID
                                     orderMoney:(NSString *)orderMoney
                                     trade_type:(NSString *)trade_type
                                networkDelegate:(id <FMNetworkProtocol>)networkDelegate{
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n"
                             "xmlns:view=\"http://view.wechatpay.juwuba.com/\">\n"
                             "<soapenv:Header/>"
                             "<soapenv:Body>\n"
                             "<%@>\n"       // 接口名
                             
                             "<out_trade_no>%@</out_trade_no>\n"   // 订单ID
                             "<spbill_create_ip>%@</spbill_create_ip>\n"   // 客户ID地址
                             "<total_fee>%@</total_fee>\n"   // 金额
                             "<trade_type>%@</trade_type>\n"   // 支付方式
                             
                             "</%@>\n"       // 接口名
                             "</soapenv:Body>\n"
                             "</soapenv:Envelope>\n", kRequestMethod_WeixinPay, orderID, customerID, orderMoney, trade_type, kRequestMethod_WeixinPay];
    
    return [self addWebserviceRequestMethod:kRequest_User_WeixinPay baseUrl:[NSString stringWithFormat:@"http://www.zgczsc.com/WechatPay/jwbservice/wechatPay"] soapMessage:soapMessage delegate:networkDelegate];
}


#pragma mark -
#pragma mark === 继承Get、Post方法 ===
#pragma mark -
//添加get请求
-(FMNetworkRequest*)addGetMethod:(NSString*)requestName
                         baseUrl:(NSString*)baseUrl
                          params:(NSDictionary*)params
                        delegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSMutableString *ms = [NSMutableString stringWithCapacity:100];
    if (baseUrl) {
        [ms setString:baseUrl];
    }
    else
    {
        [ms setString:kApiBaseUrl];
    }
    
    [ms appendString:[self combineCommonGetParams:params]];
    
    NSLog(@"[GET][%@]:%@", requestName, ms);
    
    return [super addGetUrl:ms requestName:requestName delegate:networkDelegate];
}

//添加post请求
-(FMNetworkRequest*)addPostMethod:(NSString*)requestName
                          baseUrl:(NSString*)baseUrl
                           params:(NSDictionary*)params
                        formDatas:(NSDictionary*)formDatas
                         delegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSMutableString *ms = [NSMutableString stringWithCapacity:100];
    if (baseUrl) {
        [ms setString:baseUrl];
    }
    else
    {
        [ms setString:kApiBaseUrl];
    }
    
    [ms appendString:[self combineCommonGetParams:params]];
    
    NSDictionary *datas = [self combineCommonPostDatas:formDatas];
    
    LogInfo(@"[POST][%@]:%@", requestName, [NSString stringWithFormat:@"%@%@", ms, [self combineCommonGetParams:datas]]);
    LogInfo(@"[POSTDATA][%@]:%@", requestName, datas);
    
    return [super addPostUrl:ms requestName:requestName formDatas:datas delegate:networkDelegate];
}


#pragma mark - webservice请求
-(FMNetworkRequest*)addWebserviceRequestMethod:(NSString*)requestName
                                       baseUrl:(NSString*)baseUrl
                                   soapMessage:(NSString*)soapMessage
//                        formDatas:(NSDictionary*)formDatas
                                      delegate:(id<FMNetworkProtocol>)networkDelegate
{
    NSMutableString *ms = [NSMutableString stringWithCapacity:100];
    if (baseUrl) {
        [ms setString:baseUrl];
    }
    else
    {
        [ms setString:kApiBaseUrl];
    }
    
    [ms appendString:soapMessage];
    
    //    NSDictionary *datas = [self combineCommonPostDatas:formDatas];
    //    LogInfo(@"[POST][%@]:%@", requestName, [NSString stringWithFormat:@"%@%@", ms, [self combineCommonGetParams:datas]]);
    LogInfo(@"[POSTDATA][%@]:%@", requestName, ms);
    
    return [super addWebserviceRequestWithUrl:baseUrl requestName:requestName soapMessage:soapMessage delegate:networkDelegate];
}

//合成get请求url
-(NSString*)combineCommonGetParams:(NSDictionary*)baseParams
{
    if (!baseParams) {
        return @"";
    }
    
    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:10];
    [md setDictionary:baseParams];
    
    //设备类型
    [md setObject:kApiKey forKey:@"api_key"];
    
    
    //设备id
    NSString *deviceID = [FMUSystem fmDeviceId];
    [md setObject:deviceID forKey:@"deviceid"];
    
    [md setObject:[FMUSystem platformString] forKey:@"devicetype"];
    
    [md setObject:[NSString stringWithFormat:@"%f",[FMUSystem getOSVersion]] forKey:@"osversion"];
    
    [md setObject:deviceID forKey:@"deviceid"];
    //当前应用版本
    [md setObject:[FMUSystem systemVersion] forKey:@"version"];
    
    //    //绑定手机号
    //    if (![FMUString isEmptyString:[[GlobalSetting sharedInstance] telPhone]])
    //    {
    //        [md setObject:[[GlobalSetting sharedInstance] telPhone] forKey:@"phone"];
    //    }
    //    else
    //    {
    //        [md setObject:@"" forKey:@"phone"];
    //    }
    //    //推送token
    //    if (![md objectForKey:@"tokenkey"])
    //    {
    //        if (![FMUString isEmptyString:[[GlobalSetting sharedInstance] token]])
    //        {
    //            [md setObject:[[GlobalSetting sharedInstance] token] forKey:@"tokenkey"];
    //        }
    //        else
    //        {
    //            [md setObject:@"" forKey:@"tokenkey"];
    //        }
    //    }
    //
    //    //hash 校验
    //    NSString *hashCheckStr = [NSString stringWithFormat:@"%@%@",[[GlobalSetting sharedInstance] telPhone],deviceID];
    //    NSString *haschcheckcode = [NSString md5Str:hashCheckStr];
    //    if (haschcheckcode != nil)
    //    {
    //        [md setObject:haschcheckcode forKey:@"hashcheckcode"];
    //    }
    
    return [FMNetworkManager encodedUrlForUrlPrefix:@"" params:md];
}

//合成post请求url
-(NSDictionary*)combineCommonPostDatas:(NSDictionary*)baseParams
{
    if (!baseParams) {
        return [NSDictionary dictionary];
    }
    
    NSMutableDictionary *md = [NSMutableDictionary dictionaryWithCapacity:10];
    [md setDictionary:baseParams];
    //设备类型
    [md setObject:kApiKey forKey:@"api_key"];
    
    //设备id
    NSString *deviceID = [FMUSystem fmDeviceId];
    [md setObject:deviceID forKey:@"deviceid"];
    
    //当前应用版本
    [md setObject:[FMUSystem systemVersion] forKey:@"version"];
    
    [md setObject:[FMUSystem platformString] forKey:@"devicetype"];
    
    [md setObject:[NSString stringWithFormat:@"%f",[FMUSystem getOSVersion]] forKey:@"osversion"];
    
    
    //    //绑定手机号
    //    if (![md objectForKey:@"phone"])
    //    {
    //        if (![FMUString isEmptyString:[[GlobalSetting sharedInstance] telPhone]])
    //        {
    //            [md setObject:[[GlobalSetting sharedInstance] telPhone] forKey:@"phone"];
    //        }
    //        else
    //        {
    //            [md setObject:@"" forKey:@"phone"];
    //        }
    //    }
    //    //推送token
    //    if (![md objectForKey:@"tokenkey"])
    //    {
    //        if (![FMUString isEmptyString:[[GlobalSetting sharedInstance] token]])
    //        {
    //            [md setObject:[[GlobalSetting sharedInstance] token] forKey:@"tokenkey"];
    //        }
    //        else
    //        {
    //            [md setObject:@"" forKey:@"tokenkey"];
    //        }
    //    }
    
    //    //hash 校验
    //    NSString *hashCheckStr = [NSString stringWithFormat:@"%@%@",[[GlobalSetting sharedInstance] telPhone],deviceID];
    //    NSString *haschcheckcode = [NSString md5Str:hashCheckStr];
    //    if (haschcheckcode != nil)
    //    {
    //        [md setObject:haschcheckcode forKey:@"hashcheckcode"];
    //    }
    
    return md;
}


@end
