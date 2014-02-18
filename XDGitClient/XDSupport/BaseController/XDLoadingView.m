//
//  XDLoadingView.m
//  XDGitClient
//
//  Created by dhcdht on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDLoadingView.h"

@interface XDLoadingView()

@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UIButton *cancleButton;
@property (strong, nonatomic) UIButton * backgroundButton;

@end

@implementation XDLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0.6f alpha:0.6f];
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

- (id)initWithTarget:(id)target requestOperation:(AFHTTPRequestOperation *)requestOperation title:(NSString *)title
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    self = [self initWithFrame:rect];
    if (self) {
        self.target = target;
        self.requestOperation = requestOperation;
        self.title = title;
        [self addSubview:self.loadingView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = 0;
    if (_requestOperation && ![_requestOperation isFinished] && ![_requestOperation isCancelled]) {
        _loadingView.frame = CGRectMake((self.frame.size.width - 150) / 2, (self.frame.size.height - 100) / 2, 100, 60);
        _backgroundButton.frame = CGRectMake(0, _loadingView.frame.size.height / 2 + 1, _loadingView.frame.size.width, _loadingView.frame.size.height / 2 - 1);
        height = _loadingView.frame.size.height / 2;
    }
    else{
        _loadingView.frame = CGRectMake((self.frame.size.width - 150) / 2, (self.frame.size.height - 100) / 2, 100, 30);
        _backgroundButton.frame = CGRectZero;
        height = _loadingView.frame.size.height;
    }
    
    CGFloat oX = 10;
    if (_title && _title.length > 0) {
        _titleLabel.frame = CGRectMake(oX, 0, _loadingView.frame.size.width - height - 20, height);
        oX = _titleLabel.frame.size.width;
    }
    else{
        _titleLabel.frame = CGRectZero;
    }
    
    _activityIndicatorView.frame = CGRectMake(oX, 0, _loadingView.frame.size.width - height - oX - 1, height);
    oX += _activityIndicatorView.frame.size.width;
    _cancleButton.frame = CGRectMake(oX, 0, height, height);
}

#pragma mark - getter

- (UIView *)loadingView
{
    if (_loadingView == nil) {
        _loadingView = [[UIView alloc] init];
        _loadingView.backgroundColor = [UIColor redColor];
//        _loadingView.center = _loadingView.center;
//        _loadingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
//        _loadingView.layer.cornerRadius = 6.0;
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_loadingView addSubview:_activityIndicatorView];
        
        _cancleButton = [[UIButton alloc] init];
        [_cancleButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchDragInside];
        [_cancleButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_loadingView addSubview:_cancleButton];
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
        [self.loadingView addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (UIButton *)backgroundButton
{
    if (_backgroundButton == nil) {
        _backgroundButton = [[UIButton alloc] init];
        _backgroundButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_backgroundButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backgroundButton addTarget:self action:@selector(backgroundRunAction) forControlEvents:UIControlEventTouchDragInside];
        [_backgroundButton setTitle:@"后台运行" forState:UIControlStateNormal];
        [_backgroundButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
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
    [_activityIndicatorView startAnimating];
}

- (void)stop
{
    _title = nil;
    _requestOperation = nil;
    [_activityIndicatorView stopAnimating];
}

@end
