//
//  NSMutableDictionary+nilOjbect.m
//  XDHoHo
//
//  Created by Li Zhiping on 13-12-8.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import "NSMutableDictionary+nilObject.h"

@implementation NSMutableDictionary (nilObject)

- (void)setNilOjbect:(id)anObject forKey:(id<NSCopying>)aKey{
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
    }
}

- (void)setInt:(NSInteger)anInt forKey:(id<NSCopying>)aKey{
    NSString *intStr = [NSString stringWithFormat:@"%i", anInt];
    [self setObject:intStr forKey:aKey];
}

- (void)setDouble:(double)anDouble forKey:(id<NSCopying>)aKey{
    NSString *intStr = [NSString stringWithFormat:@"%f", anDouble];
    [self setObject:intStr forKey:aKey];
}

@end
