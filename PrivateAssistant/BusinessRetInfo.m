//
//  BusinessRetInfo.m
//  Here.App.iOS
//
//  Created by weill on 16/01/02.
//  Copyright © 2015年 weill. All rights reserved.
//

#import "BusinessRetInfo.h"

@implementation BusinessRetInfo

- (id)initWithDictionary:(NSDictionary *)info{
    return self;
}

- (id)initWithDictionary:(NSDictionary *)info
      dataTypeFromString:(NSString*)typeName{
    if (self = [super init]) {
        NSLog(@"return data:%@", info);
        self.code = [[info objectForKey:@"code"] integerValue];
        self.message = [info objectForKey:@"message"];
        if(self.code == 0){
            self.data = [info valueForKey:@"data"];
        }else{
            self.data = nil;
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"BusinessRetInfo{code=%ld,message=%@,data=%@}",
            self.code, self.message, self.data];
}

@end
