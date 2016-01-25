//
//  PrivateAssistantTests.m
//  PrivateAssistantTests
//
//  Created by sevenguin on 15/12/28.
//  Copyright © 2015年 weill. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Setting.h"

@interface PrivateAssistantTests : XCTestCase

@end

@implementation PrivateAssistantTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSDictionary* d = @{@"a":@"1", @"b":@"2"};
    NSMutableDictionary* md = [[NSMutableDictionary alloc] initWithDictionary:@{@"c":@"3", @"d":@"4"}];
    
    NSLog(@"before ret:%@", md);
    [md setDictionary:d];
    NSLog(@"after ret:%@", md);
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
