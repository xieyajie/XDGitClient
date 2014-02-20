//
//  XDTableViewCell.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDTableViewCell.h"

@implementation XDTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat oX = 10;
    CGFloat oY = self.frame.size.height / 5;
    if (_headerImageView && _headerImageView.image) {
        CGFloat imageWidth = self.frame.size.height / 5 * 3;
        _headerImageView.frame = CGRectMake(oX, oY, imageWidth, imageWidth);
        oX += imageWidth;
    }
    else{
        _headerImageView.frame = CGRectZero;
    }
    
    if (_titleLabel && _titleLabel.text.length > 0) {
        oX += 5;
        UIFont *font = _titleLabel.font;
        CGFloat titleMaxWidth = self.frame.size.width - oX - 10;
        CGFloat titleWidth = [_titleLabel.text sizeWithFont:font constrainedToSize:CGSizeMake(titleMaxWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping].width;
        _titleLabel.frame = CGRectMake(oX, oY, titleWidth, self.frame.size.height - 2 * oY);
    }
    else{
        _titleLabel.frame = CGRectZero;
    }
}

#pragma mark - getter

- (UIImageView *)headerImageView
{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headerImageView];
    }
    
    return _headerImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

@end
