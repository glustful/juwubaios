//
//  FSNetworkManager.h
//  fangStar
//
//  Created by XuLei on 15/5/19.
//  Copyright (c) 2015年 HomelandStar. All rights reserved.
//

#ifndef fangStar_FSNetworkManager_h
#define fangStar_FSNetworkManager_h

#import "FMNetworkManager.h"

#define kApiKey                         @"iPhone"

// =======================================================================
// 接口名称（用来判断回调）
// =======================================================================
static NSString * kRequest_User_Login = @"登录";
static NSString * kRequest_User_Register = @"注册";
static NSString * kRequest_User_sendPhoneMessage = @"发送短信";

static NSString * kRequest_User_ResetPassword = @"重置密码";
static NSString * kRequest_User_QueryUserInfo = @"查询用户信息";
static NSString * kRequest_User_QueryUserBasicInfo = @"查询用户详细信息";
static NSString * kRequest_User_ModifyUserBasicInfo = @"修改用户基本信息";

#pragma mark 订单
static NSString * kRequest_User_QueryOrderList = @"查询订单列表";
static NSString * kRequest_User_CancelOrder = @"取消订单";
static NSString * kRequest_User_ProduceOrder = @"生成订单";
//static NSString * kRequest_user_QueryOrder=@"根据用户ID得到订单信息";
static NSString * kRequest_user_gettOrderByUserId=@"根据用户ID得到订单信息";
static NSString * kRequest_user_getUserUndeliverOrdersByUserId=@"查询指定用户所有已支付未发货的订单";
static NSString * kRequesr_User_DeleteAllOrder=@"删除所有订单信息";
static NSString * kRequest_user_queryByOrderUserIDAndTime=@"查询一段时间内的订单";
static NSString * kRequest_User_QueryOrderMessageByID=@"根据订单ID得到订单信息";
static NSString * kRequest_User_UpdateStatus=@"更新订单状态";
static NSString * kRequest_User_insertOrderDetail = @"新增一条订单详情信息";
static NSString * kRequest_User_insertOrder = @"新增一条订单消息";

/**
 * 以下订单接口为5月6日以后给的接口
 */
static NSString * kRequest_User_getOrderProductByOrderTypeAndUserId = @"根据订单类型和用户ID获得订单";
static NSString * kRequest_User_selectToBeShippedOrderByUserId = @"查询用户的待收货订单";
static NSString * kRequest_User_selectOrderbyOrderidAndUserid = @"根据用户id和订单id查询订单相关信息";

static NSString * kRequest_User_getOrderCollectingGoods = @"获得待收货订单";

static NSString * kRequest_User_getOrderProductByUserIdCount = @"分页查询用户的所有订单";


/**
 *  新给订单接口
 */
static NSString * kRequest_User_findAllOrderByUderId = @"根据用户ID查询所有订单";
static NSString * kRequest_User_findAllDetailByOrderIDFromProductDetialType = @"根据订单ID查询订单详情";

//#pragma mark 待付款 待收货 待评价 的接口信息
//static NSString * kRequest_User_getOrderProductByUserIdAndType = @"通过用户id和订单类型 查询订单内商品信息";



#pragma mark 购物车
static NSString * kRequest_User_AddToShoppingCar = @"加入购物车";
static NSString * kRequest_User_SelectShopCar = @"查询购物车";
static NSString * kRequest_User_SelectShopCarByUserId = @"查询购物车通过用户ID";
static NSString * kRequest_User_clearShoppingCar = @"删除购物车内的某个商品";



#pragma mark 积分
static NSString * kRequest_User_QueryItegralList = @"查询积分";
static NSString * kRequest_User_GetEndTimeItegralValue = @"获得即将要过期的积分，时间";
static NSString * kRequest_User_GetAvaliableValue=@"获得可用积分";
static NSString * kRequest_User_GetPointValueIN=@"通过用户ID获得积分收入列表";
static NSString * kRequest_User_GetPointValueOut=@"通过用户ID获得积分支出列表";

#pragma mark ---收货地址
static NSString * kRequest_User_AddBuyerAddress=@"添加用户收货地址";
static NSString * kRequest_User_AllReceiveAddress=@"用户列出所有收货地址";
static NSString * kRequest_user_defaultAddress=@"用户默认的收货地址";
static NSString * kRequest_User_setDefaultAddress=@"设置改地址为用户的默认地址";
static NSString * kRequest_User_ChangeAddress=@"修改收货地址";
static NSString * kRequest_User_DeleteAddress=@"删除一条收货地址";
#pragma mark ---优惠券
static NSString * kRequest_GetElectronicVolumeOfUser=@"根据ID获取电子券信息";
static NSString * KRequest_GetAllElectronicVolume=@"获得用户的所有优惠券";
static NSString * kRequest_GetElectronicVolumeDetail=@"获得优惠券详情";
static NSString * kRequest_AddElectronicVolume=@"新增优惠券";
static NSString * kRequest_GetPossibleElectronicVolume=@"获得用户可使用优惠券";

#pragma mark 广告
static NSString * kRequest_AdvertisementList=@"广告列表";
static NSString * kRequest_adListByPosition=@"查询指定位置的广告";

