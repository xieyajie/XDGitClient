//
//  XDGitRequestClient.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDGitRequestClient.h"

#define KCLIENTID @"dd15c5320bd70c217be5"
#define KCLIENTSECRET @"2428107df510240815de4cba7795e779894889d5"

@implementation XDGitRequestClient

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
    }
    
    return self;
}

#pragma mark - send request

/**
 *  自定义申请方式
 */
- (AFHTTPRequestOperation *)requestWithURLRequest:(NSMutableURLRequest *)urlRequest
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSError *error;
        id jsonObject = [NSJSONSerialization
                         JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments
                         error:&error];
        if (jsonObject != nil && error == nil){
            success(operation, jsonObject);
        }
        else{
            failure(operation, error);
        }
    }failure:failure];
    
    [self enqueueHTTPRequestOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
              parameters:(id)parameters
                        page:(NSInteger)page
                     success:(XDGitEnginePageSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock
{
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@", apiPath];
    
    if (page > 0)
    {
        if ([apiPath rangeOfString:@"?"].location == NSNotFound)
        {
            [urlString appendFormat:@"?page=%d&per_page=%d", page, KPERPAGENUMBER];
        }
        else{
            [urlString appendFormat:@"&page=%d&per_page=%d", page, KPERPAGENUMBER];
        }
    }
	
	NSMutableURLRequest *urlRequest = [self requestWithMethod:[self httpMethodWithRequestType:requestType] path:urlString parameters:parameters];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    urlRequest.timeoutInterval = 30;
    urlRequest.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

	if (self.token)
	{
		[urlRequest setValue:self.token forHTTPHeaderField:@"Authorization"];
	}

    return [self requestWithURLRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[[operation.response allHeaderFields] allKeys] containsObject:@"Link"] && page > 0)
        {
            NSString *linkHeader = [[operation.response allHeaderFields] valueForKey:@"Link"];
            NSArray *links = [linkHeader componentsSeparatedByString:@","];
            self.nextPageURL = nil;
            NSURL * __block blockURL = nil;
            [links enumerateObjectsUsingBlock:^(NSString *link, NSUInteger idx, BOOL *stop) {
                NSString *rel = [[link componentsSeparatedByString:@";"][1] componentsSeparatedByString:@"\""][1];
                if ([rel isEqualToString:@"next"])
                {
                    blockURL = [NSURL URLWithString:[[link componentsSeparatedByString:@";"][0] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]];
                    *stop = YES;
                }
            }];
            self.nextPageURL = blockURL;
            BOOL haveNext = blockURL == nil ? NO : YES;
            successBlock(responseObject, haveNext);
        }
        else{
            successBlock(responseObject, NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
}

- (AFHTTPRequestOperation *)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
                  parameters:(id)parameters
                     success:(XDGitEnginePageSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock
{
    return [self sendRequestWithApiPath:apiPath requestType:requestType responseType:responseType parameters:parameters page:0 success:successBlock failure:failureBlock];
}


- (AFHTTPRequestOperation *)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
                        page:(NSInteger)page
                     success:(XDGitEnginePageSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock
{
    return [self sendRequestWithApiPath:apiPath requestType:requestType responseType:responseType parameters:nil page:page success:successBlock failure:failureBlock];
}


- (AFHTTPRequestOperation *)sendRequestWithApiPath:(NSString *)apiPath
                 requestType:(XDGitRequestType)requestType
                responseType:(XDGitResponseType)responseType
                     success:(XDGitEnginePageSuccessBlock)successBlock
                     failure:(XDGitEngineFailureBlock)failureBlock
{
    return [self sendRequestWithApiPath:apiPath requestType:requestType responseType:responseType parameters:nil page:0 success:successBlock failure:failureBlock];
}

//- (void)invoke:(void (^)(id obj))invocationBlock success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    NSError __unsafe_unretained *error = nil;
//    NSError * __unsafe_unretained *errorPointer = &error;
//    id __unsafe_unretained result;
//    
//    NSInvocation *invocation = [NSInvocation jr_invocationWithTarget:self block:invocationBlock];
//    // Method signatures differ between invocations, but the last argument is always where the NSError lives
//    [invocation setArgument:&errorPointer atIndex:[[invocation methodSignature] numberOfArguments] - 1];
//    [invocation invoke];
//    [invocation getReturnValue:&result];
//    
//    if (error)
//    {
//        failureBlock(error);
//        return;
//    }
//    
//    while (self.isMultiPageRequest && self.nextPageURL)
//    {
//        [self.multiPageArray addObjectsFromArray:result];
//        NSMutableString *requestPath = [self.nextPageURL query] ? [[[self.nextPageURL path] stringByAppendingFormat:@"?%@", [self.nextPageURL query]] mutableCopy] : [[self.nextPageURL path] mutableCopy];
//        [requestPath deleteCharactersInRange:NSMakeRange(0, 1)];
//        
//        [invocation setArgument:&requestPath atIndex:2];//atIndex的下标必须从2开始。原因为：0 1 两个参数已经被target 和selector占用
//        [invocation setArgument:&errorPointer atIndex:[[invocation methodSignature] numberOfArguments] - 1];
//        [invocation invoke];
//        [invocation getReturnValue:&result];
//    }
//    
//    if (self.isMultiPageRequest)
//    {
//        [self.multiPageArray addObjectsFromArray:result];
//        NSLog(@"%@", @([self.multiPageArray count]));
//        successBlock(self.multiPageArray);
//    }
//    else
//    {
//        successBlock(result);
//    }
//}
//
//
//- (void)invoke:(void (^)(id obj))invocationBlock booleanSuccess:(XDGitEngineBooleanSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    NSError __unsafe_unretained *error = nil;
//    NSError * __unsafe_unretained *errorPointer = &error;
//    BOOL result;
//    
//    NSInvocation *invocation = [NSInvocation jr_invocationWithTarget:self block:invocationBlock];
//    [invocation setArgument:&errorPointer atIndex:[[invocation methodSignature] numberOfArguments] - 1];
//    [invocation invoke];
//    [invocation getReturnValue:&result];
//    
//    if (error)
//    {
//        failureBlock(error);
//        return;
//    }
//    
//    successBlock(result);
//}

#pragma mark - login

- (NSString *)fetchToken
{
    NSString *path = [NSString stringWithFormat:@"%@?client_id=%@&scope=user", @"https://github.com/login/oauth/authorize", KCLIENTID];
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject)
        {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        <#code#>
    }];
}



- (AFHTTPRequestOperation *)loginWithUserName:(NSString *)userName password:(NSString *)password token:(NSString *)token success:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
{
    if (!token || [token length] == 0) {
        token = [self fetchToken];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@?login=%@&token=%@", @"https://api.github.com/user?access_token=%@", token];
	NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(error);
    }];
    [self enqueueHTTPRequestOperation:operation];
    
    return operation;
}

#pragma mark - private

- (NSString *)httpMethodWithRequestType:(XDGitRequestType)requestType
{
    switch (requestType)
    {
        case XDGitIssueAddRequest:
		case XDGitRepositoryCreateRequest:
		case XDGitRepositoryDeleteConfirmationRequest:
        case XDGitMilestoneCreateRequest:
		case XDGitDeployKeyAddRequest:
		case XDGitDeployKeyDeleteRequest:
		case XDGitIssueCommentAddRequest:
        case XDGitPublicKeyAddRequest:
        case XDGitRepositoryLabelAddRequest:
        case XDGitIssueLabelAddRequest:
        case XDGitTreeCreateRequest:
        case XDGitBlobCreateRequest:
        case XDGitReferenceCreateRequest:
        case XDGitRawCommitCreateRequest:
        case XDGitGistCreateRequest:
        case XDGitGistCommentCreateRequest:
        case XDGitGistForkRequest:
        case XDGitPullRequestCreateRequest:
        case XDGitPullRequestCommentCreateRequest:
        case XDGitEmailAddRequest:
        case XDGitTeamCreateRequest:
        case XDGitMarkdownRequest:
        case XDGitRepositoryMergeRequest:
		{
			return @"POST";
		}
			break;
            
		case XDGitCollaboratorAddRequest:
        case XDGitIssueLabelReplaceRequest:
        case XDGitFollowRequest:
        case XDGitGistStarRequest:
        case XDGitPullRequestMergeRequest:
        case XDGitOrganizationMembershipPublicizeRequest:
        case XDGitTeamMemberAddRequest:
        case XDGitTeamRepositoryManagershipAddRequest:
        case XDGitNotificationsMarkReadRequest:
        case XDGitNotificationThreadSubscriptionRequest:
        {
            return @"PUT";
        }
            break;
            
		case XDGitRepositoryUpdateRequest:
        case XDGitMilestoneUpdateRequest:
        case XDGitIssueEditRequest:
        case XDGitIssueCommentEditRequest:
        case XDGitPublicKeyEditRequest:
        case XDGitUserEditRequest:
        case XDGitRepositoryLabelEditRequest:
        case XDGitReferenceUpdateRequest:
        case XDGitGistUpdateRequest:
        case XDGitGistCommentUpdateRequest:
        case XDGitPullRequestUpdateRequest:
        case XDGitPullRequestCommentUpdateRequest:
        case XDGitOrganizationUpdateRequest:
        case XDGitTeamUpdateRequest:
        case XDGitNotificationsMarkThreadReadRequest:
        {
            return @"PATCH";
        }
            break;
            
        case XDGitMilestoneDeleteRequest:
        case XDGitIssueDeleteRequest:
        case XDGitIssueCommentDeleteRequest:
        case XDGitUnfollowRequest:
        case XDGitPublicKeyDeleteRequest:
		case XDGitCollaboratorRemoveRequest:
        case XDGitRepositoryLabelRemoveRequest:
        case XDGitIssueLabelRemoveRequest:
        case XDGitGistUnstarRequest:
        case XDGitGistDeleteRequest:
        case XDGitGistCommentDeleteRequest:
        case XDGitPullRequestCommentDeleteRequest:
        case XDGitEmailDeleteRequest:
        case XDGitOrganizationMemberRemoveRequest:
        case XDGitOrganizationMembershipConcealRequest:
        case XDGitTeamDeleteRequest:
        case XDGitTeamMemberRemoveRequest:
        case XDGitTeamRepositoryManagershipRemoveRequest:
        case XDGitNotificationDeleteSubscriptionRequest:
        {
            return @"DELETE";
        }
            break;
            
		default:
            return @"GET";
			break;
	}
    
    return @"GET";
}

@end
