//
//  XDGithubEngine.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGithubEngine.h"

#import "XDConfigManager.h"

#define KCLIENTID @"dd15c5320bd70c217be5"
#define KCLIENTSECRET @"2428107df510240815de4cba7795e779894889d5"
static NSString * const kAccessTokenRegexPattern = @"access_token=([^&]+)";

static XDGithubEngine *engineInstance = nil;

@implementation XDGithubEngine

@synthesize apiDomain = _apiDomain;
@synthesize engineKey = _engineKey;

@synthesize token = _token;
@synthesize isMultiPageRequest = _isMultiPageRequest;

#pragma mark - pblic

- (id)init
{
    self = [super init];
    if (self) {
        _apiDomain = @"https://api.github.com";
        _engineKey = @"GitHub";
        
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.apiDomain]];
        _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

+ (instancetype)shareEngine
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            engineInstance = [[XDGithubEngine alloc] init];
        });
    }
    return engineInstance;
}

- (void)didReset
{
//    if (_requestClient) {
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSString *key = [NSString stringWithFormat:@"%@_%@_LoginToken", APPNAME, self.engineKey];
//        _requestClient.token = [defaults objectForKey:key];
//        key = [NSString stringWithFormat:@"%@_%@_LoginName", APPNAME, self.engineKey];
//        _requestClient.userName = [defaults objectForKey:key];
//    }
}

- (void)setToken:(NSString *)token
{
    if ([token length] > 0) {
        [_operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
    else{
       [_operationManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
}

#pragma mark - login

- (NSString *)_accessTokenFromString:(NSString *)string
{
    __block NSString *accessToken = nil;
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kAccessTokenRegexPattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    
    if (!error && [matches count] > 0) {
        
        [matches enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSRange matchRange = [(NSTextCheckingResult *)obj rangeAtIndex:1];
            accessToken = [string substringWithRange:matchRange];
            
        }];
    }
    
    return accessToken;
}

- (NSString *)requestPathForOauth
{
    NSString *path = [NSString stringWithFormat:@"https://github.com/login/oauth/authorize?client_id=%@&scope=%@",KCLIENTID, @"email,user"];
    
    return path;
}

- (NSURLSessionDataTask *)fetchTokenWithUsername:(NSString *)username password:(NSString *)password code:(NSString *)code success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
//    NSString *path = @"https://github.com/login/oauth/access_token";
//    NSDictionary *parameters = @{@"client_id":KCLIENTID, @"client_secret":KCLIENTSECRET, @"code":code};
//
//    _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    AFHTTPRequestOperation *operation = [_operationManager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *token = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        successBlock(token);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error);
//    }];
    
    NSString *requestString = [NSString stringWithFormat:@"https://github.com/login/oauth/access_token?client_id=%@&client_secret=%@&code=%@", KCLIENTID, KCLIENTSECRET, code];
    NSURLSessionConfiguration *sessionConficuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConficuration];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:requestString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSString *token = [self _accessTokenFromString:dataStr];
            [self setToken:token];
            successBlock(token);
        }
        else{
            failureBlock(error);
        }
    }];
    [task resume];
    
    return nil;
}

#pragma mark - User

