//
//  XDGitRequestClient.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

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
- (AFHTTPRequestOperation *)requestWithURLRequest:(NSMutableURLRequest *)urlRequest
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)sendRequestWithApiPath:(NSString *)apiPath
                   requestType:(XDGitRequestType)requestType
                  responseType:(XDGitResponseType)responseType
                    parameters:(id)parameters
                          page:(NSInteger)page
                       success:(XDGitEnginePageSuccessBlock)successBlock
                       failure:(XDGitEngineFailureBlock)failureBlock;

- (AFHTTPRequestOperation *)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
              parameters:(id)parameters
                     success:(XDGitEnginePageSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock;

- (AFHTTPRequestOperation *)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
                        page:(NSInteger)page
                     success:(XDGitEnginePageSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock;

- (AFHTTPRequestOperation *)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
                     success:(XDGitEnginePageSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock;

#pragma mark - login
- (AFHTTPRequestOperation *)loginWithUserName:(NSString *)userName password:(NSString *)password success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;


@end
