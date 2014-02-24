//
//  XDPullRequestCell.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-24.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XDTableViewModelCellProtocol.h"

@class PullRequestModel;
@interface XDPullRequestCell : UITableViewCell<XDTableViewModelCellProtocol>

@property (strong, nonatomic) UIImageView *headerImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *updateLabel;

@property (strong, nonatomic) PullRequestModel *model;

@end
