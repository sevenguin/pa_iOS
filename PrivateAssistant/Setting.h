//
//  Setting.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/4.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UNIQUE_URI @"com.weill.privateassitant"
@interface Setting : NSObject

+(BOOL)checkEmailValid:(NSString*)email;
+(NSDictionary*)loadFromLocal;
+(void)updateToLocal:(id)key value:(NSObject*)value;

@end
