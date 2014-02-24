//
//  XDPullRequestCell.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-24.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPullRequestCell.h"

#import "PullRequestModel.h"

@implementation XDPullRequestCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        _contentLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        [self.contentView addSubview:_contentLabel];
        
        _updateLabel = [[UILabel alloc] init];
        _updateLabel.backgroundColor = [UIColor clearColor];
        _updateLabel.font = [UIFont systemFontOfSize:12.0];
        _updateLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_updateLabel];
        
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [self.contentView addSubview:_headerImageView];
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
    
    CGFloat oY = 10;
    CGFloat oX = 50;
    CGFloat viewWidth = 320 - 10 - oX;
    if (_model.title && _model.title.length > 0) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:_titleLabel.font forKey:NSFontAttributeName];
        CGRect sizeRect = [_model.title boundingRectWithSize:CGSizeMake(viewWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        CGFloat titleH = sizeRect.size.height > 20 ? sizeRect.size.height : 20;
        _titleLabel.frame = CGRectMake(oX, oY, viewWidth, titleH);
        oY += titleH + 5;
    }
    else{
        _titleLabel.frame = CGRectZero;
    }
    
    if (_model.content && _model.content.length > 0) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:_contentLabel.font forKey:NSFontAttributeName];
        CGRect sizeRect = [_model.content boundingRectWithSize:CGSizeMake(viewWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        CGFloat desH = sizeRect.size.height > 15 ? sizeRect.size.height : 15;
        desH = desH > 35 ? 35 : desH;
        _contentLabel.frame = CGRectMake(oX, oY, viewWidth, desH);
        oY += desH + 5;
    }
    else{
        _contentLabel.frame = CGRectZero;
    }
    
    _updateLabel.frame = CGRectMake(oX, oY, viewWidth, 15);
    oY += 20;
}

- (void)setModel:(id<XDModelProtocol>)model
{
    _model = model;
    _titleLabel.text = _model.title;
    _contentLabel.text = _model.content;
    _updateLabel.text = [NSString stringWithFormat:@"更新于：%@", _model.updatedDateDes];
    [_headerImageView setImageWithURL:[NSURL URLWithString:_model.owner.avatarUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault_30"]];
}

+ (CGFloat)heightWithModel:(PullRequestModel *)model
{
    CGFloat viewWidth = 320 - 10 - 50;
    CGFloat viewHeight = 20;
    if (model.title && model.title.length > 0) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
        CGRect sizeRect = [model.title boundingRectWithSize:CGSizeMake(viewWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        NSInteger titleH = sizeRect.size.height > 20 ? sizeRect.size.height : 20;
        viewHeight += titleH + 5;
    }
    
    if (model.content && model.content.length > 0) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:[UIFont boldSystemFontOfSize:14.0] forKey:NSFontAttributeName];
        CGRect sizeRect = [model.content boundingRectWithSize:CGSizeMake(viewWidth - 25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        NSInteger desH = sizeRect.size.height > 15 ? sizeRect.size.height : 15;
        desH = desH > 35 ? 35 : desH;
        viewHeight += desH + 5;
    }
    viewHeight += 15;
    
    return viewHeight;
}

@end
