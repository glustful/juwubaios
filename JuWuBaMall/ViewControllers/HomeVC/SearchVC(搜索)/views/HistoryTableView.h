//
//  HistoryTableView.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/18.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击历史记录cell，回调该条历史记录
typedef void(^SelectHistoryCell)(NSString *string);
//回调滑动tableview的时机，用于弹回键盘并看到更多内容
typedef void(^BeginDraggingBlock)();

@interface HistoryTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
//数据源
@property(nonatomic,strong)NSMutableArray       *mb_historyArray;

@property(nonatomic,copy)SelectHistoryCell       mb_selectHistoryCell;

@property(nonatomic,copy)BeginDraggingBlock       mb_beginDraggingBlock;

//添加一条历史记录
- (void)addHistoryWithString:(NSString *)string;

@end
