//
//  XDTabBarController.m
//  New
//
//  Created by yajie xie on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "XDTabBarController.h"

#import "XDViewController.h"

#define KTabBarHeight 44

@interface XDTabBarController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *tabBar;

@property (nonatomic, strong) NSMutableArray *itemButtons;

@end

@implementation XDTabBarController

@synthesize currentSelectedIndex = _currentSelectedIndex;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _slideBg = [[UIView alloc] init];//选中时阴影层
        _slideBg.backgroundColor = [UIColor colorWithRed:109 / 255.0 green:60 / 255.0 blue:35 / 255.0 alpha:1.0];
        
        _currentSelectedIndex = -1;
        _tabBarHidden = NO;
    }
    return self;
}

- (void)loadView {
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height)];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [view setBackgroundColor:[UIColor whiteColor]];
    self.view = view;
    
    [view addSubview:self.contentView];
    [view addSubview:self.tabBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    CGSize viewSize = self.view.frame.size;
    [self.contentView setFrame:CGRectMake(0, 0, viewSize.width, viewSize.height - KTabBarHeight)];
    
    if ([self.itemButtons count] > 0) {
        [self selectedTabItem:[self.itemButtons objectAtIndex:0]];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    if (!_tabBarHidden && self.tabBar.frame.origin.y != self.view.frame.size.height - KTabBarHeight) {
        [self.tabBar setFrame:CGRectMake(0, self.view.frame.size.height - KTabBarHeight, self.view.frame.size.width, KTabBarHeight)];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - getting

- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        [_contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    
    return _contentView;
}

- (UIView *)tabBar
{
    if (_tabBar == nil) {
        _tabBar = [[UIView alloc] initWithFrame: CGRectZero];
        _tabBar.backgroundColor = [UIColor colorWithRed:210 / 255.0 green:220 / 255.0 blue:225 / 255.0 alpha:1.0];
        [_tabBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    
    return _tabBar;
}

- (UIViewController *)activityController
{
    return [self.viewControllers objectAtIndex: self.currentSelectedIndex];
}

#pragma mark - setting

- (void)setViewControllers:(NSArray *)viewControllers
{
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        _viewControllers = viewControllers;
        
        [self configurationTabbarItems];
    }
    else {
        _viewControllers = nil;
    }

}

#pragma mark - custom methods

- (void)configurationTabbarItems
{
    //创建按钮
    int viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
    self.itemButtons = [NSMutableArray arrayWithCapacity:viewCount];
    CGFloat width = 320.0 / viewCount;
    CGFloat height = KTabBarHeight;
    for (int i = 0; i < viewCount; i++)
    {
        XDViewController *viewController = (XDViewController *)[self.viewControllers objectAtIndex:i];
        viewController.barTitle = viewController.tabBarItem.title;
        XDTabBarItem *tabItem = [[XDTabBarItem alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        tabItem.tag = i;
        tabItem.backgroundColor = [UIColor clearColor];
        tabItem.titleLabel.text = viewController.tabBarItem.title;
        tabItem.titleColor = [UIColor colorWithRed:47 / 255.0 green:66 / 255.0 blue:75 / 255.0 alpha:1.0];
        tabItem.selectedTitleColor = [UIColor colorWithRed:127 / 255.0 green:153 / 255.0 blue:183 / 255.0 alpha:1.0];
        tabItem.image = viewController.tabBarItem.image;
        tabItem.selectedImage = viewController.tabBarItem.selectedImage;
        tabItem.imageView.image = tabItem.image;
        [tabItem addTarget:self action:@selector(selectedTabItem:) forControlEvents: UIControlEventTouchUpInside];
        
        [self.itemButtons addObject:tabItem];
        [self.tabBar addSubview:tabItem];
    }
}

//切换滑块位置
- (void)slideTabItemBg:(UIButton *)button
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.20];
	[UIView setAnimationDelegate:self];
	_slideBg.frame = button.frame;
    [self.tabBar sendSubviewToBack:_slideBg];
    
	[UIView commitAnimations];
	CAKeyframeAnimation * animation; 
	animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
	animation.duration = 0.50; 
	animation.delegate = self;
	animation.removedOnCompletion = YES;
	animation.fillMode = kCAFillModeForwards;
	NSMutableArray *values = [NSMutableArray array];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]]; 
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]]; 
	[values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
	animation.values = values;
	[button.layer addAnimation:animation forKey:nil];
}


- (void)selectedTabItem: (XDTabBarItem *)item
{
    if (self.currentSelectedIndex != item.tag)
    {
        if (self.currentSelectedIndex > -1) {
            XDTabBarItem *oldItem = [self.itemButtons objectAtIndex:self.currentSelectedIndex];
            oldItem.selected = NO;
            
            UIViewController *oldViewController = [self.viewControllers objectAtIndex: self.currentSelectedIndex];
            [oldViewController.view removeFromSuperview];
            [oldViewController removeFromParentViewController];
        }
        
        self.currentSelectedIndex = item.tag;
        item.selected = YES;
        
        XDViewController *viewController = (XDViewController *)[self.viewControllers objectAtIndex:item.tag];
        //设置navigationBar
        self.title = viewController.barTitle;
        self.navigationItem.leftBarButtonItems = viewController.leftItems;
        self.navigationItem.rightBarButtonItems = viewController.rightItems;
        //显示viewController
        [self addChildViewController:viewController];
        viewController.view.frame = self.contentView.bounds;
        [self.view addSubview:viewController.view];
        [self.view bringSubviewToFront: self.tabBar];
	}
}

#pragma mark - public

- (void)tabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    if (_tabBarHidden == hidden) {
        return;
    }
    
    _tabBarHidden = hidden;
    
    void (^block)() = ^{
        CGSize viewSize = self.view.frame.size;
        CGRect contentViewFrame = [self.contentView frame];
        CGRect tabBarFrame = [self.tabBar frame];
        
        if (hidden)
        {
            [self.tabBar setFrame:CGRectMake(CGRectGetMinX(tabBarFrame), viewSize.height, CGRectGetWidth(tabBarFrame), CGRectGetHeight(tabBarFrame))];
            [self.contentView setFrame:CGRectMake(CGRectGetMinX(contentViewFrame), CGRectGetMinY(contentViewFrame), CGRectGetWidth(contentViewFrame), viewSize.height)];
        }
        else {
            [self.tabBar setFrame:CGRectMake(CGRectGetMinX(tabBarFrame), viewSize.height - CGRectGetHeight(tabBarFrame), CGRectGetWidth(tabBarFrame), CGRectGetHeight(tabBarFrame))];
            [self.contentView setFrame:CGRectMake(CGRectGetMinX(contentViewFrame), CGRectGetMinY(contentViewFrame), CGRectGetWidth(contentViewFrame), viewSize.height - KTabBarHeight)];
        }
        
        UIViewController *viewController = [self.viewControllers objectAtIndex:self.currentSelectedIndex];
        viewController.view.frame = self.contentView.bounds;
    };
    
    if (animated) {
        [UIView animateWithDuration:0.24 animations:^{
            block();
        }];
    } else {
        block();
    }
}

- (void)tabBarHidden:(BOOL)hidden
{
    [self tabBarHidden:hidden animated:NO];
}

@end
