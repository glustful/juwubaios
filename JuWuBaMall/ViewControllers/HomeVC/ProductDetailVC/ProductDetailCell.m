//
//  ProductDetailCell.m
//  JuWuBaMall
//
//  Created by zhanglan on 16/2/2.
//  Copyright © 2016年 JuWuBa. All rights reserved.
//

#import "ProductDetailCell.h"
#import "ProductStatusModel.h"
#import "TypeView.h"
#import "BuyCountView.h"
#import <Masonry.h>
#import "ProductDetailStatuesModel.h"
#import "NSString+Extent.h"
#import "ProductStatusCanChoseModel.h"
static CGFloat const gap = 5;
@interface ProductDetailCell ()<TypeSeleteDelegete,UITextFieldDelegate>

//一级属性上次选择的
@property (nonatomic, assign)int lastcheosefirstStatus;
//二级属性上次选择的
@property (nonatomic, assign)int lastCheoseSecondStatus;
//三级属性上次选择的
@property (nonatomic, assign)int lastcheoseThirdStatus;


@property (nonatomic, strong)ProductStatusModel *userChosedProductDetailModel;



//商品详情所有可以选择三级属性模型，里面包含三级属性分别可以选择的数组
@property (nonatomic, strong)ProductStatusCanChoseModel *productStatusCanChoseModel;


//商品详情属性
@property (nonatomic, strong)ProductStatusModel *productStatus;

@property (nonatomic, strong)  ProductDetailVC *parentVC;

@property (strong, nonatomic)  UIButton *numberButton;
@property (strong, nonatomic)  UIButton *addNumberButton;
@property (strong, nonatomic)  UIButton *reduceNumberButton;
@property (strong, nonatomic)  UIButton *sizeButton;
@property (strong, nonatomic)  UIButton *colorButton;

@property (strong, nonatomic)  UILabel *productName;
@property (strong, nonatomic)  UILabel *productPrice;

@property (strong, nonatomic)  UILabel *product_first_type_name;
@property (strong, nonatomic)  UILabel *product_second_type_name;
@property (strong, nonatomic)  UILabel *product_thread_type_name;

@property (strong, nonatomic)  UILabel *numbTitle;
@property (strong, nonatomic)  UILabel *storesTitle;//库存
@property (strong, nonatomic)  UILabel *servingTitle;//服务信息

@property(nonatomic, retain)TypeView *secondTypeView;
@property(nonatomic, retain)TypeView *thirdTypeView;
@property(nonatomic, retain)TypeView *firstTypeView;
@property(nonatomic, retain)BuyCountView *countView;

@property(nonatomic, retain)UIView *allTypeBg;
@property(nonatomic, retain)UILabel *line;
@property(nonatomic, retain)UIView *choseView;


@property(nonatomic, retain)ProductDetailStatuesModel *model;
@property(nonatomic, retain) NSMutableArray *secondtagArray ;///二级属性可选按钮数组

@property(nonatomic, assign)CGFloat producTypeY;


@property(nonatomic, assign)int isfromTabviewReload;
@property(nonatomic, assign)BOOL isNeedRefresh;
@property(nonatomic, assign)BOOL isfirstInit;
@property(nonatomic, assign)int isUserChosed;
@end

@implementation ProductDetailCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ProductDetailCell";
    
    ProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ProductDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
        return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化操作;
        self.lastcheosefirstStatus  = -100;
        self.lastCheoseSecondStatus = -100;
        self.lastcheoseThirdStatus  = -100;
        self.isUserChosed = 0;
        self.isfromTabviewReload = 0;
        
         [self addObserver:self forKeyPath:@"isNeedRefresh" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
                // 2.初始化子控件
        [self setupSubviews];
        
    }return self;
}

-(void)dealloc{
    
     [self removeObserver:self forKeyPath:@"isNeedRefresh"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"isNeedRefresh"])
    {
        
        self.isUserChosed++;
        if (self.isUserChosed==1) {
            [self refresh];
        }
        
    }
}

-(void)refresh{
    if (_model) {
        
        [ self.firstTypeView.delegate  btnindex:0 view:self.firstTypeView];
    }
}


-(void)updateView{

    CGFloat productName_H  = [self.userChosedProductDetailModel.t_produce_name  heightWithText:self.userChosedProductDetailModel.t_produce_name font: [UIFont systemFontOfSize:15] width:ScreenWidth-gap*2];
    CGFloat productPrice_H  = [ self.userChosedProductDetailModel.t_produce_shop_price  heightWithText:self.userChosedProductDetailModel.t_produce_shop_price font: [UIFont systemFontOfSize:15] width:ScreenWidth-gap*2];
    //商品标题
    self.productName.frame = CGRectMake(gap, gap,ScreenWidth -2*gap, productName_H+10);
    self.productName.numberOfLines = 0;
    //商品价格

    self.productPrice.frame = CGRectMake(gap,CGRectGetMaxY( self.productName.frame),self.width-2*gap, productPrice_H+10);
    self.productPrice.numberOfLines = 0;
    self.line.frame = CGRectMake(0,CGRectGetMaxY(self.productPrice.frame)+4.5, ScreenWidth, 0.5);
  
     self.allTypeBg.frame = CGRectMake(0, CGRectGetMaxY(self.line.frame), ScreenWidth,self.producTypeY);
     self.countView.frame = CGRectMake(0, CGRectGetMaxY(self.allTypeBg.frame), ScreenWidth, 50);
     self.storesTitle.frame = CGRectMake(2*gap, CGRectGetMaxY(self.countView.frame), 200, 30);
   
    
    self.productName.text  = self.userChosedProductDetailModel.t_produce_name ;
    self.productPrice.text = [NSString stringWithFormat:@"¥ %@ 元/%@",self.userChosedProductDetailModel.t_produce_shop_price,self.userChosedProductDetailModel.t_product_unit_value];
    self.storesTitle.text  =[NSString stringWithFormat:@"库存是 ：%@",self.userChosedProductDetailModel.t_product_stock];
  
}

- (void)setupSubviews{
    
//    //商品标题
//    self.productName.frame = CGRectMake(gap, gap,ScreenWidth -2*gap, 30);
//    //商品价格
//    self.productPrice.frame = CGRectMake(gap,CGRectGetMaxY( self.productName.frame),self.width-2*gap, 30);
//    
//    UILabel *line = [[UILabel alloc] initWithFrame: CGRectMake(0,CGRectGetMaxY(self.productPrice.frame)+4.5, ScreenWidth, 0.5)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:line];
    
    
    
    
}




