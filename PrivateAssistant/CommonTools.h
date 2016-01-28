//
//  CommonTools.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/29.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTools : NSObject

+(NSString*) getIntervalTimeString:(NSString*)date;
+ (CGSize)calcuFontToSize:(NSString*)text font:(UIFont*)font maxSize:(CGSize)maxSize;

@end
