//
//  RefundVC.m
//  JuWuBaMall
//
//  Created by ZhangLan_PC on 16/3/4.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "RefundVC.h"

#import "RefundTypeCell.h"
#import "RefundUploadImagesCell.h"

#import "HDetailPictureInfo.h"
#import "SelectPhotoManager.h"

#define  kSelectPicImageSize                60

@interface RefundVC ()<UITableViewDelegate, UITableViewDataSource,SelectPhotoManagerDelegate>

@property (nonatomic, strong) NSMutableArray *upImagesArray;            // 待上传的图片

@property (nonatomic, strong) SelectPhotoManager *selectPhotoManager;   // 图片选择助手

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RefundVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // topRightItem
    [self addNavRightItemWithImageName:@"editIcon"];
    
    // 待上传的图片
    _upImagesArray = [[NSMutableArray alloc] init];
    // 图片选择助手
    _selectPhotoManager = [[SelectPhotoManager alloc] init];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // 退款修改信息cell
    if (indexPath.row == 0)
    {
        static NSString *cellId = @"RefundTypeCell";
        RefundTypeCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RefundTypeCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[RefundTypeCell class]])
                {
                    caseFieldNotificationCell = (RefundTypeCell *)obj;
                }
            }
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"RefundTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            
        }
        
        return caseFieldNotificationCell;
    }
    
    else if (indexPath.row == 1)
    {
        static NSString *cellId = @"RefundUploadImagesCell";
        RefundUploadImagesCell *caseFieldNotificationCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (caseFieldNotificationCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RefundUploadImagesCell" owner:self options:nil];
            for(id obj in nib)
            {
                if([obj isKindOfClass:[RefundUploadImagesCell class]])
                {
                    caseFieldNotificationCell = (RefundUploadImagesCell *)obj;
                }
            }
            
            caseFieldNotificationCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // cell 复用
            [tableView registerNib:[UINib nibWithNibName:@"RefundUploadImagesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
            
        }
        [caseFieldNotificationCell.contentView setFrame:CGRectMake(0, 0, ScreenWidth, 85)];
        
        // 自定义上传图片的cell
        [self setupViewPictureViewSubs:caseFieldNotificationCell.contentView];
        
        return caseFieldNotificationCell;
    }
    return nil;
}

#pragma mark - 退款申请
- (IBAction)doSubmitAction:(id)sender
{
#warning todo 待处理
    
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"已提交申请" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark - 自定义上传图片cell
- (void)setupViewPictureViewSubs:(UIView *)viewParent
{
    [viewParent removeAllSubviews];
    
    // 背景图
    UIImageView *backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewParent.width, viewParent.height)];
    backGroundImageView.image = [UIImage imageNamed:@"UploadImagesBack"];
    
    [viewParent addSubview:backGroundImageView];
    
    // 照片库
    NSInteger spaceYStart = (viewParent.height-kSelectPicImageSize)/2;
    NSInteger spaceXStart = 8;
    
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
    selectPicButton.frame = CGRectMake(spaceXStart, (viewParent.height-42)/2, 51, 42);
    [selectPicButton setBackgroundImage:[UIImage imageNamed:@"CamerGray"] forState:UIControlStateNormal];
    [selectPicButton addTarget:self action:@selector(doSelectPhotoAction:) forControlEvents:UIControlEventTouchDown];
    [viewParent addSubview:selectPicButton];
    
    spaceXStart += selectPicButton.width;
    spaceXStart += 10;
    
    // 最多三张提示
    UILabel *tintLabel = [[UILabel alloc] initWithFont:[UIFont systemFontOfSize:12] andText:@"最多三张(选填)" andColor:kTextColor];
    tintLabel.numberOfLines = 0;
    tintLabel.frame = CGRectMake(spaceXStart, 0, backGroundImageView.width-spaceXStart-10, viewParent.height);
    tintLabel.textAlignment = NSTextAlignmentLeft;
    [viewParent addSubview:tintLabel];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0)
    {
        RefundTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundTypeCell"];
        
        if (cell)
        {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            CGFloat height = cell.height;
            
            return height;
        }
    }
    else if (indexPath.row == 1)
    {
        RefundUploadImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundUploadImagesCell"];
        
        if (cell)
        {
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            CGFloat height = cell.height;
            
            return height;
        }
    }
    
    return 0;
}

#pragma mark - 选择图片回调
- (void)choosePhotoBack:(NSMutableArray *)arrayPictureInfo upStatus:(NSInteger)upStatus;
{
    [_upImagesArray removeAllObjects];
    
    [_upImagesArray addObjectsFromArray:arrayPictureInfo];
    
    [_tableView reloadData];
}

- (IBAction)doSelectPhotoAction:(id)sender
{
    [_selectPhotoManager choosePhotoWithPresentViewController:self touchData:_upImagesArray];
    
}

@end
