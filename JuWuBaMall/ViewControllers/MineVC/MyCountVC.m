//
//  MyCountVC.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/21.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "MyCountVC.h"
#import "MyCountCell.h"



@interface MyCountVC ()

@property(strong,nonatomic)IBOutlet UITableView *tableView;


@end

@implementation MyCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tableView  registerNib:[UINib nibWithNibName:@"MyCountCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"section0"];
}

#pragma mark ---UITableViewDataSource---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }
    else{
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            MyCountCell *cell=[tableView dequeueReusableCellWithIdentifier:@"section0"];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.headImgButton.layer.cornerRadius=cell.headImgButton.width/2;
            cell.headImgButton.layer.masksToBounds=YES;
            cell.headImgButton.layer.borderWidth=0.5;
            cell.headImgButton.layer.borderColor=[[UIColor blackColor]CGColor];
//            NSString *imgName=(NSString*)self.countModel.headImage;
//            [cell.headImgButton setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
            [cell.headImgButton  addTarget:self action:@selector(doPhotoAlbumSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.backGroundButton addTarget:self action:@selector(doPhotoAlbumSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        else{
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell.detailTextLabel.textColor=[UIColor lightGrayColor];
                cell=[[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
                    if (indexPath.row==1) {
                        cell.accessoryType=UITableViewCellAccessoryNone;
                    }
                    else{
                        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    }
               }
            //刷新数据
            if (indexPath.row==1) {
                cell.textLabel.text=@"用户名";
                //cell.detailTextLabel.text=self.countModel.userName;
                cell.detailTextLabel.text=@"nimmjijiiih";
            }
            if (indexPath.row==2) {
                cell.textLabel.text=@"昵称";
                //cell.detailTextLabel.text=self.countModel.nickName;
                cell.detailTextLabel.text=@"kijihiggn";
            }
            if (indexPath.row==3) {
                cell.textLabel.text=@"性别";
                cell.detailTextLabel.text=@"男";
            }
            if(indexPath.row==4){
                cell.textLabel.text=@"出生年月";
            }
            return cell;
        }
    }
    else{
        UITableViewCell   *cell=[tableView dequeueReusableCellWithIdentifier:@"section1"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"section1"];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==1) {
                cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
                cell.detailTextLabel.text=@"可修改密码";
            }
        }
        NSArray *array=@[@"地址管理",@"账户安全"];
        cell.textLabel.text=array[indexPath.row];
                 return cell;
    }
}
#pragma mark ---UITableViewDelegate---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 100;
        }
        else{
            return 60;
        }
    }
    else{
        return 60;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0.005;
    }
    else{
        return 50;
    }
}
#pragma mark --按钮点击事件--
-(void)doPhotoAlbumSelectedAction:(UIButton*)button{
    
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