#pragma mark 热销
static NSString * kRequest_HotSaleProduct=@"热销产品";

#pragma mark 秒杀
static NSString * kRequest_getAppSeckillProduct = @"App查询秒杀";

#pragma mark 促销
static NSString *kRequest_getAppPromotion=@"APP查询所有促销信息";
#pragma mark 团购类型接口
static NSString *kRequest_selectTypeGroup = @"团购类型接口";
#pragma mark 团购列表接口
static NSString *kRequest_selectGroupProduct = @"团购列表接口";

#pragma mark 查询更多的分类列表
static NSString *kRequest_getAppProductByTypePid = @"查询更多的同类产品";

#pragma mark 查询小分类的产品列表
static NSString *kRequest_appselectproductByTypeId = @"查询小分类同类产品";

#pragma mark 店铺
static NSString * kRequest_ShopInfo=@"店铺信息";

#pragma mark 收藏
//static NSString * kRequest_User_getCollectionPList = @"查看收藏的产品";
//static NSString * kRequest_User_getCollectionSList = @"查看收藏的店铺";
//static NSString * kRequest_User_deleteCollectionListID = @"删除收藏夹";
//static NSString * kRequest_User_createCollection = @"添加收藏";


#pragma mark 地区信息接口
static NSString *kRequest_QueryAllProvince=@"地区信息";
static NSString *Krequest_QueryProvince=@"获取所有地区版本信息";

#pragma mark 品牌
static NSString *kRequest_TpBrandList=@"品牌分类列表";
static NSString *kRequest_SelectBrand_attentionNum=@"查询关注品牌人数";
static NSString *kRequest_getBrandProduct=@"品牌馆列出部分商品";

#pragma mark 新闻
static NSString *kRequest_getNewsInfo=@"获取所有新闻信息";

#pragma mark 猜你喜欢
static NSString *kRequest_GuessByID=@"猜你喜欢";
#pragma mark 我的
static NSString *kRequest_GetPageInfo=@"我的页面显示";

#pragma mark 产品
static NSString *kRequest_getTpType=@"获得首页显示的分类信息";
static NSString *kRequest_GetNewProduct=@"新品上市";
static NSString * kRequest_getAllPCAllProduct=@"获得PC端首页布局";

#pragma mark 折扣
static NSString *kRequest_discountProduct=@"折扣专区";
#pragma mark 组合
static NSString *kRequest_getAppCombinationList=@"组合";

#pragma mark 日志信息
static NSString *kRequest_insertLogSourceByIOS=@"插入iOS端日志信息";

// 支付接口
static NSString * kRequest_User_UnionPay = @"银联支付";
static NSString * kRequest_User_AliPay = @"支付宝支付";
static NSString * kRequest_User_WeixinPay = @"微信支付";

#pragma mark 分类
/**
 *  根据父类id获得首页显示的分类信息列表
 */
static NSString * kRequest_User_getPtypeByPid = @"分类信息列表";
static NSString * kRequest_GetHomeProducts=@"获得首页的产品类型";

static NSString * kRequest_selectFirstType=@"查询商品最大分类";
static NSString * kRequest_selectSecondType=@"查询最大分类的子分类";


/**
 *  分类    获得分类左侧列表
 */
static NSString *kRequest_User_GetPCLeftProductDetialType = @"获得分类左侧列表";

/**
 *  获得首页砖区分类
 */
static NSString *kRequest_User_getPhoneHomePageProduct = @"获得首页砖区分类";


#pragma mark 关注
/**
 *   关注（店铺／商品）
 */
static NSString *kRequest_User_getAttentionPList = @"查看关注商品列表";
static NSString *kRequest_User_getAttentionSList = @"查看关注商铺列表";
static NSString *kRequest_User_deleteAttention = @"删除关注";
static NSString *kRequest_User_createAttention = @"添加关注";


#pragma mark 搜索
static NSString *kRequest_getProductOrShopByBlurName = @"按商品名字或者公司名字模糊查询商品和店铺信息";



#pragma mark- 商品详情内的接口

static NSString *kRequest_User_getPhoneProductStatus = @"获得产品的属性信息";
static NSString *kRequest_getProductDetial=@"根据商品id查询商品详情";
static NSString *kRequest_getProductRatedByProductId = @"根据商品id获取产品所有评价";

#pragma mark 版本信息
static NSString *kRequest_vertionInfo = @"获取版本信息";


#pragma mark-









#pragma mark- 接口方法名称（用来发送请求）
// =======================================================================
// 接口方法名称（用来发请求）
// =======================================================================
static NSString *const kRequestMethod_login = @"view:userLogin";                        // 登录
static NSString *const kRequestMethod_Register = @"view:userRegistry";                  // 注册
static NSString *const kRequestMethod_sendPhoneMessage = @"view:sendPhoneMessage";                  // 发送短信
static NSString *const kRequestMethod_ResetPassword = @"view:userResetPassword";        // 重置密码
static NSString *const kRequestMethod_QueryUserInfo = @"view:selectUSerById";           // 查询用户信息
static NSString *const kRequestMethod_QueryUserBasicInfo = @"view:getUserBasicInfo";    // 查询用户详细信息
static NSString *const kRequestMethod_ModifyUserBasicInfo = @"view:userUpdateInfo";     // 修改用户基本信息

