//
//  NSMutableDictionary+nilOjbect.h
//  XDHoHo
//
//  Created by Li Zhiping on 13-12-8.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (nilObject)

/**
 *  判断anObject 是否为nil, 为nil则不添加到字典中
 *
 *  @param anOjbect an object add to dictionary, can be nil
 *  @param aKey the key for the anObject
 */
- (void)setNilOjbect:(id)anObject forKey:(id<NSCopying>)aKey;

/**
 *  添加int字段到字典中
 *
 *  @param anInt an int add to dictionary
 *  @param aKey  the key for the int
 */
- (void)setInt:(NSInteger)anInt forKey:(id<NSCopying>)aKey;

/**
 *  添加一个double字段到字典中
 *
 *  @param anDouble
 *  @param aKey     
 */
- (void)setDouble:(double)anDouble forKey:(id<NSCopying>)aKey;
@end
