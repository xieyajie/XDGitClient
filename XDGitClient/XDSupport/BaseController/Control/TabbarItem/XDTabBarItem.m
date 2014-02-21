//
//  XDTabBarItem.m
//  leCar
//
//  Created by xieyajie on 14-1-22.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDTabBarItem.h"

@implementation XDTabBarItem

@synthesize style = _style;

- (id)init
{
    self = [self initWithStyle:XDTabBarItemStyleDefault frame:CGRectZero];
    if (self) {
        //
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithStyle:XDTabBarItemStyleDefault frame:frame];
    if (self) {
        //
    }
    
    return self;
}

- (id)initWithStyle:(XDTabBarItemStyle)style frame:(CGRect)frame
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
            case XDTabBarItemStyleDefault:
            {
                [self addSubview:_imageView];
                [self addSubview:_titleLabel];
            }
                break;
            case XDTabBarItemStyleImage:
            {
                [self addSubview:_imageView];
            }
                break;
            case XDTabBarItemStyleTitle:
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
        case XDTabBarItemStyleDefault:
        {
            _imageView.frame = CGRectMake(5, 3, self.frame.size.width - 10, self.frame.size.height - 21);
            _titleLabel.frame = CGRectMake(5, self.frame.size.height - 18, self.frame.size.width - 10, 15);
        }
            break;
        case XDTabBarItemStyleImage:
        {
            _imageView.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10);
        }
            break;
        case XDTabBarItemStyleTitle:
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
