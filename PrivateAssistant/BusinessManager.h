//
//  BusinessManager.h
//  Here.App.iOS
//
//  Created by weill on 16/01/02.
//  Copyright © 2015年 weill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BusinessRetInfo.h"

@interface BusinessManager : NSObject

+(id)shareManager;

-(void)doRequest:(NSString*)name
          params:(NSDictionary *)param
         success:(void (^)(id))success
         failure:(void (^)(NSError *error))failure;

-(void)doPost:(NSString*)name
          params:(NSDictionary *)param
         success:(void (^)(BusinessRetInfo*))success
         failure:(void (^)(NSError *error))failure;

@end
