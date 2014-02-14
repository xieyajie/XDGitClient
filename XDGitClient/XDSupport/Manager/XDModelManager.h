//
//  XDModelManager.h
//  leCar
//
//  Created by dhcdht on 14-1-2.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NotificationModel;
@class StoreModel;
@class StoreReplaceModel;
@class UserModel;
@class ProductGroupModel;
@class ProductModel;
 
@interface XDModelManager : NSObject

+ (XDModelManager *)defaultManager;

//小喇叭数据模型
- (NotificationModel *)notificationModelWithDictionary:(NSDictionary *)dictionary;
//小喇叭数据实体（存入数据库）
- (NotificationModel *)notificationEntityWithDictionary:(NSDictionary *)dictionary;

//用户数据模型
- (UserModel *)userModelWithDictionary:(NSDictionary *)dictionary;
//用户数据实体（存入数据库）
//- (UserModel *)userEntityWithDictionary:(NSDictionary *)dictionary;

//找店--店铺数据模型
- (StoreModel *)storeModelWithDictionary:(NSDictionary *)dictionary;
//找店--店铺数据实体（存入数据库）
- (StoreModel *)storeEntityWithDictionary:(NSDictionary *)dictionary;

//找店--产品组数据模型
- (ProductGroupModel *)productGroupModelWithDictionary:(NSDictionary *)dictionary;
//找店--产品组数据实体（存入数据库）
- (ProductGroupModel *)productGroupEntityWithDictionary:(NSDictionary *)dictionary;

//找店--产品数据模型
- (ProductModel *)productModelWithDictionary:(NSDictionary *)dictionary;
//找店--产品数据实体（存入数据库）
- (ProductModel *)productEntityWithDictionary:(NSDictionary *)dictionary;

//找店--置换数据模型
- (StoreReplaceModel *)replaceModelWithDictionary:(NSDictionary *)dictionary;

@end
