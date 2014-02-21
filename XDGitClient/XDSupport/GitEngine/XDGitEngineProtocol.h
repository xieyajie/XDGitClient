//
//  XDGitEngineProtocol.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XDLocalDefine.h"

@protocol XDGitEngineProtocol <NSObject>

@property (strong, nonatomic) NSString *engineKey;
@property (strong, nonatomic) NSString *apiDomain;

#pragma mark - config
+ (id<XDGitEngineProtocol>)defaultEngine;
- (void)didReset;

#pragma mark - base request
- (AFHTTPRequestOperation *)sendRequestWithPath:(NSString *)path parameters:(id)parameters page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - login
- (AFHTTPRequestOperation *)loginWithUserName:(NSString *)userName password:(NSString *)password success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

//没有userName参数的默认是当前登录用户，需要将登录用户的Token传到request的header中
//page = 0，不需要分页获取

#pragma mark - User
- (AFHTTPRequestOperation *)userWithSuccess:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)user:(NSString *)userName success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)editUser:(NSDictionary *)userDictionary success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Email
//- (AFHTTPRequestOperation *)emailAddressesSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)addEmailAddresses:(NSArray *)emails success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)deleteEmailAddresses:(NSArray *)emails success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Repositories
- (AFHTTPRequestOperation *)repositoriesWithStyle:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)repositoriesWithUser:(NSString *)userName style:(XDRepositoryStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

- (AFHTTPRequestOperation *)createRepositoryWithInfo:(NSDictionary *)infoDictionary success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)updateRepository:(NSString *)repositoryPath withInfo:(NSDictionary *)infoDictionary success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;


//- (void)contributorsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (void)languageBreakdownForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (void)teamsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (void)annotatedTagsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (void)branchesForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Gits
- (AFHTTPRequestOperation *)gistsWithStyle:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)gistsForUser:(NSString *)userName style:(XDGitStyle)style page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)publicGistsWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)gist:(NSString *)gistId success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//
//- (AFHTTPRequestOperation *)starredGistsWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)gistIsStarred:(NSString *)gistId success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//
//- (AFHTTPRequestOperation *)createGist:(NSDictionary *)gistDictionary success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)editGist:(NSString *)gistId withDictionary:(NSDictionary *)gistDictionary success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)starGist:(NSString *)gistId success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)unstarGist:(NSString *)gistId success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)forkGist:(NSString *)gistId success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)deleteGist:(NSString *)gistId success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Events

//- (void)eventsForIssue:(NSInteger)issueId forRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (void)issueEventsForRepository:(NSString *)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (void)issueEvent:(NSInteger)eventId forRepository:(NSString*)repositoryPath success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

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

#pragma mark - Follow
- (AFHTTPRequestOperation *)followers:(NSString *)user page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)followersWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)followingWithPage:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (AFHTTPRequestOperation *)following:(NSString *)userName page:(NSInteger)page success:(XDGitEnginePageSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

//- (AFHTTPRequestOperation *)follows:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)follow:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
//- (AFHTTPRequestOperation *)unfollow:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

@end
