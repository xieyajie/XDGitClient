//
//  XDRepositoryCell.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDRepositoryCell.h"

#import "RepositoryModel.h"

@implementation XDRepositoryCell

//@synthesize model = _model;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:18.0];
        [self.contentView addSubview:_nameLabel];
        
        _desLabel = [[UILabel alloc] init];
        _desLabel.backgroundColor = [UIColor clearColor];
        _desLabel.numberOfLines = 0;
        _desLabel.font = [UIFont systemFontOfSize:14.0];
        _desLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
        [self.contentView addSubview:_desLabel];
        
        _updateLabel = [[UILabel alloc] init];
        _updateLabel.backgroundColor = [UIColor clearColor];
        _updateLabel.font = [UIFont systemFontOfSize:12.0];
        _updateLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_updateLabel];
        
        _starButton = [[UIButton alloc] init];
        _starButton.enabled = NO;
//        _starButton.backgroundColor = [UIColor redColor];
        _starButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _starButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        _starButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _starButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _starButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        [_starButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_starButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_starButton setImage:[UIImage imageNamed:@"star40"] forState:UIControlStateNormal];
        [_starButton setImage:[UIImage imageNamed:@"starred40"] forState:UIControlStateSelected];
        [_starButton addTarget:self action:@selector(starAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_starButton];

        _forkButton = [[UIButton alloc] init];
        _forkButton.enabled = NO;
//        _forkButton.backgroundColor = [UIColor greenColor];
        _forkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _forkButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        _forkButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _forkButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _forkButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        [_forkButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_forkButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_forkButton setImage:[UIImage imageNamed:@"fork40"] forState:UIControlStateNormal];
        [_forkButton setImage:[UIImage imageNamed:@"starred40"] forState:UIControlStateSelected];
        [_forkButton addTarget:self action:@selector(forkAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_forkButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewWidth = 320;
    CGFloat oY = 10;
    if (_model.name && _model.name.length > 0) {
        _nameLabel.frame = CGRectMake(10, oY, viewWidth - 20, 20);
        oY += 25;
    }
    else{
        _nameLabel.frame = CGRectZero;
    }
    
    if (_model.describe && _model.describe.length > 0) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:[UIFont boldSystemFontOfSize:14.0] forKey:NSFontAttributeName];
        CGRect sizeRect = [_model.describe boundingRectWithSize:CGSizeMake(viewWidth - 25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        CGFloat desH = sizeRect.size.height > 15 ? sizeRect.size.height : 15;
        _desLabel.frame = CGRectMake(15, oY, viewWidth - 25, desH);
        oY += desH + 5;
    }
    else{
        _desLabel.frame = CGRectZero;
    }
    
    _updateLabel.frame = CGRectMake(10, oY, viewWidth - 20, 15);
    oY += 20;
    _starButton.frame = CGRectMake(10, oY, 80, 20);
    _forkButton.frame = CGRectMake(10 + _starButton.frame.size.width + 10, oY, 80, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(id<XDModelProtocol>)model
{
    _model = model;
    _nameLabel.text = _model.name;
    _desLabel.text = _model.describe;
    _updateLabel.text = [NSString stringWithFormat:@"更新于：%@", _model.updatedDateDes];
    [_starButton setTitle:_model.starsCountDes forState:UIControlStateNormal];
    [_forkButton setTitle:_model.forksCountDes forState:UIControlStateNormal];
}

+ (CGFloat)heightWithModel:(RepositoryModel *)model
{
    CGFloat viewWidth = 320;
    CGFloat viewHeight = 60;
    if (model.name && model.name.length > 0) {
        viewHeight += 25;
    }
    
    if (model.describe && model.describe.length > 0) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:[UIFont boldSystemFontOfSize:14.0] forKey:NSFontAttributeName];
        CGRect sizeRect = [model.describe boundingRectWithSize:CGSizeMake(viewWidth - 25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        CGFloat desH = sizeRect.size.height > 15 ? sizeRect.size.height : 15;
        viewHeight += desH + 5;
    }

    return viewHeight;
}

#pragma mark - action

- (void)starAction
{
    _starButton.selected = !_starButton.selected;
}

- (void)forkAction
{
    
}

@end
