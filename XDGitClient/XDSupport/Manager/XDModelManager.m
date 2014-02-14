//
//  XDModelManager.m
//  leCar
//
//  Created by dhcdht on 14-1-2.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "XDModelManager.h"

#import "NotificationModel.h"
#import "StoreModel.h"
#import "StoreReplaceModel.h"
#import "UserModel.h"
#import "ProductGroupModel.h"
#import "ProductModel.h"
#import "NSDictionary+Category.h"

static XDModelManager *defaultManagerInstance = nil;

@interface XDModelManager()

@end

@implementation XDModelManager

+ (XDModelManager *)defaultManager
{
    @synchronized(self)
    {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultManagerInstance = [[self alloc] init];
        });
    }
    return defaultManagerInstance;
}

#pragma mark - 数据模型

/**
 *  小喇叭数据模型
 */
- (NotificationModel *)notificationModelWithDictionary:(NSDictionary *)dictionary
{
    NotificationModel *model = [[NotificationModel alloc] init];
    return [self notificationModel:model withDictionary:dictionary];
}

- (NotificationModel *)notificationEntityWithDictionary:(NSDictionary *)dictionary
{
    NotificationModel *model = [NotificationModel createEntity];
    return [self notificationModel:model withDictionary:dictionary];
}

- (NotificationModel *)notificationModel:(NotificationModel *)model withDictionary:(NSDictionary *)dictionary
{
    model.accountId = AccountID;
    model.notificationId = [dictionary stringForKey:DATA_ID];
    model.headerImagePath = [dictionary stringForKey:NOTIFICATION_IMAGEPATH];
    model.title = [dictionary stringForKey:NOTIFICATION_TITLE];
    model.content = [dictionary stringForKey:NOTIFICATION_CONTENT];
    model.subject = [dictionary stringForKey:NOTIFICATION_SUBJECT];
    model.activityDate = [dictionary stringForKey:NOTIFICATION_ACTIVITYDATE];
    model.type = [dictionary stringForKey:NOTIFICATION_MESSAGETYPE];
    
    return model;
}

/**
 *  用户数据模型
 *
 *  @param dictionary
 *
 *  @return model
 */
- (UserModel *)userModelWithDictionary:(NSDictionary *)dictionary
{
    UserModel *model = [UserModel createEntity];
    
    model.userId = [dictionary stringForKey:DATA_ID];
    model.name = [dictionary stringForKey:USER_NAME];
    model.headerImagePath = [dictionary stringForKey:USER_HEADERIMAGEPATH];
    model.nickName = [dictionary stringForKey:USER_NICKNAME];
    model.gender = [NSNumber numberWithInteger:[dictionary integerForKey:USER_GENDER]];
    
    return model;
}

/**
 *  找店--店铺数据模型
 */
- (StoreModel *)storeModelWithDictionary:(NSDictionary *)dictionary
{
    StoreModel *model = [[StoreModel alloc] init];
    return [self storeModel:model withDictionary:dictionary];
}

- (StoreModel *)storeEntityWithDictionary:(NSDictionary *)dictionary
{
    StoreModel *model = [StoreModel createEntity];
    return [self storeModel:model withDictionary:dictionary];
}

- (StoreModel *)storeModel:(StoreModel *)model withDictionary:(NSDictionary *)dictionary
{
    model.accountId = AccountID;
    model.storeId = [dictionary stringForKey:DATA_ID];
    model.type = [NSNumber numberWithInteger:[dictionary integerForKey:STORE_TYPE]];
    model.name = [dictionary stringForKey:STORE_NAME];
    model.headerImagePath = [dictionary stringForKey:STORE_HEADERIMAGEPATH];
    model.bigImagePath = [dictionary stringForKey:STORE_BIGIMAGEPATH];
    model.address = [dictionary stringForKey:STORE_ADDRESS];
    model.mobilePhone = [dictionary stringForKey:STORE_MOBILEPHONE];
    model.landlinePhone = [dictionary stringForKey:STORE_LANDLINEPHONE];
    NSArray *array = [dictionary objectForKey:STORE_BRAND];
    model.carBrands = [array componentsJoinedByString:@","];
    
    return model;
}

//找店--产品组数据模型
- (ProductGroupModel *)productGroupModelWithDictionary:(NSDictionary *)dictionary
{
    ProductGroupModel *model = [[ProductGroupModel alloc] init];
    return [self productGroupModel:model withDictionary:dictionary];
}

- (ProductGroupModel *)productGroupEntityWithDictionary:(NSDictionary *)dictionary
{
    ProductGroupModel *model = [ProductGroupModel createEntity];
    return [self productGroupModel:model withDictionary:dictionary];
}

- (ProductGroupModel *)productGroupModel:(ProductGroupModel *)model withDictionary:(NSDictionary *)dictionary
{
    model.groupId = [dictionary stringForKey:DATA_ID];
    model.title = [dictionary stringForKey:PRODUCT_GROUP_TITLE];
    model.imagePath = [dictionary stringForKey:PRODUCT_GROUP_IMAGEPATH];
    
    return model;
}

//找店--产品数据模型
- (ProductModel *)productModelWithDictionary:(NSDictionary *)dictionary
{
    ProductModel *model = [[ProductModel alloc] init];
    return [self productModel:model withDictionary:dictionary];
}

- (ProductModel *)productEntityWithDictionary:(NSDictionary *)dictionary
{
    ProductModel *model = [ProductModel createEntity];
    return [self productModel:model withDictionary:dictionary];
}

- (ProductModel *)productModel:(ProductModel *)model withDictionary:(NSDictionary *)dictionary
{
    model.groupId = [dictionary stringForKey:DATA_ID];
    model.title = [dictionary stringForKey:PRODUCT_GROUP_TITLE];
    model.imagePath = [dictionary stringForKey:PRODUCT_GROUP_IMAGEPATH];
    
    return model;
}

//找店--置换数据模型
- (StoreReplaceModel *)replaceModelWithDictionary:(NSDictionary *)dictionary
{
    StoreReplaceModel *model = [StoreReplaceModel createEntity];
    
    model.replaceId = [dictionary stringForKey:DATA_ID];
    model.storeId = [dictionary stringForKey:REPLACE_STOREID];
    model.title = [dictionary stringForKey:REPLACE_TITLE];
    model.beginDate = [dictionary stringForKey:REPLACE_BEGINDATE];
    model.endDate = [dictionary stringForKey:REPLACE_ENDDATE];
    
    return model;
}

@end
