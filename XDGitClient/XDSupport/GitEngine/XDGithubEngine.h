//
//  XDGithubEngine.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XDLocalDefine.h"

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
//- (void)didReset;

#pragma mark - login
- (NSString *)requestPathForOauth;
- (NSURLSessionDataTask *)fetchTokenWithUsername:(NSString *)username password:(NSString *)password code:(NSString *)code success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

//没有userName参数的默认是当前登录用户，需要将登录用户的Token传到request的header中
//page = 0，不需要分页获取

#pragma mark - User
- (AFHTTPRequestOperation *)userWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)user:(NSString *)userName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Repositories
- (AFHTTPRequestOperation *)repositoriesWithStyle:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)repositoriesWithUser:(NSString *)userName style:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

//单个repo操作
- (AFHTTPRequestOperation *)repository:(NSString *)repositoryFullName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Gits
- (AFHTTPRequestOperation *)gistsWithStyle:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)gistsForUser:(NSString *)userName style:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Events

- (AFHTTPRequestOperation *)eventsForIssue:(NSInteger)issueId forRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)issueEventsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)issueEvent:(NSInteger)eventId forRepository:(NSString*)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Notification

- (AFHTTPRequestOperation *)notificationsWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)notificationsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Pull Request
- (AFHTTPRequestOperation *)pullRequestsForRepository:(NSString *)repositoryFullName state:(XDPullRequestState)state page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)pullRequest:(NSString *)pullRequestId forRepository:(NSString *)repositoryFullName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Follow
- (AFHTTPRequestOperation *)followers:(NSString *)user page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)followersWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)followingWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)following:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Fork
- (AFHTTPRequestOperation *)forkersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)forkedWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Star
- (AFHTTPRequestOperation *)stargazersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)starredWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark Watching
- (AFHTTPRequestOperation *)watchersForRepository:(NSString *)repositoryFullname page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

@end
