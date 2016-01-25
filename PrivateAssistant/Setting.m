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

@end