-(UILabel *)line{
    if(!_line){
        
       _line = [[UILabel alloc] initWithFrame: CGRectMake(0,CGRectGetMaxY(self.productPrice.frame)+4.5, ScreenWidth, 0.5)];
        _line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_line];
    }
    return _line;
    
    
}
-(UILabel *)productName{
   
    if(!_productName){
       
        _productName = [[UILabel alloc]init];
        _productName.font  = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_productName];
    }
    return _productName;
    
    
}
-(UILabel *)productPrice{
if(!_productPrice){
    
    _productPrice = [[UILabel alloc]init];
    _productPrice.textColor =[UIColor redColor];
    _productPrice.font  = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_productPrice];
}
return _productPrice;


}

-(UILabel *)product_first_type_name{
    
    if(!_product_first_type_name){
      
        _product_first_type_name = [[UILabel alloc]init];
        [self.contentView addSubview:_product_first_type_name];
    }
    
return _product_first_type_name;


}



-(UILabel *)product_second_type_name{
    
    if(!_product_second_type_name){
       
        _product_second_type_name = [[UILabel alloc]init];
        [self.contentView addSubview:_product_second_type_name];
    }
    return _product_second_type_name;
}




-(UILabel *)product_thread_type_name{
if(!_product_thread_type_name){
    _product_thread_type_name = [[UILabel alloc]init];
    [self.contentView addSubview:_product_thread_type_name];
}
return _product_thread_type_name;
}

-(UILabel *)numbTitle{
if(!_numbTitle){
    _numbTitle = [[UILabel alloc]init];
    [self.contentView addSubview:_numbTitle];
}
return _numbTitle;
}
-(UILabel *)storesTitle{
if(!_storesTitle){
    _storesTitle= [[UILabel alloc]init];
    [self.contentView addSubview:_storesTitle];
    _storesTitle.font = [UIFont systemFontOfSize:14];
}
return _storesTitle;
}



//-(UILabel *)servingTitle{
//    if(!_servingTitle){
//        _servingTitle= [[UILabel alloc]init];
//        _servingTitle.font = [UIFont systemFontOfSize:14];
//        [self.contentView addSubview:_servingTitle];
//    }
//    return _servingTitle;
//}


//-(UILabel *)promptTitle{
//    if(!_promptTitle){
//        _promptTitle= [[UILabel alloc]init];
//        _promptTitle.font = [UIFont systemFontOfSize:14];
//        [self.contentView addSubview:_promptTitle];
//    }
//    return _promptTitle;
//}
//

