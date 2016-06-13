//
//  PublicDefine.h
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/11.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

// 系统版本
#define kSystemVersion                   [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7_OR_LATER                    ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
#define kAppName                         @"瓷砖商城"
#define kWhiteColor                      [UIColor whiteColor]

// 判断iPhone4
#define isIPhone4                        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhone5
#define isIPhone5                        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iphone6
#define isIPhone6                         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

// 判断iphone6+
#define isIPhone6Plus                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

// 颜色
#define kTextColor                        [UIColor colorWithHex:0x888888 alpha:1.0]
#define kARGBColor(r,g,b,a)               [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kSepartorLineColor                kARGBColor(230, 230, 230, 1.0)
#define kMainBackGroundColor              [UIColor colorWithHex:0xdb4f34 alpha:1.0]

// 尺寸
#define TabBarHeight                      54
#define NavgationBarHeight                64
#define ScreenWidth                       [UIScreen mainScreen].bounds.size.width
#define ScreenHeight                      [UIScreen mainScreen].bounds.size.height

// 加载图片
#define LoadImageUrl(RelativePath)        [NSString stringWithFormat:@"%@%@", @"http://182.92.98.174", RelativePath]








//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))



// ===================================================
// 通知
// ===================================================


// ===================================================
// URL Scheme 配置 不要进行更改
// ===================================================

#define kJuWuBaMallAlipayScheme					@"JuWuBaMallAlipay"
#define kJuWuBaUPPayScheme                      @"JuWuBaUPPay"

#define UPPayDebugMode                          @"01"
#define UPPayReleaseMode                        @"00"

// ===================================================
// 微信APPID
// ===================================================

//#define kJuWuBaMallWechatAppID                  @"wx065b247a5e4d0ee7"
#define kJuWuBaMallWechatAppID                  @"wxe0824d70b6fd3391"

// ===================================================
// 地址
// ===================================================




#define KHostUrl   @"http://www.zgczsc.com/"
//#define KHostUrl   @"120.27.194.2"


#define kApiBaseUrl                         @"http://www.zgczsc.com/Users/jwbservice/"
//短信
#define kApiPhoneUrl                        @"http://www.zgczsc.com/PhoneMesg/jwbservice/PhoneMessage"
//新闻
#define kApiNewsUrl                         @"http://www.zgczsc.com/NewsMesg/jwbservice/News"
//优惠券
#define kElectronicVolumeUrl                @"http://www.zgczsc.com/Electronicvolume/jwbservice/Electronicvolume"

//添加到购物车
#define kShoppingCarUrl                      @"http://www.zgczsc.com/ShoppingCars/jwbservice/ShoppingCar"
//#define kShoppingCarUrl                      @"http://120.27.194.2/ShoppingCars/jwbservice/ShoppingCar"


//订单                                        
#define korderManagerUrl                @"http://www.zgczsc.com/Orders/jwbservice/orderManager"
//#define korderManagerUrl                @"http://120.27.194.2/Orders/jwbservice/orderManager"

//广告
#define kAdvertisementUrl               @"http://www.zgczsc.com/Advertisement/jwbservice/advertisement"
//推送消息接口
#define kApiPushMessageUrl              @"http://www.zgczsc.com/Msgpush/jwbservice/msgpush"

// 积分
#define quaryItegralUrl       @"http://www.zgczsc.com/Integral/jwbservice/integral"


/**
 *  收藏  这个是应该用的关注
 */
#define CollectionUrl         @"http://www.zgczsc.com/Collection/jwbservice/collection"

/**
 *  关注商品  此关注接口改为上面的  CollectionUrl
 */
//#define KAddAttentionUrl         @"http://www.zgczsc.com/Attenion/jwbservice/IAttention"

#define AttentionUrl         @"http://www.zgczsc.com/Attenion/jwbservice/IAttention"


/**
 *  根据父类id获得首页显示的分类信息列表
 */
#define ProductCategoryUrl     @"http://www.zgczsc.com/Product/jwbservice/product"

//热销
#define  HotSaleUrl     @"http://www.zgczsc.com/HotBand/jwbservice/hotBand"


//猜你喜欢
#define kApiGuessUrl     @"http://www.zgczsc.com/GuessYouLike/jwbservice/guess"
//我的
#define  kMyPageInfoUrl   @"http://www.zgczsc.com/Phone/jwbservice/phone"

//商品 新品上市等
#define kApiProductUrl   @"http://www.zgczsc.com/Product/jwbservice/product"

//商品所有评价
#define kApiProductRatedUrl   @"http://www.zgczsc.com/Leavemesg/jwbservice/IProductRated"

//店铺
#define kShopInfoUrl       @"http://www.zgczsc.com/ShopService/jwbservice/ShopInfoImp"

// 获得分类页左侧列表
#define kApiSortUrl      @"http://www.zgczsc.com/Product/jwbservice/product"

//首页砖区分类
#define kHomeSortUrl      @"http://www.zgczsc.com/Product/jwbservice/product"

//地区
#define kProvinceUrl     @"http://www.zgczsc.com/Provinces/jwbservice/iprovince"
//品牌馆
#define kBrandUrl        @"http://www.zgczsc.com/BrandLibrary/jwbservice/IBrandLibrary"

//促销
#define kPromotoionUrl    @"http://www.zgczsc.com/Sudorific/jwbservice/IPromotion"
//组合
#define kCombinationUrl  @"http://www.zgczsc.com/Sudorific/jwbservice/ICombination"
//团购
#define IGroupPurchase    @"http://www.zgczsc.com/Sudorific/jwbservice/IGroupPurchase"
/**
 *  秒杀
 */
#define kSeckillProduct    @"http://www.zgczsc.com/Sudorific/jwbservice/ISecKill"

//日志
#define kLogUrl           @"http://www.zgczsc.com/Log/jwbservice/log"
#endif


