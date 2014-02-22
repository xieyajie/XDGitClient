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

- (AFHTTPRequestOperation *)loginWithUserName:(NSString *)userName password:(NSString *)password success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient loginWithUserName:userName password:password success:^(id object) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:userName forKey:[NSString stringWithFormat:@"%@_%@_UserName", APPNAME, self.engineKey]];//最后一次成功登陆的用户名
        
        NSString *key = [NSString stringWithFormat:@"%@_%@_LoginName", APPNAME, self.engineKey];
        [defaults setValue:userName forKey:key];//当前账号的用户名
        
        key = [NSString stringWithFormat:@"%@_%@_LoginToken", APPNAME, self.engineKey];
        [defaults setValue:[NSString stringWithFormat:@"Basic %@", [[[NSString stringWithFormat:@"%@:%@", userName, password] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString]] forKey:key];//当前账号的token
        
        successBlock(object, NO);
    } failure:failureBlock];
}

#pragma mark - User

- (AFHTTPRequestOperation *)userWithSuccess:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:@"user" requestType:XDGitUserRequest responseType:XDGitUserResponse success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)user:(NSString *)userName success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@", userName] requestType:XDGitUserRequest responseType:XDGitUserResponse success:successBlock failure:failureBlock];
}

//
- (AFHTTPRequestOperation *)editUser:(NSDictionary *)userDictionary success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
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
- (AFHTTPRequestOperation *)followers:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (userName == nil || userName.length == 0) {
        return [self followersWithPage:page success:successBlock failure:failureBlock];
    }
    else{
        return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@/followers", userName] requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:1 success:successBlock failure:failureBlock];
    }
}

- (AFHTTPRequestOperation *)followersWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:@"user/followers" requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)followingWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [self following:_requestClient.userName page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)following:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (userName == nil || userName.length == 0)
    {
        return [self followingWithPage:page success:successBlock failure:failureBlock];
    }
    else{
        return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@/following", userName] requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:1 success:successBlock failure:failureBlock];
    }
}

#pragma mark - Fork

- (AFHTTPRequestOperation *)forkersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/forks", repositoryFullname] requestType:XDGitRepositoryForksRequest responseType:XDGitRepositoriesResponse page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)forkedWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:@"user/forks" requestType:XDGitUsersRequest responseType:XDGitUsersResponse page:page success:successBlock failure:failureBlock];
}

#pragma mark - Star

- (AFHTTPRequestOperation *)stargazersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/stargazers", repositoryFullname] requestType:XDGitUsersRequest responseType:XDGitUsersResponse page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)starredWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
     return [_requestClient sendRequestWithApiPath:@"user/starred" requestType:XDGitUsersRequest responseType:XDGitUsersResponse page:page success:successBlock failure:failureBlock];
}

#pragma mark Watching

- (AFHTTPRequestOperation *)watchersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/watchers", repositoryFullname] requestType:XDGitUsersRequest responseType:XDGitUsersResponse page:page success:successBlock failure:failureBlock];
}

#pragma mark - Repositories

- (AFHTTPRequestOperation *)repositoriesWithStyle:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (style == XDRepositoryStyleStars) {
        return [self starredWithPage:page success:successBlock failure:failureBlock];
    }
    else if (style == XDRepositoryStyleForks)
    {
        return [self forkedWithPage:page success:successBlock failure:failureBlock];
    }
    return [_requestClient sendRequestWithApiPath:@"user/repos" requestType:XDGitRepositoriesRequest responseType:XDGitRepositoriesResponse parameters:[self parametersWithRepositoryStyle:style] page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)repositoriesWithUser:(NSString *)userName style:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (userName == nil || userName.length == 0)
    {
        return [self repositoriesWithStyle:style includeWatched:watched page:page success:successBlock failure:failureBlock];
    }
    else{
        NSString *apiPath = [NSString stringWithFormat:@"users/%@/repos", userName];
        return [_requestClient sendRequestWithApiPath:apiPath requestType:XDGitRepositoriesRequest responseType:XDGitRepositoriesResponse parameters:[self parametersWithRepositoryStyle:style] page:page success:successBlock failure:failureBlock];
    }
}

- (AFHTTPRequestOperation *)repository:(NSString *)repositoryFullName success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@", repositoryFullName] requestType:XDGitRepositoryRequest responseType:XDGitRepositoryResponse success:successBlock failure:failureBlock];
}

#pragma mark - Gits
- (AFHTTPRequestOperation *)gistsWithStyle:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *apiPath = [NSString stringWithFormat:@"gists%@", [self typePathWithGitStyle:style]];
    return [_requestClient sendRequestWithApiPath:apiPath requestType:XDGitGistsRequest responseType:XDGitGistsResponse page:page success:successBlock failure:failureBlock];
}


- (AFHTTPRequestOperation *)gistsForUser:(NSString *)userName style:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (userName == nil || userName.length == 0)
    {
        return [self gistsWithStyle:style page:page success:successBlock failure:failureBlock];
    }
    else{
        NSString *apiPath = [NSString stringWithFormat:@"users/%@/gists", userName];
        return [_requestClient sendRequestWithApiPath:apiPath requestType:XDGitGistsRequest responseType:XDGitGistsResponse page:page success:successBlock failure:failureBlock];
    }
}

#pragma mark - Pull Request
- (AFHTTPRequestOperation *)pullRequestsForRepository:(NSString *)repositoryFullName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/pulls", repositoryFullName] requestType:XDGitPullRequestsRequest responseType:XDGitPullRequestsResponse page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)pullRequest:(NSString *)pullRequestId forRepository:(NSString *)repositoryFullName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (pullRequestId == nil || pullRequestId.length == 0) {
        return [self pullRequestsForRepository:repositoryFullName page:page success:successBlock failure:failureBlock];
    }
    
    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/pulls/%@", repositoryFullName, pullRequestId] requestType:XDGitPullRequestsRequest responseType:XDGitPullRequestsResponse page:page success:successBlock failure:failureBlock];
}

#pragma mark - private

- (NSMutableDictionary *)parametersWithRepositoryStyle:(XDRepositoryStyle)style
{
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSString *typeValue = @"";
    switch (style) {
        case XDRepositoryStyleAll:
            typeValue = @"all";
            break;
        case XDRepositoryStyleOwner:
            typeValue = @"owner";
            break;
        case XDRepositoryStyleMember:
            typeValue = @"member";
            break;
        case XDRepositoryStylePublic:
            typeValue = @"public";
            break;
        case XDRepositoryStylePrivate:
            typeValue = @"private";
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

- (NSString *)typePathWithGitStyle:(XDGitStyle)style
{
    NSString *typeValue = @"";
    switch (style) {
        case XDGitStyleAll:
            typeValue = @"";
            break;
        case XDGitStylePublic:
            typeValue = @"public";
            break;
        case XDGitStylePrivate:
            typeValue = @"private";
            break;
        case XDGitStyleStarred:
            typeValue = @"starred";
            break;
            
        default:
            break;
    }
    
    return typeValue;
}

@end
