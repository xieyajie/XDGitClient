//
//  UIButton+AsyncImage.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AsyncImage)

- (void)setImageFromURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage forState:(UIControlState)state adjustToSize:(CGSize)size;

@end
