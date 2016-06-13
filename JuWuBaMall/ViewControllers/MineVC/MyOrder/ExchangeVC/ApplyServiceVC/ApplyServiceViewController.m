//
//  ApplyServiceViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/1/26.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ApplyServiceViewController.h"
#import "SelectPhotoManager.h"
#import "HDetailPictureInfo.h"
#import <UIImageView+WebCache.h>
#import "CustButton.h"


#define kSelectPicImageSize  50

typedef NS_ENUM(NSInteger, ApplyServiceTag)
{
    aSepartorView1 = 1,
    aSepartorView2,
    aSepartorView3,
    aSepartorView4,
    aSepartorView5,
    aSepartorView6,
    aSepartorView7,
    
};
@interface ApplyServiceViewController ()<SelectPhotoManagerDelegate,UIScrollViewDelegate, UITextViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;//滑动主视图
@property (nonatomic, strong) UIButton *countButton;//数字button
@property (nonatomic, strong) UITextView *textView;//输入框
@property (nonatomic, strong) UIView *questionView;//问题描述

@property (nonatomic, strong) SelectPhotoManager *selectPhotoManager;//图片选择助手
@property (nonatomic, strong) NSMutableArray *upImagesArray;//待上传图片
@property (nonatomic, strong) UIView *pictureView;//放图片的view



@end

@implementation ApplyServiceViewController

- (NSMutableArray *)upImagesArray
{
    if (!_upImagesArray) {
        _upImagesArray = [[NSMutableArray alloc]init];
    }
    return _upImagesArray;
}

- (SelectPhotoManager *)selectPhotoManager
{
    if (!_selectPhotoManager) {
        _selectPhotoManager = [[SelectPhotoManager alloc] init];
        
    }
    return _selectPhotoManager;
}
- (UIView *)pictureView
{
    if (!_pictureView) {
        _pictureView = [[UIView alloc]init];
        _pictureView=[[UIView alloc]initWithFrame:CGRectMake(0, 420, ScreenWidth, 100)];
        _pictureView.backgroundColor=[UIColor whiteColor];
    }
    return _pictureView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self addNavRightItemWithImageName:@"ExchangedSetting"];
    [self setupRootViewSubs:self.view];
   
    [self setupPictureViewSubs:self.pictureView];
    [_scrollView addSubview:_pictureView];
}
-(void)doRightItemAction:(UIButton *)button{
    [self doCommonRightItemAction:button];
}
- (void)setupPictureViewSubs:(UIView *)viewParent
{
    [viewParent removeAllSubviews];
    
    NSInteger spaceYStart = 0;
    NSInteger spaceXStart = 5;
    
    if (self.upImagesArray && self.upImagesArray.count>0) {
        for (int i = 0; i < self.upImagesArray.count; i++) {
            HDetailPictureInfo *detailPictureInfo = self.upImagesArray[i];
            ALAsset *asset = detailPictureInfo.asset;
            UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
            
            UIImageView *imageView = (UIImageView *)[viewParent viewWithTag:100+i];
            if (!imageView) {
                imageView = [[UIImageView alloc]init];
                imageView.tag = 100+i;
                [viewParent addSubview:imageView];
            }
            imageView.frame = CGRectMake(spaceXStart, spaceYStart, kSelectPicImageSize, kSelectPicImageSize);
            imageView.layer.cornerRadius = 5;
            imageView.layer.masksToBounds = YES;
            imageView.layer.borderWidth = 0.01;
            imageView.image = image;
            
        }
    }
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 70, 20)];
    titleLabel.text = @"上传图片";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [viewParent addSubview:titleLabel];
    
    //icon
    UIButton *addPictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addPictureButton setBackgroundImage:[UIImage imageNamed:@"ApplyServiceAddPicture"] forState:UIControlStateNormal];
    addPictureButton.frame = CGRectMake(5, titleLabel.bottom+5, 50, 50);
    [addPictureButton addTarget:self action:@selector(selectPhontoImage:) forControlEvents:UIControlEventTouchDown];
    [viewParent addSubview:addPictureButton];
    //icon内的label
    UILabel *newLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, addPictureButton.height-20, addPictureButton.width-10, 15)];
    newLabel.text = @"添加新图片";
    newLabel.font = [UIFont systemFontOfSize:8];
    newLabel.textColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    [addPictureButton addSubview:newLabel];
    
    //说明Label
    UILabel *explain = [[UILabel alloc]initWithFrame:CGRectMake(5, addPictureButton.bottom+5, ScreenWidth-10, 20)];
    explain.text = @"最多上传3张，每张不超过5M，支持JPG，BMP，PNG";
    explain.font = [UIFont systemFontOfSize:10];
    explain.textColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    [viewParent addSubview:explain];
}

