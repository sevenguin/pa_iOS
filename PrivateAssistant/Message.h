//
//  Message.h
//  PrivateAssistant
//
//  Created by sevenguin on 16/1/27.
//  Copyright © 2016年 weill. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MACHINE_MESSAGE_TYPE,
    SELF_MESSAGE_TYPE
}MessageType;

@interface Message : NSObject

@property(nonatomic)NSString *time;
@property(nonatomic)NSString *message;
@property(nonatomic)NSString *header;
@property(nonatomic)MessageType messageType;

@end
