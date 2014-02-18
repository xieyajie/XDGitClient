//
//  XDGitRequestClient.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "XDGitEngineRequestTypes.h"
#import "NSData+Category.h"

@interface XDGitRequestClient : AFHTTPClient

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *token;

@property BOOL isMultiPageRequest;
@property (strong, nonatomic) NSURL *nextPageURL;
@property (strong, nonatomic) NSURL *lastPageURL;
@property (strong, nonatomic) NSMutableArray *multiPageArray;

#pragma mark - send request
- (void)requestWithURLRequest:(NSMutableURLRequest *)urlRequest
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)sendRequestWithApiPath:(NSString *)apiPath
                   requestType:(XDGitRequestType)requestType
                  responseType:(XDGitResponseType)responseType
                    parameters:(id)parameters
                          page:(NSInteger)page
                       success:(XDGitEngineSuccessBlock)successBlock
                       failure:(XDGitEngineFailureBlock)failureBlock;

- (void)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
              parameters:(id)parameters
                     success:(XDGitEngineSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock;

- (void)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
                        page:(NSInteger)page
                     success:(XDGitEngineSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock;

- (void)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
                     success:(XDGitEngineSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - login
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;


@end
