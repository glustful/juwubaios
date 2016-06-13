//
//  AccountManageVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/17.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "AccountManageVC.h"
#import "CreateNewAddressVC.h"
#import "AccountManagerCell.h"
#import "AddressEditingVC.h"

/**
 *  选择收货地址
 */
@interface AccountManageVC ()<UITableViewDataSource,UITableViewDelegate,AccountCellDelegate,AddressEditingViewControllerDelegate>

@property(weak,nonatomic)IBOutlet UIView *NoAddressView;
@property(weak,nonatomic)IBOutlet UIView *HaveAddressView;

@property(weak,nonatomic)IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *addressListArray;//用来存放地址的数组
@property(strong,nonatomic)AddressInfo *addressInfo;

@property(assign,nonatomic)NSInteger  selectedRowIndex;

@property(strong,nonatomic)AddressInfo *EditingAddressInfo;

@end

@implementation AccountManageVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BaseAlert sharedInstance]showMessage:@"加载中......"];

    //用户列出所有收货地址  @"688831b3-b671-46a1-8a14-e739c72ecac4"
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]requeatForAddBuyerAddressWithUserID:[[GlobalSetting sharedInstance]gUser].t_user_id networkDelegate:self];
    [self.networkRequestArray addObject:request];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.tableView.backgroundColor = [UIColor redColor];
    
    _addressListArray=[[NSMutableArray alloc]init];
    _selectedRowIndex=-1;
    _tableView.userInteractionEnabled=YES;
    
       [_tableView  reloadData];
    
    self.view=_NoAddressView;
    self.view=_HaveAddressView;
    
}
#pragma mark AddressEditingViewControllerDelegate
-(void)gaveTheValuOfAccountManagerWithAddressInfo:(AddressInfo *)addressInfo{
    self.EditingAddressInfo=addressInfo;
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_selectedRowIndex inSection:0];
    AccountManagerCell *cell=[_tableView cellForRowAtIndexPath:indexPath];
    cell.nameLabel.text=self.EditingAddressInfo.t_receipt_name;
    cell.phoneLabel.text=self.EditingAddressInfo.t_receipt_phone;
    cell.addressLabel.text=[NSString stringWithFormat:@"%@%@",self.EditingAddressInfo.t_receipt_area,self.EditingAddressInfo.t_receipt_streetaddress];
}
#pragma mark ---UITableViewDataSource---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressListArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"AccountManagerCell";
    AccountManagerCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (caseFieldNotificationCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AccountManagerCell" owner:self options:nil];
        for(id obj in nib)
        {
            if([obj isKindOfClass:[AccountManagerCell class]])
            {
                caseFieldNotificationCell = (AccountManagerCell *)obj;
                
            }
        }
        caseFieldNotificationCell.accessoryType=UITableViewCellAccessoryNone;
        caseFieldNotificationCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        // cell 复用
        [tableView registerNib:[UINib nibWithNibName:@"AccountManagerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
    }
        caseFieldNotificationCell.delegate=self;
        caseFieldNotificationCell.editingButton.tag=indexPath.row;
        caseFieldNotificationCell.deleteButton.tag=indexPath.row+10;
    
        AddressInfo *address=[_addressListArray objectAtIndex:indexPath.row];
    
    [caseFieldNotificationCell customWithModel:address];
    if (address.t_is_default_address && [address.t_is_default_address  isEqualToString:@"Y"]) {//默认
            //设置按钮的默认背景
            [caseFieldNotificationCell.setDefaultButton setBackgroundImage:[UIImage imageNamed:@"AllSelectIcon.png"] forState:UIControlStateNormal];
    }else{
        //不是默认
        [caseFieldNotificationCell.setDefaultButton setBackgroundImage:[UIImage imageNamed:@"setNormorl.png"] forState:UIControlStateNormal];
    }
    return caseFieldNotificationCell;
}
#pragma mark ---UITableViewDelegate---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AccountManagerCell"];
//    if (cell) {
//        [cell  updateConstraintsIfNeeded];
//        [cell  setNeedsUpdateConstraints];
//        CGFloat height=cell.height;
//        return height;
//    }
    return 135;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    AddressInfo *address=_addressListArray[indexPath.row];
    if (_accountDelegate && [_accountDelegate respondsToSelector:@selector(didSelectedAddressInfoToOrderConfirmWithOrder:)]) {
        [_accountDelegate didSelectedAddressInfoToOrderConfirmWithOrder:address];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)doCreateNewAddressAction:(id)sender{
    CreateNewAddressVC *createNewAddress=[[CreateNewAddressVC alloc]initWithName:@"新建收货地址"];
    [self.navigationController pushViewController:createNewAddress animated:YES];
}

#pragma mark ---AccountCellDelegate----
#pragma mark --设置为默认
-(void)AccountCellSetDefaultButtonDidTouchDown:(CustButton *)button withAddressInfo:(AddressInfo *)addressInfoModel
{
    
//    [button setBackgroundImage:[UIImage imageNamed:@"AllSelectIcon.png"] forState:UIControlStateNormal];
  
    
    //[[BaseAlert sharedInstance]showMessage:@"设置中"];    //arg1 收货地址ID  arg0 用户ID
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]requestForUserSetDefaultAddressWithArg0:addressInfoModel.t_receipt_id arg1:[[GlobalSetting sharedInstance]gUser].t_user_id networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
    [self.networkRequestArray addObject:request];
    
    
//    if (button.isCover==NO) {
//        button.isCover=YES;
//        [button setBackgroundImage:[UIImage imageNamed:@"AllSelectIcon.png"] forState:UIControlStateNormal];
//    }else{
//        button.isCover=NO;
//        [button setBackgroundImage:[UIImage imageNamed:@"setNormorl.png"] forState:UIControlStateNormal];
//    }
    
  

//    [self.tableView reloadData];
}
#pragma mark  --编辑
-(void)AccountCellEditingButtonDidTouchDown:(UIButton *)button{
    AddressEditingVC *addressEditingVC=[[AddressEditingVC alloc]initWithName:@"收货地址编辑"];
    AddressInfo  *address=_addressListArray[button.tag];
    _selectedRowIndex=button.tag;
    addressEditingVC.addressInfo=address;
    addressEditingVC.delegate=self;
    [self.navigationController pushViewController:addressEditingVC animated:YES];
}
#pragma mark  --删除
-(void)AccountCellDeleteButtonDidTouchDown:(AddressInfo *)myAddInfo
{

    UIAlertController  *alertControl=[UIAlertController alertControllerWithTitle:@"您确定要删除此地址吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertControl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FMNetworkRequest *request=[[FSNetworkManager sharedInstance]requestForUserDeleteAddressWithArg0:myAddInfo.t_receipt_id networkDelegate:self];
        [self.networkRequestArray addObject:request];
        
//        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_selectedRowIndex inSection:0];
//        UITableViewCell *cell=[_tableView  cellForRowAtIndexPath:indexPath];
//        AddressInfo  *address=_addressListArray[_selectedRowIndex];
//        [cell  removeFromSuperview];
//        [_addressListArray  removeObject:address];
        
        [self.addressListArray removeObject:myAddInfo];
        
        [_tableView  reloadData];
        
    }]];
    [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertControl animated:YES completion:nil];
}
#pragma mark  ----网络回调请求----
- (void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.requestData isKindOfClass:[NSString class]]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
    }
}

