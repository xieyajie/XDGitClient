//
//  XDRequestManager.m
//  leCar
//
//  Created by xieyajie on 13-12-30.
//  Copyright (c) 2013年 XDIOS. All rights reserved.
//

#import "XDRequestManager.h"

#import "XDGithubEngine.h"

static XDRequestManager *defaultManagerInstance = nil;

@implementation XDRequestManager

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

+ (XDRequestManager *)defaultManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultManagerInstance = [[self alloc] init];
        });
    }
    return defaultManagerInstance;
}

#pragma mark - getter

- (id<XDGitEngineProtocol>)activityGitEngine
{
    if (_activityGitEngine == nil) {
        _activityGitEngine = [XDGithubEngine defaultEngine];
    }
    else{
        
    }
    
    return _activityGitEngine;
}

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

//#pragma mark - account info
//
//- (void)followersWithSuccess:(void(^)(id object))successBlock failure:(void(^)(NSError *error))failureBlock
//{
//    if (_githubEngine) {
//        [_githubEngine followers:_githubEngine.username success:^(id object) {
//            successBlock(object);
//        } failure:^(NSError *error) {
//            failureBlock(error);
//        }];
//    }
//    else{
//        NSError *error = [NSError errorWithDomain:@"申请数据失败" code:404 userInfo:nil];
//        failureBlock(error);
//    }
//}
//
//- (void)followingsWithSuccess:(void(^)(id object))successBlock failure:(void(^)(NSError *error))failureBlock
//{
//    if (_githubEngine) {
//        [_githubEngine following:_githubEngine.username success:^(id object) {
//            successBlock(object);
//        } failure:^(NSError *error) {
//            failureBlock(error);
//        }];
//    }
//    else{
//        NSError *error = [NSError errorWithDomain:@"申请数据失败" code:404 userInfo:nil];
//        failureBlock(error);
//    }
//}
//
//#pragma mark - activity
//
//- (void)allActivityWithSuccess:(void(^)(id object))successBlock failure:(void(^)(NSError *error))failureBlock
//{
//    if (_githubEngine) {
//        [_githubEngine publicEventsPerformedByUser:_githubEngine.username success:^(id object) {
//            successBlock(object);
//        } failure:^(NSError *error) {
//            failureBlock(error);
//        }];
//    }
//    else{
//        NSError *error = [NSError errorWithDomain:@"申请数据失败" code:404 userInfo:nil];
//        failureBlock(error);
//    }
//}
//
//#pragma mark - project
//
//- (void)projectsWithStyle:(XDProjectStyle)style userName:(NSString *)userName success:(void(^)(id object))successBlock failure:(void(^)(NSError *error))failureBlock
//{
//    if (_githubEngine) {
//        if (userName == nil || userName.length == 0) {
//            userName = _githubEngine.username;
//        }
//        
//        NSString *path = [NSString stringWithFormat:@"user=%@&type=%@", userName, @"owner"];
//        [_githubEngine repositoriesWithSuccess:^(id object) {
//            successBlock(object);
//        } failure:^(NSError *error) {
//            failureBlock(error);
//        }];
//    }
//    else{
//        NSError *error = [NSError errorWithDomain:@"申请数据失败" code:404 userInfo:nil];
//        failureBlock(error);
//    }
//}

@end