#pragma mark 订单
static NSString *const kRequestMethod_QueryOrderList = @"view:queryByUserIDForProduct";            // 查询订单列表
static NSString *const kRequestMethod_CancelOrder = @"view:cancelOrder";                 // 取消订单
static NSString *const kRequestMethod_ProduceOrder = @"ord:insert";// 生成订单
//static NSString *const kRequestMethod_QueryOrder=@"view:queryByUserID";//根据用户ID得到订单信息
static NSString *const kRequestMethod_gettOrderByUserId=@"view:gettOrderByUserId";//根据用户ID得到订单信息

static NSString *const kRequestMethod_GetUserUndeliverOrdersByUserId=@"view:getUserUndeliverOrdersByUserId";//查询指定用户所有已支付未发货的订单
static NSString *const kRequestMethod_DeleteAllOrder=@"view:deleteAll";//删除所有订单信息
static NSString *const kRequestMethod_QueryByOrderUserIDAndTime=@"view:queryByOrderUserIDAndTime";//查询一定时间内的订单
static NSString *const kRequestMethod_queryOrderMessage=@"view:queryByID";//根据订单ID得到订单信息
static NSString *const kRequestMethod_UpdateStatus=@"view:updateStatus";//更新订单状态
static NSString *const kRequestMethod_insertOrderDetail = @"view:insertOrderDetail";  //新增一条订单详情信息
static NSString *const kRequestMethod_insertOrder = @"view:insertOrder";  //新增一条订单信息

/**
 *  一下订单接口是5月6日新增接口
 */
static NSString *const kRequestMethod_getOrderProductByOrderTypeAndUserId = @"view:getOrderProductByOrderTypeAndUserIdV2";  //根据订单类型和用户ID获得订单
static NSString *const kRequestMethod_getOrderCollectingGoods = @"view:getOrderCollectingGoodsV2";  //根据订单类型和用户ID获得订单
static NSString *const kRequestMethod_selectToBeShippedOrderByUserId = @"view:selectToBeShippedOrderByUserId";  //查询用户的待收货接口
static NSString *const kRequestMethod_selectOrderbyOrderidAndUserid = @"view:getOrderbyOrderidAndUseridV2";  //根据用户id和订单id查询订单相关信息

static NSString *const kRequestMethod_getOrderProductByUserIdCount = @"view:getOrderProductByOrderUserId";  //根据用户ID分页获得订单  查看的是全部的订单

//6月新给接口
static NSString *const kRequestMethod_findAllOrderByUderId = @"view:findAllOrderByUderId";  //根据用户ID查询所有订单
static NSString *const kRequestMethod_findAllDetailByOrderIDFromProductDetialType = @"view:findAllDetailByOrderIDFromProductDetialType";  //根据订单ID查询订单详情
//#pragma mark 待付款 待收货 待评价 的接口信息
//static NSString *const kRequestMethod_getOrderProductByUserIdAndType = @"view:getOrderProductByUserIdAndType";  //通过用户id和订单类型 查询订单内商品信息


#pragma mark 购物车
static NSString *const kRequestMethod_AddToShoppingCar = @"view:addToShoppingCar";     // 加入购物车
static NSString *const kRequestMethod_SelectShopCar = @"view:selectShopCar";            // 查询购物车
static NSString *const kRequestMethod_SelectShopCarByUserId = @"view:selectShopCarByUserId";//查询购物车通过用户ID
static NSString *const kRequestMethod_clearShoppingCar = @"view:clearShoppingCars";  //删除购物车内的某个商品
#pragma mark 积分

static NSString *const kRequestMethod_QueryItegralList = @"view:getAllPointValueOut";            // 查询积分列表
static NSString *const kRequestMethod_GetEndTimeItegralValue = @"view:getEndTimeValue"; // 获得即将要过期的积分,时间
static NSString *const kRequestMethod_GetAvailableValue=@"view:getAvaliableValue";//获得可用积分
static NSString *const kRequestMethod_GetPointValueIN=@"view:getPointValueIn";//获得积分收入列表
static NSString *const kRequestMethod_GetPointValueOut=@"view:getPointValueOut";//获得积分支出列表


#pragma mark 收藏
/**
 *  收藏
 */
//static NSString *const kRequestMethod_getCollectionPList = @"view:getCollectionPList";//查看收藏的商品
//static NSString *const kRequestMethod_getCollectionSList = @"view:getCollectionSList";//查看收藏的店铺
//static NSString *const kRequestMethod_deleteCollectionListID = @"view:deleteCollectionListID";//删除收藏夹
//static NSString *const kRequestMethod_createCollection = @"view:createCollection";//添加收藏


#pragma mark 关注
/**
 *  关注  此关注弃用，改为上面的收藏
 */
static NSString *const kRequestMethod_GetAttentionPList = @"view:getAttentionPList";//查看关注商品列表
static NSString *const kRequestMethod_GetAttentionSList = @"view:getAttentionSList";//查看关注商铺列表
static NSString *const kRequestMethod_DeleteAttention = @"view:deleteAttention";//删除关注
static NSString *const kRequestMethod_CreateAttention = @"view:createAttention";//添加关注

