//
//  XDProjectViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDProjectViewController.h"

@interface XDProjectViewController ()
{
    NSString *_userName;
    XDProjectStyle _style;
}

@end

@implementation XDProjectViewController

- (id)initWithUserName:(NSString *)userName
{
    self = [self initWithUserName:userName projectsStyle:XDProjectStyleAll];
    if (self) {
        //
    }
    
    return self;
}

- (id)initWithUserName:(NSString *)userName projectsStyle:(XDProjectStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        //
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - date

- (void)tableViewDidTriggerHeaderRefresh
{
    [self showLoadingView];
    __block __weak XDProjectViewController *weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[XDRequestManager defaultManager] projectsWithStyle:_style userName:nil success:^(id object) {
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
