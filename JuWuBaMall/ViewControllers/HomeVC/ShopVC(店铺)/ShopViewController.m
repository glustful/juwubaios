//
//  ShopViewController.m
//  JuWuBaMall
//
//  Created by JWB on 16/2/25.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ShopViewController.h"
#import "GoodsCollectionViewCell.h"
#import "ShopCollectionViewCell.h"
#import "GoodsTopCollectionViewCell.h"
#import "ShopInfo.h"
//详情页
#import "DetailViewController.h"
#import <UIImageView+WebCache.h>

#import "SearchViewController.h"//搜索界面


@interface ShopViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *MyCollection;
@property (nonatomic, strong) UIView *bottomView;//底部视图
@property(nonatomic,strong)ShopInfo *shopInfo;

@end

@implementation ShopViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //    [UIApplication sharedApplication].statusBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    //    [UIApplication sharedApplication].statusBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupScrollViewSubs:self.view];
#pragma mark 店铺
    FMNetworkRequest *request=[[FSNetworkManager sharedInstance]getShopInfoRequestWithShopId:@"2342342" UserId:@"18d2ed59-d804-4771-ad7d-f462240bd13c" netWorkDelegate:self];//[[GlobalSetting sharedInstance]gUser].t_user_id
    [self.networkRequestArray addObject:request];
    [_MyCollection  setShowsVerticalScrollIndicator:NO];
    
}

- (void)setupScrollViewSubs:(UIView *)viewParent
{
    
    UIView *shopVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [viewParent addSubview:shopVIew];
    [self setupShopBackSubs:shopVIew];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.MyCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, shopVIew.height, ScreenWidth, ScreenHeight-shopVIew.height)collectionViewLayout:layout];
    self.MyCollection.delegate = self;
    self.MyCollection.dataSource = self;
    self.MyCollection.backgroundColor = [UIColor whiteColor];
    
    [self.MyCollection registerNib:[UINib nibWithNibName:@"GoodsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsCollectionViewCell"];
    [self.MyCollection registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShopCollectionViewCell"];
    [self.MyCollection registerNib:[UINib nibWithNibName:@"GoodsTopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsTopCollectionViewCell"];
    [viewParent addSubview:self.MyCollection];
    
    //设置底部视图
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-30, ScreenWidth, 30)];
    //    self.bottomView.backgroundColor = [UIColor redColor];
    [viewParent addSubview:self.bottomView];
    [self setupBottomViewSubs:self.bottomView];
    
    
}

//设置底部视图
- (void)setupBottomViewSubs:(UIView *)viewParent
{
    //设置背景图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    imageView.image = [UIImage imageNamed:@"shopDetailBack"];
    [viewParent addSubview:imageView];
    
    //设置三个button
    NSArray *titleArr = @[@"店铺详情", @"热门分类", @"联系客服"];
    
    NSInteger buttonXStart = 0;
    NSInteger buttonYStart = 0;
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonXStart, buttonYStart, ScreenWidth *0.33, viewParent.height);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        if (i==0) {
            button.tag = 11;
        }else if(i == 1){
            button.tag = 12;
        }else{
            button.tag = 13;
        }
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewParent addSubview:button];
        buttonXStart += button.width;
    }
    
    //添加图片的分割线
    UIImageView *imageSepa = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth*0.33, 5, 1, 20)];
    imageSepa.image = [UIImage imageNamed:@"shopBottomSeparate"];
    [viewParent addSubview:imageSepa];
    
    UIImageView *imageSepa1 = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*0.67, 5, 1, 20)];
    imageSepa1.image = [UIImage imageNamed:@"shopBottomSeparate"];
    [viewParent addSubview:imageSepa1];
    
}

- (void)bottomButtonClick:(UIButton *)button
{
    DetailViewController *dvc = [[DetailViewController alloc] initWithName:@"店铺详情"];
    dvc.shopInfo=self.shopInfo;
    [self presentViewController:dvc animated:YES completion:nil];
}

//设置店铺背景子控件
- (void)setupShopBackSubs:(UIView *)viewParent
{
    //设置背景图片
    UIImageView *shopBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewParent.width, viewParent.height)];
    //    [shopBackImage setImage:[UIImage imageNamed:@"MyTopBack"]];
    shopBackImage.image = [UIImage imageNamed:@"MyTopBack"];
    [viewParent addSubview:shopBackImage];
}

#pragma mark- collectionDataDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(self.MyCollection.width, 120);
    }
    if (indexPath.row==0) {
        return CGSizeMake(self.MyCollection.width-10, 150);
    }
    
    return CGSizeMake((self.MyCollection.width-40)*0.5, 140);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    if (section==0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(5, 10, 10, 10);
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCollectionViewCell" forIndexPath:indexPath];
        [cell.shopIcon sd_setImageWithURL:[NSURL URLWithString:_shopInfo.t_shop_logo] placeholderImage:[UIImage imageNamed:@"adErrorImage.png"]];
        cell.shopNameLabel.text=_shopInfo.t_shop_name;
        cell.shopAttentionCount.text=[NSString stringWithFormat:@"%ld人关注",(long)_shopInfo.t_shop_attention_num];
        [cell.buttonTitleLabel1  setTitle:[NSString stringWithFormat:@"%ld",(long)_shopInfo.t_shop_product_num] forState:UIControlStateNormal];
        [cell.buttonTitleLabel2  setTitle:[NSString stringWithFormat:@"%ld",(long)_shopInfo.t_shop_new_product] forState:UIControlStateNormal];
        [cell.buttonTitleLabel3  setTitle:[NSString stringWithFormat:@"%ld",(long)_shopInfo.t_shop_promotion] forState:UIControlStateNormal];
        //动态
        //[cell.buttonTitleLabel4  setTitle:[NSString stringWithFormat:@"%ld",(long)_shopInfo.t_shop_product_num] forState:UIControlStateNormal];
        return cell;
    }
    if (indexPath.row==0) {
        GoodsTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsTopCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }
    GoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionViewCell" forIndexPath:indexPath];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.bottomView.alpha = 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.bottomView.alpha = 1;
}

- (IBAction)topBackClick:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark 网络回调
-(void)fmNetworkFailed:(FMNetworkRequest *)fmNetworkReques{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkReques.responseData && [fmNetworkReques.responseData isKindOfClass:[NSString class]]) {
        [[BaseAlert sharedInstance]showMessage:fmNetworkReques.responseData];
    }
}
-(void)fmNetworkFinished:(FMNetworkRequest *)fmNetworkRequest{
    [[BaseAlert sharedInstance]dismiss];
    if (fmNetworkRequest.responseData && [fmNetworkRequest.responseData isKindOfClass:[ShopInfo class]]) {
        _shopInfo=fmNetworkRequest.responseData;
        [_MyCollection reloadData];
    }
}


- (IBAction)doSearchClickButton:(UIButton *)sender {
    
    SearchViewController *searchVC = [[SearchViewController alloc] initWithName:@"搜索"];
    [self.navigationController pushViewController:searchVC animated:YES];
    
    
}




@end
