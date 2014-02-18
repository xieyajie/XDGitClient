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

#pragma mark - login
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

//没有userName参数的默认是当前登录用户，需要将登录用户的Token传到request的header中
//page = 0，不需要分页获取

#pragma mark - User
- (void)userWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)user:(NSString *)userName success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)editUser:(NSDictionary *)userDictionary success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Email
- (void)emailAddressesSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)addEmailAddresses:(NSArray *)emails success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)deleteEmailAddresses:(NSArray *)emails success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Follow
- (void)followers:(NSString *)user page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)followersWithPage:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)followingWithPage:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)following:(NSString *)userName page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)follows:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)follow:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)unfollow:(NSString *)userName success:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - Repositories
- (void)repositoriesWithStyle:(XDProjectStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;
- (void)repositoriesWithUser:(NSString *)userName style:(XDProjectStyle)style includeWatched:(BOOL)watched page:(NSInteger)page success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

@end
