//
//  UnitTestDemoTests.m
//  UnitTestDemoTests
//
//  Created by xing on 16/7/13.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "AFTestCase.h"
#import "AFNetworking.h"
@interface UnitTestDemoTests : AFTestCase

@end

@implementation UnitTestDemoTests

//每次测试用例执行前的调用方法
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}
//每次测试用例执行后调用方法
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    
    //用于测试耗时操作的代码片段 block
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

//每个方法左侧有个菱形  点击可以单次测试
- (void)testDemo{
    //单元测试的测试用例 命名是固定 -(void)testXXXXX  否则Xcode不会检测到
    
    XCTAssertTrue([self total]);
}
- (BOOL)total{
    return YES;
}

//测试网络请求
- (void)testServer{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    [manager GET:@"http://www.douban.com/j/app/radio/channels"
      parameters:@{@"q":@"你好"}
        progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSLog(@"%@",responseObject);
            XCTAssertTrue([responseObject objectForKey:@"channels"]!=nil);
            //发出异步通知，终止用例
            NOTIFY;
        }
        [manager.session finishTasksAndInvalidate];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error =========%@",[error userInfo]);
        XCTFail(@"请求失败报错提示");
        //发出异步通知，终止用例
        NOTIFY;
        [manager.session finishTasksAndInvalidate];
    }];
    
    //等待测试用例异步请求
    WAIT

    
}

@end
