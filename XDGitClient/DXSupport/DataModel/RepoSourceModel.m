//
//  RepoSourceModel.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-15.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "RepoSourceModel.h"

#define KRSOURCE_DOWNLOAD @"download_url"
#define KRSOURCE_GIT @"git_url"
#define KRSOURCE_HTML @"html_url"
#define KRSOURCE_NAME @"name"
#define KRSOURCE_PATH @"path"

@implementation RepoSourceModel

@synthesize downloadPath = _downloadPath;
@synthesize gitPath = _gitPath;
@synthesize htmlPath = _htmlPath;
@synthesize name = _name;
@synthesize path = _path;
@synthesize sha = _sha;
@synthesize size = _size;
@synthesize type = _type;
@synthesize contentsPath = _contentsPath;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.downloadPath = [dictionary objectForKey:KRSOURCE_DOWNLOAD];
        self.gitPath = [dictionary objectForKey:KRSOURCE_GIT];
        self.htmlPath = [dictionary objectForKey:KRSOURCE_HTML];
        self.name = [dictionary objectForKey:KRSOURCE_NAME];
        self.path = [dictionary objectForKey:KRSOURCE_PATH];
        self.sha = [dictionary objectForKey:KMODEL_SHA];
        self.size = [[dictionary objectForKey:KMODEL_SIZE] longLongValue];
        self.contentsPath = [dictionary objectForKey:KMODEL_URL];
        
        NSString *fileType = [dictionary objectForKey:KMODEL_TYPE];
        self.type = [self typeForDes:fileType];
    }
    
    return self;
}

- (XDSourceType)typeForDes:(NSString *)string
{
    XDSourceType type = XDSourceTypeFile;
    string = [string lowercaseString];
    if ([string isEqualToString:@"dir"]) {
        type = XDSourceTypeDir;
    }
    
    return type;
}

- (NSString *)imageName
{
    NSString *imageName = @"tab_allSelect.png";
    switch (self.type) {
        case XDSourceTypeDir:
            imageName = @"tab_all.png";
            break;
            
        default:
            break;
    }
    
    return imageName;
}

- (UITableViewCellAccessoryType)cellAccessoryType
{
    UITableViewCellAccessoryType type = UITableViewCellAccessoryNone;
    switch (self.type) {
        case XDSourceTypeFile:
            type = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case XDSourceTypeDir:
//            type = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        default:
            break;
    }
    
    return type;
}

@end
