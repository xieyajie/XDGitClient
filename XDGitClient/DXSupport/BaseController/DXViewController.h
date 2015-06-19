//
//  DXViewController.h
//  DXStudio
//
//  Created by xieyajie on 13-10-14.
//  Copyright (c) 2013年 DXStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXViewController : UIViewController
{
    NSMutableArray *_rightItems;
    NSMutableArray *_leftItems;
}

@property (strong, nonatomic) NSString *barTitle;
@property (strong, nonatomic) NSMutableArray *rightItems;
@property (strong, nonatomic) NSMutableArray *leftItems;

- (void)showLoadingView;
- (void)showLoadingViewWithTitle:(NSString *)title;
- (void)showLoadingViewWithRequestOperation:(AFHTTPRequestOperation *)requestOperation;
- (void)hideLoadingView;

@end
