//
//  XDGithubEngine.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGithubEngine.h"

#import "XDConfigManager.h"

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

- (AFHTTPRequestOperation *)loginWithUserName:(NSString *)userName password:(NSString *)password success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient loginWithUserName:userName password:password success:^(id object) {
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

- (AFHTTPRequestOperation *)userWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:@"user" requestType:XDGitUserRequest responseType:XDGitUserResponse success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)user:(NSString *)userName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@", userName] requestType:XDGitUserRequest responseType:XDGitUserResponse success:successBlock failure:failureBlock];
}

//
- (AFHTTPRequestOperation *)editUser:(NSDictionary *)userDictionary success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:@"user" requestType:XDGitUserEditRequest responseType:XDGitUserResponse parameters:userDictionary success:successBlock failure:failureBlock];
}

#pragma mark - Email
- (AFHTTPRequestOperation *)emailAddressesSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return nil;
}

- (AFHTTPRequestOperation *)addEmailAddresses:(NSArray *)emails success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return nil;
}

- (AFHTTPRequestOperation *)deleteEmailAddresses:(NSArray *)emails success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return nil;
}

#pragma mark - Follow
- (AFHTTPRequestOperation *)followers:(NSString *)userName page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@/followers", userName] requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:1 success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)followersWithPage:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:@"user/followers" requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)followingWithPage:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [self following:_requestClient.userName page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)following:(NSString *)userName page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@/following", userName] requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:1 success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)follows:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return nil;
}

- (AFHTTPRequestOperation *)follow:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return nil;
}

- (AFHTTPRequestOperation *)unfollow:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return nil;
}

#pragma mark - Repositories
- (AFHTTPRequestOperation *)repositoriesWithStyle:(XDProjectStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:@"user/repos" requestType:XDGitRepositoriesRequest responseType:XDGitRepositoriesResponse parameters:[self parametersWithProjectStyle:style] page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)repositoriesWithUser:(NSString *)userName style:(XDProjectStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *apiPath = [NSString stringWithFormat:@"users/%@/repos", userName];
    return [_requestClient sendRequestWithApiPath:apiPath requestType:XDGitRepositoriesRequest responseType:XDGitRepositoriesResponse parameters:[self parametersWithProjectStyle:style] page:page success:successBlock failure:failureBlock];
}

#pragma mark - private

- (NSMutableDictionary *)parametersWithProjectStyle:(XDProjectStyle)style
{
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSString *typeValue = @"";
    switch (style) {
        case XDProjectStyleAll:
            typeValue = @"all";
            break;
        case XDProjectStylePublic:
            typeValue = @"public";
            break;
        case XDProjectStylePrivate:
            typeValue = @"private";
            break;
        case XDProjectStyleForks:
            typeValue = @"owner";
            break;
        case XDProjectStyleContributed:
            typeValue = @"member";
            break;
            
        default:
            break;
    }
    if (typeValue.length > 0) {
        [resultDic setObject:typeValue forKey:@"type"];
        [resultDic setObject:[[XDConfigManager defaultManager] repositorySortName] forKey:@"sort"];
        [resultDic setObject:[[XDConfigManager defaultManager] repositorySortType] forKey:@"direction"];
    }
    
    return resultDic;
}

@end
