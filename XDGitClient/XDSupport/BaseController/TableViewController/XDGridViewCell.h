//
//  XDGridViewCell.h
//  leCar
//
//  Created by xieyajie on 14-1-15.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "NRGridViewCell.h"

typedef enum{
    XDGridViewCellStyleDefault  = 0,    //imageView at top and titleLabel at bottom
    XDGridViewCellStyleImage,           //imageView only
    XDGridViewCellStyleTitle,           //titleLabel only
    XDGridViewCellStyleCustom,          //custom
}XDGridViewCellStyle;

@interface XDGridViewCell : NRGridViewCell
{
    XDGridViewCellStyle _style;
}

- (id)initWithStyle:(XDGridViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
