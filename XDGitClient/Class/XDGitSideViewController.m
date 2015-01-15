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
#import "XDRepositoryViewController.h"
#import "XDGitsViewController.h"
#import "XDNewsViewController.h"
#import "XDNotificationsViewController.h"
#import "XDIssuesViewController.h"
#import "XDFollowerViewController.h"
#import "XDFollowingViewController.h"
#import "XDUserCardViewController.h"
#import "XDTableViewCell.h"
#import "UIButton+AsyncImage.h"

#import "XDConfigManager.h"

@interface XDGitSideViewController ()
{
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    UIBarButtonItem *_menuItem;
    
    XDConfigManager *_configManager;
}

@property (strong, nonatomic) UIButton *accountButton;
@property (strong, nonatomic) UIView *footerView;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@property (strong, nonatomic) UINavigationController *reposityNavTabController;
@property (strong, nonatomic) UINavigationController *gitsNavTabController;
@property (strong, nonatomic) UINavigationController *newsNavController;
@property (strong, nonatomic) UINavigationController *notifsNavController;
@property (strong, nonatomic) UINavigationController *issuesNavController;
@property (strong, nonatomic) UINavigationController *followerNavController;
@property (strong, nonatomic) UINavigationController *followingNavController;

@end

@implementation XDGitSideViewController

@synthesize reposityNavTabController = _reposityNavTabController;
@synthesize gitsNavTabController = _gitsNavTabController;
@synthesize newsNavController = _newsNavController;
@synthesize notifsNavController = _notifsNavController;
@synthesize issuesNavController = _issuesNavController;
@synthesize followerNavController = _followerNavController;
@synthesize followingNavController = _followingNavController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.accountButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sideSource" ofType:@"plist"];
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:243 / 255.0 alpha:1.0];
//    self.tableView.tableFooterView = self.footerView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.sectionHeaderHeight = 40.0;
    self.tableView.rowHeight = 50.0;
    
    _configManager = [XDConfigManager defaultManager];
    [self fetchUserInfo];
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
        [_accountButton addTarget:self action:@selector(accountCardAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_accountButton setImage:[UIImage imageNamed:@"userHeaderDefault_30"] forState:UIControlStateNormal];
        [_accountButton setTitle:@"正在获取..." forState:UIControlStateNormal];
    }
    
    return _accountButton;
}

- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
        _footerView.backgroundColor = [UIColor clearColor];
        
        UIButton *fButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, KLEFTVIEWWIDTH - 30, 35)];
        fButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [fButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [fButton setBackgroundImage:[[UIImage imageNamed:@"button_bg_red"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
        [fButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:fButton];
    }
    
    return _footerView;
}

- (UINavigationController *)reposityNavTabController
{
    if (_reposityNavTabController == nil) {
        NSArray *titleArray = @[@"Me全部的", @"Me自己的", @"Me参与的", @"Me关注的"];
        NSArray *imageArray = @[@"tab_all.png", @"side_copy.png", @"side_copy.png", @"side_copy.png"];
        NSArray *selectedImageArray = @[@"tab_allSelect.png", @"side_own.png", @"side_own.png", @"side_own.png"];
        NSArray *typeArray = @[[NSNumber numberWithInt:XDRepositoryStyleAll], [NSNumber numberWithInt:XDRepositoryStyleOwner], [NSNumber numberWithInt:XDRepositoryStyleMember], [NSNumber numberWithInt:XDRepositoryStyleStars]];
        NSMutableArray *controllers = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            XDRepositoryViewController *projectsController = [[XDRepositoryViewController alloc] initWithProjectsStyle:[[typeArray objectAtIndex:i] intValue]];
            UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:[titleArray objectAtIndex:i] image:nil tag:i];
            [tabBarItem setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
            [tabBarItem setSelectedImage:[UIImage imageNamed:[selectedImageArray objectAtIndex:i]]];
            projectsController.tabBarItem = tabBarItem;
            
            [controllers addObject:projectsController];
        }
        
        XDTabBarController *reposityTabController = [[XDTabBarController alloc] init];
        [reposityTabController setViewControllers:controllers];
        _reposityNavTabController = [[UINavigationController alloc] initWithRootViewController:reposityTabController];
    }
    
    return _reposityNavTabController;
}

- (UINavigationController *)gitsNavTabController
{
    if (_gitsNavTabController == nil) {
        NSArray *titleArray = @[@"全部", @"公开", @"私有", @"关注的"];
        NSArray *imageArray = @[@"tab_all.png", @"side_copy.png", @"side_copy.png", @"side_copy.png"];
        NSArray *selectedImageArray = @[@"tab_allSelect.png", @"side_own.png", @"side_own.png", @"side_own.png"];
        NSMutableArray *controllers = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            XDGitsViewController *projectsController = [[XDGitsViewController alloc] initWithGitsStyle:i];
            UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:[titleArray objectAtIndex:i] image:nil tag:i];
            [tabBarItem setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
            [tabBarItem setSelectedImage:[UIImage imageNamed:[selectedImageArray objectAtIndex:i]]];
            projectsController.tabBarItem = tabBarItem;
            
            [controllers addObject:projectsController];
        }
        
        XDTabBarController *gitsTabController = [[XDTabBarController alloc] init];
        [gitsTabController setViewControllers:controllers];
        _gitsNavTabController = [[UINavigationController alloc] initWithRootViewController:gitsTabController];
    }
    
    return _gitsNavTabController;
}

