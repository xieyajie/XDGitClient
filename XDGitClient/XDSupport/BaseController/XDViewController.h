//
//  XDViewController.h
//  XDUI
//
//  Created by xieyajie on 13-10-14.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDViewController : UIViewController
{
    NSMutableArray *_rightItems;
    NSMutableArray *_leftItems;
}

@property (strong, nonatomic) NSString *barTitle;
@property (strong, nonatomic) NSMutableArray *rightItems;
@property (strong, nonatomic) NSMutableArray *leftItems;

- (void)showLoadingView;
- (void)hideLoadingView;

@end
