//
//  SearchHistoryDataBase.m
//  JuWuBaMall
//
//  Created by JWB on 16/4/18.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SearchHistoryDataBase.h"

@implementation SearchHistoryDataBase


+(id)shareDataBase{
    
    static  SearchHistoryDataBase *collectDataBase;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        collectDataBase = [[SearchHistoryDataBase alloc]init];
    });
    
    return collectDataBase;
    
}



-(NSMutableArray *)readLocalArray{
    
    //从沙盒中取数据
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dataPath = [filePath stringByAppendingString:@"/history.plist"];
    
    //判断是否存在这个文件
    if (![[NSFileManager defaultManager]fileExistsAtPath:dataPath]) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        
        [array writeToFile:dataPath atomically:YES];
        
        return array;
        
    }else{
        
        NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:dataPath];
        if (array==nil) {
            array=[[NSMutableArray alloc]init];
        }
        return array;
    }
    
}
//写入
- (void)writeLocalWithDataArray:(NSMutableArray *)dataArray{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dataPath = [filePath stringByAppendingString:@"/history.plist"];
    
    [dataArray writeToFile:dataPath atomically:YES];
    
}
//删除
- (void)deleteLocalDataArray{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dataPath = [filePath stringByAppendingString:@"/history.plist"];
    
    NSMutableArray *localArray  = [NSMutableArray arrayWithContentsOfFile:dataPath];
    
    [localArray removeAllObjects];
}


@end