#pragma mark 搜索
static NSString *const kRequestMethod_getProductOrShopByBlurName = @"view:getProductOrShopByBlurName";//搜索

#pragma mark 店铺
static NSString *const kRequestMethod_GetShopInfo=@"view:getPhoneShopDetailPage";//店铺信息

#pragma mark  地址
static NSString *const kRequestMethod_InfoAddress=@"view:userAddBuyerAddress"; //新增收货地址
static NSString *const kRequestMethod_AllReceiveAddress=@"view:ListReceiveAddr";//用户列出所有收货地址
static NSString *const kRequestMethod_DefaultAddress=@"view:getDefaultAddr";//用户默认的收货地址
static NSString *const kRequestMethod_SetDefaultAddress=@"view:setToDefaultAddr";//设置该地址为用户的默认地址
static NSString *const kRequestMethod_ChangeDAddress=@"view:changeAddr";//修改收货地址
static NSString *const kRequestMethod_DeleteAddress=@"view:deleteAddr"; //删除一条收货地址


#pragma mark ---优惠券---
static NSString *const kRequestMethod_getElectronicVolumeOfUser=@"view:getElectronicVolumeOfUser";//根据ID获取优惠券信息
static NSString *const kRequestMethod_GetAllElectronicVolum=@"view:getAllElectronicVolume";//获得所有优惠券
static NSString *const kRequestMethod_GetElectronicVolumeDetail=@"elec:geTElectricVolumeDetail";//获得优惠券详情
static NSString *const kRequestMethod_AddElectronicVolume=@"view:addElectronicVolume";//新增优惠券
static NSString *const kRequestMethod_GetPossibleElectronicVolume=@"view:getPossibleElectronicVolume";//获得可用的优惠券


#pragma mark 广告
static NSString *const kRequestMethod_AdvertisementList=@"view:adList";
static NSString *const kRequestMetthod_AdListByPosition=@"view:adListByPosition";//查询指定位置的广告

#pragma mark 地区信息接口
static NSString *const kRequestMethod_QueryAllProvince=@"view:phoneGetTProvince";//获取所有地区信息
static NSString *const kRequestMethod_QueryProvince=@"view:getProviceNameCode";//获得所有地区版本信息

#pragma mark 品牌
static NSString *const kRequestMethod_TPbrandList=@"view:selectPbrandInfo";//品牌列表
static NSString *const kRequestMethos_selectAttenionNum=@"view:selectBrand_attention_num";//查询关注品牌人数
static NSString *const kRequestMethod_getBrandProduct=@"view:getBrandLibraryProduct";//品牌馆列出部分商品


#pragma mark 新闻
static NSString *const kRequestMethod_GetNewsInfo=@"view:getNewsInfo";//获取所有的新闻
#pragma mark 猜你喜欢
static NSString *const kRequestMethod_GuessByID=@"view:guessById";//猜你喜欢
#pragma mark 我的
static NSString *const kRequestMethod_GetPageinfo=@"view:getMyPageInfo";//我的页面

static NSString *const kRequestMethod_GetHomeProducts=@"view:getHomeProductes";//获得首页的产品类型
#pragma mark 获得首页显示的分类信息
static NSString *const kRequestMethod_GetTpType=@"view:tptype";//获得首页显示的分类信息
#pragma mark- 商品详情页接口
#pragma mark 根据商品id查询商品详情

static NSString *const kRequestMethod_GetProductDetail=@"view:getProductDetial";//根据商品id查询商品详情
static NSString *const kRequestMethod_getPhoneProductStatus=@"view:getPhoneProductStatus";//获得商品信息属性

static NSString *const kRequestMethod_getProductRatedByProductId=@"view:getProductRatedByProductId";//获得评价信息属性

#pragma mark-
#pragma mark 获得PC端首页布局
static NSString *const kRequestMethod_GetAllPCAllProduct=@"view:getAllPCAllProductDetialType";//获得PC端首页布局
#pragma mark- 新品上市
static NSString *const kRequestMethod_GetNewProduct=@"view:getNewProduct";//新品上市
#pragma mark 热销
static NSString *const kRequestMethod_HotSaleProduct=@"view:getHotProduct";//热销产品
#pragma mark 秒杀
static NSString *const kRequestMethod_getAppSeckillProduct = @"sei:getAppSeckillProduct";//App查询秒杀

#pragma mark 促销
static NSString *const kRequestMethod_promotoionProduct=@"sei:getAppPromotion";//查询所有促销信息
static NSString *const kRequestMethod_getAppCombinationList=@"sei:getAppCombinationLimit";//组合

#pragma mark 团购类型接口
static NSString *const kRequestMethod_selectTypeGroup = @"sei:selectTypeGroup";
#pragma mark 团购列表接口
static NSString *const kRequestMethod_selectGroupProduct = @"sei:selectGroupProduct";