#pragma mark- 选择图片回调
- (void)choosePhotoBack:(NSMutableArray *)arrayPictureInfo upStatus:(NSInteger)upStatus
{
    [self.upImagesArray removeAllObjects];
    [self.upImagesArray addObjectsFromArray:arrayPictureInfo];
    [self setupPictureViewSubs:self.pictureView];
}
-(void)selectPhontoImage:(UIButton*)button{
    
    [_selectPhotoManager choosePhotoWithPresentViewController:self touchData:_upImagesArray];
    
}


//设置主视图的子视图
- (void)setupRootViewSubs:(UIView *)viewParent
{
    NSInteger rootXStart = 0;
    NSInteger rootYStart = 0;
    
//    //设置头视图
//    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, ScreenWidth, 60)];
//    [viewParent addSubview:topView];
   // [self setupTopViewSubs:topView];
    
    //重置坐标
//    rootXStart = 0;
//    rootYStart += topView.height;
    
    //设置滑动视图
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(rootXStart, rootYStart, ScreenWidth, ScreenHeight-rootYStart)];
        [viewParent addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor whiteColor];
        [self setupScrollViewSubs:_scrollView];
    }
}
//设置滚动视图的子视图
- (void)setupScrollViewSubs:(UIScrollView *)viewParent
{
    NSInteger scrollXStart = 0;
    NSInteger scrollYStart = 0;
    
    //分割线view1
    UIImageView *seperator1 = (UIImageView *)[viewParent viewWithTag:aSepartorView1];
    if (!seperator1) {
        seperator1 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 10)];
        seperator1.tag = aSepartorView1;
        seperator1.image = [UIImage imageNamed:@"ExchangedCellSeperator"];
        [viewParent addSubview:seperator1];
    }
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += seperator1.height;
    
    //商品属性
    UIView *goodsView = [[UIView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 90)];
    [self setupGoodsViewSubs:goodsView];
    goodsView.backgroundColor = [UIColor whiteColor];
    [viewParent addSubview:goodsView];
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += goodsView.height;
    
    //分割线View2
    UIImageView *seperator2 = (UIImageView *)[viewParent viewWithTag:aSepartorView2];
    if (!seperator2) {
        seperator2 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 10)];
        seperator2.tag = aSepartorView2;
        seperator2.image = [UIImage imageNamed:@"ExchangedCellSeperator"];
        [viewParent addSubview:seperator2];
    }
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += seperator2.height;
    
    //服务类型View
    UIView *serviceTypeView = [[UIView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 60)];
    {
        //服务类型
        UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 20)];
        typeLabel.text = @"服务类型";
        typeLabel.font = [UIFont systemFontOfSize:15];
        [serviceTypeView addSubview:typeLabel];
        
        //维修button
        CustButton *button = [CustButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(typeLabel.left+10, typeLabel.bottom+5, typeLabel.width, 25);
        [button setTitle:@"维修" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setBackgroundImage:[UIImage imageNamed:@"ApplyServiceButton"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
        [serviceTypeView addSubview:button];
    }
    serviceTypeView.backgroundColor = [UIColor whiteColor];
    [viewParent addSubview:serviceTypeView];
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += serviceTypeView.height;
    
    //分割线View3
    UIImageView *seperator3 = (UIImageView *)[viewParent viewWithTag:aSepartorView3];
    if (!seperator3) {
        seperator3 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 10)];
        seperator3.tag = aSepartorView3;
        seperator3.image = [UIImage imageNamed:@"ExchangedCellSeperator"];
        [viewParent addSubview:seperator3];
    }

    //重置坐标
    scrollXStart = 0;
    scrollYStart += seperator3.height;
    
    //服务数量View
    UIView *serviceCount = [[UIView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 70)];
    serviceCount.backgroundColor = [UIColor whiteColor];
    [viewParent addSubview:serviceCount];
    [self setupServiceCountSubs:serviceCount];
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += serviceCount.height;
    
    //分割线View4
    UIImageView *seperator4 = (UIImageView *)[viewParent viewWithTag:aSepartorView4];
    if (!seperator4) {
        seperator4 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 10)];
        seperator4.tag = aSepartorView4;
        seperator4.image = [UIImage imageNamed:@"ExchangedCellSeperator"];
        [viewParent addSubview:seperator4];
    }

    //重置坐标
    scrollXStart = 0;
    scrollYStart += seperator4.height;
    
    //检测报告View
    UIView *detectionView = [[UIView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 60)];
    detectionView.backgroundColor = [UIColor whiteColor];
    [viewParent addSubview:detectionView];
    [self setupDetectionViewSubs:detectionView];
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += detectionView.height;
    
    //分割线View5
    UIImageView *seperator5 = (UIImageView *)[viewParent viewWithTag:aSepartorView5];
    if (!seperator5) {
        seperator5 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 10)];
        seperator5.tag = aSepartorView5;
        seperator5.image = [UIImage imageNamed:@"ExchangedCellSeperator"];
        [viewParent addSubview:seperator5];
    }
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += seperator5.height;
    
    //问题描述View
    _questionView = [[UIView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 80)];
    _questionView.backgroundColor = [UIColor whiteColor];
    [viewParent addSubview:_questionView];
    [self setupQuestionViwSubs:_questionView];
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += _questionView.height;
    
    //分割线View6
    UIImageView *seperator6 = (UIImageView *)[viewParent viewWithTag:aSepartorView6];
    if (!seperator6) {
        seperator6 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 10)];
        seperator6.tag = aSepartorView6;
        seperator6.image = [UIImage imageNamed:@"ExchangedCellSeperator"];
        [viewParent addSubview:seperator6];
    }
        //重置坐标
    scrollXStart = 0;
    scrollYStart += seperator6.height;

    //重置坐标
    scrollXStart = 0;
    scrollYStart += 100;
    
    //分割线View
    UIImageView *seperator7 = (UIImageView *)[viewParent viewWithTag:aSepartorView7];
    if (!seperator7) {
        seperator7 = [[UIImageView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 10)];
        seperator7.tag = aSepartorView7;
        seperator7.image = [UIImage imageNamed:@"ExchangedCellSeperator"];
        [viewParent addSubview:seperator7];
    }
    
    //重置坐标
    scrollXStart = 0;
    scrollYStart += seperator7.height;
    
    //下一步View
    UIView *nextViw = [[UIView alloc]initWithFrame:CGRectMake(scrollXStart, scrollYStart, ScreenWidth, 40)];
    nextViw.backgroundColor = [UIColor whiteColor];
    [viewParent addSubview:nextViw];
    [self setupNextViwSubs:nextViw];
    
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, nextViw.bottom+100, 0);
    
}
//设置下一步的子视图
- (void)setupNextViwSubs:(UIView *)viewParent
{
    //按钮
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(viewParent.width*0.5-100, 5, 200,30);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"ApplyServiceNextStap"] forState:UIControlStateNormal];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [viewParent addSubview:nextButton];
    
}