- (AFHTTPRequestOperation *)userWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    AFHTTPRequestOperation *operation = [_operationManager GET:@"user" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)user:(NSString *)userName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"users/%@", userName];
    AFHTTPRequestOperation *operation = [_operationManager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

//
//- (AFHTTPRequestOperation *)editUser:(NSDictionary *)userDictionary success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return [_requestClient sendRequestWithApiPath:@"user" requestType:XDGitUserEditRequest responseType:XDGitUserResponse parameters:userDictionary success:successBlock failure:failureBlock];
//}
//
//#pragma mark - Email
//- (AFHTTPRequestOperation *)emailAddressesSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return nil;
//}
//
//- (AFHTTPRequestOperation *)addEmailAddresses:(NSArray *)emails success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return nil;
//}
//
//- (AFHTTPRequestOperation *)deleteEmailAddresses:(NSArray *)emails success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return nil;
//}
//
//#pragma mark - Follow
//- (AFHTTPRequestOperation *)followers:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    if (userName == nil || userName.length == 0) {
//        return [self followersWithPage:page success:successBlock failure:failureBlock];
//    }
//    else{
//        return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@/followers", userName] requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:1 success:successBlock failure:failureBlock];
//    }
//}
//
//- (AFHTTPRequestOperation *)followersWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return [_requestClient sendRequestWithApiPath:@"user/followers" requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:page success:successBlock failure:failureBlock];
//}
//
//- (AFHTTPRequestOperation *)followingWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return [self following:_requestClient.userName page:page success:successBlock failure:failureBlock];
//}
//
//- (AFHTTPRequestOperation *)following:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    if (userName == nil || userName.length == 0)
//    {
//        return [self followingWithPage:page success:successBlock failure:failureBlock];
//    }
//    else{
//        return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"users/%@/following", userName] requestType:XDGitUserRequest responseType:XDGitFollowersResponse page:1 success:successBlock failure:failureBlock];
//    }
//}
//
//#pragma mark - Fork
//
//- (AFHTTPRequestOperation *)forkersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/forks", repositoryFullname] requestType:XDGitRepositoryForksRequest responseType:XDGitRepositoriesResponse page:page success:successBlock failure:failureBlock];
//}
//
//- (AFHTTPRequestOperation *)forkedWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return [_requestClient sendRequestWithApiPath:@"user/forks" requestType:XDGitUsersRequest responseType:XDGitUsersResponse page:page success:successBlock failure:failureBlock];
//}

#pragma mark - Star

//- (AFHTTPRequestOperation *)stargazersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/stargazers", repositoryFullname] requestType:XDGitUsersRequest responseType:XDGitUsersResponse page:page success:successBlock failure:failureBlock];
//}

- (AFHTTPRequestOperation *)starredWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"user/starred?page=%d&per_page=%d", page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)starredWithUserName:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"users/%@/starred?page=%d&per_page=%d", userName, page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

//#pragma mark Watching
//
//- (AFHTTPRequestOperation *)watchersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/watchers", repositoryFullname] requestType:XDGitUsersRequest responseType:XDGitUsersResponse page:page success:successBlock failure:failureBlock];
//}

#pragma mark - Repositories

- (AFHTTPRequestOperation *)_requestWithPath:(NSString *)path page:(NSInteger)page parameters:(id)parameters success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    AFHTTPRequestOperation *operation = [_operationManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[[operation.response allHeaderFields] allKeys] containsObject:@"Link"] && page > 0)
        {
            NSString *linkHeader = [[operation.response allHeaderFields] valueForKey:@"Link"];
            NSArray *links = [linkHeader componentsSeparatedByString:@","];
            //                self.nextPageURL = nil;
            NSURL * __block blockURL = nil;
            [links enumerateObjectsUsingBlock:^(NSString *link, NSUInteger idx, BOOL *stop) {
                NSString *rel = [[link componentsSeparatedByString:@";"][1] componentsSeparatedByString:@"\""][1];
                if ([rel isEqualToString:@"next"])
                {
                    blockURL = [NSURL URLWithString:[[link componentsSeparatedByString:@";"][0] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]];
                    *stop = YES;
                }
            }];
            //                self.nextPageURL = blockURL;
            BOOL haveNext = blockURL == nil ? NO : YES;
            successBlock(responseObject, haveNext);
        }
        else{
            successBlock(responseObject, NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)repositoriesWithStyle:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (style == XDRepositoryStyleStars) {
        return [self starredWithPage:page success:successBlock failure:failureBlock];
    }
    else{
        NSString *path = [NSString stringWithFormat:@"user/repos?page=%d&per_page=%d", page, KPERPAGENUMBER];
        NSDictionary *parameters = [self parametersWithRepositoryStyle:style];
        AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:parameters success:^(id object, BOOL haveNextPage) {
            successBlock(object, haveNextPage);
        } failure:^(NSError *error) {
            failureBlock(error);
        }];
        
        return operation;
    }
}

