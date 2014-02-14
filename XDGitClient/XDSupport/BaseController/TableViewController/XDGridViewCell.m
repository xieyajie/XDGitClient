//
//  XDGridViewCell.m
//  leCar
//
//  Created by xieyajie on 14-1-15.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGridViewCell.h"

@implementation XDGridViewCell

- (id)initWithStyle:(XDGridViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _style = style;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor grayColor];
//        self.textLabel.backgroundColor = [UIColor yellowColor];
        
//        self.contentView.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (_style) {
        case XDGridViewCellStyleDefault:
        {
            self.detailedTextLabel.frame = CGRectZero;
            self.imageView.frame = CGRectMake(0, 5, self.contentView.frame.size.width, self.contentView.frame.size.height - 20 - 10);
            self.textLabel.frame = CGRectMake(0, self.contentView.frame.size.height - 20, self.contentView.frame.size.width, 20);
        }
            break;
        case XDGridViewCellStyleImage:
        {
            self.textLabel.frame = CGRectZero;
            self.detailedTextLabel.frame = CGRectZero;
            self.imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
        }
            break;
            
        default:
            break;
    }
}

@end