-(BuyCountView *)countView{
    if (!_countView) {
    _countView= [[BuyCountView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    _countView.tf_count.delegate = self;
    [self.contentView addSubview:_countView];
    [_countView.bt_add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];

    [_countView.bt_reduce addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
    }
    return _countView;
}

-(void)layoutSubviews{
    
      [super layoutSubviews];

}


-(UIView *)allTypeBg{
    
    if (!_allTypeBg) {
        _allTypeBg  = [[UIView alloc]init];
        [self.contentView addSubview:self.allTypeBg];
    }
    return _allTypeBg;
}




- (void)customWithModel:(ProductDetailStatuesModel*)model{
     _model = model;
    
    ProductStatusModel*productStatusModel=model.typeArray[0];

    
//    self.servingTitle.text = @"服务：由中国瓷砖商城从昆明发货并提供售货服务";
//    self.promptTitle.text  =  @"提示：支持7天无理由退货";

    
//    self.allTypeBg = [[UIView alloc]init];
//    [self.contentView addSubview:self.allTypeBg];
    CGFloat typeView_begin_Y= 0;
    self.producTypeY = typeView_begin_Y;
    if (model.product_first_type_value_array.count>0) {
        if (!self.firstTypeView) {
        
        
        
        self.firstTypeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50) andDatasource:model.product_first_type_value_array :  [NSString stringWithFormat:@"%@:",productStatusModel.t_product_first_type_name]];
        
        self.firstTypeView.delegate = self;
        self.firstTypeView.frame = CGRectMake(0, typeView_begin_Y, ScreenWidth, self.firstTypeView.height);
       
//        [self.contentView addSubview:self.firstTypeView];
          [self.allTypeBg addSubview:self.firstTypeView];
            
           
            }
        
         self.producTypeY = CGRectGetMaxY(self.firstTypeView.frame);
    }

    
   if (model.product_second_type_value_array.count>0) {
       
          if (!self.secondTypeView) {
        self.secondTypeView = [[TypeView alloc] initWithFrame:CGRectMake(0, self.secondTypeView.frame.size.height, ScreenWidth, 50) andDatasource:model.product_second_type_value_array : [NSString stringWithFormat:@"%@:",productStatusModel.t_product_second_type_name]];
        self.secondTypeView.delegate = self;
        
        self.secondTypeView.frame = CGRectMake(0,self.firstTypeView?CGRectGetMaxY(self.firstTypeView.frame):typeView_begin_Y, ScreenWidth, self.secondTypeView.height);
//        [self.contentView addSubview:self.secondTypeView];
               [self.allTypeBg addSubview:self.secondTypeView];
          
          }
       self.producTypeY = CGRectGetMaxY(self.secondTypeView.frame);
 
   
   
   }
    
    if (model.product_thread_type_value_array.count>0) {
        
        if (!self.thirdTypeView) {

        self.thirdTypeView = [[TypeView alloc] initWithFrame:CGRectMake(0, self.thirdTypeView.frame.size.height, ScreenWidth, 50) andDatasource:model.product_thread_type_value_array :[NSString stringWithFormat:@"%@:",productStatusModel.t_product_thread_type_name]];
        self.thirdTypeView.delegate = self;
        self.thirdTypeView.frame = CGRectMake(0, self.producTypeY, ScreenWidth, self.thirdTypeView.height);
//        [self.contentView addSubview:self.thirdTypeView];
           [self.allTypeBg addSubview:self.thirdTypeView];
        }
        self.producTypeY = CGRectGetMaxY(self.thirdTypeView.frame);

    }
//    self.countView.frame = CGRectMake(0, self.producTypeY, ScreenWidth, 50);
//    self.storesTitle.frame = CGRectMake(2*gap, CGRectGetMaxY(self.countView.frame), 200, 30);
//  self.producTypeY = CGRectGetMaxY(self.storesTitle.frame);
  
    
    //商品服务title
//    self.servingTitle.frame = CGRectMake(gap,CGRectGetMaxY(self.countView.frame)+ gap,self.width-2*gap, 20);
    //商品服务title
//    self.promptTitle.frame = CGRectMake(gap,CGRectGetMaxY( self.servingTitle.frame)+ gap,self.width-2*gap, 20);
    
    if (_model) {
       
        self.isNeedRefresh = YES;
    }
   
    
        
}





//
//- (void)typeSource:(NSArray *)arr :(NSString *)typename
//{
//
//        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 200, 25)];
//        lab.text = typename;
//        lab.textColor = [UIColor blackColor];
//        lab.font = [UIFont systemFontOfSize:14];
//        [self addSubview:lab];
//    
//        BOOL  isLineReturn = NO;
//        float upX = 10;
//        float upY = 90;
//        for (int i = 0; i<arr.count; i++) {
//            NSString *str = [arr objectAtIndex:i] ;
//            
//            NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14] forKey:NSFontAttributeName];
//            CGSize size = [str sizeWithAttributes:dic];
//            //NSLog(@"%f",size.height);
//            if ( upX > (self.frame.size.width-20 -size.width-35)) {
//                
//                isLineReturn = YES;
//                upX = 10;
//                upY += 30;
//            }
//            
//            UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(upX, upY, size.width+30,25);
//            [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
//            [btn setTitleColor:[UIColor blackColor] forState:0];
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//            btn.titleLabel.font = [UIFont systemFontOfSize:13];
//            [btn setTitle:[arr objectAtIndex:i] forState:0];
//            btn.layer.cornerRadius = 3;
//            btn.layer.borderColor = [UIColor clearColor].CGColor;
//            btn.layer.borderWidth = 0;
//            [btn.layer setMasksToBounds:YES];
//            
//            [self addSubview:btn];
//            btn.tag = 100+i;
//            [btn addTarget:self action:@selector(touchbtn) forControlEvents:UIControlEventTouchUpInside];
//            upX+=size.width+35;
//        }
//        
//        upY +=30;
//        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, upY+10, self.frame.size.width, 0.5)];
//        line.backgroundColor = [UIColor lightGrayColor];
//        [self addSubview:line];
//        
//        self.height = upY+11;
//        
//        self.seletIndex = -1;
////    }
////    return self;
//}



//
//
//- (IBAction)doAddNumberAction:(id)sender
//{
//    NSInteger number = [_numberButton.titleLabel.text integerValue];
//    number++;
//    
//    [_numberButton setTitle:[NSString stringWithFormat:@"%ld", (long)number] forState:UIControlStateNormal];
//}
//- (IBAction)doMinusNumberAction:(id)sender
//{
//    NSInteger number = [_numberButton.titleLabel.text integerValue];
//    if (number == 1) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能再减少了！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//    }
//    else {
//        number--;
//        
//        [_numberButton setTitle:[NSString stringWithFormat:@"%ld", (long)number] forState:UIControlStateNormal];
//    }
//}



-(void)touchbtn{
    
    
}




-(void)add
{
    
    int count =[self.countView.tf_count.text intValue];
    if (count <[self.userChosedProductDetailModel.t_product_stock intValue]) {
        self.countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
    
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"KGetProductCount" object:self userInfo:@{@"productCount":self.countView.tf_count.text}];
    
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出库存范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 100;
        [alert show];
    }
}
-(void)reduce
{
    int count =[self.countView.tf_count.text intValue];
    if (count > 1) {
        self.countView.tf_count.text = [NSString stringWithFormat:@"%d",count-1];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"KGetProductCount" object:self userInfo:@{@"productCount":self.countView.tf_count.text}];
        

    }else
    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        alert.tag = 100;
        //        [alert show];
    }
}




#pragma mark-typedelegete

