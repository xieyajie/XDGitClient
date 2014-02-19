//
//  XDActivityIndicatorView.h
//  XDGitClient
//
//  Created by dhcdht on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDActivityIndicatorView : UIView

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame ballColor:(UIColor *)ballColor;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