#pragma mark - 查询更多的同类产品
static NSString *const kRequestMethod_getAppProductByTypePid = @"view:getAppProductByTypePid";
#pragma mark 小分类产品列表
static NSString *const kRequestMethod_appselectproductByTypeId = @"view:appselectproductByTypeId";

#pragma mark- 分类信息列表
static NSString *const kRequestMethod_getPtypeByPid = @"prod:getPtypeByPid";//根据父类id获得首页显示的分类信息列表

#pragma mark 获得分类左侧列表
static NSString *const kRequestMethod_getPCLeftProductDetialType = @"view:getPCLeftProductDetialType";//获得分类左侧列表
#pragma mark 获得首页砖区
static NSString *const kRequestMethod_getPhoneHomePageProduct = @"view:getPhoneHomePageProduct";//获得分类左侧列表
#pragma mark 查询商品的最大分类
static NSString *const kRequestMethod_selectFirstType = @"view:selectFirstType";//获得商品的最大分类

#pragma mark 查询最大分类的子分类
static NSString *const kRequestMethod_selectSecondType = @"view:selectSecondType";//查询最大分类的子分类


#pragma mark- 折扣专区
static NSString *kRequestMethod_disccountProduct=@"view:getDiscountProduct";//折扣专区
#pragma mark 日志信息
static NSString *const kRequestMethod_insertLogSourceByIOS=@"view:insertLog";//插入iOS端日志信息

// 支付
static NSString *const kRequestMethod_UnionPay = @"view:poetPayAPP";//银联支付
static NSString *const kRequestMethod_AliPay = @"alip:openIAlipay";//支付宝支付
static NSString *const kRequestMethod_WeixinPay = @"view:wechatPage";//微信支付


@interface FSNetworkManager : FMNetworkManager

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
                             networkDelegate:(id<FMNetworkProtocol>)networkDelegate;

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
- (FMNetworkRequest *)registerRequestWithUserId:(NSString *)t_user_id
                            t_membership_gradle:(int)t_membership_gradle
                                    t_user_name:(NSString *)t_user_name
                                t_user_password:(NSString *)t_user_password
                                   t_user_phone:(NSString *)t_user_phone
                                    t_user_type:(int)t_user_type
                                   t_user_value:(int)t_user_value
                                networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

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
                                           networkDelegate:(id <FMNetworkProtocol>)networkDelegate;
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
                                                  networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

#pragma mark - 查询用户信息
/**
 *  查询用户信息
 *
 *  @param networkDelegate 代理
 *
 *  @return 请求结果
 */
- (FMNetworkRequest *)queryUserInfoRequestWitht_user_id:(NSString*)t_user_id networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

#pragma mark - 查询用户详细信息
/**
 *  查询用户基本信息
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 请求结果
 */
- (FMNetworkRequest *)queryUserBasicInfoRequestWithUserId:(NSString *)t_user_id
                                          networkDelegate:(id <FMNetworkProtocol>)networkDelegate;
#pragma mark -修改用户信息
/**
 *  @param t_user_id       用户id
 */
-(FMNetworkRequest*)updateUserInfoRequestWithUserID:(NSString*)t_user_id andPhone:(NSString *)phone andSex:(NSString *)sex andBirthDay:(NSString *)birDay   networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

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
                                      networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

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
                                    networkDelegate:(id <FMNetworkProtocol>)networkDelegate;


#pragma mark 根据用户ID查询订单
/**
 *  订单信息
 *
 *  @param userID       订单id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
//-(FMNetworkRequest*)QueryOrderWithUserID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
-(FMNetworkRequest*)gettOrderByUserId:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 查询指定用户所有已支付未发货的订单
-(FMNetworkRequest*)GetUserUndeliverOrdersByUserIdWithUserID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 删除所有订单信息
-(FMNetworkRequest*)deleteAllOrderRequestWithUserID:(NSString*)userID etworkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 查询一段时间内的订单
-(FMNetworkRequest*)QueryByOrderUserIDAndTimeRequestWithuserID:(NSString*)userID  beginTime:(NSString*)beginTime networkDelegate:(id<FMNetworkProtocol>)delegate;
#pragma mark 根据订单ID查询订单信息
-(FMNetworkRequest*)queryOrderMessageRequestWithOrderID:(NSString*)orderID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 更新订单状态
-(FMNetworkRequest*)UpdateOrderStatusRequestWitht_order_id:(NSString*)t_order_id t_order_type:(NSString*)t_order_type networkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 新增一条订单详情信息
- (FMNetworkRequest *)insertOrderDetailAmountDue:(NSString *)due andBuyeraddress:(NSString *)address andPhone:(NSString *)phone andNum:(NSString *)num andOrderDetailId:(NSString *)orderDetailId andPayment:(NSString *)payment andOrderId:(NSString *)orderId andProduceNumber:(NSString *)produceNum andSellerAddress:(NSString *)sellerAddress andSellerphone:(NSString *)sellerPhone andTotalMoney:(NSString *)totalMoney andProduceDetailId:(NSString *)produceDetailId andProductBrand:(NSString *)productBrand andProductColor:(NSString *)productColor andProductSize:(NSString *)productSize andReceipAddress:(NSString *)receipAddress andReceipId:(NSString *)receipId andReceivingmode:(NSString *)receivingmode andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 新增一条信息
- (FMNetworkRequest *)insertOrderWithDeliverNum:(NSString *)deliverNum andCreateTime:(NSString *)createtime andPayment:(NSString *)payment andOrderId:(NSString *)orderId andState:(NSString *)state andType:(NSString *)type andProduceId:(NSString *)produceId andShopId:(NSString *)shopId andTotalNum:(NSString *)totalNum andUserId:(NSString *)userId andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;


//#pragma mark 通过用户id和订单类型 查询订单内商品信息
//- (FMNetworkRequest *)getOrderProductByUserId:(NSString *)t_user_id andType:(NSString *)type andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

/**
   以下订单接口为5月6日以后所给接口
 */
