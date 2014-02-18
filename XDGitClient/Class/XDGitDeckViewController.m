//
//  XDGitDeckViewController.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-14.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGitDeckViewController.h"

#import "XDGitSideViewController.h"
#import "XDTableViewController.h"

@interface XDGitDeckViewController ()

@end

@implementation XDGitDeckViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    XDGitSideViewController *leftController = [[XDGitSideViewController alloc] initWithStyle:UITableViewStylePlain];
    leftController.deckController = self;
    XDTableViewController *centerController = [[XDTableViewController alloc] initWithStyle:UITableViewStylePlain];

    self.leftSize = 320 - KLEFTVIEWWIDTH;
    self.leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    self.centerController = centerController;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
