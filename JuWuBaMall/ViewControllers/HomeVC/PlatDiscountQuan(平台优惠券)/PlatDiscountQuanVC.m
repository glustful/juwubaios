//
//  PlatDiscountQuanVC.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/12.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "PlatDiscountQuanVC.h"
#import "PlatDiscountQuanCell.h"
#import "PlatDiscountQuanNoCell.h"
#import "DiscountJuan.h"

@interface PlatDiscountQuanVC ()<UITableViewDataSource,UITableViewDelegate,PlatDiscountQuanCellDelegate>

@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,strong) UIView *tableHeadView;

@end

@implementation PlatDiscountQuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, 160)];
    [self.view addSubview:_tableHeadView];
    _tableView.tableHeaderView=_tableHeadView;
    _tableView.showsVerticalScrollIndicator=NO;
    [self createheaderView:_tableHeadView];

}
/**
 创建表头
 */
-(void)createheaderView:(UIView*)parentView{
    UIImageView *headImg=[[UIImageView alloc]init];
    headImg.frame=CGRectMake(0, 0, ScreenWidth, 129);
    headImg.image=[UIImage imageNamed:@"adErrorImage.png"];
    [parentView addSubview:headImg];
    UIImageView *sepeatorImg=[[UIImageView alloc]init];
    sepeatorImg.frame=CGRectMake(0, 159, ScreenWidth, 1);
    sepeatorImg.image=[UIImage imageNamed:@"SepeatLine.png"];
    [parentView addSubview:sepeatorImg];
    UILabel *label=[[UILabel alloc]initWithFont:[UIFont systemFontOfSize:17] andText:@"每日抢券"];
    label.frame=CGRectMake(0, 134, 100, 25);
    [parentView addSubview:label];
    UILabel *label2=[[UILabel alloc]initWithFont:[UIFont systemFontOfSize:15] andText:@"每天10点抢全品券"];
    label2.frame=CGRectMake(ScreenWidth-135, 134, 130, 25);
    [parentView addSubview:label2];

}
#pragma mark --UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.row==0) {
        static NSString *caseCellId=@"PlatDiscountQuanNoCell";
        PlatDiscountQuanNoCell *casecell=[tableView dequeueReusableCellWithIdentifier:caseCellId];
        if (casecell==nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlatDiscountQuanNoCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[PlatDiscountQuanNoCell class]])
                {
                    casecell = (PlatDiscountQuanNoCell *)obj;
                }
            }
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"PlatDiscountQuanNoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:caseCellId];
        }
        return casecell;

     }
    else{
        static NSString *cellID=@"PlatDiscountQuanCell";
        PlatDiscountQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlatDiscountQuanCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[PlatDiscountQuanCell class]])
                {
                    cell = (PlatDiscountQuanCell *)obj;
                    cell.delegate=self;
                }
            }
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"PlatDiscountQuanCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellID];
        }
        return cell;
    }
}
#pragma mark ---UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        PlatDiscountQuanNoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PlatDiscountQuanNoCell"];
        if (cell) {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            CGFloat height=cell.height;
            return height;
        }
        return 0;

           }
    else{
        PlatDiscountQuanCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PlatDiscountQuanCell"];
        if (cell) {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            CGFloat height=cell.height;
            return height;
        }
        return 0;
    }
    
}
#pragma mark PlatDiscountQuanCellDelegate
-(void)didButtonClick:(UIButton *)button{
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"您已领取过此优惠券！" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alert show];
    FMNetworkRequest *platCouponsRequest=[[FSNetworkManager sharedInstance]requestForAddElectronicVolumWitht_electric_volume_id:@"156161" t_user_id:111 networkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
    [self.networkRequestArray  addObject:platCouponsRequest];
}
#pragma mark 网络回调
-(void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkRequest{
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[NSString class]]) {
        [[BaseAlert  sharedInstance]showMessage:fmNetworkRequest.responseData];
    }
}
-(void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[DiscountJuan class]]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkRequest.responseData];
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