-(void)btnindex:(int)tag view:(UIView *)view{

    if (view==self.firstTypeView){

        if (_model) {
    //算数据
    
    self.productStatusCanChoseModel = [self chosefirstType:tag ProductDetailStatuesModel:_model];

    //算出详情id,
            
    NSString *productDetailID = [self getProductDetailID];
    //发送通知。
    [self updateView];
                
    [[NSNotificationCenter defaultCenter]postNotificationName:@"getProductDetailID" object:self userInfo:@{@"productDetailID":productDetailID,@"productStatueModel":self.userChosedProductDetailModel}];
//                     self.isUserChosed++;

//                 }
      //UI处理
    [self choseFirstTypeViewStateWithFirstTypeValueArray:_model productStatusCanChoseModel: self.productStatusCanChoseModel];

        }
        
    }
    if (view==self.secondTypeView){

        if (_model) {
            
        //一级属性默认上次的，用户自己选择了二属性，算三属性的可选，得到当前所有规格可选
    [self choseSecondType:tag productStatusCanChoseModel: self.productStatusCanChoseModel ProductDetailStatuesModel:_model];
            
            //算出详情id,
            NSString *productDetailID = [self getProductDetailID];
            //发送通知。
            
//           if (self.isUserChosed%2==0) {
        [self updateView];
            
        [[NSNotificationCenter defaultCenter]postNotificationName:@"getProductDetailID" object:self userInfo:@{@"productDetailID":productDetailID,@"productStatueModel":self.userChosedProductDetailModel}];
//               self.isUserChosed++;

//               }
            //UI处理
        [self userChoseSecondTypeViewStateWithFirstTypeValueArray:_model productStatusCanChoseModel:self.productStatusCanChoseModel];
      
        }
       
    }
    if (view==self.thirdTypeView){

        if (_model) {
            
            //一级属性默认上次的，用户自己选择了二属性，算三属性的可选，得到当前所有规格可选
        [self   choseThirdType:tag productStatusCanChoseModel: self.productStatusCanChoseModel ProductDetailStatuesModel:_model];
        
            
            //算出详情id,
            
            NSString *productDetailID = [self getProductDetailID];
             [self updateView];
            //发送通知。
//                 if (self.isUserChosed%2==0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"getProductDetailID" object:self userInfo:@{@"productDetailID":productDetailID,@"productStatueModel":self.userChosedProductDetailModel}];
//                     self.isUserChosed++;
//                 }
            //UI处理
        [self userChoseThirdTypeViewStateWithFirstTypeValueArray:_model productStatusCanChoseModel:self.productStatusCanChoseModel];
            
        }
    }

}
#pragma mark --第一种情况  ———————————————————————————————————————————————————————————
#pragma mark ---算数据，首先选择一级属性，然后选择二级属性下（二级属性默认选择上次选择的，若没有就选择第一个），算三级属性列表操作
- (ProductStatusCanChoseModel*)chosefirstType:(int)tag ProductDetailStatuesModel:(ProductDetailStatuesModel*)productDetailStatuesModel{
    //首先选择一级属性第一个
    NSString *firstChocedValue = productDetailStatuesModel.product_first_type_value_array[tag];
        self.firstTypeView.seletIndex =tag;
        self.lastcheosefirstStatus =tag;
ProductStatusCanChoseModel*productStatusCanChoseModel = [[ProductStatusCanChoseModel alloc]init];
productStatusCanChoseModel.firstStatusCanChoseArray =[NSMutableArray array];
productStatusCanChoseModel.secondStatusCanChoseArray =[NSMutableArray array];
productStatusCanChoseModel.thirdStatusCanChoseArray =[NSMutableArray array];

    productStatusCanChoseModel.firstStatusCanChoseArray = productDetailStatuesModel.product_first_type_value_array;
    
    //计算二级属性可选属性列表
    NSMutableSet *secondStatusCanChoseSet = [[NSMutableSet alloc]init];
    //计算三级属性可选属性列表
    NSMutableSet *thirdStatusCanChoseSet = [[NSMutableSet alloc]init];
    
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
   
         for (int i = 0; i<productDetailStatuesModel.typeArray.count; i++) {
        
             ProductStatusModel*model =productDetailStatuesModel.typeArray[i];
        //如果一级属性值相同的话，
        if ([model.t_product_first_type_value isEqualToString:firstChocedValue]) {

            [secondStatusCanChoseSet addObject:  model.t_product_second_type_value];
        }
    }
    //得到二级属性可选属性列表
    productStatusCanChoseModel.secondStatusCanChoseArray = [secondStatusCanChoseSet sortedArrayUsingDescriptors:sortDesc];
    
    NSLog(@"%@",productStatusCanChoseModel.secondStatusCanChoseArray);
    
    
#pragma mark —— 获取二级属性选择值,（若有选择且可选择第之前的选择的，就选择之前的，不行的话默认3级选择第一个！）
    NSString*secondChocedValue;
 if (productDetailStatuesModel.product_second_type_value_array.count>0) {
    
    if (self.lastCheoseSecondStatus>=0) {
  NSString*  lastSecondStatueValue= productDetailStatuesModel.product_second_type_value_array[self.lastCheoseSecondStatus];
        
    if([productStatusCanChoseModel.secondStatusCanChoseArray containsObject:lastSecondStatueValue]) {

        secondChocedValue =lastSecondStatueValue;
        
    }else{
            //算出二级属性默认可选选择的按钮tag
    self.lastCheoseSecondStatus = [[productDetailStatuesModel.product_second_type_value_dic objectForKey:productStatusCanChoseModel.secondStatusCanChoseArray[0]] intValue];
    //算出二级属性选择可选的属性值
    secondChocedValue=productStatusCanChoseModel.secondStatusCanChoseArray[0];
    NSLog(@"%@",secondChocedValue);
    self.secondTypeView.seletIndex = self.lastCheoseSecondStatus;
      
    }
  }

else{
                 
       //算出二级属性默认选择的按钮tag
     self.lastCheoseSecondStatus = [[productDetailStatuesModel.product_second_type_value_dic objectForKey:productStatusCanChoseModel.secondStatusCanChoseArray[0]] intValue];
       //算出二级属性选择可选的属性值
     secondChocedValue=productStatusCanChoseModel.secondStatusCanChoseArray[0];
                 NSLog(@"%@",secondChocedValue);
     self.secondTypeView.seletIndex = self.lastCheoseSecondStatus;
      
             }
 }
#pragma mark ——获取三级属性可选列表  
       for (int i = 0; i<productDetailStatuesModel.typeArray.count; i++) {
                 
                 ProductStatusModel*model =productDetailStatuesModel.typeArray[i];

                 if ([model.t_product_first_type_value isEqualToString:firstChocedValue]&&[model.t_product_second_type_value isEqualToString:secondChocedValue]) {
                     
                    [thirdStatusCanChoseSet addObject:  model.t_product_thread_type_value];
                 }
             }
    //得到三级属性可选属性列表
    productStatusCanChoseModel.thirdStatusCanChoseArray = [thirdStatusCanChoseSet sortedArrayUsingDescriptors:sortDesc];

                 
    
    
#pragma mark —— 获取三级属性选择值,若有选择且可选择第之前的，就选择之前的，不行的话默认3级选择第一个！
//    NSString *thirdChocedValue;
//    
//    if (self.lastcheoseThirdStatus&&productStatusCanChoseModel.thirdStatusCanChoseArray.count>=self.lastcheoseThirdStatus) {
//        
//        secondChocedValue= productStatusCanChoseModel.thirdStatusCanChoseArray[self.lastcheoseThirdStatus];
//        
//    }else{
//        
//        //算出三级属性默认选择的按钮tag
//        self.lastcheoseThirdStatus = [[productDetailStatuesModel.product_thread_type_value_dic objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[0]] intValue];
//        //算出三级属性选择可选的属性值
//        thirdChocedValue=productStatusCanChoseModel.thirdStatusCanChoseArray[0];
//        self.thirdTypeView.seletIndex = self.lastcheoseThirdStatus;
//        
//    }

    
     NSString*thirdChocedValue;
    if (productDetailStatuesModel.product_thread_type_value_array.count>0) {
    
   
    if (self.lastcheoseThirdStatus>=0) {
        NSString* lastThirdStatueValue= productDetailStatuesModel.product_thread_type_value_array[self.lastcheoseThirdStatus];
        
        if([productStatusCanChoseModel.thirdStatusCanChoseArray containsObject:lastThirdStatueValue]) {
            
            thirdChocedValue =lastThirdStatueValue;
            
        }else{
            //算出二级属性默认可选选择的按钮tag
            self.lastcheoseThirdStatus = [[productDetailStatuesModel.product_thread_type_value_dic objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[0]] intValue];
            //算出三级属性选择可选的属性值
            thirdChocedValue=productStatusCanChoseModel.thirdStatusCanChoseArray[0];
             self.thirdTypeView.seletIndex = self.lastcheoseThirdStatus;
            
        }
    }
    
    else{
                //算出三级属性默认选择的按钮tag
                self.lastcheoseThirdStatus = [[productDetailStatuesModel.product_thread_type_value_dic objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[0]] intValue];
                //算出三级属性选择可选的属性值
                thirdChocedValue=productStatusCanChoseModel.thirdStatusCanChoseArray[0];
                self.thirdTypeView.seletIndex = self.lastcheoseThirdStatus;
        
    }
    
    
    }
    
    
    return productStatusCanChoseModel;

    
}




