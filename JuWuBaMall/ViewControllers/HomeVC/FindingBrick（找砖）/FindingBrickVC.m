//
//  FindingBrickVC.m
//  JuWuBaMall
//
//  Created by JWB on 16/3/14.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "FindingBrickVC.h"
#import "SelectPhotoManager.h"
#import "HDetailPictureInfo.h"

#define  kSelectPicImageSize   140

@interface FindingBrickVC ()<UITextFieldDelegate,UITextViewDelegate,SelectPhotoManagerDelegate>

@property(weak,nonatomic)IBOutlet UIScrollView *scrollView;
@property(weak,nonatomic)IBOutlet UIView *contentView;
@property(weak,nonatomic)IBOutlet UITextField *conditionsText;
@property(weak,nonatomic)IBOutlet UITextField *brandText;
@property(weak,nonatomic)IBOutlet UITextField *priceText;
@property(weak,nonatomic)IBOutlet UITextField *colorText;
@property(weak,nonatomic)IBOutlet UITextField *sizeText;
@property(weak,nonatomic)IBOutlet UITextView  *textView;
@property (nonatomic, strong) SelectPhotoManager *selectPhotoManager;   // 图片选择助手
@property (nonatomic, strong) NSMutableArray *upImagesArray;            // 待上传的图片
@property(strong,nonatomic)IBOutlet UIView *pictureView;//放图片的View
@property(strong,nonatomic)UIButton *searchButton;

@end

@implementation FindingBrickVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _textView.layer.borderWidth=0.2;
    _textView.layer.cornerRadius=5;
    [self createTheSearchButton];
    
    // 图片选择助手
    _selectPhotoManager = [[SelectPhotoManager alloc] init];
    // 待上传的图片
    _upImagesArray = [[NSMutableArray alloc] init];
    
    // 初始化图片视图
    [self setupViewPictureViewSubs:_pictureView];
    
    //放图片的View
    _pictureView=[[UIView alloc]init];
    [_scrollView  addSubview:_pictureView];
    _scrollView.showsVerticalScrollIndicator=NO;
    
    UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [_contentView addGestureRecognizer:tap];
    
}
-(void)createTheSearchButton{
    _searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton.center=CGPointMake(_scrollView.centerX, _scrollView.centerY+250);
    _searchButton.bounds=CGRectMake(0, 0, 100, 40);
    _searchButton.layer.masksToBounds=YES;
    _searchButton.layer.cornerRadius=5;
    [_searchButton setBackgroundImage:[UIImage imageNamed:@"redBack.png"] forState:UIControlStateNormal];
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchButton addTarget:self action:@selector(doSearchingBrickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_searchButton];
    
}
- (void)setupViewPictureViewSubs:(UIView *)viewParent
{
    [viewParent removeAllSubviews];
    
    NSInteger spaceYStart = 20;
    NSInteger spaceXStart = ScreenWidth/2-70;
    
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
            imageView.layer.cornerRadius=5;
            imageView.layer.masksToBounds=YES;
            imageView.layer.borderWidth=0.01;
            imageView.image = image;
        }
    }
    
}
#pragma mark - 选择图片回调
- (void)choosePhotoBack:(NSMutableArray *)arrayPictureInfo upStatus:(NSInteger)upStatus;
{
    [_upImagesArray removeAllObjects];
    
    [_upImagesArray addObjectsFromArray:arrayPictureInfo];
    
    [self setupViewPictureViewSubs:_pictureView];
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return YES;
}

#pragma mark --相片选择
- (IBAction)doSelectPhotoAction:(id)sender {
    [_selectPhotoManager choosePhotoWithPresentViewController:self touchData:_upImagesArray];
}

#pragma mark --条件选择
- (IBAction)doConditionSelectButtonAction:(id)sender {
    
}

#pragma mark ---搜索
- (void)doSearchingBrickAction:(UIButton*)sender {
    LogInfo(@"搜索。。。");
}

- (void)viewDidLayoutSubviews
{
//    CGRect scrollViewBounds = _scrollView.bounds;
//    
//    UIEdgeInsets scrollViewInsets = UIEdgeInsetsZero;
//    scrollViewInsets.top = scrollViewBounds.size.height/2.0;
//    scrollViewInsets.top -= _contentView.bounds.size.height/2.0;
//    
//    scrollViewInsets.bottom = scrollViewBounds.size.height/2.0;
//    scrollViewInsets.bottom -= _contentView.bounds.size.height/2.0;
//    scrollViewInsets.bottom += 200;
//    
//    _scrollView.contentInset = scrollViewInsets;
    _scrollView.contentSize=CGSizeMake(ScreenWidth, 600);
}

- (void)dismissKeyboard
{
    if ([_conditionsText isFirstResponder])
    {
        [_conditionsText resignFirstResponder];
    }
    
    if ([_brandText isFirstResponder])
    {
        [_brandText resignFirstResponder];
    }
    
    if ([_priceText isFirstResponder])
    {
        [_priceText resignFirstResponder];
    }
    
    if ([_colorText isFirstResponder])
    {
        [_colorText resignFirstResponder];
    }
    if ([_sizeText  isFirstResponder]) {
        [_sizeText resignFirstResponder];
    }
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
    }
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}
#pragma mark --UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//        self.view.frame = CGRec   tMake(0.0f, 20, self.view.frame.size.width, self.view.frame.size.height);

    [UIView commitAnimations];
}

//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    return YES;
//}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [_textView resignFirstResponder];
     self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    
//    CGRect frame = textView.frame;
//    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
//    self.view.frame = CGRectMake(0.0f, 64, self.view.frame.size.width, self.view.frame.size.height);

}
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