//设置问题描述子控件
- (void)setupQuestionViwSubs:(UIView *)viewParent
{
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 20)];
    titleLabel.text = @"问题描述";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [viewParent addSubview:titleLabel];
    
    //输入的内容
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(5, titleLabel.bottom, ScreenWidth-10, viewParent.height-titleLabel.bottom-5)];
    _textView.text = @"请在此描述详细问题";
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.backgroundColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];

    [viewParent addSubview:_textView];
    
}

//设置检测报告子视图
- (void)setupDetectionViewSubs:(UIView *)viewParent
{
    NSInteger detectionXStart = 0;
    NSInteger detectionYStart = 0;
    
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(detectionXStart+5, detectionYStart+5, 60, 20)];
    titleLabel.text = @"检测报告";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [titleLabel setTextColor:[UIColor blackColor]];
    [viewParent addSubview:titleLabel];
    
    //重置坐标
    detectionXStart = 0;
    detectionYStart += titleLabel.height;
    
    //selectedButton
    CustButton *iHave = [CustButton buttonWithType:UIButtonTypeCustom];
    iHave.frame = CGRectMake(detectionXStart+30, detectionYStart+10, 22, 22);
    [iHave setImage:[UIImage imageNamed:@"ApplyServiceRound"] forState:UIControlStateNormal];
    [iHave addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchDown];
    iHave.tag=1;
    [viewParent addSubview:iHave];
    //已有检测报告Label
    UILabel *iLabel = [[UILabel alloc]initWithFrame:CGRectMake(iHave.right+5, iHave.top, 80, iHave.height)];
    iLabel.text = @"已有检测报告";
    iLabel.font = [UIFont systemFontOfSize:12];
    iLabel.textColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    [viewParent addSubview:iLabel];
    
    //noSelectedButton
    CustButton *nHave = [CustButton buttonWithType:UIButtonTypeCustom];
    nHave.frame = CGRectMake(iLabel.right+40, detectionYStart+10, 22, 22);
    [nHave setImage:[UIImage imageNamed:@"ApplyServiceRound"] forState:UIControlStateNormal];
    [nHave addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchDown];
    nHave.tag=2;
    [viewParent addSubview:nHave];
    //已有检测报告Label
    UILabel *nLabel = [[UILabel alloc]initWithFrame:CGRectMake(nHave.right+5, iHave.top, 80, iHave.height)];
    nLabel.text = @"尚无检测报告";
    nLabel.font = [UIFont systemFontOfSize:12];
    nLabel.textColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    [viewParent addSubview:nLabel];
    
    
}


