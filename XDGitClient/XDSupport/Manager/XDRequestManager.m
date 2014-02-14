//
//  XDRequestManager.m
//  leCar
//
//  Created by xieyajie on 13-12-30.
//  Copyright (c) 2013年 XDIOS. All rights reserved.
//

#import "XDRequestManager.h"

static NSString *const BASEURL = @"http://github.com";

static XDRequestManager *defaultManagerInstance = nil;

@implementation XDRequestManager

@synthesize accountToken = _accountToken;

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
//        _appApiPath = [NSString stringWithFormat:@"%@/%@", kOrgName, kAppName];
    }
    
    return self;
}

+ (XDRequestManager *)defaultManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultManagerInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
//            [defaultManagerInstance setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        });
    }
    return defaultManagerInstance;
}

#pragma mark - 信息处理

//- (NSString *)accountToken
//{
//    _accountToken = [NSString stringWithFormat:@"Bearer %@", AccountToken];
//    
//    return _accountToken;
//}

/*获取请求错误信息描述*/
- (NSString *)requestErrorDescription:(NSError *)error
{
    NSLog(@"请求失败: %@", error.localizedDescription);
    
//    switch (error.code) {
//        case AF:
//            return @"连接失败，请稍后再试";
//            break;
//            
//        case ASIRequestTimedOutErrorType:
//            return @"请求超时，请稍后再试";
//            break;
//            
//        case ASIAuthenticationErrorType:
//            return @"授权失败";
//            break;
//            
//        case ASIRequestCancelledErrorType:
//            return @"请求已取消";
//            break;
//            
//        case ASIUnableToCreateRequestErrorType:
//            return @"无法创建请求";
//            break;
//            
//        case ASIInternalErrorWhileBuildingRequestType:
//            return @"创建请求错误";
//            break;
//            
//        case ASIInternalErrorWhileApplyingCredentialsType:
//            return @"申请证书错误";
//            break;
//            
//        case ASIFileManagementError:
//            return @"文件管理错误";
//            break;
//            
//        case ASITooMuchRedirectionErrorType:
//            return @"重定向过多错误";
//            break;
//            
//        case ASIUnhandledExceptionError:
//            return @"未知错误";
//            break;
//            
//        case ASICompressionError:
//            return @"文件管理错误";
//            break;
//            
//        default:
//            return @"请求失败，请稍后再试";
//            break;
//    }
    
    return @"";
}

#pragma mark - 用户相关

/**
 *  登录
 *
 *  @param userName   用户名
 *  @param password   密码
 *  @param parameters 参数
 *  @param success    申请成功时，回调方法
 *  @param failure    申请失败时，回调方法
 */
- (void)loginRequestWithUserName:(NSString *)userName
                        password:(NSString *)password
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSString *errorDescription))failure
{
    NSString *path = [NSString stringWithFormat:@"%@?login=%@&token=%@", BASEURL, userName, password];
	NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:parameters];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
        success(operation);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [self requestErrorDescription:error];
        failure(operation, errorStr);
    }];
    [self enqueueHTTPRequestOperation:operation];
}

#pragma mark - 上拉、下拉申请数据

/**
 *  执行下拉刷新请求
 *
 *  @param path       链接字符串
 *  @param userInfo   参数
 *  @param success    申请成功时，回调方法
 *  @param failure    申请失败时，回调方法
 */
- (void)startTableHeaderRequestWithPath:(NSString *)path
                               userInfo:(NSDictionary *)userInfo
                                success:(void (^)(AFHTTPRequestOperation *operation, id JSONValue))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSString *errorDescription))failure
{
    path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    if (!url.scheme.length) {
        NSString *tmpPath = [NSString stringWithString:path];
        path = [NSString stringWithFormat:@"%@/%@", BASEURL, tmpPath];
    }
    
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:userInfo];
    [request addValue:self.accountToken forHTTPHeaderField:@"Authorization"];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSError *error;
        id jsonObject = [NSJSONSerialization
                         JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments
                         error:&error];
        if (jsonObject != nil && error == nil){
            success(operation, jsonObject);
        }
        else{
            failure(operation, [self requestErrorDescription:error]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [self requestErrorDescription:error];
        failure(operation, errorStr);
    }];
    [self enqueueHTTPRequestOperation:operation];
}

/**
 *  执行上拉刷新请求
 *
 *  @param path       链接字符串
 *  @param userInfo   参数
 *  @param success    申请成功时，回调方法
 *  @param failure    申请失败时，回调方法
 */
- (void)startTableFooterRequestWithPath:(NSString *)path
                               userInfo:(NSDictionary *)userInfo
                                success:(void (^)(AFHTTPRequestOperation *operation, id JSONValue))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSString *errorDescription))failure
{
    path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    if (!url.scheme.length) {
        NSString *tmpPath = [NSString stringWithString:path];
        path = [NSString stringWithFormat:@"%@/%@", BASEURL, tmpPath];
    }
    
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:userInfo];
    [request addValue:self.accountToken forHTTPHeaderField:@"Authorization"];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSError *error;
        id jsonObject = [NSJSONSerialization
                         JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments
                         error:&error];
        if (jsonObject != nil && error == nil){
            success(operation, jsonObject);
        }
        else{
            failure(operation, [self requestErrorDescription:error]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSString *errorStr = [self requestErrorDescription:error];
        failure(operation, errorStr);
    }];
    [self enqueueHTTPRequestOperation:operation];
}

/**
 *  自定义申请方式
 */
- (void)requestWithMode:(NSString *)mode
               path:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (mode == nil || mode.length == 0) {
        mode = @"GET";
    }
    else{
        mode = [mode uppercaseString];
    }
    
    path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    if (!url.scheme.length) {
        NSString *tmpPath = [NSString stringWithString:path];
        path = [NSString stringWithFormat:@"%@/%@", BASEURL, tmpPath];
    }
    
	NSMutableURLRequest *request = [self requestWithMethod:mode path:path parameters:parameters];
    [request addValue:self.accountToken forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
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
}

/**
 *  GET申请
 *
 *  @param path       链接字符串
 *  @param parameters 参数
 *  @param success    申请成功时，回调方法
 *  @param failure    申请失败时，回调方法
 */
- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    if (!url.scheme.length) {
        NSString *tmpPath = [NSString stringWithString:path];
        path = [NSString stringWithFormat:@"%@/%@", BASEURL, tmpPath];
    }
    
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters];
    [request addValue:self.accountToken forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
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
}

/**
 *  POST申请
 *
 *  @param path       链接字符串
 *  @param parameters 参数
 *  @param success    申请成功时，回调方法
 *  @param failure    申请失败时，回调方法
 */
- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    path = [path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    if (!url.scheme.length) {
        NSString *tmpPath = [NSString stringWithString:path];
        path = [NSString stringWithFormat:@"%@/%@", BASEURL, tmpPath];
    }
    
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:parameters];
    [request addValue:self.accountToken forHTTPHeaderField:@"Authorization"];
	AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject){
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
    } failure:failure];
    [self enqueueHTTPRequestOperation:operation];
}

@end
