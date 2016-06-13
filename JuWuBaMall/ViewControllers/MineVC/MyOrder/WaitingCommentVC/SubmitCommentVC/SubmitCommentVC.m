//
//  SubmitCommentVC.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/1/29.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "SubmitCommentVC.h"
#import "GCPlaceholderTextView.h"
#import "HDetailPictureInfo.h"
#import "SelectPhotoManager.h"
#import "CustButton.h"
#import <UIImageView+WebCache.h>

#define  kSelectPicImageSize                60

@interface SubmitCommentVC ()<SelectPhotoManagerDelegate>

@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *inputCountLabel;
@property (weak, nonatomic) IBOutlet UIView *pictureView;

@property (nonatomic, strong) NSMutableArray *upImagesArray;            // 待上传的图片
@property (nonatomic, strong) SelectPhotoManager *selectPhotoManager;   // 图片选择助手

@end

@implementation SubmitCommentVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addNavLeftItemWithImageName:@"WhiteBack" withName:@"取消"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.productLogo sd_setImageWithURL:[NSURL URLWithString:_orderInfo.t_product_img] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
    
    // topRightItem
    [self addNavRightItemWithImageName:@"editIcon"];
    
    // 初始化图片视图
    [self setupViewPictureViewSubs:_pictureView];
    
    _textView.placeholderColor = kTextColor;
    _textView.placeholder = NSLocalizedString(@"说说你和这件小物的故事吧",);
    
    // 图片选择助手
    _selectPhotoManager = [[SelectPhotoManager alloc] init];
    // 待上传的图片
    _upImagesArray = [[NSMutableArray alloc] init];
    
    
}

- (void)setupViewPictureViewSubs:(UIView *)viewParent
{
    [viewParent removeAllSubviews];
    
    NSInteger spaceYStart = (viewParent.height-kSelectPicImageSize)/2;
    NSInteger spaceXStart = 5;
    
    if (_upImagesArray && _upImagesArray.count > 0)
    {
        for (int i = 0; i < _upImagesArray.count; i++)
        {
            // 图片信息
            HDetailPictureInfo *detailPictureInfo = _upImagesArray[i];
            ALAsset *asset = detailPictureInfo.asset;
            UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
            
            UIImageView *imageView = (UIImageView *)[viewParent viewWithTag:100+i];
            if (imageView == nil)
            {
                imageView = [[UIImageView alloc] init];
                imageView.tag = 100+i;
                [viewParent addSubview:imageView];
            }
            
            imageView.frame = CGRectMake(spaceXStart, spaceYStart, kSelectPicImageSize, kSelectPicImageSize);
            imageView.image = image;
            
            
            // 调整X
            spaceXStart += imageView.width;
            spaceXStart += 10;
        }
    }
    
    // 选择图片入口
    UIButton *selectPicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectPicButton.frame = CGRectMake(spaceXStart, spaceYStart, kSelectPicImageSize, kSelectPicImageSize);
    [selectPicButton setBackgroundImage:[UIImage imageNamed:@"Carmera"] forState:UIControlStateNormal];
    [selectPicButton addTarget:self action:@selector(doSelectPhotoAction:) forControlEvents:UIControlEventTouchDown];
    [viewParent addSubview:selectPicButton];
    
    spaceXStart += selectPicButton.width;
    spaceXStart += 10;
    
    // 最多三张提示
    UILabel *tintLabel = [[UILabel alloc] initWithFont:[UIFont systemFontOfSize:12] andText:@"最多三张(选填)" andColor:kTextColor];
    tintLabel.numberOfLines = 0;
    tintLabel.frame = CGRectMake(spaceXStart, (viewParent.height-50)/2, ScreenWidth-spaceXStart, 50);
    tintLabel.textAlignment = NSTextAlignmentLeft;
    [viewParent addSubview:tintLabel];
}

#pragma mark - topRightItem点击事件
- (void)doRightItemAction:(UIButton *)button
{
    [super doCommonRightItemAction:button];

}


/**
 *  导航左入口点击事件
 *
 *  @param button 响应button
 */
- (void)doLeftItemAction:(UIButton *)button;
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 选择图片回调
- (void)choosePhotoBack:(NSMutableArray *)arrayPictureInfo upStatus:(NSInteger)upStatus;
{
    [_upImagesArray removeAllObjects];
    
    [_upImagesArray addObjectsFromArray:arrayPictureInfo];
    
    [self setupViewPictureViewSubs:_pictureView];
    //    [_tableView reloadData];
}

- (IBAction)doSelectPhotoAction:(id)sender
{
    [_selectPhotoManager choosePhotoWithPresentViewController:self touchData:_upImagesArray];
    
}
//评分
- (IBAction)commentScoreAction:(CustButton*)sender {
    if (sender.isCover==YES) {
        sender.isCover=NO;
        //背景图片变为红色
        [sender  setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    else{
        sender.isCover=YES;
        [sender  setBackgroundImage:[UIImage imageNamed:@"CommentStar.png"] forState:UIControlStateNormal];
    }
}



@end