- (AFHTTPRequestOperation *)repositoriesWithUser:(NSString *)userName style:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (style == XDRepositoryStyleStars)
    {
        if (userName == nil || userName.length == 0)
        {
            return [self starredWithPage:page success:successBlock failure:failureBlock];
        }
    }
    else
    {
        if (userName == nil || userName.length == 0)
        {
            return [self repositoriesWithStyle:style includeWatched:watched page:page success:successBlock failure:failureBlock];
        }
        else{
            NSString *path = [NSString stringWithFormat:@"users/%@/repos?page=%d&per_page=%d", userName, page, KPERPAGENUMBER];
            NSDictionary *parameters = [self parametersWithRepositoryStyle:style];
            AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:parameters success:^(id object, BOOL haveNextPage) {
                successBlock(object, haveNextPage);
            } failure:^(NSError *error) {
                failureBlock(error);
            }];
            
            return operation;
        }
    }
    
    return nil;
}

//- (AFHTTPRequestOperation *)repository:(NSString *)repositoryFullName success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@", repositoryFullName] requestType:XDGitRepositoryRequest responseType:XDGitRepositoryResponse success:successBlock failure:failureBlock];
//}
//
//#pragma mark - Gits
//- (AFHTTPRequestOperation *)gistsWithStyle:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    NSString *apiPath = [NSString stringWithFormat:@"gists%@", [self typePathWithGitStyle:style]];
//    return [_requestClient sendRequestWithApiPath:apiPath requestType:XDGitGistsRequest responseType:XDGitGistsResponse page:page success:successBlock failure:failureBlock];
//}
//
//
//- (AFHTTPRequestOperation *)gistsForUser:(NSString *)userName style:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    if (userName == nil || userName.length == 0)
//    {
//        return [self gistsWithStyle:style page:page success:successBlock failure:failureBlock];
//    }
//    else{
//        NSString *apiPath = [NSString stringWithFormat:@"users/%@/gists", userName];
//        return [_requestClient sendRequestWithApiPath:apiPath requestType:XDGitGistsRequest responseType:XDGitGistsResponse page:page success:successBlock failure:failureBlock];
//    }
//}
//
//#pragma mark - Pull Request
//- (AFHTTPRequestOperation *)pullRequestsForRepository:(NSString *)repositoryFullName state:(XDPullRequestState)state page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    NSString *stateStr = state == XDPullRequestStateOpen ? @"open" : @"closed";
//    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/pulls?state=%@", repositoryFullName, stateStr] requestType:XDGitPullRequestsRequest responseType:XDGitPullRequestsResponse page:page success:successBlock failure:failureBlock];
//}
//
//- (AFHTTPRequestOperation *)pullRequest:(NSString *)pullRequestId forRepository:(NSString *)repositoryFullName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    if (pullRequestId == nil || pullRequestId.length == 0) {
//        return [self pullRequestsForRepository:repositoryFullName state:XDPullRequestStateOpen page:page success:successBlock failure:failureBlock];
//    }
//    
//    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/pulls/%@", repositoryFullName, pullRequestId] requestType:XDGitPullRequestsRequest responseType:XDGitPullRequestsResponse page:page success:successBlock failure:failureBlock];
//}

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
        XDConfigManager *configManager = [XDConfigManager defaultManager];
        [resultDic setObject:typeValue forKey:@"type"];
        [resultDic setObject:configManager.appConfig.repositorySortName forKey:@"sort"];
        [resultDic setObject:configManager.appConfig.repositorySortType forKey:@"direction"];
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
