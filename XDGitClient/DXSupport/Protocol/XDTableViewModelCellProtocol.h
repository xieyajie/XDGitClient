//
//  XDTableViewModelCellProtocol.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DXModelProtocol.h"

@protocol XDTableViewModelCellProtocol <NSObject>

//@property (strong, nonatomic) id<XDModelProtocol> model;

@optional
+ (CGFloat)heightWithModel:(id<DXModelProtocol>)model;
+ (CGFloat)heightWithModel:(id<DXModelProtocol>)model accessoryType:(UITableViewCellAccessoryType)accessoryType;

@end
