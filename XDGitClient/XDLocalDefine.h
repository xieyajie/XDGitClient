//
//  XDLocalDefine.h
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#ifndef XDGitClient_XDLocalDefine_h
#define XDGitClient_XDLocalDefine_h

//enum
#pragma mark - enum
typedef enum{
    XDRepositoryStyleAll   = 0,
    XDRepositoryStyleOwner,
    XDRepositoryStyleMember,
    XDRepositoryStyleForks,
    XDRepositoryStyleStars,
    XDRepositoryStyleWatchs,
    XDRepositoryStylePublic,
    XDRepositoryStylePrivate,
    XDRepositoryStyleSource,
    XDRepositoryStyleMirrors,
}XDRepositoryStyle;

typedef enum{
    XDGitStyleAll   = 0,
    XDGitStylePublic,
    XDGitStylePrivate,
    XDGitStyleStarred,
}XDGitStyle;

typedef enum{
    XDPullRequestStateOpen   = 0,
    XDPullRequestStateClosed,
}XDPullRequestState;

//block
#pragma mark - block
typedef void (^XDGitEngineSuccessBlock)(id object);
typedef void (^XDGitEngineBooleanSuccessBlock)(BOOL success);
typedef void (^XDGitEnginePageSuccessBlock)(id object, BOOL haveNextPage);
typedef void (^XDGitEngineFailureBlock)(NSError *error);

#pragma mark - NSNotification name

#define KNOTIFICATION_LOFINSTATECHANGED @"LoginStateChanged"

#pragma mark - default

#define KPERPAGENUMBER 50
#define KLEFTVIEWWIDTH 200.0

//textField color (detail)
#define TEXTFIELDDETAILCOLOR [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0]

//app name
#pragma mark - app name
#define APPNAME @"XDGitHub"

//config key
#pragma mark - config key
#define KCONFIG_FILE @"xdgit_config.plist"
#define KCONFIG_LOGINUSERNAME @"login_username"
#define KCONFIG_LOGINUSERPASSWORD @"login_password"
#define KCONFIG_LOGINUSERTOKEN @"login_token"
#define KCONFIG_LOGINUSERDATE @"login_date"

//plist key
#pragma mark - plist key
#define KPLIST_KEYIMAGE @"icon"
#define KPLIST_KEYTITLE @"title"
#define KPLIST_KEYMODELSELECTOR @"model_selector"
#define KPLIST_KEYCONTROLLERSELECTOR @"controller_selector"
#define KPLIST_KEYACCESSORYTYPE @"accessoryType"

//plist value controller selector tag

//base
#define KPLIST_VALUE_CONTROLLERSELECTOR_NEW         100
#define KPLIST_VALUE_CONTROLLERSELECTOR_ACTIVITY    101
#define KPLIST_VALUE_CONTROLLERSELECTOR_NOTIF       102
#define KPLIST_VALUE_CONTROLLERSELECTOR_PULLREQUEST 103
#define KPLIST_VALUE_CONTROLLERSELECTOR_ISSUE       104

//user
#define KPLIST_VALUE_CONTROLLERSELECTOR_REPO        110
#define KPLIST_VALUE_CONTROLLERSELECTOR_GIT         111
#define KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOWER    112
#define KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOEING   113

//repo
#define KPLIST_VALUE_CONTROLLERSELECTOR_ACCOUNT     120
#define KPLIST_VALUE_CONTROLLERSELECTOR_FORKORIGIN  121
#define KPLIST_VALUE_CONTROLLERSELECTOR_FORKER      122
#define KPLIST_VALUE_CONTROLLERSELECTOR_STARER      123
#define KPLIST_VALUE_CONTROLLERSELECTOR_WATCHER     124
#define KPLIST_VALUE_CONTROLLERSELECTOR_REPOSOURCE  125

#pragma mark - model

//config
#define KCONFIG_LOGIN_USERNAME @"loginUsername"
#define KCONFIG_LOGIN_TOKEN @"loginToken"
#define KCONFIG_SORT_REPOSITORY_NAME @"repositorySortName"
#define KCONFIG_SORT_REPOSITORY_TYPE @"repositorySortType"

#define KMODEL_ID @"id"
#define KMODEL_LOGIN @"login"
#define KMODEL_AVATARURL @"avatar_url"
#define KMODEL_TYPE @"type"
#define KMODEL_URL @"url"
#define KMODEL_CREATE @"created_at"
#define KMODEL_UPDATE @"updated_at"
#define KMODEL_SIZE @"size"


//Pull Request
#define KPULLREQUEST_TITLE @"title"
#define KPULLREQUEST_CONTENT @"body"
#define KPULLREQUEST_OWNER @"user"


//#define KPULLREQUEST_ @""
//#define KPULLREQUEST_ @""

#endif
