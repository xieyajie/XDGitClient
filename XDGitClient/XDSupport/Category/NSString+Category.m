//
//  NSString+Category.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

//- (NSDate *)dateFromGithubDateString
//{
//    //设置源日期时区
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
//    //设置转换后的目标日期时区
//    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
//    //得到源日期与世界标准时间的偏移量
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:];
//    //目标日期与本地时区的偏移量
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:];
//    //得到时间偏移量的差值
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
//    //转为现在时间
//    NSDate* destinationDateNow = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate] autorelease];
//    return destinationDateNow;
//}
//
//
//- (NSString *)encodedString
//{
//    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (CFStringRef)@";/?:@&=$+{}<>,", kCFStringEncodingUTF8);
//    
//}

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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:self];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];

    return dateString;
}

@end
