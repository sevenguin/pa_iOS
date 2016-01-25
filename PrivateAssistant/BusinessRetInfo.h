//
//  BusinessRetInfo.h
//  Here.App.iOS
//
//  Created by weill on 16/01/02.
//  Copyright © 2015年 weill. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSDictionary+ValueForKeyExcept.h"

@interface BusinessRetInfo : NSObject

@property (nonatomic) NSInteger code;
@property (nonatomic) NSString *message;
@property (nonatomic) id data; // could be array or dictionary

- (id)initWithDictionary:(NSDictionary *)info;
- (id)initWithDictionary:(NSDictionary *)info
      dataTypeFromString:(NSString*)typeName;

@end
