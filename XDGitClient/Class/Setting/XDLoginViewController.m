//
//  XDLoginViewController.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-31.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDLoginViewController.h"

#import "XDOauthViewController.h"

@interface XDLoginViewController ()
{
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UIButton *_oauthButton;
    UILabel *_copyrightLabel;
}

@property (strong, nonatomic) XDOauthViewController *oauthController;

@end

@implementation XDLoginViewController

@synthesize oauthController = _oauthController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _oauthController = [[XDOauthViewController alloc] init];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 80)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:32];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"G i t H u b";
    [self.view addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 20, self.view.frame.size.width, 100)];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15];;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.text = @"随时阅读你的代码动态\n\nRead the codes that matter to you.\n Anywhere, anytime.";
    [self.view addSubview:_contentLabel];
    
    _oauthButton = [[UIButton alloc] initWithFrame:CGRectMake(30, self.view.frame.size.height / 2 + 60, self.view.frame.size.width - 60, 40)];
    [_oauthButton setTitle:@"github 官方授权" forState:UIControlStateNormal];
    [_oauthButton setTitleColor:[UIColor colorWithRed:48 / 255.0 green:169 / 255.0 blue:55 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [_oauthButton addTarget:self action:@selector(oauthAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_oauthButton];
    
    _copyrightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 40, self.view.frame.size.width - 40, 20)];
    _copyrightLabel.backgroundColor = [UIColor clearColor];
    _copyrightLabel.font = [UIFont systemFontOfSize:13];
    _copyrightLabel.textAlignment = NSTextAlignmentCenter;
    _copyrightLabel.textColor = [UIColor grayColor];
    _copyrightLabel.text = @"XDStudio工作室出品，欢迎使用";
    [self.view addSubview:_copyrightLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (void)oauthAction:(id)sender
{
    [self.navigationController pushViewController:_oauthController animated:YES];
}

@end
