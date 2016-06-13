//
//  DetailViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/2/27.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "DetailViewController.h"
#import "ShopDetailTableViewCell.h"
#import "ShopTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *detailArr1;
@property (nonatomic, strong) NSMutableArray *detailArr2;
@property (nonatomic, strong) NSMutableArray *detailIconArr;

@end

@implementation DetailViewController

- (NSMutableArray *)detailIconArr
{
    if (!_detailIconArr) {
        _detailIconArr = [[NSMutableArray alloc]initWithObjects:@"serviceImg", @"phoneImg", @"codeImg", nil];
    }
    return _detailIconArr;
}

- (NSMutableArray *)detailArr1
{
    if (!_detailArr1) {
        _detailArr1 = [[NSMutableArray alloc]initWithObjects:@"在线客服", @"商家电话", @"店铺二维码", nil];
    }
    return _detailArr1;
}
- (NSMutableArray *)detailArr2
{
    if (!_detailArr2) {
        _detailArr2 = [[NSMutableArray alloc]initWithObjects:@"店铺简介", @"公司名称", @"所在地区", @"开店时间", nil];
    }
    return _detailArr2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_tableView  setShowsVerticalScrollIndicator:NO];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopDetailTableViewCell"];
}

#pragma mark- tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1){
        return self.detailArr1.count;
    }
    return self.detailArr2.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 170;
    }
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.shopIcon sd_setImageWithURL:[NSURL URLWithString:_shopInfo.t_shop_logo] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
        cell.shopNameLabel.text=_shopInfo.t_shop_name;
        cell.shopAttentionCount.text=[NSString stringWithFormat:@"%ld人关注",(long)_shopInfo.t_shop_attention_num];
        [cell.buttonTitleLabel1  setTitle:[NSString stringWithFormat:@"%ld",(long)_shopInfo.t_shop_product_num] forState:UIControlStateNormal];
        [cell.buttonTitleLabel2  setTitle:[NSString stringWithFormat:@"%ld",(long)_shopInfo.t_shop_new_product] forState:UIControlStateNormal];
        [cell.buttonTitleLabel3  setTitle:[NSString stringWithFormat:@"%ld",(long)_shopInfo.t_shop_promotion] forState:UIControlStateNormal];
        //动态
        //[cell.buttonTitleLabel4  setTitle:[NSString stringWithFormat:@"%ld",(long)_shopInfo.t_shop_product_num] forState:UIControlStateNormal];
        cell.quality_scoreLabel.text=[NSString stringWithFormat:@"%.2f分",_shopInfo.t_shop_comment_quality_score];
        cell.server_scoreLabel.text=[NSString stringWithFormat:@"%.2f分",_shopInfo.t_shop_comment_server_score];
        cell.speed_scoreLabel.text=[NSString stringWithFormat:@"%.2f分",_shopInfo.t_shop_comment_speed_score];
        if (_shopInfo.compare_quality >=0) {
            cell.compare_qualityLabel.text=[NSString stringWithFormat:@"高于同行%.2f%@",(_shopInfo.compare_quality)*100,@"%"];
        }else{
            cell.compare_qualityLabel.text=[NSString stringWithFormat:@"低于同行%.2f%@",(_shopInfo.compare_quality)*100,@"%"];
        }
        if ([_shopInfo.compare_server integerValue]>=0) {
            cell.compare_serverLabel.text=[NSString stringWithFormat:@"高于同行%@%@",_shopInfo.compare_server,@"%"];
        }else{
            cell.compare_serverLabel.text=[NSString stringWithFormat:@"低于同行%@%@",_shopInfo.compare_server,@"%"];
        }
        if (_shopInfo.compare_speed >=0) {
            cell.compare_speedLabel.text=[NSString stringWithFormat:@"高于同行%.2f%@",_shopInfo.compare_speed,@"%"];
        }else{
            cell.compare_speedLabel.text=[NSString stringWithFormat:@"低于同行%.2f%@",_shopInfo.compare_speed,@"%"];
        }
        
        return cell;
    }
    ShopDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopDetailTableViewCell" forIndexPath:indexPath];
    if (indexPath.section==1) {
        cell.detailTitle.text = self.detailArr1[indexPath.row];
        cell.detailIcon.image = [UIImage imageNamed:self.detailIconArr[indexPath.row]];
        if (indexPath.row==0) {
            cell.detailText.text=_shopInfo.t_shop_customer_service;
        }
        if (indexPath.row==1) {
            cell.detailText.text=_shopInfo.t_shop_phone;
        }
    }else if(indexPath.section==2){
        cell.detailTitle.text = self.detailArr2[indexPath.row];
        if (indexPath.row==0) {
            cell.detailText.text=_shopInfo.t_shop_function;
        }
        else if (indexPath.row==1){
            cell.detailText.text=_shopInfo.t_company_name;
        }
        else if (indexPath.row==2){
            cell.detailText.text=_shopInfo.t_shop_address;
        }
        else if (indexPath.row==3){
            NSString *str=[_shopInfo.t_shop_createtime substringToIndex:10];
            cell.detailText.text=str;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else{
        return 10;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:tableView.tableHeaderView.frame];
    imageView.image = [UIImage imageNamed:@"SepartorLine"];
    return imageView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//返回操作
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//设置操作
- (IBAction)setClick:(id)sender {
}


//下面两个方法是将cell的分割线显示全
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
@end
