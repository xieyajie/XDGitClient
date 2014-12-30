//
//  XDUserCardViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDUserCardViewController.h"

#import "XDTableViewCell.h"
#import "XDTabBarController.h"
#import "XDRepositoryViewController.h"
#import "XDGitsViewController.h"
#import "XDFollowerViewController.h"
#import "XDFollowingViewController.h"
#import "XDEventsViewController.h"
#import "XDNotificationsViewController.h"
#import "XDConfigManager.h"

#define KPLIST_SOURCE_OWN @"Own"
#define KPLIST_SOURCE_OTHER @"Other"

@interface XDUserCardViewController ()
{
    BOOL _isOwn;
}

@property (strong, nonatomic) UserModel *userModel;

@property (strong, nonatomic) NSArray *plistSourceArray;
@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) UIBarButtonItem *acttentionItem;;
@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) XDTabBarController *reposityController;
@property (strong, nonatomic) XDGitsViewController *gitsController;

@end

@implementation XDUserCardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _isOwn = YES;
        _userModel = [[XDConfigManager defaultManager] loginUser];
    }
    return self;
}

- (id)initWithUser:(UserModel *)model
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        UserModel *loginAccount = [[XDConfigManager defaultManager] loginUser];
        if ([model.uId integerValue] == [loginAccount.uId integerValue]) {
            _userModel = loginAccount;
            _isOwn = YES;
        }
        else{
            _userModel = model;
            _isOwn = NO;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.userModel.userName;
    self.showRefreshHeader = YES;
    [self.navigationItem setRightBarButtonItem:self.acttentionItem];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
//    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissButtonTapped:(id)sender
{
    [super dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter

- (UIBarButtonItem *)acttentionItem
{
    if (_acttentionItem == nil && !_isOwn) {
        _acttentionItem = [[UIBarButtonItem alloc] initWithTitle:@"关注" style:UIBarButtonItemStylePlain target:self action:@selector(acttentionAction)];
    }
    
    return _acttentionItem;
}

- (UIImageView *)headerImageView
{
    if(_headerImageView == nil)
    {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [_headerImageView setImageWithURL:[NSURL URLWithString:self.userModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
        
        if (_isOwn) {
            _headerImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageAction)];
            [_headerImageView addGestureRecognizer:tap];
        }
    }
    
    return _headerImageView;
}

- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        if (_isOwn) {
            _titleArray = @[@"基本资料"];
        }
        else{
            _titleArray = @[@"基本资料", @"工程", @"动态", @"关注"];
        }
    }
    
    return _titleArray;
}

- (NSArray *)plistSourceArray
{
    if (_plistSourceArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"userCard" ofType:@"plist"];
        NSDictionary *sourcrDic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSString *sourceKey = _isOwn ? KPLIST_SOURCE_OWN : KPLIST_SOURCE_OTHER;
        _plistSourceArray = [sourcrDic objectForKey:sourceKey];
    }
    
    return _plistSourceArray;
}

- (XDTabBarController *)reposityController
{
    if (_reposityController == nil) {
        NSArray *titleArray = @[@"Ta全部的", @"Ta自己的", @"Ta参与的", @"Ta关注的"];
        NSArray *imageArray = @[@"tab_all.png", @"side_copy.png", @"side_copy.png", @"side_copy.png"];
        NSArray *selectedImageArray = @[@"tab_allSelect.png", @"side_own.png", @"side_own.png", @"side_own.png"];
        NSArray *typeArray = @[[NSNumber numberWithInt:XDRepositoryStyleAll], [NSNumber numberWithInt:XDRepositoryStyleOwner], [NSNumber numberWithInt:XDRepositoryStyleMember], [NSNumber numberWithInt:XDRepositoryStyleStars]];
        NSMutableArray *controllers = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            XDRepositoryViewController *controller = [[XDRepositoryViewController alloc] initWithUserName:self.userModel.userName repositoryStyle:[[typeArray objectAtIndex:i] intValue]];
            UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:[titleArray objectAtIndex:i] image:nil tag:i];
            [tabBarItem setImage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
            [tabBarItem setSelectedImage:[UIImage imageNamed:[selectedImageArray objectAtIndex:i]]];
            controller.tabBarItem = tabBarItem;
            
            [controllers addObject:controller];
        }
        
        _reposityController = [[XDTabBarController alloc] init];
        [_reposityController setViewControllers:controllers];
    }
    
    return _reposityController;
}

