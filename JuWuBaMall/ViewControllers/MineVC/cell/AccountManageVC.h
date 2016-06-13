
/************************************************************************
 *Copyright (c) 2015 fangstar. All rights reserved.
 *FileName:     AccountManageVC.h
 *Author:       zhanglan
 *Date:         16/1/17
 *Description:  账户管理、收货地址管理
 *Others:
 *History:
 ************************************************************************/

#import "BaseVC.h"

@protocol AccountManagerDelegate <NSObject>

-(void)didSelectedAddressInfoToOrderConfirmWithOrder:(AddressInfo*)addressInfo;

@end


@interface AccountManageVC : BaseVC
@property(nonatomic,weak)id<AccountManagerDelegate> accountDelegate;

@end