- (UINavigationController *)newsNavController
{
    if (_newsNavController == nil) {
        XDNewsViewController *newController = [[XDNewsViewController alloc] initWithUserName:nil];
        _newsNavController = [[UINavigationController alloc] initWithRootViewController:newController];
    }
    
    return _newsNavController;
}

- (UINavigationController *)notifsNavController
{
    if (_notifsNavController == nil) {
        XDNotificationsViewController *notifsController = [[XDNotificationsViewController alloc] initWithUserName:nil];
        _notifsNavController = [[UINavigationController alloc] initWithRootViewController:notifsController];
    }
    
    return _notifsNavController;
}

- (UINavigationController *)issuesNavController
{
    if (_issuesNavController == nil) {
        XDIssuesViewController *issuesController = [[XDIssuesViewController alloc] initWithUserName:nil];
        _issuesNavController = [[UINavigationController alloc] initWithRootViewController:issuesController];
    }
    
    return _issuesNavController;
}

- (UINavigationController *)followerNavController
{
    if (_followerNavController == nil) {
        XDFollowerViewController *followerController = [[XDFollowerViewController alloc] initWithUserName:nil];
        _followerNavController = [[UINavigationController alloc] initWithRootViewController:followerController];
    }
    
    return _followerNavController;
}

- (UINavigationController *)followingNavController
{
    if (_followingNavController == nil) {
        XDFollowingViewController *followingController = [[XDFollowingViewController alloc] initWithUserName:nil];
        _followingNavController = [[UINavigationController alloc] initWithRootViewController:followingController];
    }
    
    return _followingNavController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
//    return [self.dataArray count];
    return 3;
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
            return @"工程";
            break;
        case 1:
            return @"关注";
            break;
        case 2:
            return @"附属功能";
            break;
//        case 3:
//            return @"动态";
//            break;
            
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
        label.font = [UIFont boldSystemFontOfSize:13.0];
        label.textColor = [UIColor whiteColor];
        label.tag = 100;
        label.layer.cornerRadius = 5.0;
        [cell.contentView addSubview:label];
    }
    
    NSDictionary *dic = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (dic) {
        cell.headerImageView.image = [UIImage imageNamed:[dic objectForKey:KPLIST_KEYIMAGE]];
        cell.titleLabel.text = [dic objectForKey:KPLIST_KEYTITLE];
        
        UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:100];
        detailLabel.backgroundColor = [UIColor clearColor];
        NSString *selectorStr = [dic objectForKey:KPLIST_KEYMODELSELECTOR];
        if (selectorStr && selectorStr.length) {
            SEL selectorMethod = NSSelectorFromString(selectorStr);
            if(selectorMethod){
                NSString *resultStr = [_configManager.loginUser performSelector:selectorMethod];
                if(resultStr && resultStr.length > 0)
                {
                    detailLabel.text = resultStr;
                    detailLabel.backgroundColor = [UIColor colorWithRed:70 / 255.0 green:175 / 255.0 blue:226 / 255.0 alpha:0.7];
                }
            }
        }
        else{
            detailLabel.text = @"";
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedIndexPath == nil || self.selectedIndexPath.section != indexPath.section || self.selectedIndexPath.row != indexPath.row) {
        self.selectedIndexPath = indexPath;
        
        NSDictionary *dic = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSInteger controllerSelectorTag = [[dic objectForKey:KPLIST_KEYCONTROLLERSELECTOR] integerValue];
        
        switch (controllerSelectorTag) {
            case KPLIST_VALUE_CONTROLLERSELECTOR_REPO:
                self.deckController.centerController = self.reposityNavTabController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_GIT:
                self.deckController.centerController = self.gitsNavTabController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_NEW:
                self.deckController.centerController = self.newsNavController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_ACTIVITY:
//                self.deckController.centerController = self.eventsNavController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_NOTIF:
                self.deckController.centerController = self.notifsNavController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_PULLREQUEST:
//                self.deckController.centerController = self.notifsNavController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_ISSUE:
                self.deckController.centerController = self.issuesNavController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOWER:
                self.deckController.centerController = self.followerNavController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOEING:
                self.deckController.centerController = self.followingNavController;
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_XDS:
            {
                
            }
                break;
            case KPLIST_VALUE_CONTROLLERSELECTOR_EMAIL:
            {
                
            }
                break;
            default:
                break;
        }
    }

    [self.deckController closeLeftViewAnimated:YES];
}

