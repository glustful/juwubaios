//
//  SearchHistoryDataBase.h
//  JuWuBaMall
//
//  Created by JWB on 16/4/18.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHistoryDataBase : NSObject

+ (id)shareDataBase;

- (NSMutableArray *)readLocalArray;

- (void)writeLocalWithDataArray:(NSMutableArray *)dataArray;

- (void)deleteLocalDataArray;

@end