#pragma mark --  .处理按钮状态  !!!!!首先选择一级属性，然后选择二级属性下（二级属性默认选择上次选择的，若没有就选择第一个），算三级属性列表操作按钮可选与不可选操作算数据
- (void)choseFirstTypeViewStateWithFirstTypeValueArray:(ProductDetailStatuesModel*)productDetailStatuesModel      productStatusCanChoseModel:(ProductStatusCanChoseModel*)productStatusCanChoseModel{
    
//    self.firstTypeView.seletIndex = 0;
    ///默认首选的一级属性
    for (int i = 0; i < productDetailStatuesModel.product_first_type_value_array .count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
         UIButton *btn =(UIButton *)[self.firstTypeView viewWithTag:100+i];
         btn.selected = NO;
         [btn setBackgroundColor:[UIColor whiteColor]];
         [btn setTitleColor:[UIColor blackColor] forState:0];
        
        
        //库存为零 不可点击
        //        if (count == 0) {
        //            btn.enabled = NO;
        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        //        }else
        //       if {
        //            btn.enabled = YES;
        //            [btn setTitleColor:[UIColor blackColor] forState:0];
        //        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (self.firstTypeView.seletIndex == i) {
            
              btn.selected = YES;
             [btn setBackgroundColor:[UIColor redColor]];
        }
    }
   
    
    
    
        ///二级属性视图
    
    
    ///默认首选的一级属性
    for (int i = 0; i < productDetailStatuesModel.product_second_type_value_array .count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[self.secondTypeView viewWithTag:100+i];
//        btn.selected = NO;
//        [btn setBackgroundColor:[UIColor whiteColor]];
//        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setBackgroundColor:[UIColor whiteColor]];

        
        btn.enabled = NO;
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    }
    
    
    
    for (int i = 0; i < productStatusCanChoseModel.secondStatusCanChoseArray.count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];

        int btnTag = [[productDetailStatuesModel.product_second_type_value_dic   objectForKey:productStatusCanChoseModel.secondStatusCanChoseArray[i]] intValue];
        
           //            btn.enabled = NO;
            //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
            //        }else
            //            if {
            //                btn.enabled = YES;
            //                [btn setTitleColor:[UIColor blackColor] forState:0];
            //                //        }
            //    }
            //
        UIButton *btn =(UIButton *)[self.secondTypeView viewWithTag:100+btnTag];
        btn.selected = NO;
        btn.enabled = YES;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
       
