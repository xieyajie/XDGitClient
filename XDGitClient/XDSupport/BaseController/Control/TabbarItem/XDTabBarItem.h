//
//  XDTabBarItem.h
//  leCar
//
//  Created by xieyajie on 14-1-22.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    XDTabBarItemStyleDefault    = 0,// imageView at top and titleLabel at bottom
    XDTabBarItemStyleImage,         // imageView only
    XDTabBarItemStyleTitle,         // titleLabel only
}XDTabBarItemStyle;

@interface XDTabBarItem : UIControl

@property (nonatomic, readonly) XDTabBarItemStyle style;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;

- (id)initWithStyle:(XDTabBarItemStyle)style frame:(CGRect)frame;

@end