//设置服务数量的子视图
- (void)setupServiceCountSubs:(UIView *)viewParent
{
    NSInteger countXStart = 0;
    NSInteger countYStart = 0;
    //服务数量
    UILabel *serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(countXStart+5, countYStart+5, 60, 20)];
    serviceLabel.text = @"服务数量";
    serviceLabel.font = [UIFont systemFontOfSize:15];
    [viewParent addSubview:serviceLabel];
    
    //重置坐标
    countXStart = 0;
    countYStart += serviceLabel.height;
    
    //加减号
    //减号
    UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    minusButton.frame = CGRectMake(countXStart+5, countYStart+10, 20, 20);
    [minusButton setBackgroundImage:[UIImage imageNamed:@"ApplyServiceMinus"] forState:UIControlStateNormal];
    minusButton.tag = 101;
    [minusButton addTarget:self action:@selector(doCountAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewParent addSubview:minusButton];
    //数字
    _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _countButton.frame = CGRectMake(minusButton.right+5, minusButton.top, 60, 20);
    [_countButton setBackgroundImage:[UIImage imageNamed:@"ApplyServiceCount"] forState:UIControlStateNormal];
    _countButton.tag = 102;
    [_countButton addTarget:self action:@selector(doCountAction:) forControlEvents:UIControlEventTouchUpInside];
    [_countButton setTitle:@"1" forState:UIControlStateNormal];
    [_countButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _countButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _countButton.userInteractionEnabled = NO;
    [viewParent addSubview:_countButton];
    //加号
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(_countButton.right+5, _countButton.top, 20, 20);
    [addButton setBackgroundImage:[UIImage imageNamed:@"ApplyServiceAddCount"] forState:UIControlStateNormal];
    addButton.tag = 103;
    [addButton addTarget:self action:@selector(doCountAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewParent addSubview:addButton];
    
    //重置坐标
    countXStart = 0;
    countYStart += minusButton.height;
    
    //最多提交量
    UILabel *maxCount = [[UILabel alloc]initWithFrame:CGRectMake(countXStart+5, countYStart+10, ScreenWidth-10, 20)];
    maxCount.text = @"您最多可以提交的数量为1个";
    maxCount.font = [UIFont systemFontOfSize:11];
    maxCount.textColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    [viewParent addSubview:maxCount];
    
}
//加减运算的方法
- (void)doCountAction:(UIButton *)button
{
    static NSInteger count = 1;
    if (button.tag==101&&count>1) {
        count--;
    }else if(button.tag==103){
        count++;
    }
    
    [_countButton setTitle:[NSString stringWithFormat:@"%ld", (long)count] forState:UIControlStateNormal];
    
    
    
}
//点击维修
- (void)doButton:(CustButton *)button
{
    if (button.isCover==YES) {
        button.isCover=NO;
        [button setBackgroundImage:[UIImage imageNamed:@"ApplyServiceNextStap"] forState:UIControlStateNormal];
    }else{
        button.isCover=YES;
        [button setBackgroundImage:[UIImage imageNamed:@"ApplyServiceButton"] forState:UIControlStateNormal];
    }
}
-(void)buttonClickAction:(CustButton*)button{
    if (button.isCover==YES) {
        button.isCover=NO;
        [button setBackgroundImage:[UIImage imageNamed:@"CircleSelected"] forState:UIControlStateNormal];
        
    }
    else{
        button.isCover=YES;
        [button setBackgroundImage:[UIImage imageNamed:@"ApplyServiceRound"] forState:UIControlStateNormal];
    }
}

//设置商品子视图
- (void)setupGoodsViewSubs:(UIView *)viewParent
{
    NSInteger goodXStart = 5;
    NSInteger goodYStart = 5;
    //icon
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(goodXStart, goodYStart, 80, 80)];
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.orderInfo.t_produce_logo_image] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
   //iconImageView.image = [UIImage imageNamed:@"adErrorImage.png"];
    [viewParent addSubview:iconImageView];
    
    //重置坐标
    goodXStart += iconImageView.width+5;
    goodYStart = 5;
    //goodaTitle
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(goodXStart, goodYStart, ScreenWidth-goodXStart-10, 33)];
    titleLabel.text = self.orderInfo.t_produce_name;//@"中国瓷砖商城全抛釉防大理石瓷砖客厅地砖800*800";
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.numberOfLines = 0;
    [viewParent addSubview:titleLabel];
    
    //重置坐标
    goodXStart += 0;
    goodYStart += titleLabel.height;
    
    //属性
    UILabel *colorAndSize = [[UILabel alloc]initWithFrame:CGRectMake(goodXStart, goodYStart, titleLabel.width, 20)];
//    colorAndSize.text =[NSString stringWithFormat:@"颜色：%@  尺寸：%@",self.orderInfo.t_produce_color,@"1000*800"];
    colorAndSize.font = [UIFont systemFontOfSize:11];
    colorAndSize.textColor = [UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1];
    [viewParent addSubview:colorAndSize];
    
    //重置坐标
    goodXStart += 0;
    goodYStart += colorAndSize.height;
    
    //价格
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(goodXStart, goodYStart, colorAndSize.width, 20)];
    priceLabel.text =@"58.00元/片";//self.orderInfo.t_produce_money
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor colorWithRed:222/255.0f green:92/255.0f blue:64/255.0f alpha:1];
    [viewParent addSubview:priceLabel];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    LogInfo(@"将要开始编辑");
    CGFloat offset = self.view.frame.size.height-(_questionView.frame.origin.y+_questionView.frame.size.height+216+100);
    if (offset<=0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    return YES;
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    LogInfo(@"结束编辑");
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0;
        self.view.frame = frame;
    }];
    return YES;
}
//点击return推出键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
