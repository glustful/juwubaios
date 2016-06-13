//
//  SearchViewController.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/18.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "BaseVC.h"
#import "NewSearchBar.h"
#import "HistoryTableView.h"

@interface SearchViewController : BaseVC<NewSearchBarDelegate>
@property(nonatomic,strong)NewSearchBar      *mb_searchBar;
//自定义搜索Bar

@property(nonatomic,strong)HistoryTableView          *mb_historyTableView;//显示搜索历史记录列表

@property(nonatomic,strong)UILabel          *mb_searchResultTableView;//搜索结果伪列表

@end
