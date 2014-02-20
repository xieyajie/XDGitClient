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
        _desLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_desLabel];
        
//        _starButton = [[UIButton alloc] init];
//        _starButton.backgroundColor = [UIColor grayColor];
//        _starButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [_starButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [_starButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        [_starButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_starButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
//        [_starButton addTarget:self action:@selector(starAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_starButton];
//        
//        _forkButton = [[UIButton alloc] init];
//        _forkButton.backgroundColor = [UIColor greenColor];
//        _forkButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        [_forkButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [_forkButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        [_forkButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_forkButton setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
//        [_forkButton addTarget:self action:@selector(forkAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_forkButton];
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
    
    if (_model.description && _model.description.length > 0) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:[UIFont boldSystemFontOfSize:14.0] forKey:NSFontAttributeName];
        CGRect sizeRect = [_model.description boundingRectWithSize:CGSizeMake(viewWidth - 25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        CGFloat desH = sizeRect.size.height > 15 ? sizeRect.size.height : 15;
        _desLabel.frame = CGRectMake(15, oY, viewWidth - 25, desH);
        oY += desH + 5;
    }
    else{
        _desLabel.frame = CGRectZero;
    }
    
//    _starButton.frame = CGRectMake(15, oY, 60, 30);
//    _forkButton.frame = CGRectMake(15 + _starButton.frame.size.width + 10, oY, 60, 30);
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
    _desLabel.text = _model.description;
//    [_starButton setTitle:_model.starsCountDes forState:UIControlStateNormal];
//    [_forkButton setTitle:_model.forksCountDes forState:UIControlStateNormal];
}

+ (CGFloat)heightWithModel:(RepositoryModel *)model
{
    CGFloat viewWidth = 320;
    CGFloat viewHeight = 20;
    if (model.name && model.name.length > 0) {
        viewHeight += 25;
    }
    
    if (model.description && model.description.length > 0) {
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:[UIFont boldSystemFontOfSize:14.0] forKey:NSFontAttributeName];
        CGRect sizeRect = [model.description boundingRectWithSize:CGSizeMake(viewWidth - 25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
        CGFloat desH = sizeRect.size.height > 15 ? sizeRect.size.height : 15;
        viewHeight += desH + 5;
    }

    return viewHeight;
}

#pragma mark - action

- (void)starAction
{
    
}

- (void)forkAction
{
    
}

@end
