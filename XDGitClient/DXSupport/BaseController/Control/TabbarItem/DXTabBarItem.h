//
//  DXTabBarItem.h
//  DXStudio
//
//  Created by xieyajie on 14-1-22.
//  Copyright (c) 2014年 DXStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    DXTabBarItemStyleDefault    = 0,// imageView at top and titleLabel at bottom
    DXTabBarItemStyleImage,         // imageView only
    DXTabBarItemStyleTitle,         // titleLabel only
}DXTabBarItemStyle;

@interface DXTabBarItem : UIControl

@property (nonatomic, readonly) DXTabBarItemStyle style;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;

- (id)initWithStyle:(DXTabBarItemStyle)style frame:(CGRect)frame;

@end
