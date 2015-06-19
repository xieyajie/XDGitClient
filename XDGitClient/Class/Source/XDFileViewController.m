//
//  XDFileViewController.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-15.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDFileViewController.h"

#import "RepoSourceModel.h"
#import "FileModel.h"
#import "GTMBase64.h"
#import <MMMarkdown/MMMarkdown.h>

@interface XDFileViewController ()
{
    RepoSourceModel *_model;
    FileModel *_fileModel;
    UIBarButtonItem *_browserItem;
}

@end

@implementation XDFileViewController

- (instancetype)initWithSourceModel:(RepoSourceModel *)model
{
    self = [self init];
    if (self) {
        _model = model;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _browserItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_settingWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(browserAction)];
    
    [self fetchFile];
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
        NSData *encodeData = [_fileModel.content dataUsingEncoding:NSUTF8StringEncoding];
        NSData *decodeData = [GTMBase64 decodeData:encodeData];
        NSString *tmpContent = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
        _fileModel.content = [MMMarkdown HTMLStringWithMarkdown:tmpContent error:nil];
        [self loadHtmlString:_fileModel.content];
    }
}

- (void)browserAction
{
    DXWebViewController *webController = [[DXWebViewController alloc] initWithUrlPath:_fileModel.htmlPath];
    webController.title = _model.name;
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:webController action:@selector(closeWithDismiss)];
    [webController.navigationItem setRightBarButtonItem:closeItem];
    UINavigationController *webNav = [[UINavigationController alloc] initWithRootViewController:webController];
    [self presentViewController:webNav animated:YES completion:nil];
}

#pragma mark - fetch data

- (void)fetchFile
{
    if (_model) {
        __weak typeof(self) weakSelf = self;
        AFHTTPRequestOperation *operation = [[DXGithubEngine shareEngine] requestWithPath:_model.contentsPath mothod:DXRequestMothodGet success:^(id object) {
            if ([object count] > 0) {
                _fileModel = [[FileModel alloc] initWithDictionary:object];
                
                if ([_fileModel.htmlPath length] > 0) {
                    [self.navigationItem setRightBarButtonItem:_browserItem];
                }
                else{
                    [self.navigationItem setRightBarButtonItem:nil];
                }
                
                [weakSelf contentEncoding:_fileModel.encoding];
            }
            [weakSelf hideLoadingView];
        } failure:^(NSError *error) {
            [weakSelf hideLoadingView];
        }];
        
        [[XDViewManager defaultManager] showLoadingViewWithTitle:@"获取ReadMe..." requestOperation:operation];
    }
}

@end