- (XDGitsViewController *)gitsController
{
    if (_gitsController == nil) {
        _gitsController = [[XDGitsViewController alloc] initWithUserName:self.userModel.userName gitsStyle:XDGitStyleAll];
        _gitsController.title = @"Gits";
    }
    
    return _gitsController;
}

#pragma mark - setter

- (void)setUserModel:(UserModel *)userModel
{
    _userModel = userModel;
    [self.headerImageView setImageWithURL:[NSURL URLWithString:userModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.plistSourceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.plistSourceArray objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.titleArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellValue1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.2f alpha:1.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    NSDictionary *dic = [[self.plistSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = [[dic objectForKey:KPLIST_KEYACCESSORYTYPE] integerValue];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"";
        [cell.contentView addSubview:self.headerImageView];
        cell.detailTextLabel.text = self.userModel.userName;
    }
    else{
        cell.textLabel.text = [dic objectForKey:KPLIST_KEYTITLE];
        
        NSString *selectorStr = [dic objectForKey:KPLIST_KEYMODELSELECTOR];
        SEL selectorMethod = NSSelectorFromString(selectorStr);
        if (selectorStr && selectorStr.length && selectorMethod) {
            NSString *resultStr = [self.userModel performSelector:selectorMethod withObject:nil];
            if(resultStr && resultStr.length > 0)
            {
                cell.detailTextLabel.text = resultStr;
            }
        }
        else{
            cell.detailTextLabel.text = @"";
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *str = [self.titleArray objectAtIndex:section];
    if (str == nil || str.length == 0) {
        return 20.0;
    }
    
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [[self.plistSourceArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSInteger controllerSelectorTag = [[dic objectForKey:KPLIST_KEYCONTROLLERSELECTOR] integerValue];
    NSString *userName = self.userModel.userName;
    
    switch (controllerSelectorTag) {
        case KPLIST_VALUE_CONTROLLERSELECTOR_REPO:
            [self.navigationController pushViewController:self.reposityController animated:YES];
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_GIT:
            [self.navigationController pushViewController:self.gitsController animated:YES];
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_EVENT:
        {
            XDEventsViewController *eventsController = [[XDEventsViewController alloc] initWithUserName:userName];
            [self.navigationController pushViewController:eventsController animated:YES];
        }
            break;
        case KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOWER:
        {
            XDFollowerViewController *followerController = [[XDFollowerViewController alloc] initWithUserName:userName];
            followerController.title = [dic objectForKey:KPLIST_KEYTITLE];
            [self.navigationController pushViewController:followerController animated:YES];
        }
        case KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOEIMG:
        {
            XDFollowingViewController *followingController = [[XDFollowingViewController alloc] initWithUserName:userName];
            followingController.title = [dic objectForKey:KPLIST_KEYTITLE];
            [self.navigationController pushViewController:followingController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - action

- (void)acttentionAction
{
    
}

- (void)headerImageAction
{
    
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    __block __weak XDUserCardViewController *weakSelf = self;
    AFHTTPRequestOperation *operation = nil;
    if (_isOwn) {
        operation = [[XDGithubEngine shareEngine] userWithSuccess:^(id object) {
            weakSelf.userModel = [[UserModel alloc] initWithDictionary:object];
            
            [weakSelf tableViewDidFinishHeaderRefresh];
        } failure:^(NSError *error) {
            [weakSelf tableViewDidFailHeaderRefresh];
        }];
    }
    else{
        operation = [[XDGithubEngine shareEngine] user:_userModel.userName success:^(id object) {
            weakSelf.userModel = [[UserModel alloc] initWithDictionary:object];
            
            [weakSelf tableViewDidFinishHeaderRefresh];
        } failure:^(NSError *error) {
            [weakSelf tableViewDidFailHeaderRefresh];
        }];
    }
    
    [self showLoadingViewWithRequestOperation:operation];
}

@end
