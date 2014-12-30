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

#pragma mark - base

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


//- (AFHTTPRequestOperation *)editUser:(NSDictionary *)userDictionary success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    NSString *path = [NSString stringWithFormat:@"users/%@", userName];
//    AFHTTPRequestOperation *operation = [_operationManager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error);
//    }];
//    
//    return operation;
//    
//    return [_requestClient sendRequestWithApiPath:@"user" requestType:XDGitUserEditRequest responseType:XDGitUserResponse parameters:userDictionary success:successBlock failure:failureBlock];
//}

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

#pragma mark - Follow
- (AFHTTPRequestOperation *)followers:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (userName == nil || userName.length == 0) {
        return [self followersWithPage:page success:successBlock failure:failureBlock];
    }
    else{
        NSString *path = [NSString stringWithFormat:@"users/%@/followers?page=%d&per_page=%d", userName, page, KPERPAGENUMBER];
        AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
            successBlock(object, haveNextPage);
        } failure:^(NSError *error) {
            failureBlock(error);
        }];
        
        return operation;
    }
}

- (AFHTTPRequestOperation *)followersWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"user/followers?page=%d&per_page=%d", page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)followingWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"user/following?page=%d&per_page=%d", page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)following:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (userName == nil || userName.length == 0)
    {
        return [self followingWithPage:page success:successBlock failure:failureBlock];
    }
    else{
        NSString *path = [NSString stringWithFormat:@"users/%@/following?page=%d&per_page=%d", userName, page, KPERPAGENUMBER];
        AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
            successBlock(object, haveNextPage);
        } failure:^(NSError *error) {
            failureBlock(error);
        }];
        
        return operation;
    }
}

#pragma mark - Fork

- (AFHTTPRequestOperation *)forkersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"repos/%@/forks?page=%d&per_page=%d", repositoryFullname, page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)forkedWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"user/forks?page=%d&per_page=%d", page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

#pragma mark - Star

- (AFHTTPRequestOperation *)stargazersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"repos/%@/stargazers?page=%d&per_page=%d", repositoryFullname, page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

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

#pragma mark Watching

- (AFHTTPRequestOperation *)watchersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"repos/%@/watchers?page=%d&per_page=%d", repositoryFullname, page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

#pragma mark - Repositories

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
        else{
            return [self starredWithUserName:userName page:page success:successBlock failure:failureBlock];
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

- (AFHTTPRequestOperation *)repository:(NSString *)repositoryFullName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"repos/%@", repositoryFullName];
    AFHTTPRequestOperation *operation = [_operationManager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

#pragma mark - Gits
- (AFHTTPRequestOperation *)gistsWithStyle:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"gists%@", [self typePathWithGitStyle:style]];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}


- (AFHTTPRequestOperation *)gistsForUser:(NSString *)userName style:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (userName == nil || userName.length == 0)
    {
        return [self gistsWithStyle:style page:page success:successBlock failure:failureBlock];
    }
    else{
        NSString *path = [NSString stringWithFormat:@"users/%@/gists?page=%d&per_page=%d", userName, page, KPERPAGENUMBER];
        AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
            successBlock(object, haveNextPage);
        } failure:^(NSError *error) {
            failureBlock(error);
        }];
        
        return operation;
    }
}

#pragma mark - Events

- (AFHTTPRequestOperation *)allPublicEventsWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"events?page=%d&per_page=%d", page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)eventsForUsername:(NSString *)username page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *path = [NSString stringWithFormat:@"users/%@/received_events?page=%d&per_page=%d", username, page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
}

//- (AFHTTPRequestOperation *)eventsForIssue:(NSInteger)issueId forRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    
//}
//
//- (AFHTTPRequestOperation *)issueEventsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    
//}
//
//- (AFHTTPRequestOperation *)issueEvent:(NSInteger)eventId forRepository:(NSString*)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    
//}

#pragma mark - Notification

//- (AFHTTPRequestOperation *)notificationsWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    
//}
//
//- (AFHTTPRequestOperation *)notificationsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    
//}

#pragma mark - Pull Request
- (AFHTTPRequestOperation *)pullRequestsForRepository:(NSString *)repositoryFullName state:(XDPullRequestState)state page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    NSString *stateStr = state == XDPullRequestStateOpen ? @"open" : @"closed";
    NSString *path = [NSString stringWithFormat:@"repos/%@/pulls?state=%@&page=%d&per_page=%d", repositoryFullName, stateStr, page, KPERPAGENUMBER];
    AFHTTPRequestOperation *operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
        successBlock(object, haveNextPage);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
    return operation;
    
//    NSString *stateStr = state == XDPullRequestStateOpen ? @"open" : @"closed";
//    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/pulls?state=%@", repositoryFullName, stateStr] requestType:XDGitPullRequestsRequest responseType:XDGitPullRequestsResponse page:page success:successBlock failure:failureBlock];
}

- (AFHTTPRequestOperation *)pullRequest:(NSString *)pullRequestId forRepository:(NSString *)repositoryFullName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    AFHTTPRequestOperation *operation = nil;
    if (pullRequestId == nil || pullRequestId.length == 0) {
        operation = [self pullRequestsForRepository:repositoryFullName state:XDPullRequestStateOpen page:page success:successBlock failure:failureBlock];
    }
    else{
        NSString *path = [NSString stringWithFormat:@"repos/%@/pulls/%@?page=%d&per_page=%d", repositoryFullName, pullRequestId, page, KPERPAGENUMBER];
        operation = [self _requestWithPath:path page:page parameters:nil success:^(id object, BOOL haveNextPage) {
            successBlock(object, haveNextPage);
        } failure:^(NSError *error) {
            failureBlock(error);
        }];
    }
    
    return operation;
    
//    return [_requestClient sendRequestWithApiPath:[NSString stringWithFormat:@"repos/%@/pulls/%@", repositoryFullName, pullRequestId] requestType:XDGitPullRequestsRequest responseType:XDGitPullRequestsResponse page:page success:successBlock failure:failureBlock];
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