//        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        
        
        if (btn.tag ==self.lastCheoseSecondStatus+100) {
            btn.selected = YES;
            btn.enabled = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
        



    
    
    
    ///3级属性视图
    
    
    ///默认首选的一级属性
    for (int i = 0; i < productDetailStatuesModel.product_thread_type_value_array .count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[self.thirdTypeView viewWithTag:100+i];
        //        btn.selected = NO;
                [btn setBackgroundColor:[UIColor whiteColor]];
        //        [btn setTitleColor:[UIColor blackColor] forState:0];
        //
        
        btn.enabled = NO;
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    }
    
    
    
    for (int i = 0; i < productStatusCanChoseModel.thirdStatusCanChoseArray.count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        
        int btnTag = [[productDetailStatuesModel.product_thread_type_value_dic   objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[i]] intValue];
        
        //            btn.enabled = NO;
        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        //        }else
        //            if {
        //                btn.enabled = YES;
        //                [btn setTitleColor:[UIColor blackColor] forState:0];
        //                //        }
        //    }
        //
        UIButton *btn =(UIButton *)[self.thirdTypeView viewWithTag:100+btnTag];
        btn.selected = NO;
        btn.enabled = YES;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        
        //        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        
        
        if (btn.tag ==self.lastcheoseThirdStatus+100) {
            btn.selected = YES;
            btn.enabled = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
    
}





#pragma mark 第二种情况————————————————————————————————————————————————————————————————
#pragma mark - 算数据—————— 一级属性默认优选，用户首选二级属性，最后算出三级属性
//默认首选一级属性，然后选择二级属性下自由可选择（二级属性默认选择上次选择的，若没有就选择第一个），算三级属性列表操作
- (void)choseSecondType:(int)tag  productStatusCanChoseModel:(ProductStatusCanChoseModel*)productStatusCanChoseModel ProductDetailStatuesModel:(ProductDetailStatuesModel*)productDetailStatuesModel{
    
    //首先选择二级属性
    NSString *secondChocedValue = productDetailStatuesModel.product_second_type_value_array[tag];
        self.secondTypeView.seletIndex = tag;
        self.lastCheoseSecondStatus = tag;
 

    //计算三级属性可选属性列表
    NSMutableSet *thirdStatusCanChoseSet = [[NSMutableSet alloc]init];
    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
#pragma mark ——获取三级属性可选列表
    for (int i = 0; i<productDetailStatuesModel.typeArray.count; i++) {
        
        ProductStatusModel*model =productDetailStatuesModel.typeArray[i];
        //首先选择一级属性第一个
        NSString *firstChocedValue = productDetailStatuesModel.product_first_type_value_array[self.lastcheosefirstStatus];
 
        if ([model.t_product_first_type_value isEqualToString: firstChocedValue]&&[model.t_product_second_type_value isEqualToString:secondChocedValue]) {
            
            [thirdStatusCanChoseSet addObject:  model.t_product_thread_type_value];
        }
    }
    //得到三级属性可选属性列表
    productStatusCanChoseModel.thirdStatusCanChoseArray = [thirdStatusCanChoseSet sortedArrayUsingDescriptors:sortDesc];
    
    
    
    
#pragma mark —— 获取三级属性选择值,若有选择且可选择第之前的，就选择之前的，不行的话默认3级选择第一个！
//    NSString *thirdChocedValue;
    
//    if (self.lastcheoseThirdStatus&&productStatusCanChoseModel.thirdStatusCanChoseArray.count>=self.lastcheoseThirdStatus) {
//        
//        thirdChocedValue= productDetailStatuesModel.product_thread_type_value_array [self.lastcheoseThirdStatus];
//        
//    }else{
//        
//        //算出三级属性默认选择的按钮tag
//        self.lastcheoseThirdStatus = [[productDetailStatuesModel.product_thread_type_value_dic objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[0]] intValue];
//        //算出三级属性选择可选的属性值
//        thirdChocedValue=productStatusCanChoseModel.thirdStatusCanChoseArray[0];
//        self.thirdTypeView.seletIndex = self.lastcheoseThirdStatus;
//        
//    }
    
    
    NSString*thirdChocedValue;
    
    if (productDetailStatuesModel.product_thread_type_value_array.count>0) {
        
    
    
    if (self.lastcheoseThirdStatus>=0) {
        NSString* lastThirdStatueValue= productDetailStatuesModel.product_thread_type_value_array[self.lastcheoseThirdStatus];
        
        if([productStatusCanChoseModel.thirdStatusCanChoseArray containsObject:lastThirdStatueValue]) {
            
            thirdChocedValue =lastThirdStatueValue;
            
        }else{
            //算出二级属性默认可选选择的按钮tag
            self.lastcheoseThirdStatus = [[productDetailStatuesModel.product_thread_type_value_dic objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[0]] intValue];
            //算出三级属性选择可选的属性值
            thirdChocedValue=productStatusCanChoseModel.thirdStatusCanChoseArray[0];
            self.thirdTypeView.seletIndex = self.lastcheoseThirdStatus;
            
        }
    }
    
    else{
        
        //算出三级属性默认选择的按钮tag
        self.lastcheoseThirdStatus = [[productDetailStatuesModel.product_thread_type_value_dic objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[0]] intValue];
        //算出三级属性选择可选的属性值
        thirdChocedValue=productStatusCanChoseModel.thirdStatusCanChoseArray[0];
        self.thirdTypeView.seletIndex = self.lastcheoseThirdStatus;
        
    }
  
    }

    
}



#pragma mark ----按钮处理 ———————— 默认首先选择一级属性，然后用户选择二级属性下（二级属性默认选择上次选择的，若没有就选择第一个），算三级属性列表操作按钮可选与不可选操作
- (void)userChoseSecondTypeViewStateWithFirstTypeValueArray:(ProductDetailStatuesModel*)productDetailStatuesModel      productStatusCanChoseModel:(ProductStatusCanChoseModel*)productStatusCanChoseModel{
    
    //    self.firstTypeView.seletIndex = 0;
    ///默认首选的一级属性
//    for (int i = 0; i < productDetailStatuesModel.product_first_type_value_array .count; i++) {
//        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
//        UIButton *btn =(UIButton *)[self.firstTypeView viewWithTag:100+i];
//        btn.selected = NO;
//        [btn setBackgroundColor:[UIColor whiteColor]];
//        [btn setTitleColor:[UIColor blackColor] forState:0];
//        
//        
//        //库存为零 不可点击
//        //        if (count == 0) {
//        //            btn.enabled = NO;
//        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
//        //        }else
//        //       if {
//        //            btn.enabled = YES;
//        //            [btn setTitleColor:[UIColor blackColor] forState:0];
//        //        }
//        //根据seletIndex 确定用户当前点了那个按钮
//        if (self.firstTypeView.seletIndex == i) {
//            btn.selected = YES;
//            [btn setBackgroundColor:[UIColor redColor]];
//        }
//    }
//    
//    
    
    
    ///二级属性视图
    
    
    ///默认首选的一级属性
    for (int i = 0; i < productDetailStatuesModel.product_second_type_value_array .count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[self.secondTypeView viewWithTag:100+i];
        //        btn.selected = NO;
                [btn setBackgroundColor:[UIColor whiteColor]];
        //        [btn setTitleColor:[UIColor blackColor] forState:0];
        //
    
        btn.enabled = NO;
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    }
    
    
    
    for (int i = 0; i < productStatusCanChoseModel.secondStatusCanChoseArray.count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        
        int btnTag = [[productDetailStatuesModel.product_second_type_value_dic   objectForKey:productStatusCanChoseModel.secondStatusCanChoseArray[i]] intValue];
        
        //            btn.enabled = NO;
        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        //        }else
        //            if {
        //                btn.enabled = YES;
        //                [btn setTitleColor:[UIColor blackColor] forState:0];
        //                //        }
        //    }
        //
        UIButton *btn =(UIButton *)[self.secondTypeView viewWithTag:100+btnTag];
        btn.selected = NO;
        btn.enabled = YES;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        
        //        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        
        
        if (btn.tag ==self.lastCheoseSecondStatus+100) {
            btn.selected = YES;
            btn.enabled = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
    
    
    
    
    
    
    
    ///3级属性视图
    
    
    
    
    ///默认首选的一级属性
    for (int i = 0; i < productDetailStatuesModel.product_thread_type_value_array .count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[self.thirdTypeView viewWithTag:100+i];
        //        btn.selected = NO;
        //        [btn setBackgroundColor:[UIColor whiteColor]];
        //        [btn setTitleColor:[UIColor blackColor] forState:0];
        //
        [btn setBackgroundColor:[UIColor whiteColor]];

        btn.enabled = NO;
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    }
    
    
    
    for (int i = 0; i < productStatusCanChoseModel.thirdStatusCanChoseArray.count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        
        int btnTag = [[productDetailStatuesModel.product_thread_type_value_dic   objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[i]] intValue];
        
        //            btn.enabled = NO;
        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        //        }else
        //            if {
        //                btn.enabled = YES;
        //                [btn setTitleColor:[UIColor blackColor] forState:0];
        //                //        }
        //    }
        //
        UIButton *btn =(UIButton *)[self.thirdTypeView viewWithTag:100+btnTag];
        btn.selected = NO;
        btn.enabled = YES;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        
        //[btn setTitleColor:[UIColor lightGrayColor] forState:0];
        
        
        if (btn.tag ==self.lastcheoseThirdStatus+100) {
            btn.selected = YES;
            btn.enabled = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
    
}








#pragma mark 第三种情况————————————————————————————————————————————————————————————————
#pragma mark - 算数据—————— 一级属性默认优选 二级属性默认优选，用户手选三级属性，最后算出三级属性
//默认首选一级属性，然后选择二级属性下自由可选择（二级属性默认选择上次选择的，若没有就选择第一个），算三级属性列表操作
- (void)choseThirdType:(int)tag  productStatusCanChoseModel:(ProductStatusCanChoseModel*)productStatusCanChoseModel ProductDetailStatuesModel:(ProductDetailStatuesModel*)productDetailStatuesModel{
 
    
    
        self.thirdTypeView.seletIndex = self.lastcheoseThirdStatus=tag;

    
}





#pragma mark ----按钮处理 ———————— 默认首先选择一级属性，默认选择二级属性下（二级属性默认选择上次选择的，若没有就选择第一个），算三级属性列表操作按钮可选与不可选操作
- (void)userChoseThirdTypeViewStateWithFirstTypeValueArray:(ProductDetailStatuesModel*)productDetailStatuesModel      productStatusCanChoseModel:(ProductStatusCanChoseModel*)productStatusCanChoseModel{
    
      ///3级属性视图
    
    
    ///默认首选的一级属性
    for (int i = 0; i < productDetailStatuesModel.product_thread_type_value_array .count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[self.thirdTypeView viewWithTag:100+i];
        //        btn.selected = NO;
        //        [btn setBackgroundColor:[UIColor whiteColor]];
        //        [btn setTitleColor:[UIColor blackColor] forState:0];
        //
        
        btn.enabled = NO;
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    }
    
    
    
    for (int i = 0; i < productStatusCanChoseModel.thirdStatusCanChoseArray.count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        
        int btnTag = [[productDetailStatuesModel.product_thread_type_value_dic   objectForKey:productStatusCanChoseModel.thirdStatusCanChoseArray[i]] intValue];
        
        //            btn.enabled = NO;
        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        //        }else
        //            if {
        //                btn.enabled = YES;
        //                [btn setTitleColor:[UIColor blackColor] forState:0];
        //                //        }
        //    }
        //
        UIButton *btn =(UIButton *)[self.thirdTypeView viewWithTag:100+btnTag];
        btn.selected = NO;
        btn.enabled = YES;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        
        //        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        
        
        if (btn.tag ==self.lastcheoseThirdStatus+100) {
            btn.selected = YES;
            btn.enabled = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
    
}





-(NSString*)getProductDetailID{
    
    
    NSString* firstChocedValue;
    NSString* secondChocedValue;
    NSString* threadChocedValue;
    NSString *getProductDetailID = @"暂无商品";
    if (_model.product_first_type_value_array.count>0){
    firstChocedValue =_model.product_first_type_value_array [self.lastcheosefirstStatus];
       
    }
    if (_model.product_second_type_value_array.count>0) {

     secondChocedValue =_model.product_second_type_value_array [self.lastCheoseSecondStatus];
    }
   if (_model.product_thread_type_value_array.count>0) {
       threadChocedValue =_model.product_thread_type_value_array [self.lastcheoseThirdStatus];
    }
    

    ///3属性都存在的
    if (_model.product_second_type_value_array.count>0&&_model.product_first_type_value_array.count>0&&_model.product_thread_type_value_array.count>0) {

            for ( ProductStatusModel*model in _model.typeArray) {
        
            if ([model.t_product_first_type_value isEqualToString: firstChocedValue]
                 &&[model.t_product_second_type_value isEqualToString:secondChocedValue]
                 &&[model.t_product_thread_type_value isEqualToString:threadChocedValue]) {

                getProductDetailID = model.t_product_detail_id;
                self.userChosedProductDetailModel =model;

           
            }
        }
        
         return getProductDetailID;
    }
    
    
    
    ///2属性都存在的,最后一个不存在
    if (_model.product_first_type_value_array .count>0&&_model.product_second_type_value_array.count>0&&_model.product_thread_type_value_array.count<=0) {
        
        for ( ProductStatusModel*model in _model.typeArray) {
            
            if ([model.t_product_first_type_value isEqualToString: firstChocedValue]
                &&[model.t_product_second_type_value isEqualToString:secondChocedValue]) {
                
                getProductDetailID = model.t_product_detail_id;
                self.userChosedProductDetailModel =model;

              
            }
        }
   
      return getProductDetailID;
    }

    
    ///2属性都存在的,第二个不存在
    if (_model.product_first_type_value_array.count>0&&_model.product_second_type_value_array.count<=0&&_model.product_thread_type_value_array.count>0) {
        
        for ( ProductStatusModel*model in _model.typeArray) {
            
            if ([model.t_product_first_type_value isEqualToString: firstChocedValue]
                &&[model.t_product_thread_type_value isEqualToString:secondChocedValue]) {
                
                getProductDetailID = model.t_product_detail_id;
                self.userChosedProductDetailModel =model;

          }
            
        }
        return getProductDetailID;

    
    }
  
    
    ///2属性都存在的,第一个个不存在
    if (_model.product_first_type_value_array.count<=0&&_model.product_second_type_value_array.count>0&&_model.product_thread_type_value_array.count>0) {
        
        for ( ProductStatusModel*model in _model.typeArray) {
            
            if ([model.t_product_second_type_value isEqualToString: firstChocedValue]
                &&[model.t_product_thread_type_value isEqualToString:secondChocedValue]) {
                
                getProductDetailID = model.t_product_detail_id;
                self.userChosedProductDetailModel =model;

            }
          

        }
          return getProductDetailID;
    }
    
    
    
    
    ///一个属性存在的
    if (_model.product_first_type_value_array.count>0&&_model.product_second_type_value_array.count==0&&_model.product_thread_type_value_array.count==0) {
        
        for ( ProductStatusModel*model in _model.typeArray) {
            
    if ([model.t_product_first_type_value isEqualToString: firstChocedValue]) {

                getProductDetailID = model.t_product_detail_id;
                 self.userChosedProductDetailModel = model;
        
                }

            }
        return getProductDetailID;

    }

    
   
    
    ///一个属性存在的
    if (_model.product_first_type_value_array.count==0&&_model.product_second_type_value_array.count>0&&_model.product_thread_type_value_array.count==0) {
        
        for ( ProductStatusModel*model in _model.typeArray) {
            
            if ([model.t_product_second_type_value isEqualToString: firstChocedValue]) {
            
            getProductDetailID = model.t_product_detail_id;
            
            self.userChosedProductDetailModel =model;
            }
            
        }
        
        return getProductDetailID;

    }
    
    
    ///一个属性都存在的
    if (_model.product_first_type_value_array.count==0&&_model.product_second_type_value_array.count==0&&_model.product_thread_type_value_array.count>0) {
        
        for ( ProductStatusModel*model in _model.typeArray) {
            
            if ([model.t_product_thread_type_value isEqualToString: firstChocedValue]) {
                
            getProductDetailID = model.t_product_detail_id;
            
            self.userChosedProductDetailModel =model;
             }
            
        }
        
        return getProductDetailID;
    }
    
    
            return getProductDetailID;
}
        
    




////二级属性
//- (void)newChoeseSecondTypeValueArray:(NSArray*)secondTypeArray :(TypeView *)view{
//    
//    //    NSString *firstChocedValue   = firstTypeArray[view.seletIndex];
//    //    self.secondtagArray = [NSMutableArray array];///二级属性可选按钮数组
//    //根据seletIndex 确定用户当前点了那个按钮
//    
//    
//    for (int i = 0; i < firstTypeArray.count; i++) {
//        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
//        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
//        btn.selected = NO;
//        [btn setBackgroundColor:[UIColor whiteColor]];
//        [btn setTitleColor:[UIColor blackColor] forState:0];
//        
//        //库存为零 不可点击
//        //        if (count == 0) {
//        //            btn.enabled = NO;
//        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
//        //        }else
//        //       if {
//        //            btn.enabled = YES;
//        //            [btn setTitleColor:[UIColor blackColor] forState:0];
//        //        }
//        //根据seletIndex 确定用户当前点了那个按钮
//        if (view.seletIndex == i) {
//            btn.selected = YES;
//            [btn setBackgroundColor:[UIColor redColor]];
//        }
//    }
//    
//    
//}












//        //根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
//        -(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
//        {
//            for (int i = 0; i<arr.count; i++) {
//                int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
//                UIButton *btn =(UIButton *)[view viewWithTag:100+i];
//                btn.selected = NO;
//                [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
//                //库存为零 不可点击
//                if (count == 0) {
//                    btn.enabled = NO;
//                    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
//                }else
//                {
//                    btn.enabled = YES;
//                    [btn setTitleColor:[UIColor blackColor] forState:0];
//                }
//                //根据seletIndex 确定用户当前点了那个按钮
//                if (view.seletIndex == i) {
//                    btn.selected = YES;
//                    [btn setBackgroundColor:[UIColor redColor]];
//                }
//            }
//        }
//
//
//
//
//
//
//
//
////选择一级和二级属性下，三级属性列表操作
//- (void)choesefirstType:(NSInteger) firstTag secondType:(NSString*) secondTag  firstTypeValueArray:(NSArray*)firstTypeArray SecondTypeValueArray:(NSArray*)secondTypeArray thirdTypedic:(NSDictionary*)thirdTypedic allArray:(NSArray*)allArray  :(TypeView *)view{
//    
//    NSString *firstChocedValue      =  firstTypeArray[firstTag];
//    NSString *secondChocedValue     =  secondTypeArray[[secondTag integerValue]];
//    NSLog(@"%@",thirdTypedic);
//    
//    NSMutableArray *aray =[NSMutableArray array];
//    for (int i = 0; i<allArray.count; i++) {
//        
//        ProductStatusModel*model =allArray[i];
//        ///取出可选按钮tag
//        NSInteger btntag = [[thirdTypedic objectForKey:model.t_product_thread_type_value] intValue];
//        UIButton *btn =(UIButton *)[view viewWithTag:100+btntag];
//        
//        //如果一级属性值相同的话，
//        if ([model.t_product_first_type_value isEqualToString:firstChocedValue]&&[model.t_product_second_type_value isEqualToString:secondChocedValue]) {
//            [aray addObject:btn];
//            //设置按钮未选中状态
//            //            btn.enabled = YES;
//            //            [btn setTitleColor:[UIColor blackColor] forState:0];
//        }
//        //        else{
//        //
//        //            btn.enabled = NO;
//        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
//        //        }
//        
//    }
//    
//    for (UIButton*btn in aray) {
//        btn.enabled = YES;
//        [btn setTitleColor:[UIColor blackColor] forState:0];
//    }
//    
//    
//}
//

//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}

//一级属性
- (void)newChoeseWithFirstTypeValueArray:(NSArray*)firstTypeArray :(TypeView *)view{
    
    //    NSString *firstChocedValue   = firstTypeArray[view.seletIndex];
    //    self.secondtagArray = [NSMutableArray array];///二级属性可选按钮数组
    //根据seletIndex 确定用户当前点了那个按钮
    
    
    for (int i = 0; i < firstTypeArray.count; i++) {
        //        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        
        //库存为零 不可点击
        //        if (count == 0) {
        //            btn.enabled = NO;
        //            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        //        }else
        //       if {
        //            btn.enabled = YES;
        //            [btn setTitleColor:[UIColor blackColor] forState:0];
        //        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
    
    
}




////#pragma mark-tf
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    return NO;
    
  
}
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//   int count =[self.countView.tf_count.text intValue];
//    if (count > self.stock) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        alert.tag = 100;
//        [alert show];
//        countView.tf_count.text = [NSString stringWithFormat:@"%d",self.stock];
////        [self tap];
//    }
////} 
//-(void)tap
//{
//    mainscrollview.contentOffset = CGPointMake(0, 0);
//    [countView.tf_count resignFirstResponder];
//}

@end