#pragma  mark 根据订单类型和用户ID获得订单
- (FMNetworkRequest *)getOrderProductByUserId:(NSString *)t_user_id andOrderType:(NSString *)type andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma  mark 获取待收货的订单接口
- (FMNetworkRequest *)getOrderCollectingGoods:(NSString *)t_user_id andOrderType:(NSString *)type andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 查询用户的待收货的订单
- (FMNetworkRequest *)selectToBeShippedOrderByUserId:(NSString *)t_user_id andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 根据用户id和订单id查询订单相关信息
- (FMNetworkRequest *)selectOrderbyOrderid:(NSString *)orderID  andUserId:(NSString *)t_user_id andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 根据用户ID分页获得用户的所有订单
- (FMNetworkRequest *)getOrderProductByUserIdCountWithUserId:(NSString *)t_user_id  andPage:(NSString *)page andRow:(NSString *)row andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

/**
 订单新加入的方法
 */
#pragma mark 查询用户的所有订单
- (FMNetworkRequest *)findAllOrderByUderId:(NSString *)t_user_id  andPage:(NSString *)page andRow:(NSString *)row andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 根据订单号得到订单详情
- (FMNetworkRequest *)findAllDetailByOrderIDFromProductDetialType:(NSString *)t_user_id andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark - 加入购物车
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
                                        networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

#pragma mark  查询购物车
/**
 *  查询购物车
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)queryShoppingCarListRequestWithUserId:(NSString *)t_user_id
                                            networkDelegate:(id <FMNetworkProtocol>)networkDelegate;
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
                                                networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

#pragma mark 删除购物车内的某个商品
- (FMNetworkRequest *)clearShoppingCarWithShoppingCarID:(NSString *)shoppingCarID andNetworkDelegate:(id <FMNetworkProtocol>)networkDelegate;

#pragma mark- 查询积分列表
/**
 *  查询订单列表
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate  代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)queryItegralListRequestWithUserId:(NSString *)t_user_id networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

#pragma mark  获取将要过期积分
/**
 *  获取将要过期积分
 *
 *  @param t_user_id       用户id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)GetEndTimeItegralValueRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 获得可用积分
-(FMNetworkRequest*)getAvailableValueRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 获得积分收入列表
-(FMNetworkRequest*)getPointValueInRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 获得积分支出列表
-(FMNetworkRequest*)getPointValueOutListRequestWithUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate;


#pragma mark- 收藏
//#pragma mark 查看收藏商品
//- (FMNetworkRequest *)getCollectionPListUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
//#pragma mark 查看收藏的店铺
//- (FMNetworkRequest *)getCollectionSListUserId:(NSString *)t_user_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
//#pragma mark 删除收藏
//- (FMNetworkRequest *)deleteCollectionListIDWithCollectionId:(NSString *)collectionID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
//#pragma mark 增加收藏  有些疑问
//- (FMNetworkRequest *)createCollectiontWithCreatetime:(NSString *)createtime andCollectionHref:(NSString *)CollectionHref andCollectionId:(NSString *)collectionId andCollectionTitle:(NSString *)CollectionTitle andCollectionType:(NSString *)collectionType andProduceId:(NSString *)produceId andShopId:(NSString *)shopId andUserId:(NSString *)userId networkDelegate:(id<FMNetworkProtocol>)networkDelegate;



#pragma mark- 关注的商品及店铺

#pragma mark 查看关注商品列表
- (FMNetworkRequest *)queryAttentionProductListWithUserId:(NSString *)t_user_id netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 查看关注商铺列表
- (FMNetworkRequest *)queryAttentionShopListWithUserId:(NSString *)t_usr_id netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 删除关注
- (FMNetworkRequest *)deleteAttentionId:(NSString *)attentionId netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 添加关注   

//- (FMNetworkRequest *)createAttentionId:(NSString *)attentionId netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark -增加关注
-(FMNetworkRequest*)createAttentionWithCreatetime:(NSString *)createTime attentionHerf:(NSString *)attentionHerf attentionId :(NSString *)attentionId attentionMoney:(NSString *)attentionMoney attentiontitle:(NSString *)attentiontitle  attentionType:(NSString *)attentionType  produceId:(NSString *)produceId shopId:(NSString *)shopId userId:(NSString *)userId  networkDelegate:(id<FMNetworkProtocol>)networkDelegate;



#pragma mark 店铺信息
-(FMNetworkRequest*)getShopInfoRequestWithShopId:(NSString*)shopID  UserId:(NSString *)t_usr_id    netWorkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 搜索
- (FMNetworkRequest *)getProductOrShopByBlurNameText:(NSString *)seartText andPage:(NSString *)page andRow:(NSString *)row andNetWorkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark- 新增收货地址
/**
 *  新增收货地址
 *@param t_user_id           用户id
 *@param t_receipt_id        收货人ID
 *
 */
