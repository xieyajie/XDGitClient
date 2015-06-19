//
//  DXTabBarItem.m
//  DXStudio
//
//  Created by xieyajie on 14-1-22.
//  Copyright (c) 2014年 DXStudio. All rights reserved.
//

#import "DXTabBarItem.h"

@implementation DXTabBarItem

@synthesize style = _style;

- (id)init
{
    self = [self initWithStyle:DXTabBarItemStyleDefault frame:CGRectZero];
    if (self) {
        //
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithStyle:DXTabBarItemStyleDefault frame:frame];
    if (self) {
        //
    }
    
    return self;
}

- (id)initWithStyle:(DXTabBarItemStyle)style frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        _imageView.backgroundColor = [UIColor redColor];
        
        _titleColor = [UIColor grayColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:10];
        _titleLabel.textColor = _titleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        switch (_style) {
            case DXTabBarItemStyleDefault:
            {
                [self addSubview:_imageView];
                [self addSubview:_titleLabel];
            }
                break;
            case DXTabBarItemStyleImage:
            {
                [self addSubview:_imageView];
            }
                break;
            case DXTabBarItemStyleTitle:
            {
                [self addSubview:_titleLabel];
            }
                break;
                
            default:
                break;
        }
        
        self.selected = NO;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.style) {
        case DXTabBarItemStyleDefault:
        {
            _imageView.frame = CGRectMake(5, 3, self.frame.size.width - 10, self.frame.size.height - 21);
            _titleLabel.frame = CGRectMake(5, self.frame.size.height - 18, self.frame.size.width - 10, 15);
        }
            break;
        case DXTabBarItemStyleImage:
        {
            _imageView.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10);
        }
            break;
        case DXTabBarItemStyleTitle:
        {
            _titleLabel.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10);
        }
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.imageView.image = self.selectedImage;
        self.titleLabel.textColor = self.selectedTitleColor;
    }
    else{
        self.imageView.image = self.image;
        self.titleLabel.textColor = self.titleColor;
    }
}

@end