- (void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest
{
    [[BaseAlert sharedInstance]dismiss];
    if ([fmNetworkRequest.requestName isEqualToString: kRequest_User_AllReceiveAddress ]) {//用户列出所有收货地址
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSArray class]]) {
            
            [_addressListArray removeAllObjects];
            [_addressListArray  addObjectsFromArray:fmNetworkRequest.responseData];
//            [_tableView  reloadData];
            //判断是否已经填写并保存了地址，如果有就直接加载HaveAddressView，若没有就加载没有地址的NoAddressView，默认加载NoAddressView
            if (_addressListArray.count && _addressListArray.count==0) {
                self.view=_NoAddressView;
                _HaveAddressView.hidden=YES;
            }
            else{
                self.view=_HaveAddressView;
                _HaveAddressView.hidden=NO;
            }
        }else if (fmNetworkRequest.responseData &&[fmNetworkRequest.responseData isKindOfClass:[AddressInfo class]]) {
            [_addressListArray  removeAllObjects];
            _addressInfo=fmNetworkRequest.responseData;
            [_addressListArray  addObject:_addressInfo];
            [_tableView  reloadData];
        }
        [self.tableView reloadData];
    }
    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_setDefaultAddress]){//设置该用户为默认收货地址
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
            [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
//            [self.tableView reloadData];
            
            //用户列出所有收货地址
            FMNetworkRequest *request=[[FSNetworkManager sharedInstance]requeatForAddBuyerAddressWithUserID:[[GlobalSetting sharedInstance]gUser].t_user_id networkDelegate:self];
            [self.networkRequestArray addObject:request];
        }
    }
    else if ([fmNetworkRequest.requestName isEqualToString:kRequest_User_ChangeAddress]){//修改用户收货地址
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
            [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
        }
    }
    else if ([fmNetworkRequest.requestName isEqualToString:kRequestMethod_DeleteAddress]){//删除一条收货地址
        if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
            [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