-(FMNetworkRequest*)requeatForAddBuyerAddressWithIsDefault:(NSString *)t_is_default andArea:(NSString *)area andId:(NSString *)receiptId andName:(NSString *)name andPhone:(NSString *)phone andStreetAddress:(NSString *)streetAddress    andUserID:(NSString*)t_user_id  networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark ---用户列出所有收货地址
/**
 *  用户列出所有收货地址
 *@param t_user_id  用户id
 */
-(FMNetworkRequest*)requeatForAddBuyerAddressWithUserID:(NSString*)t_user_id  networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark ---用户默认的收货地址
/**
 *  用户默认的收货地址
 *  @param t_user_id 用户ID
 *  @return
 */
-(FMNetworkRequest*)requestForUserDefauleAddressWithUserID:(NSString*)t_user_id  networkDelegate:(id<FMNetworkProtocol>)networkDelegate;







#pragma mark ---设置该地址为用户的默认地址
/**
 *  设置该地址为用户的默认地址
 *  @param arg0  用户ID
 *  @param arg1  收货地址ID
 *  @return
 */
-(FMNetworkRequest*)requestForUserSetDefaultAddressWithArg0:(NSString*)arg0 arg1:(NSString*)arg1 networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark ---修改收货地址
/**修改收货地址
 *  @param t_user_id     用户ID
 *  @param t_receipt_id  收货地址id
 *  @return
 */


-(FMNetworkRequest*)requestForUserChangeAddressWithUser_id:(NSString*)t_user_id  t_receipt_id:(NSString*)t_receipt_id networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark ---删除一条收货地址
/**删除一条收货地址
 *  @param arg0   收货地址ID
 *  @return
 */
-(FMNetworkRequest*)requestForUserDeleteAddressWithArg0:(NSString*)arg0  networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark ---根据ID获取优惠券信息
//根据ID获取优惠券信息
-(FMNetworkRequest*)requestFoGetElectronicVolumeOfUseWithArg0:(NSString*)arg0 networkDElegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark ---获得所有优惠券
/** 获得所有优惠券
 *  @param  useID  用户ID
 */
-(FMNetworkRequest*)requestForGetAllElectronicvolumWithUseID:(NSString*)useID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark ---获得优惠券详情
/**
 *  获得优惠券详情
 *@param  electronicVolumeID  电子券ID
 */
-(FMNetworkRequest*)requestForGetElectronicVolumeDetailWithelectronicVolumeID:(NSString*)electronicVolumeID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 新增优惠券
/**
 *新增优惠券
 *@param   t_electric_volume_id  电子券ID
 *@param   t_user_id            用户ID
 */
-(FMNetworkRequest*)requestForAddElectronicVolumWitht_electric_volume_id:(NSString*)t_electric_volume_id  t_user_id:(NSInteger)t_user_id   networkDelegate:(id<FMNetworkProtocol>)delegate;
#pragma mark 获得可用优惠券
/**
 *获得可用优惠券
 *@param   T_ELECTRIC_VOLUME_ISEFFECT  优惠券可使用规则
 *@param   t_user_id            用户ID
 */
-(FMNetworkRequest*)requestForGetPossibleElectronicVolumeWithUseID:(NSString*)useID   possibleRule:(NSString*)possibleRule networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 获得用户所有的优惠券
-(FMNetworkRequest*)getAllElectronicVolumeWithUseID:(NSString*)useID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark- 广告
-(FMNetworkRequest*)requestForAdvertisementWithNetworkDelegate:(id<FMNetworkProtocol>)delegate;
#pragma mark 查询指定位置的广告
-(FMNetworkRequest*)adListByPositionRequestWithadPsition:(NSString*)adPsition networkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark ---获取所有地区信息
-(FMNetworkRequest*)queryAllProvinceInfromationRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark -获得地区版本信息
-(FMNetworkRequest*)queryProvincceInfromationRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 品牌分类列表
-(FMNetworkRequest*)TPbrandListRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 查询关注品牌人数
-(FMNetworkRequest*)selectAttentionNumWithProductID:(NSString*)productID withNetworkDelegate:(id<FMNetworkProtocol>)delegate;

#pragma mark 品牌列出部分商品
-(FMNetworkRequest*)getBrandProductWithType:(NSInteger)type start:(NSInteger)start number:(NSInteger)number userID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)delegate;

#pragma mark 新闻
-(FMNetworkRequest*)getNewsInfoWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 猜你喜欢
-(FMNetworkRequest*)guessByIDRequestWitht_user_id:(NSString*)t_user_id len:(NSInteger)len networkDelegate:(id<FMNetworkProtocol>)delegate;
#pragma mark 我的页面
-(FMNetworkRequest*)getMyPageInfoRequestWithuserID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)delegate;
#pragma mark 获得PC端首页布局
-(FMNetworkRequest*)getAllPCAllProductDetialTypeRequestWitNetworkDelegate:(id<FMNetworkProtocol>)delegate;

