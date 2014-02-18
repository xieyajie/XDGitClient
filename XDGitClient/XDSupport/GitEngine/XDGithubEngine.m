//
//  XDGithubEngine.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGithubEngine.h"

static id<XDGitEngineProtocol> defaultEngineInstance = nil;

@implementation XDGithubEngine

@synthesize apiDomain = _apiDomain;
@synthesize engineKey = _engineKey;

#pragma mark - config

- (id)init
{
    self = [super init];
    if (self) {
        _apiDomain = @"https://api.github.com";
        _engineKey = @"GitHub";
        _requestClient = [[XDGitRequestClient alloc] initWithBaseURL:[NSURL URLWithString:self.apiDomain]];
        
        [self didReset];
    }
    
    return self;
}

+ (id<XDGitEngineProtocol>)defaultEngine
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultEngineInstance = [[self alloc] init];
        });
    }
    return defaultEngineInstance;
}

- (void)didReset
{
    if (_requestClient) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *key = [NSString stringWithFormat:@"%@_%@_LoginToken", APPNAME, self.engineKey];
        _requestClient.token = [defaults objectForKey:key];
        key = [NSString stringWithFormat:@"%@_%@_LoginName", APPNAME, self.engineKey];
        _requestClient.userName = [defaults objectForKey:key];
    }
}

#pragma mark - login

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    [_requestClient loginWithUserName:userName password:password success:^(id object) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:userName forKey:[NSString stringWithFormat:@"%@_%@_UserName", APPNAME, self.engineKey]];//最后一次成功登陆的用户名
        
        NSString *key = [NSString stringWithFormat:@"%@_%@_LoginName", APPNAME, self.engineKey];
        [defaults setValue:userName forKey:key];//当前账号的用户名
        
        key = [NSString stringWithFormat:@"%@_%@_LoginToken", APPNAME, self.engineKey];
        [defaults setValue:[NSString stringWithFormat:@"Basic %@", [[[NSString stringWithFormat:@"%@:%@", userName, password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString]] forKey:key];//当前账号的token
        
        successBlock(object);
    } failure:failureBlock];
}

#pragma mark - User

- (void)userWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    [_requestClient sendRequestWithApiPath:@"user" requestType:XDGitUserRequest responseType:XDGitUserResponse success:successBlock failure:failureBlock];
}

- (void)user:(NSString *)userName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@", userName] requestType:XDGitUserRequest responseType:XDGitUserResponse success:successBlock failure:failureBlock];
}

//
- (void)editUser:(NSDictionary *)userDictionary success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    [_requestClient sendRequestWithApiPath:@"user" requestType:XDGitUserEditRequest responseType:XDGitUserResponse parameters:userDictionary success:successBlock failure:failureBlock];
}

#pragma mark - Email
- (void)emailAddressesSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    
}

- (void)addEmailAddresses:(NSArray *)emails success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    
}

- (void)deleteEmailAddresses:(NSArray *)emails success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    
}

#pragma mark - Follow
- (void)followers:(NSString *)userName page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@/followers", userName] requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:1 success:successBlock failure:failureBlock];
}

- (void)followersWithPage:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    [_requestClient sendRequestWithApiPath:@"user/followers" requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:page success:successBlock failure:failureBlock];
}

- (void)followingWithPage:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    [self following:_requestClient.userName page:page success:successBlock failure:failureBlock];
}

- (void)following:(NSString *)userName page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@/following", userName] requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:1 success:successBlock failure:failureBlock];
}

- (void)follows:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    
}

- (void)follow:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    
}

- (void)unfollow:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    
}

#pragma mark - Repositories
- (void)repositoriesWithStyle:(XDProjectStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *apiPath = [NSString stringWithFormat:@"%@%@", @"user/repos", [self apiPathWithProjectStyle:style]];
    [_requestClient sendRequestWithApiPath:apiPath requestType:XDGitRepositoriesRequest responseType:XDGitRepositoriesResponse page:page success:successBlock failure:failureBlock];
}

- (void)repositoriesWithUser:(NSString *)userName style:(XDProjectStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *apiPath = [NSString stringWithFormat:@"users/%@/repos%@", userName, [self apiPathWithProjectStyle:style]];
    [_requestClient sendRequestWithApiPath:apiPath requestType:XDGitRepositoriesRequest responseType:XDGitRepositoriesResponse page:page success:successBlock failure:failureBlock];
}

#pragma mark - private

- (NSString *)apiPathWithProjectStyle:(XDProjectStyle)style
{
    switch (style) {
        case XDProjectStyleAll:
            return @"";
            break;
        case XDProjectStylePublic:
            return @"?type=public";
            break;
        case XDProjectStylePrivate:
            return @"?type=private";
            break;
        case XDProjectStyleForks:
            return @"?type=owner";
            break;
        case XDProjectStyleContributed:
            return @"?type=member";
            break;
            
        default:
            break;
    }
    return @"";
}

@end
