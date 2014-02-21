//
//  NSString+Category.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (NSDate *)dateFromGithubDateString {
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	NSString *dateString = self;
    
    if (![[self substringWithRange:NSMakeRange([self length] - 1, 1)] isEqualToString:@"Z"])
    {
        NSMutableString *newDate = [self mutableCopy];
        [newDate deleteCharactersInRange:NSMakeRange(19, 1)];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        dateString = newDate;
    }
    else
    {
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    }
    
    return [df dateFromString:dateString];
}


- (NSString *)encodedString
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (CFStringRef)@";/?:@&=$+{}<>,", kCFStringEncodingUTF8);
    
}

- (NSString *)fileSizeDescription
{
    double bytes = [self doubleValue];
    NSString *readable = @"0 B";
    if (bytes > 0)
    {
        if ((bytes < 1024)){
            readable = [NSString stringWithFormat:@"%.2lf B", bytes];
        }
        
        //kilobytes
        if ((bytes/1024) >= 1){
            readable = [NSString stringWithFormat:@"%.2lf KB", (bytes/1024)];
        }
        
        //megabytes
        if ((bytes/1024/1024) >= 1){
            readable = [NSString stringWithFormat:@"%.2lf MB", (bytes/1024/1024)];
        }
        
        //gigabytes
        if ((bytes/1024/1024/1024)>=1){
            readable = [NSString stringWithFormat:@"%.2lf GB", (bytes/1024/1024/1024)];
        }
        
        //terabytes
        if ((bytes/1024/1024/1024/1024)>=1){
            readable = [NSString stringWithFormat:@"%.2lf TB", (bytes/1024/1024/1024/1024)];
        }
        
        //petabytes
        if ((bytes/1024/1024/1024/1024/1024)>=1){
            readable = [NSString stringWithFormat:@"%.2lf PB", (bytes/1024/1024/1024/1024/1024)];
        }
    }
    
    return readable;
}

- (NSString *)dateDes
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [df stringFromDate:[self dateFromGithubDateString]];
}

@end
