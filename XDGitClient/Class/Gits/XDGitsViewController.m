//
//  XDGitsViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGitsViewController.h"

#import "GitModel.h"

@interface XDGitsViewController ()
{
    NSString *_userName;
    XDGitStyle _style;
    
    UIBarButtonItem *_editItem;
}

@end

@implementation XDGitsViewController

- (id)initWithGitsStyle:(XDGitStyle)style
{
    self = [self initWithUserName:nil gitsStyle:style];
    if (self) {
        
    }
    
    return self;
}

- (id)initWithUserName:(NSString *)userName gitsStyle:(XDGitStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _style = style;
        _userName = userName;
        
        if (_userName == nil && _userName.length == 0) {
            _editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
            _rightItems = [NSMutableArray arrayWithObjects:_editItem, nil];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //        cell.titleLabel.textColor = [UIColor grayColor];
        //        cell.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    GitModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.Id;
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}


#pragma mark - date

- (void)tableViewDidTriggerHeaderRefresh
{
    self.page = 1;
    __block __weak XDGitsViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperation *operation = [[[XDRequestManager defaultManager] activityGitEngine] gistsForUser:_userName style:_style page:self.page success:^(id object, BOOL haveNextPage) {
            [weakSelf.dataArray removeAllObjects];
            weakSelf.haveNextPage = haveNextPage;
            if (object) {
                for (NSDictionary *dic in object) {
                    GitModel *model = [[GitModel alloc] initWithDictionary:dic];
                    [weakSelf.dataArray addObject:model];
                }
                
                [weakSelf tableViewDidFinishHeaderRefresh];
            }
        } failure:^(NSError *error) {
            [weakSelf tableViewDidFailHeaderRefresh];
        }];
        
        [self showLoadingViewWithRequestOperation:operation];
    });
}

- (void)tableViewDidTriggerFooterRefresh
{
    self.page++;
    __block __weak XDGitsViewController *weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPRequestOperation *operation = [[[XDRequestManager defaultManager] activityGitEngine] gistsForUser:_userName style:_style page:self.page success:^(id object, BOOL haveNextPage) {
            weakSelf.haveNextPage = haveNextPage;
            if (object) {
                for (NSDictionary *dic in object) {
                    GitModel *model = [[GitModel alloc] initWithDictionary:dic];
                    [weakSelf.dataArray addObject:model];
                }
                
                [weakSelf tableViewDidFinishFooterRefresh];
            }
        } failure:^(NSError *error) {
            [weakSelf tableViewDidFailFooterRefresh];
        }];
        
        [self showLoadingViewWithRequestOperation:operation];
    });
}

#pragma mark - action

- (void)editAction
{
    self.tableView.editing = !self.tableView.editing;
    _editItem.title = self.tableView.editing ? @"完成" : @"编辑";
}


@end
