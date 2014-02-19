//
//  XDLoadingView.m
//  XDGitClient
//
//  Created by dhcdht on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDLoadingView.h"

#import "XDActivityIndicatorView.h"

#define KTIWidth 150
#define KIndicatorHeight 35
#define KTitleHeight 35
#define KButtonHeight 30

@interface XDLoadingView()

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) XDActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UIButton *cancleButton;
@property (strong, nonatomic) UIButton * backgroundButton;

@end

@implementation XDLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0.6f alpha:0.7f];
        [self addSubview:self.loadingView];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    self = [self initWithFrame:rect];
    if (self) {
        self.title = title;
        [self addSubview:self.loadingView];
    }
    
    return self;
}

- (id)initWithRequestOperation:(AFHTTPRequestOperation *)requestOperation title:(NSString *)title
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    self = [self initWithFrame:rect];
    if (self) {
        self.requestOperation = requestOperation;
        self.title = title;
        [self addSubview:self.loadingView];
    }
    
    return self;
}

//- (id)initWithTarget:(id)target requestOperation:(AFHTTPRequestOperation *)requestOperation title:(NSString *)title
//{
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    self = [self initWithFrame:rect];
//    if (self) {
//        self.target = target;
//        self.requestOperation = requestOperation;
//        self.title = title;
//        [self addSubview:self.loadingView];
//    }
//    
//    return self;
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewHeight = KIndicatorHeight + KButtonHeight;
    CGFloat viewWidth = KTIWidth;
    
    if (_title && _title.length > 0) {
        viewHeight += KTitleHeight;
        _titleLabel.frame = CGRectMake(5, 0, viewWidth - 10, KTitleHeight);
    }
    else{
        _titleLabel.frame = CGRectZero;
    }
    _activityIndicatorView.frame = CGRectMake(5, _titleLabel.frame.size.height, viewWidth - 10, KIndicatorHeight);
    
    if (_requestOperation && ![_requestOperation isFinished] && ![_requestOperation isCancelled]) {
        _loadingView.frame = CGRectMake((self.frame.size.width - viewWidth) / 2, (self.frame.size.height - viewHeight) / 2, viewWidth, viewHeight);
        _backgroundButton.frame = CGRectMake(0, _loadingView.frame.size.height - 30, (_loadingView.frame.size.width - 10) / 2, KButtonHeight);
        _cancleButton.frame = CGRectMake(_backgroundButton.frame.size.width + 10, _loadingView.frame.size.height - 30, (_loadingView.frame.size.width - 10) / 2, KButtonHeight);
    }
    else{
        _loadingView.frame = CGRectMake((self.frame.size.width - viewWidth) / 2, (self.frame.size.height - viewHeight) / 2, viewWidth, viewHeight);
        _backgroundButton.frame = CGRectZero;
        _cancleButton.frame = CGRectMake(10, _loadingView.frame.size.height - 30, _loadingView.frame.size.width - 20, KButtonHeight);
    }
}

#pragma mark - getter

- (UIView *)loadingView
{
    if (_loadingView == nil) {
        _loadingView = [[UIView alloc] init];
        
        if (_activityIndicatorView == nil) {
            _activityIndicatorView = [[XDActivityIndicatorView alloc] initWithFrame:CGRectMake(5, 0, KTIWidth - 10, KIndicatorHeight) ballColor:[UIColor colorWithRed:0.47 green:0.60 blue:0.89 alpha:1]];
            [_loadingView addSubview:_activityIndicatorView];
        }
        
        if (_cancleButton == nil) {
            _cancleButton = [[UIButton alloc] init];
            _cancleButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [_cancleButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
            [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
            [_cancleButton setBackgroundImage:[[UIImage imageNamed:@"button_bg_red"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
            [_loadingView addSubview:_cancleButton];
        }
    }
    
    if (_title && _title.length > 0) {
        _titleLabel.text = _title;
    }
    return _loadingView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.loadingView addSubview:_titleLabel];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    
    return _titleLabel;
}

- (UIButton *)backgroundButton
{
    if (_backgroundButton == nil) {
        _backgroundButton = [[UIButton alloc] init];
        _backgroundButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_backgroundButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backgroundButton addTarget:self action:@selector(backgroundRunAction) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundButton setTitle:@"后台申请" forState:UIControlStateNormal];
        [_backgroundButton setBackgroundImage:[[UIImage imageNamed:@"button_bg_green"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [self.loadingView addSubview:_backgroundButton];
    }
    
    return _backgroundButton;
}

#pragma mark - setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (_title && _title.length > 0) {
        self.titleLabel.text = _title;
    }
}

- (void)setRequestOperation:(AFHTTPRequestOperation *)requestOperation
{
    if (requestOperation && _requestOperation != requestOperation) {
        if (![_requestOperation isFinished] || ![_requestOperation isCancelled]) {
            [_requestOperation cancel];
        }
        
        [self backgroundButton];
        _requestOperation = requestOperation;
    }
}

- (void)setTarget:(id)target
{
    
}

#pragma mark - action

- (void)cancelAction
{
    [_requestOperation cancel];
    [self stop];
    
    [self removeFromSuperview];
}

- (void)backgroundRunAction
{
    [self stop];
    
    [self removeFromSuperview];
}

#pragma mark - public

- (void)start
{
    [_activityIndicatorView stopAnimating];
    [_activityIndicatorView startAnimating];
}

- (void)stop
{
    _title = nil;
    _requestOperation = nil;
    [_activityIndicatorView stopAnimating];
}

@end
