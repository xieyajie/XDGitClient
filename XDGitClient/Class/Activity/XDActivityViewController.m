//
//  XDActivityViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDActivityViewController.h"

@interface XDActivityViewController ()
{
    NSString *_userName;
}

@end

@implementation XDActivityViewController

- (id)initWithUserName:(NSString *)userName
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        _userName = userName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"动态";
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    [self showLoadingView];
    __block __weak XDActivityViewController *weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[XDRequestManager defaultManager] allActivityWithSuccess:^(id object) {
//            [weakSelf.dataArray removeAllObjects];
//            if (object) {
//                for (NSDictionary *dic in object) {
//                    
//                }
//                
//                [weakSelf tableViewDidFinishHeaderRefresh];
//            }
//        } failure:^(NSError *error) {
//            [weakSelf tableViewDidFinishHeaderRefresh];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"获取数据失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alertView show];
//            });
//        }];
//    });
}

@end
