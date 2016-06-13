//
//  LogisticsDetailVC.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "LogisticsDetailVC.h"
#import "LogisticsStatusCell.h"

@interface LogisticsDetailVC ()<UITableViewDelegate, UITableViewDataSource, PhoneNumberDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LogisticsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // topRightItem
    [self addNavRightItemWithImageName:@"editIcon"];
    
}
-(void)doRightItemAction:(UIButton *)button{
    [self doCommonRightItemAction:button];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // 物流状态相关cell
 
        if (indexPath.row == 0)
        {
            static NSString *cellId = @"LogisticsStatusCell";
            LogisticsStatusCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
            
            if (caseFieldNotificationCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LogisticsStatusCell" owner:self options:nil];
                for(id obj in nib)
                {
                    if([obj isKindOfClass:[LogisticsStatusCell class]])
                    {
                        caseFieldNotificationCell = (LogisticsStatusCell *)obj;
                    }
                }
                caseFieldNotificationCell.delegate = self;
                caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                // cell 复用
                [tableView registerNib:[UINib nibWithNibName:@"LogisticsStatusCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
                
            }
            
            return caseFieldNotificationCell;
        }
        
   
       return nil;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
 
        LogisticsStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogisticsStatusCell"];
        
        if (cell)
        {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            CGFloat height = cell.height;
            
            return height;
        }
   
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.001;
}

//打电话
- (void)phoneNumberClick:(UIButton *)button
{
    
    NSString *phoneNum = button.titleLabel.text;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //    UIAlertAction *normalAction = [UIAlertAction actionWithTitle:@"0871-123456778" style:UIAlertActionStyleDefault handler:@selector(doPhoNum:)];
    UIAlertAction *normalAction = [UIAlertAction actionWithTitle:@"0871-67353358" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNum];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:normalAction];
    

}


@end