#pragma mark 获得首页显示的分类信息
-(FMNetworkRequest*)getTPTypeProductInfoRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 获得首页的产品类型
-(FMNetworkRequest*)getHomeProductsRequestWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark- 商品详情页加载接口数据
#pragma mark 根据商品ID获得商品详情
-(FMNetworkRequest*)getProductDetailWithProductID:(NSString*)t_produce_id networkDelegate:(id<FMNetworkProtocol>)delegate;
#pragma mark 获得商品属性
- (FMNetworkRequest*)getPhoneProductStatusProductID:(NSString *)t_produce_id networkDelegate:(id<FMNetworkProtocol>)delegate;
#pragma mark 获得商品评价信息
- (FMNetworkRequest *)getProductRatedByProductID:(NSString *)t_produce_id networkDelegate:(id<FMNetworkProtocol>)delegate;



#pragma mark- 分类信息列表
- (FMNetworkRequest *)requestForGetPTypeByPId:(NSString *)pId withStartRow:(NSInteger)startRow withPageNum:(NSInteger)pageNum networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 跟多的分类列表
- (FMNetworkRequest *)getAppProductByTypePid:(NSString *)typeId andTypes:(NSInteger )type andPage:(NSString *)page andRows:(NSString *)row andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 小分类的产品列表
- (FMNetworkRequest *)appselectproductByTypeId:(NSString *)typeId andTypes:(NSInteger )type andPage:(NSString *)page andRows:(NSString *)row andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark- 获得分类左侧列表
- (FMNetworkRequest *)getPCLeftProductDetailTypeNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 获得首页砖区列表
- (FMNetworkRequest *)getPhoneHomePageProductNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 获得商品最大分类
- (FMNetworkRequest *)selectFirstTypeWithNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 查询最大分类的子分类
- (FMNetworkRequest *)selectSecondTypeWthPid:(NSString *)pId andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark- 热销
- (FMNetworkRequest *)querySelectedAllRequestType:(NSInteger)type start:(NSInteger)start num:(NSInteger)number userID:(NSString*)userID  NetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 组合
-(FMNetworkRequest*)getAppCombinationListRequestWithpage:(NSInteger)page rows:(NSInteger)row NetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 查询所有促销信息
-(FMNetworkRequest*)getAllPromotoiomProductRequestWithtype:(NSInteger)type start:(NSInteger)start num:(NSInteger)num networkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 折扣
-(FMNetworkRequest*)getDiscountProductRequestWithType:(NSInteger)type currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize networkDelegate:(id<FMNetworkProtocol>)networkDelegate;


#pragma mark 团购类型接口
- (FMNetworkRequest *)getSelectTypeGroupNetWorkDelegate:(id<FMNetworkProtocol>)networkDelegate;
#pragma mark 团购列表接口
- (FMNetworkRequest *)getSelectGroupProductTypeId:(NSString *)typeId andCurrentPage:(int)currentpage andPageSize:(int)pageSize andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;

#pragma mark 秒杀
- (FMNetworkRequest *)getAppSeckillProductPage:(NSString *)page andRow:(NSString *)row andStartTime:(NSString *)startTime andEndTime:(NSString *)endTime andNetworkDelegate:(id<FMNetworkProtocol>)networkDelegate;




#pragma mark 新品上市
/**
 *@param type  查询类型
 *@param start 起始设置
 *@param  num  查询条数
 *@param  userID  用户ID
 */
-(FMNetworkRequest*)getNewProductWithType:(NSInteger)type start:(NSInteger)start num:(NSInteger)number userID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;



#pragma mark 日志信息
-(FMNetworkRequest*)insertLogRequestWithClientloginID:(NSString*)clientLoginID time:(NSString*)createTime loginID:(NSString*)loginID logMessage:(NSString*)logMsg userID:(NSString*)userID networkDelegate:(id<FMNetworkProtocol>)networkDelegate;


#pragma mark - 支付宝支付
/**
 *  支付宝支付
 *
 *  @param orderID       订单id
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
                                  networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

#pragma mark - 银联支付
/**
 *  银联支付
 *
 *  @param orderID       订单id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */
- (FMNetworkRequest *)openUnopayRequestByOrderID:(NSString *)orderID
                                      orderMoney:(NSString *)orderMoney
                                 networkDelegate:(id <FMNetworkProtocol>)networkDelegate;

#pragma mark - 微信支付
/**
 *  微信支付
 *
 *  @param orderID       订单id
 *  @param networkDelegate 代理
 *
 *  @return 返回结果
 */

- (FMNetworkRequest *)weixinPayRequestByOrderID:(NSString *)orderID
                                     customerID:(NSString *)customerID
                                     orderMoney:(NSString *)orderMoney
                                     trade_type:(NSString *)trade_type
                                networkDelegate:(id <FMNetworkProtocol>)networkDelegate;





@end

#endif
