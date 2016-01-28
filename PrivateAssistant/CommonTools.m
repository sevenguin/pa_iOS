//
//  CommonTools.m
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/29.
//  Copyright © 2016年 weill. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+(NSString*) getIntervalTimeString:(NSString*)date{
    if (!date) {
        NSDate* curTime = [NSDate date];
        NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"HH:mm"];
        NSString* localTime = [dateFormater stringFromDate:curTime];
        return localTime;
    }
    return @"";
}

+(CGSize)calcuFontToSize:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName :font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
