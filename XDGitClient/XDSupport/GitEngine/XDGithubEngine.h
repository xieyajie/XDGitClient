//
//  XDGithubEngine.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XDLocalDefine.h"

typedef enum{
    XDRequestMothodGet,
    XDRequestMothodPost,
    XDRequestMothodDelete,
}XDRequestMothod;

@interface XDGithubEngine : NSObject
{
    AFHTTPRequestOperationManager *_operationManager;
}

@property (strong, nonatomic) NSString *engineKey;
@property (strong, nonatomic) NSString *apiDomain;

@property (strong, nonatomic) NSString *token;
@property (nonatomic) BOOL isMultiPageRequest;
//@property (strong, nonatomic) NSURL *nextPageURL;
//@property (strong, nonatomic) NSURL *lastPageURL;
//@property (strong, nonatomic) NSMutableArray *multiPageArray;

#pragma mark - public
+ (instancetype)shareEngine;

#pragma mark - login
- (NSString *)requestPathForOauth;
- (NSURLSessionDataTask *)fetchTokenWithUsername:(NSString *)username password:(NSString *)password code:(NSString *)code success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

//没有userName参数的默认是当前登录用户，需要将登录用户的Token传到request的header中
//page = 0，不需要分页获取

#pragma mark - User
- (AFHTTPRequestOperation *)userWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)user:(NSString *)userName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Repositories
- (AFHTTPRequestOperation *)repositoriesWithStyle:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)repositoriesWithUser:(NSString *)userName style:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

//单个repo操作
- (AFHTTPRequestOperation *)repository:(NSString *)repositoryFullName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Gits
- (AFHTTPRequestOperation *)gistsWithStyle:(XDGitStyle)style page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)gistsForUser:(NSString *)userName style:(XDGitStyle)style page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Events

- (AFHTTPRequestOperation *)allPublicEventsWithPage:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)eventsForUsername:(NSString *)username page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)eventsForIssue:(NSInteger)issueId forRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Issue

- (AFHTTPRequestOperation *)issueEventsWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)issueEventsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)issueEvent:(NSInteger)eventId forRepository:(NSString*)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Notification

- (AFHTTPRequestOperation *)notificationsWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)notificationsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Pull Request
- (AFHTTPRequestOperation *)pullRequestsForRepository:(NSString *)repositoryFullName state:(XDPullRequestState)state page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)pullRequest:(NSString *)pullRequestId forRepository:(NSString *)repositoryFullName page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Follow
- (AFHTTPRequestOperation *)followers:(NSString *)user page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)followersWithPage:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)followingWithPage:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)following:(NSString *)userName page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Fork
- (AFHTTPRequestOperation *)forkersForRepository:(NSString *)repositoryFullname page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)forkedWithPage:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Star
- (AFHTTPRequestOperation *)stargazersForRepository:(NSString *)repositoryFullname page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)starredWithPage:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark Watching
- (AFHTTPRequestOperation *)watchersForRepository:(NSString *)repositoryFullname page:(int)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Read Me
- (AFHTTPRequestOperation *)readmeForRepository:(NSString *)repositoryFullName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

- (AFHTTPRequestOperation *)sourceForRepository:(NSString *)repositoryFullName filePath:(NSString *)filePath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - 通用

- (AFHTTPRequestOperation *)requestWithPath:(NSString *)path mothod:(XDRequestMothod)mothod headers:(NSDictionary *)headers parameters:(NSDictionary *)parameters success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

@end
