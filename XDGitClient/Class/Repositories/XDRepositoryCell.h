//
//  XDRepositoryCell.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XDTableViewModelCellProtocol.h"

@class RepositoryModel;
@interface XDRepositoryCell : UITableViewCell<XDTableViewModelCellProtocol>
{
    UILabel *_nameLabel;
    UILabel *_desLabel;
    UILabel *_updateLabel;
    UIButton *_starButton;
    UIButton *_forkButton;
}

@property (strong, nonatomic) RepositoryModel *model;

@end
