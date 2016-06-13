//
//  BrowsHistoryVC.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/19.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BrowsHistoryVC.h"
#import "BrowHistoryCell.h"

@interface BrowsHistoryVC ()<UITableViewDataSource,UITableViewDelegate>


@property(weak,nonatomic)IBOutlet UITableView *tableView;

@property(weak,nonatomic)NSMutableArray *dataArray;

@end

@implementation BrowsHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置导航条右侧按钮
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(clearAll)];
    [rightButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem=rightButton;
    
   [_tableView  registerNib:[UINib nibWithNibName:@"BrowHistoryCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
}
#pragma mark ---按钮点击事件---
//右侧的清空按钮
-(void)clearAll{
    NSLog(@"%s",__FUNCTION__);
}
#pragma mark ---UITableViewDataSource---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.dataArray.count;
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BrowHistoryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}


#pragma mark ---UITableViewDelegate---
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
