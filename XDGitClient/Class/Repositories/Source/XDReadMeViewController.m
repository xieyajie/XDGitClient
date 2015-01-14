//
//  XDReadMeViewController.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-14.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDReadMeViewController.h"

#import "GTMBase64.h"
#import <MMMarkdown/MMMarkdown.h>

#import "XDWebViewController.h"

#define KREPO_README_CONTENT @"content"
#define KREPO_README_SIZE @"size"
#define KREPO_README_DOWNLOADPATH @"download_url"
#define KREPO_README_BROWSERPATH @"html_url"
#define KREPO_README_ENCODING @"encoding"

@interface XDReadMeViewController ()
{
    NSString *_repoFullName;
    UIBarButtonItem *_browserItem;
}

@property(nonatomic, strong) NSString *content;
@property(nonatomic, strong) NSString *downloadPath;
@property(nonatomic, strong) NSString *encoding;
@property(nonatomic, strong) NSString *browserPath;
@property(nonatomic) int size;

@end

@implementation XDReadMeViewController

@synthesize content = _content;
@synthesize downloadPath = _downloadPath;
@synthesize browserPath = _browserPath;
@synthesize size = _size;

- (instancetype)initWithRepositoryFullName:(NSString *)repoFullName
{
    self = [self init];
    if (self) {
        _repoFullName = repoFullName;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ReadMe";
    
    _browserItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_settingWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(browserAction)];
    
    [self fetchReadMe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)contentEncoding:(NSString *)encoding
{
    if([encoding isEqualToString:@"base64"])
    {
        NSData *encodeData = [_content dataUsingEncoding:NSUTF8StringEncoding];
        NSData *decodeData = [GTMBase64 decodeData:encodeData];
        NSString *tmpContent = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
        _content = [MMMarkdown HTMLStringWithMarkdown:tmpContent error:nil];
        [self loadHtmlString:_content];
    }
}

- (void)browserAction
{
    XDWebViewController *webController = [[XDWebViewController alloc] initWithUrlPath:_browserPath];
    webController.title = @"ReadMe.md";
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:webController action:@selector(closeWithDismiss)];
    [webController.navigationItem setRightBarButtonItem:closeItem];
    UINavigationController *webNav = [[UINavigationController alloc] initWithRootViewController:webController];
    [self presentViewController:webNav animated:YES completion:nil];
}

#pragma mark - fetch data

- (void)fetchReadMe
{
    if ([_repoFullName length] > 0) {
        __weak typeof(self) weakSelf = self;
        AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] readmeForRepository:_repoFullName success:^(id object) {
            if ([object count] > 0) {
                weakSelf.content = [object objectForKey:KREPO_README_CONTENT];
                weakSelf.encoding = [object objectForKey:KREPO_README_ENCODING];
                weakSelf.downloadPath = [object objectForKey:KREPO_README_DOWNLOADPATH];
                weakSelf.browserPath = [object objectForKey:KREPO_README_BROWSERPATH];
                weakSelf.size = [[object objectForKey:KREPO_README_SIZE] intValue];
                
                if ([weakSelf.browserPath length] > 0) {
                    [self.navigationItem setRightBarButtonItem:_browserItem];
                }
                else{
                    [self.navigationItem setRightBarButtonItem:nil];
                }
                
//                [weakSelf loadPath:weakSelf.browserPath];
                [weakSelf contentEncoding:weakSelf.encoding];
            }
            [weakSelf hideLoadingView];
        } failure:^(NSError *error) {
            [weakSelf hideLoadingView];
        }];
        
        [[XDViewManager defaultManager] showLoadingViewWithTitle:@"获取ReadMe..." requestOperation:operation];
    }
}

@end
