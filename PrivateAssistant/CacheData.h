//
//  CacheData.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/19.
//  Copyright © 2016年 weill. All rights reserved.
//

#define KEY_STATUS_LOGIN @"status"
#define KEY_USER_NAME @"username"
#define KEY_USER_EMAIL @"email"
#define KEY_USER_PASSWORD @"password"
#define KEY_USER_ID @"userid"

#define VALUE_STATUS_LOGIN @"login"
#define VALUE_STATUS_UNLOGIN @"unlogin"

#import <Foundation/Foundation.h>

@interface CacheData : NSObject

+(NSMutableDictionary*)getUsers;
+(void)setUsers:(NSString*)key value:(NSObject*)value;

@end
