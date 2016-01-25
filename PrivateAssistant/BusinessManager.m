//
//  BusinessManager.m
//  Here.App.iOS
//
//  Created by weill on 15/9/22.
//  Copyright © 2015年 weill. All rights reserved.
//

#import "BusinessManager.h"
#import "AFNetworkActivityLogger.h"

#define SERVERHOST @"http://127.0.0.1:8000/"

@interface BusinessManager()
@property (nonatomic)NSDictionary *apis;
@end

@implementation BusinessManager

+(id)shareManager{
    static BusinessManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"apis" ofType:@"plist"];
    shareManager.apis = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    return shareManager;
}

-(id)init{
    if(self = [super init]){
        _apis = [[NSDictionary alloc] init];
    }
    return self;
}

-(NSString *)requestUrl:(NSString *)suffix {
    NSMutableString *strUrl = [NSMutableString stringWithString:SERVERHOST];
    [strUrl appendString:suffix];
    return [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

-(void)doRequest:(NSString*)name
          params:(NSDictionary *)param
         success:(void (^)(id))success
         failure:(void (^)(NSError *error))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager GET:[self requestUrl:[[self.apis valueForKey:name] valueForKey:@"url"]] parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary* respondData){
        NSLog(@"\n----response:%@", respondData);
//        BusinessRetInfo *retInfo = [[BusinessRetInfo alloc] initWithDictionary:respondData dataTypeFromString:[[self.apis valueForKey:name] valueForKey:@""]];
//        success(retInfo.data);
        success(respondData);
    } failure:^(AFHTTPRequestOperation *option, NSError *error){
        NSLog(@"error:%@", error.description);
        failure(error);
    }];
}

-(void)doPost:(NSString*)name
       params:(NSDictionary *)param
      success:(void (^)(BusinessRetInfo*))success
      failure:(void (^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager POST: [self requestUrl:[[self.apis valueForKey:name] valueForKey:@"url"]] parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary* respondData){
        BusinessRetInfo *retInfo = [[BusinessRetInfo alloc] initWithDictionary:respondData dataTypeFromString:[[self.apis valueForKey:name] valueForKey:@""]];
        success(retInfo);
    } failure:^(AFHTTPRequestOperation *option, NSError *error){
        failure(error);
    }];
}

-(void)uploadImg:(NSString*)imageNamed
             url:(NSString*)name
          params:(NSDictionary*)params{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:imageNamed]);
        [formData appendPartWithFileData:imageData name:@"picfile" fileName:imageNamed mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"upload success");
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"upload success");
    }];
}

@end
