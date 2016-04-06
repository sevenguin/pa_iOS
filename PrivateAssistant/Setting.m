//
//  Setting.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/4.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "Setting.h"

@implementation Setting

+(BOOL)checkEmailValid:(NSString*)email{
    NSString *pattern = @"^.*@..+\\.[a-zA-Z]{2,4}$";
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *results = [regular matchesInString:email options:NSMatchingAnchored range:NSMakeRange(0, [email length])];
    if ([results count] > 0) {
        return YES;
    }else{
        return NO;
    }
}

+(void)updateToLocal:(id)key value:(NSObject*)value{
    NSDictionary* config = @{key:value};
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setPersistentDomain:config forName:UNIQUE_URI];
    [ud synchronize];
}

+(NSDictionary*)loadFromLocal{
    NSUserDefaults *ud = [[NSUserDefaults alloc] init];
    NSDictionary *dicts = [ud persistentDomainForName:UNIQUE_URI];
    NSMutableDictionary* retdict = [[NSMutableDictionary alloc] initWithDictionary:dicts];
    [retdict setObject:[dicts objectForKey:@"userid"] != nil ? [dicts objectForKey:@"userid"] : @-1 forKey:@"userid"];
    [retdict setObject:[dicts objectForKey:@"hasLogin"] != nil ? [dicts objectForKey:@"hasLogin"] : @NO forKey:@"hasLogin"];
    return retdict;
}

@end
