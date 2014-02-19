//
//  XDGitSideViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-14.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGitSideViewController.h"

#import "XDGitDeckViewController.h"
#import "XDTabBarController.h"
#import "XDProjectViewController.h"
#import "XDActivityViewController.h"
#import "XDFollowViewController.h"
#import "XDAccountCardViewController.h"
#import "XDTableViewCell.h"

#import "XDConfigManager.h"

@interface XDGitSideViewController ()
{
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    UIBarButtonItem *_menuItem;
    
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
    [refreshButton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
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
        [_accountButton addTarget:self action:@selector(accountCardAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _accountButton;
}

- (UIView *)logoutView
{
    if (_logoutView == nil) {
        _logoutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
        _logoutView.backgroundColor = [UIColor clearColor];
        
        UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, KLEFTVIEWWIDTH - 30, 35)];
        logoutButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [logoutButton setTitle:@"退出当前账户" forState:UIControlStateNormal];
        [logoutButton setBackgroundImage:[[UIImage imageNamed:@"button_bg_red"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
        [logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        [_logoutView addSubview:logoutButton];
    }
    
    return _logoutView;
}

- (UINavigationController *)projectNavTabController
{
    if (_projectNavTabController == nil) {
        NSArray *titleArray = @[@"全部", @"公开", @"私有", @"参与", @"拷贝"];
        NSArray *imageArray = @[@"tab_all.png", @"side_copy.png", @"side_copy.png", @"side_copy.png", @"side_copy.png"];
        NSArray *selectedImageArray = @[@"tab_allSelect.png", @"side_own.png", @"side_own.png", @"side_own.png", @"side_own.png"];
        NSMutableArray *controllers = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            XDProjectViewController *projectsController = [[XDProjectViewController alloc] initWithUserName:nil projectsStyle:i];
            UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:[titleArray objectAtIndex:i] image:nil tag:i];
            [tabBarItem setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
            [tabBarItem setSelectedImage:[UIImage imageNamed:[selectedImageArray objectAtIndex:i]]];
            projectsController.tabBarItem = tabBarItem;
            
            [controllers addObject:projectsController];
        }
        
        XDTabBarController *projectTabController = [[XDTabBarController alloc] init];
        [projectTabController setViewControllers:controllers];
        _projectNavTabController = [[UINavigationController alloc] initWithRootViewController:projectTabController];
    }
    
    return _projectNavTabController;
}

- (UINavigationController *)activityNavController
{
    if (_activityNavController == nil) {
        XDActivityViewController *activityController = [[XDActivityViewController alloc] initWithUserName:nil];
        _activityNavController = [[UINavigationController alloc] initWithRootViewController:activityController];
    }
    
    return _activityNavController;
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
        cell.headerImageView.image = [UIImage imageNamed:[dic objectForKey:KPLIST_SOURCEIMAGE]];
        cell.titleLabel.text = [dic objectForKey:KPLIST_SOURCETITLE];
        
        UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:100];
        detailLabel.backgroundColor = [UIColor clearColor];
        NSString *selectorStr = [dic objectForKey:KPLIST_SOURCESELECTOR];
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
            self.deckController.centerController = self.projectNavTabController;
        }
            break;
        case 1:
        {
            self.deckController.centerController = self.activityNavController;
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
    
    if (_menuItem == nil) {
        UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(15.0, 20.0+(44.0-30.0)/2, 30.0, 30.0)];
        [menuButton setBackgroundImage:[UIImage imageNamed:@"side_menu"] forState:UIControlStateNormal];
        [menuButton addTarget:self action:@selector(openSideAction) forControlEvents:UIControlEventTouchUpInside];
        _menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    }
    
    id controller = self.deckController.centerController;
    if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)controller;
        [[[navController.viewControllers objectAtIndex:0] navigationItem] setLeftBarButtonItem:_menuItem];
    }

    [self.deckController closeLeftViewAnimated:YES];
}

#pragma mark - action

- (void)accountCardAction
{
    XDAccountCardViewController *cardController = [[XDAccountCardViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *cardNavigation = [[UINavigationController alloc] initWithRootViewController:cardController];
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:cardController action:@selector(dismissButtonTapped:)];
    
    [[[XDViewManager defaultManager] appRootNavController] presentViewController:cardNavigation animated:YES completion:^{
        [self.deckController closeLeftViewAnimated:YES];
        [cardController.navigationItem setLeftBarButtonItem:cancleItem];
    }];
}

- (void)refreshAction
{
    [self loadAccountData];
}

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

- (void)openSideAction
{
    [self.deckController openLeftViewAnimated:YES];
}

#pragma mark - private

- (void)loadAccountData
{
    __block __weak XDGitSideViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [_configManager loadLoginAccountWithSuccess:^(id object) {
        AccountModel *account = (AccountModel *)object;
        
        [weakSelf.accountButton setTitle:account.accountName forState:UIControlStateNormal];
        [weakSelf.accountButton.imageView setImageWithURL:[NSURL URLWithString:account.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
        
        [weakSelf hideLoadingView];
        [weakSelf.tableView reloadData];
        [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    } failure:^(NSError *error) {
        [weakSelf hideLoadingView];
        
        [weakSelf.accountButton setTitle:@"获取失败" forState:UIControlStateNormal];
        [weakSelf.accountButton setImage:[UIImage imageNamed:@"userHeaderDefault_30"] forState:UIControlStateNormal];
    }];
    
    [[XDViewManager defaultManager] showLoadingViewWithTitle:@"配置账号..." requestOperation:operation];
}

@end
