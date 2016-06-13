//
//  RegistViewController.m
//  AutoLayout__Text
//
//  Created by JWB on 16/1/18.
//  Copyright © 2016年 JWB. All rights reserved.
//

#import "RegistViewController.h"
#import "MainTabBarViewController.h"
#import "CustButton.h"

@interface RegistViewController ()<UITextFieldDelegate>

@property(weak,nonatomic)IBOutlet UITextField  *pswTextField;
@property(weak,nonatomic)IBOutlet UITextField  *nameTextField;
@property(weak,nonatomic)IBOutlet UITextField  *phoneNumberText;


@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    
    [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_pswTextField  addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_phoneNumberText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}
//返回按钮
-(IBAction)dobackAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//确认注册
-(IBAction)RegistAction:(id)sender{
    //发送请求 直接跳转到我的界面
//    MainTabBarViewController *mainVC=[[MainTabBarViewController alloc]init];
//    [self.navigationController pushViewController:mainVC  animated:YES];
    [[BaseAlert sharedInstance]showLodingWithMessage:@"注册中"];
    
}
//控制密码是否可见
-(IBAction)doSecretCodeSee:(CustButton*)sender{
    //密码不可见
    if (sender.isCover==YES) {
        sender.isCover=NO;
        _pswTextField.secureTextEntry=NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"PswSee"] forState:UIControlStateNormal];
    }
    //密码可见
    else {
        sender.isCover=YES;
        _pswTextField.secureTextEntry=YES;
        [sender  setBackgroundImage:[UIImage imageNamed:@"PswNoSee"] forState:UIControlStateNormal];
    }
}
//获取短信验证码
-(IBAction)doGetPhoneVerificationCode:(id)sender{
    //发送请求
}
//我已阅读
-(IBAction)doGreenAction:(CustButton*)sender{
    if (sender.isCover==YES) {
        sender.isCover=NO;
        [sender setBackgroundColor:[UIColor blueColor]];
    }
    //密码可见
    else {
        sender.isCover=YES;
        [sender setBackgroundColor:[UIColor yellowColor]];
    }

}
#pragma mark ---UITextFieldDelegate--
-(void)textFieldDidChange:(UITextField*)textField{
    if (textField==_nameTextField) {
        if (textField.markedTextRange==nil&&textField.text.length>16) {
            [[BaseAlert sharedInstance]showMessage:@"用户姓名最长可输入16位"];
            textField.text=_nameTextField.text;
            textField.text=[textField.text  substringToIndex:16];
        }
    }
    else if (textField==_pswTextField){
        if (textField.markedTextRange==nil&&textField.text.length>16) {
            [[BaseAlert sharedInstance]showMessage:@"密码最长可输入16位"];
            textField.text=_pswTextField.text;
            textField.text=[textField.text substringToIndex:16];
        }
    }
    else{
        if (textField.markedTextRange==nil&&textField.text.length>11) {
            [[BaseAlert sharedInstance]showMessage:@"手机号最长不超过11位"];
            textField.text=_phoneNumberText.text;
            textField.text=[textField.text substringToIndex:11];
        }
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField  resignFirstResponder];
        return NO;
    }
    if (textField==_nameTextField) {
        if (range.location>=16&&(textField.markedTextRange==nil&&range.length==0)) {
            //.length==0表示输入的更多 .length==1表示删除
            [[BaseAlert sharedInstance]showMessage:@"用户姓名最长可输入16位"];
            return NO;
        }
    }
    if (textField==_pswTextField) {
         if (range.location>=16&&(textField.markedTextRange==nil&&range.length==0)){
             [[BaseAlert sharedInstance]showMessage:@"密码最长可输入16位"];
             return NO;
        }
    }
    if (textField==_phoneNumberText) {
        if (range.location>=11&&(textField.markedTextRange==nil&&range.length==0)) {
            [[BaseAlert sharedInstance]showMessage:@"手机号最长不超过11位"];
            return NO;
        }
    }
    return YES;
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