#pragma mark - action

- (void)accountCardAction
{
    XDUserCardViewController *cardController = [[XDUserCardViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *cardNavigation = [[UINavigationController alloc] initWithRootViewController:cardController];
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:cardController action:@selector(dismissButtonTapped:)];
    
    [[[XDViewManager defaultManager] appRootNavController] presentViewController:cardNavigation animated:YES completion:^{
        [cardController.navigationItem setRightBarButtonItem:cancleItem];
    }];
}

- (void)refreshAction
{
    [self fetchUserInfo];
}

- (void)settingAction
{
    
}

- (void)logoutAction
{
    [[XDConfigManager defaultManager] logoff];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOFINSTATECHANGED object:nil];
}

- (void)openSideAction
{
    [self.deckController openLeftViewAnimated:YES];
}

#pragma mark - private

- (void)tableViewDidTriggerHeaderRefresh
{
    [self fetchUserInfo];
}

- (void)fetchUserInfo
{
    __block __weak XDGitSideViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] userWithSuccess:^(id object) {
        UserModel *account = [[UserModel alloc] initWithDictionary:object];
        _configManager.loginUser = account;
        [weakSelf.accountButton setImageFromURL:[NSURL URLWithString:account.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"] forState:UIControlStateNormal adjustToSize:CGSizeMake(30, 30)];
        [weakSelf.accountButton setTitle:account.userName forState:UIControlStateNormal];
        
        [weakSelf hideLoadingView];
        [weakSelf.tableView reloadData];
        
        if (self.selectedIndexPath == nil) {
            [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
        else{
            [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:weakSelf.selectedIndexPath];
            [weakSelf.tableView selectRowAtIndexPath:weakSelf.selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    } failure:^(NSError *error) {
        [weakSelf hideLoadingView];
        
        _configManager.loginUser = nil;
        [weakSelf.accountButton setTitle:@"获取失败" forState:UIControlStateNormal];
        [weakSelf.accountButton setImage:[UIImage imageNamed:@"userHeaderDefault_30"] forState:UIControlStateNormal];
    }];
    
    [[XDViewManager defaultManager] showLoadingViewWithTitle:@"配置账号..." requestOperation:operation];
}

@end
