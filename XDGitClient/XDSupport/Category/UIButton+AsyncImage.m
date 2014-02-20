//
//  UIButton+AsyncImage.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "UIButton+AsyncImage.h"

@implementation UIButton (AsyncImage)

- (void)setImageFromURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage forState:(UIControlState)state adjustToSize:(CGSize)size
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block UIImage *image = nil;
        NSData *data = [NSData dataWithContentsOfURL:url];
        image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                if (!CGSizeEqualToSize(size, CGSizeZero)) {
                    image = [UIImage imageWithCGImage:image.CGImage scale:[self scaleImage:image adjustToSize:size] orientation:image.imageOrientation];
                }
                [self setImage:image forState:state];
            }
            else{
                [self setImage:placeholderImage forState:state];
            }
        });
    });
}

// 缩放图片以适应按钮大小
- (CGFloat)scaleImage:(UIImage *)image adjustToSize:(CGSize)size
{
    CGFloat xScale = size.width / image.size.width;
    CGFloat yScale = size.height / image.size.height;
    
    return 1.0 / MIN(xScale, yScale);
}

@end
