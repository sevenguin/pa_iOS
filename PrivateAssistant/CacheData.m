//
//  CacheData.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/19.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "CacheData.h"
#define DOMAIN_USERDEFAULTS @"scuwei.pa.com"
@implementation CacheData

static NSMutableDictionary *users;
+(NSMutableDictionary*)getUsers{
    if (!users) {
        users = [[NSMutableDictionary alloc] init];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [users setDictionary:[ud persistentDomainForName:DOMAIN_USERDEFAULTS]];
    return users;
}
+(void)setUsers:(NSString*)key value:(NSObject*)value{
    if (!users) {
        users = [[NSMutableDictionary alloc] init];
    }
    [users setValue:value forKey:key];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setPersistentDomain:users forName:DOMAIN_USERDEFAULTS];
}

@end
