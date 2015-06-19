//
//  DXLoadingView.h
//  DXStudio
//
//  Created by dhcdht on 14-2-18.
//  Copyright (c) 2014年 DXStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXLoadingView : UIView

@property (strong, nonatomic) AFHTTPRequestOperation *requestOperation;
@property (strong, nonatomic) id target;
@property (strong, nonatomic) NSString *title;

- (id)initWithTitle:(NSString *)title;
- (id)initWithRequestOperation:(AFHTTPRequestOperation *)requestOperation title:(NSString *)title;

- (void)start;
- (void)stop;

@end
