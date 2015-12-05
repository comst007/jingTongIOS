//
//  LZTableViewFunTests.m
//  LZTableViewFunTests
//
//  Created by comst on 15/12/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface LZTableViewFunTests : XCTestCase

@end

@implementation LZTableViewFunTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    NSArray *sourceArray = @[@"hello", @"she", @"world", @"how"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" SELF CONTAINS[c] %@", @"he"];
    
    NSArray *array = [sourceArray filteredArrayUsingPredicate:predicate];
    
    NSLog(@"%@", array);
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
