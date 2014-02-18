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

#import "XDGitDeckViewController.h"
#import "XDTabBarController.h"
#import "XDProjectViewController.h"
#import "XDActivityViewController.h"
#import "XDFollowViewController.h"
#import "XDTableViewCell.h"

#define KSOURCEIMAGE @"icon"
#define KSOURCETITLE @"title"
#define KSOURCESELECTOR @"selector"

@interface XDGitSideViewController ()
{
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    
    XDConfigManager *_configManager;
}

@property (strong, nonatomic) UIButton *accountButton;
@property (strong, nonatomic) UIView *logoutView;

@end

@implementation XDGitSideViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _configManager = [XDConfigManager defaultManager];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sideSource" ofType:@"plist"];
        self.dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.accountButton];
    UIButton *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [settingButton setImage:[UIImage imageNamed:@"navi_settingWhite.png"] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"navi_settingBlue.png"] forState:UIControlStateHighlighted];
    [settingButton addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [refreshButton setImage:[UIImage imageNamed:@"navi_settingBlue.png"] forState:UIControlStateNormal];
    [refreshButton setImage:[UIImage imageNamed:@"navi_settingBlue.png"] forState:UIControlStateHighlighted];
    [refreshButton addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:refreshButton];
    
    [self.navigationItem setLeftBarButtonItems:@[leftItem, refreshItem, settingItem]];
    [self loadAccountData];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1.0];
    self.tableView.tableFooterView = self.logoutView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UIButton *)accountButton
{
    if (_accountButton == nil) {
        _accountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 100, 34)];
        _accountButton.backgroundColor = [UIColor clearColor];
        _accountButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _accountButton.titleLabel.numberOfLines = 0;
        _accountButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _accountButton.titleLabel.textColor = [UIColor whiteColor];
        _accountButton.imageEdgeInsets = UIEdgeInsetsMake(0, -7, 0, 0);
        _accountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [_accountButton setImage:[UIImage imageNamed:@"userHeaderDefault_30"] forState:UIControlStateNormal];
        [_accountButton setTitle:@"正在获取..." forState:UIControlStateNormal];
    }
    
    return _accountButton;
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
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.dataArray objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"";
            break;
        case 1:
            return @"";
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
    XDTableViewCell *cell = (XDTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[XDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.titleLabel.textColor = [UIColor grayColor];
        cell.titleLabel.font = [UIFont systemFontOfSize:15.0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KLEFTVIEWWIDTH - 45, 15, 35, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13.0];
        label.textColor = [UIColor whiteColor];
        label.tag = 100;
        label.layer.cornerRadius = 5.0;
        [cell.contentView addSubview:label];
    }
    
    NSDictionary *dic = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (dic) {
        cell.headerImageView.image = [UIImage imageNamed:[dic objectForKey:KSOURCEIMAGE]];
        cell.titleLabel.text = [dic objectForKey:KSOURCETITLE];
        
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
    switch (section) {
        case 0:
        case 1:
            return 20.0;
            break;
        case 2:
            return 40.0;
            break;
            
        default:
            return 20.0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            NSArray *titleArray = @[@"全部", @"公开", @"私有", @"参与", @"拷贝"];
            NSArray *imageArray = @[@"side_copy.png", @"side_copy.png", @"side_copy.png", @"side_copy.png", @"side_copy.png"];
            NSArray *selectedImageArray = @[@"side_own.png", @"side_own.png", @"side_own.png", @"side_own.png", @"side_own.png"];
            NSMutableArray *controllers = [NSMutableArray array];
            for (int i = 0; i < 5; i++) {
                XDProjectViewController *projectsController = [[XDProjectViewController alloc] initWithUserName:nil projectsStyle:i];
                UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:[titleArray objectAtIndex:i] image:nil tag:i];
                [tabBarItem setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
                [tabBarItem setSelectedImage:[UIImage imageNamed:[selectedImageArray objectAtIndex:i]]];
                projectsController.tabBarItem = tabBarItem;
                
                [controllers addObject:projectsController];
            }
            
            XDTabBarController *tabController = [[XDTabBarController alloc] init];
            [tabController setViewControllers:controllers];
            self.deckController.centerController = [[UINavigationController alloc] initWithRootViewController:tabController];
        }
            break;
        case 1:
        {
            XDActivityViewController *activityController = [[XDActivityViewController alloc] initWithUserName:nil];
            self.deckController.centerController = [[UINavigationController alloc] initWithRootViewController:activityController];
        }
            break;
        case 2:
        {
            BOOL follower = indexPath.row == 0 ? YES : NO;
            XDFollowViewController *followController = [[XDFollowViewController alloc] initWithFollowers:follower];
            self.deckController.centerController = [[UINavigationController alloc] initWithRootViewController:followController];
        }
            break;
            
        default:
            break;
    }
    
    [self.deckController closeLeftViewAnimated:YES];
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
    id<XDGitEngineProtocol> gitEngine = [[XDRequestManager defaultManager] activityGitEngine];
    [gitEngine userWithSuccess:^(id object) {
        AccountModel *account = [[AccountModel alloc] initWithDictionary:object];
        _configManager.loginAccount = account;
        
        [self.accountButton setTitle:account.accountName forState:UIControlStateNormal];
        [self.accountButton.imageView setImageWithURL:[NSURL URLWithString:account.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.accountButton setTitle:@"获取失败" forState:UIControlStateNormal];
        [self.accountButton setImage:[UIImage imageNamed:@"userHeaderDefault_30"] forState:UIControlStateNormal];
    }];
}

@end
