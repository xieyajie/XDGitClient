//
//  XDRootViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-14.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDRootViewController.h"

#import "XDGitDeckViewController.h"

@interface XDRootViewController ()

@end

@implementation XDRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    XDGitDeckViewController *deckController = [[XDGitDeckViewController alloc] init];
    deckController.view.frame = self.view.bounds;
    [self.view addSubview:deckController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
