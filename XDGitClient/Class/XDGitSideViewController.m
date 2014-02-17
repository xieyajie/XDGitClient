//
//  XDGitSideViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-14.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGitSideViewController.h"

#import "UIImageView+AFNetworking.h"
#import "XDRequestManager.h"
#import "XDConfigManager.h"

#define KSOURCEIMAGE @"icon"
#define KSOURCETITLE @"title"
#define KSOURCESELECTOR @"selector"

@interface XDGitSideViewController ()
{
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    
    NSArray *_titleArray;
    XDConfigManager *_configManager;
}

@property (strong, nonatomic) UIView *accountView;
@property (strong, nonatomic) UIView *logoutView;

@end

@implementation XDGitSideViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sideSource" ofType:@"plist"];
        _titleArray = [NSArray arrayWithContentsOfFile:path];
        
        _configManager = [XDConfigManager defaultManager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.accountView];
    UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [settingButton setImage:[UIImage imageNamed:@"navi_settingWhite.png"] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"navi_settingBlue.png"] forState:UIControlStateHighlighted];
    [settingButton addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    [self.navigationItem setLeftBarButtonItems:@[leftItem, settingItem]];
    [self loadAccountData];
    
    self.tableView.tableFooterView = self.logoutView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UIView *)accountView
{
    if (_accountView == nil) {
        _accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
        _accountView.backgroundColor = [UIColor clearColor];
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 30, 30)];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_accountView addSubview:_headerImageView];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_headerImageView.frame.origin.x + _headerImageView.frame.size.width + 10, 7, 90, 30)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _nameLabel.textColor = [UIColor whiteColor];
        [_accountView addSubview:_nameLabel];
    }
    
    return _accountView;
}

- (UIView *)logoutView
{
    if (_logoutView == nil) {
        _logoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 65)];
        _logoutView.backgroundColor = [UIColor clearColor];
        
        UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, KLEFTVIEWWIDTH - 30, 35)];
        logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [logoutButton setTitle:@"退出当前账户" forState:UIControlStateNormal];
        [logoutButton setBackgroundImage:[[UIImage imageNamed:@"button_bg_red"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
        [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        [_logoutView addSubview:logoutButton];
    }
    
    return _logoutView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"工程";
            break;
        case 1:
            return @"动态";
            break;
        case 2:
            return @"关注";
            break;
            
        default:
            return @"";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KLEFTVIEWWIDTH - 45, 15, 35, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13.0];
        label.textColor = [UIColor whiteColor];
        label.tag = 100;
        label.layer.cornerRadius = 5.0;
        [cell.contentView addSubview:label];
    }
    
    NSDictionary *dic = [[_titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (dic) {
        cell.imageView.image = [UIImage imageNamed:[dic objectForKey:KSOURCEIMAGE]];
        cell.textLabel.text = [dic objectForKey:KSOURCETITLE];
        
        UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:100];
        detailLabel.backgroundColor = [UIColor clearColor];
        NSString *selectorStr = [dic objectForKey:KSOURCESELECTOR];
        if (selectorStr && selectorStr.length > 0) {
            SEL selectorMethod = NSSelectorFromString(selectorStr);
            if (selectorMethod) {
                NSString *resultStr = [_configManager.loginAccount performSelector:selectorMethod];
                if(resultStr && resultStr.length > 0)
                {
                    detailLabel.text = resultStr;
                    detailLabel.backgroundColor = [UIColor lightGrayColor];
                }
            }
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - action

- (void)settingAction
{
    
}

- (void)logoutAction
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"%@_LoginAccountName", APPNAME];
    [defaults removeObjectForKey:key];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOFINSTATECHANGED object:nil];
}

#pragma mark - private

- (void)loadAccountData
{
    UAGithubEngine *githubEngine = [[XDRequestManager defaultManager] githubEngine];
    [githubEngine user:githubEngine.username success:^(id object) {
        NSDictionary *dic = [object objectAtIndex:0];
        AccountModel *account = [[AccountModel alloc] initWithDictionary:dic];
        _configManager.loginAccount = account;
        
        [_headerImageView setImageWithURL:[NSURL URLWithString:account.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
        _nameLabel.text = account.accountName;
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        _headerImageView.image = [UIImage imageNamed:@"userHeaderDefault_30"];
        _nameLabel.text = @"获取失败";
    }];
}

@end
