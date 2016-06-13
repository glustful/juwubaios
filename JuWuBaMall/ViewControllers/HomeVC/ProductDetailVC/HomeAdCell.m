//
//  HomeAdCell.h
//  YunshangYoupin
//
//  Created by yanghua on 15/11/18.
//  Copyright © 2015年 hxyxt. All rights reserved.


#import "HomeAdCell.h"
#import "AdPageView.h"
#import "AdInfo.h"
#import <Masonry.h>
@interface HomeAdCell ()<AdPageViewDelegate>
{
    __weak id<HomeAdCellDelegate> delegate;
    AdPageView      *adPage;
//    __block  NSArray            *adArr;
}
@property(nonatomic,strong)NSMutableArray *imageUrlArray;
@end

@implementation HomeAdCell
@synthesize delegate;


+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString*ID = @"HomeAdCell";
    HomeAdCell*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell=[[HomeAdCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        
        /* 关键步骤 */
        //       [self addObserver:self
        //                          forKeyPath:@"age"
        //                              options:NSKeyValueObservingOptionNew
        //                              context:nil];
      //  __weak HomeAdCell *weakself = self;
        adPage= [[AdPageView alloc]init];
        adPage.frame = CGRectMake(0, 0, ScreenWidth, 200);

        adPage.delegate = self;
        [self addSubview:adPage];
    
//        [adPage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.equalTo(self);
//            
//        }];

    }
    return self;
}

-(NSMutableArray *)imageUrlArray{
    if (_imageUrlArray) {
       _imageUrlArray= [NSMutableArray array];
        
    }
    return _imageUrlArray;
}

-(void)setAdPageData:(NSMutableArray *)AdPageData{
       _imageUrlArray =AdPageData;
    
//    if (AdPageData.count>0) {
//        
//    _imageUrlArray= [NSMutableArray array];
//        
//    for (AdInfo*imageModel in AdPageData) {
//        
////        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",ImageHeader_URL,imageModel.imageUrl];
//        [_imageUrlArray addObject:imageModel.imageUrl];
////         NSLog(@"image--是%@",imageUrl);
//    }
    NSLog(@"image--是 数量是%ld",_imageUrlArray.count);
    adPage.imgNameArr =_imageUrlArray;
//    }else{
//        NSLog(@"没数据");
//    }
    
}

- (void)click:(int)index
{
    if(delegate)
    {
       NSString*harf = [_imageUrlArray objectAtIndex:index];
        [delegate homeADPageClick:harf index:index];

    }
}

- (void)changeImage:(int)index
{
    adPage.imgNameArr = _imageUrlArray;
}

@end
