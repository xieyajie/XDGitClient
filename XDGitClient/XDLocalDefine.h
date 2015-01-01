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
#define KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOEIMG   113

//repo
#define KPLIST_VALUE_CONTROLLERSELECTOR_ACCOUNT     120
#define KPLIST_VALUE_CONTROLLERSELECTOR_FORKORIGIN  121
#define KPLIST_VALUE_CONTROLLERSELECTOR_ISSUE       122
#define KPLIST_VALUE_CONTROLLERSELECTOR_PULLREQUEST 123
#define KPLIST_VALUE_CONTROLLERSELECTOR_FORKER      124
#define KPLIST_VALUE_CONTROLLERSELECTOR_STARER      125
#define KPLIST_VALUE_CONTROLLERSELECTOR_WATCHER     126
#define KPLIST_VALUE_CONTROLLERSELECTOR_REPOSOURCE  127

#pragma mark - model
//config
#define KCONFIG_LOGIN_USERNAME @"loginUsername"
#define KCONFIG_LOGIN_TOKEN @"loginToken"
#define KCONFIG_SORT_REPOSITORY_NAME @"repositorySortName"
#define KCONFIG_SORT_REPOSITORY_TYPE @"repositorySortType"

#define KMODEL_ID @"id"
#define KMODEL_TYPE @"type"
#define KMODEL_URL @"url"
#define KMODEL_CREATE @"created_at"
#define KMODEL_UPDATE @"updated_at"
#define KMODEL_SIZE @"size"

//User
#define KUSER_NAME @"login"
#define KUSER_AVATARURL @"avatar_url"
#define KUSER_COMPANY @"company"
#define KUSER_EMAIL @"email"
#define KUSER_WEBURL @"html_url"
#define KUSER_LOCATION @"location"
#define KUSER_FOLLOWER @"followers"
#define KUSER_FOLLOWING @"following"

//Organization
#define KORG_NAME @"login"
#define KORG_AVATARURL @"avatar_url"
#define KORG_GRAVATARID @"gravatar_id"

//Repository
#define KREPO_NAME @"name"
#define KREPO_FULLNAME @"full_name"
#define KREPO_DESC @"description"
#define KREPO_PUSH @"pushed_at"
#define KREPO_LANGUAGE @"language"
#define KREPO_OWNER @"owner"
#define KREPO_DEFAULTBRANCH @"default_branch"
#define KREPO_FORKSCOUNT @"forks_count"
#define KREPO_OPENISSUESCOUNT @"open_issues_count"
#define KREPO_WATCHERSCOUNT @"watchers_count"
#define KREPO_STARSCOUNT @"stargazers_count"
#define KREPO_PRIVATESTATE @"private"
#define KREPO_FORKSTATE @"fork"

//Git
#define KGIT_DESC @"description"
#define KGIT_HTMLURL @"html_url"
#define KGIT_FORKURL @"forks_url"
#define KGIT_COMMENTCOUNT @"comments"
#define KGIT_PUBLICSTATE @"public"

//Event
#define KEVENT_PUBLICSTATE @"public"
#define KEVENT_PAYLOAD @"payload"
#define KEVENT_USER @"actor"
#define KEVENT_ORG @"org"
#define KEVENT_REPO @"repo"

//Event Payload
#define KEVENT_PAYLOAD_ID @"push_id"
#define KEVENT_PAYLOAD_COMMITS @"commits"
#define KEVENT_PAYLOAD_HEAD @"head"
#define KEVENT_PAYLOAD_DISTINCTSIZE @"distinct_size"
#define KEVENT_PAYLOAD_BEFORE @"before"
#define KEVENT_PAYLOAD_RER @"ref"

//Pull Request
#define KPULLREQUEST_TITLE @"title"
#define KPULLREQUEST_CONTENT @"body"
#define KPULLREQUEST_OWNER @"user"

//Commit
#define KCOMMIT_AUTHOR @"author"
#define KCOMMIT_AUTHOR_NAME @"name"
#define KCOMMIT_AUTHOR_EMAIL @"email"
#define KCOMMIT_DISTINCT @"distinct"
#define KCOMMIT_MESSAGE @"message"
#define KCOMMIT_SHA @"sha"

//#define KPULLREQUEST_ @""
//#define KPULLREQUEST_ @""

#endif
