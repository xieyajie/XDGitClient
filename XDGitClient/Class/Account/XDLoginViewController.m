//
//  XDLoginViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-14.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDLoginViewController.h"

#import "XDRequestManager.h"
#import "XDViewManager.h"
#import "XDConfigManager.h"

@interface XDLoginViewController ()<UITextFieldDelegate>
{
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    UIButton *_loginButton;
    UIButton *_rememberButton;
    UIButton *_forgetButton;
}

@property (strong, nonatomic) UIView *mainLoginView;

@end

@implementation XDLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleBordered target:self action:@selector(registerAction)];
    
    [self.view addSubview:self.mainLoginView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, self.mainLoginView.frame.origin.y + self.mainLoginView.frame.size.height + 50, self.view.frame.size.width - 40, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = @"XDIOS工作室出品";
    [self.view addSubview:label];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:[NSString stringWithFormat:@"%@_UserName", APPNAME]];
    if (userName && userName.length > 0) {
        _usernameTextField.text = userName;
        
        NSString *pswd = [defaults objectForKey:userName];
        if (pswd && pswd.length > 0) {
            _passwordTextField.text = pswd;
            _rememberButton.selected = YES;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UIView *)mainLoginView
{
    if (_mainLoginView == nil) {
        _mainLoginView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 40.0, self.view.frame.size.width - 40.0, 165.0)];
        
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, _mainLoginView.frame.size.width, 80.0)];
        backgroundImageView.image = [[UIImage imageNamed:@"login_input_bg"] stretchableImageWithLeftCapWidth:10 topCapHeight:15];
        [_mainLoginView addSubview:backgroundImageView];
        
        UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, 39.0, _mainLoginView.frame.size.width - 10.0, 2.0)];
        separatorImageView.image = [UIImage imageNamed:@"login_separator"];
        [_mainLoginView addSubview:separatorImageView];
        
        //用户名输入框
        if (!_usernameTextField) {
            _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0, 0.0, _mainLoginView.frame.size.width - 16.0, 40.0)];
            _usernameTextField.placeholder = @" 请输入用户名/邮箱";
            NSString *saveUserName = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
            if (saveUserName.length) {
                _usernameTextField.text = saveUserName;
            }
            _usernameTextField.delegate = self;
            _usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
            _usernameTextField.returnKeyType = UIReturnKeyNext;
            _usernameTextField.enablesReturnKeyAutomatically = NO;
//            [_usernameTextField addTarget:self action:@selector(textFieldDidChangeEditing:) forControlEvents:UIControlEventEditingChanged];//替代delegate，解决中文输入法字符不匹配问题
            [_usernameTextField addTarget:_passwordTextField action:@selector(becomeFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
            [_mainLoginView addSubview:_usernameTextField];
        }
        
        //密码输入框
        if (!_passwordTextField) {
            _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(8.0, 40.0, _mainLoginView.frame.size.width - 16.0, 38.0)];
            _passwordTextField.placeholder = @" 请输入密码";
            _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            _passwordTextField.returnKeyType = UIReturnKeyGo;
            _passwordTextField.enablesReturnKeyAutomatically = NO;
            _passwordTextField.secureTextEntry = YES;
            _passwordTextField.clearsOnBeginEditing = YES;
            [_passwordTextField addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventEditingDidEndOnExit];
            [_passwordTextField addTarget:self action:@selector(hideKeyboardAction) forControlEvents:UIControlEventEditingDidEndOnExit];
            [_mainLoginView addSubview:_passwordTextField];
        }
        
        //登录按钮
        if (!_loginButton) {
            UIImage *bgImage = [[UIImage imageNamed:@"button_bg_green"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
            _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, _passwordTextField.frame.origin.y + _passwordTextField.frame.size.height + 10, _mainLoginView.frame.size.width, 40.0)];
            [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
            [_loginButton setBackgroundImage:bgImage forState:UIControlStateNormal];
            _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            _loginButton.titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
            [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
            [_loginButton addTarget:self action:@selector(hideKeyboardAction) forControlEvents:UIControlEventTouchUpInside];
            [_mainLoginView addSubview:_loginButton];
        }
        
        if (!_rememberButton) {
            _rememberButton = [[UIButton alloc] initWithFrame:CGRectMake(5, _loginButton.frame.origin.y + _loginButton.frame.size.height + 10, 100, 30)];
            _rememberButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [_rememberButton setTitle:@" 记住密码" forState:UIControlStateNormal];
            [_rememberButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [_rememberButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            _rememberButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [_rememberButton setImage:[UIImage imageNamed:@"rectangle_uncheck.png"] forState:UIControlStateNormal];
            [_rememberButton setImage:[UIImage imageNamed:@"rectangle_checked.png"] forState:UIControlStateSelected];
            [_rememberButton addTarget:self action:@selector(rememberPswdAction) forControlEvents:UIControlEventTouchUpInside];
            [_mainLoginView addSubview:_rememberButton];
        }
        
//        if (!_forgetButton) {
//            _forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(190, _loginButton.frame.origin.y + _loginButton.frame.size.height + 10, 100, 30)];
//            _forgetButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//            [_forgetButton setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
//            [_forgetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            [_forgetButton addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
//            [_mainLoginView addSubview:_forgetButton];
//        }
    }
    
    return _mainLoginView;
}

#pragma mark - UITextFieldDelegate



#pragma mark - action

- (void)hideKeyboardAction
{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (void)registerAction
{
    
}

- (void)forgetAction
{
    
}

- (void)rememberPswdAction
{
    _rememberButton.selected = !_rememberButton.selected;
}

- (void)loginAction
{
    NSString *userName = _usernameTextField.text;
    NSString *paswd = _passwordTextField.text;
    
    UIAlertView *alert = nil;
    if (userName.length == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"用户名/邮箱不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (paswd.length == 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    AFHTTPRequestOperation *operation = [[[XDRequestManager defaultManager] activityGitEngine] loginWithUserName:userName password:paswd success:^(id object) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (_rememberButton.selected) {
            [defaults setValue:paswd forKey:userName];
        }
        else{
            [defaults removeObjectForKey:userName];
        }
        
        [self hideLoadingView];
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOFINSTATECHANGED object:nil];
    } failure:^(NSError *error) {
        [self hideLoadingView];
    }];
    
    [[XDViewManager defaultManager] showLoadingViewWithTitle:@"验证账号..." requestOperation:operation];
}

@end
