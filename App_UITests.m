//
//  App_UITests.m
//  App_UITests
//
//  Created by XDS on 16/9/5.
//  Copyright © 2016年 xds. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface App_UITests : XCTestCase

@end

@implementation App_UITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

#pragma mark 多次重登
- (void)testRepeatLoginInAndOut {
    NSInteger repeatNum = 3;
    for (NSInteger i = 0; i < repeatNum; i ++) {
        if (i % 2 == 0) {
            [self testLogin];
        } else {
            [self testLogout];
        }
    }
}

#pragma mark 登录成功
- (void)testLogin {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"我的"] tap];

    XCUIElement *phontTF = app.textFields[@"请输入11位手机号"];
    if ([phontTF exists] == NO) {
        [self testLogout];
        return;
    }
    [phontTF tap];
    [app.buttons[@"Clear text"] tap];
    [phontTF typeText:@"15155143516"];

    XCUIElement *passwordTF = app.secureTextFields[@"请输入密码"];
    [passwordTF tap];
    [passwordTF typeText:@"123456"];

    XCUIElement *moreNumbersKey = app.keys[@"more, numbers"];
    [moreNumbersKey tap];
    [app.buttons[@"Return"] tap];
    [app.buttons[@"登录"] tap];
}

#pragma mark 登录失败后登录成功
- (void)testFailLogin {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"我的"] tap];
    
    XCUIElement *phontTF = app.textFields[@"请输入11位手机号"];
    if ([phontTF exists] == NO) {
        [self testLogout];
        return;
    }
    
    [phontTF tap];
    [app.buttons[@"Clear text"] tap];
    [phontTF typeText:@"18312345678"];
    
    XCUIElement *passwordTF = app.secureTextFields[@"请输入密码"];
    [passwordTF tap];
    
    XCUIElement *moreNumbersKey = app.keys[@"more, numbers"];
    [moreNumbersKey tap];
    [passwordTF typeText:@"1234567"];
    
    
    [app.buttons[@"Return"] tap];
    [app.buttons[@"登录"] tap];
    
    [app.alerts[@"提示"].collectionViews.buttons[@"确定"] tap];
    
    [phontTF tap];
    [app.buttons[@"Clear text"] tap];
    [phontTF typeText:@"15155143516"];
    
    [passwordTF tap];
    [app.buttons[@"Clear text"] tap];
    
    [moreNumbersKey tap];
    [passwordTF typeText:@"123456"];
    
    [app.buttons[@"Return"] tap];
    [app.buttons[@"登录"] tap];
}

#pragma mark 退出账号
- (void)testLogout {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tabBars.buttons[@"我的"] tap];
    XCUIElement *setupBtn = app.buttons[@"icon set up"];
    if ([setupBtn exists] == NO) {
        [self testLogin];
        [app.tabBars.buttons[@"我的"] tap];
    }
    [setupBtn tap];
    [app.buttons[@"退出当前账号"] tap];
    [app.alerts[@"温馨提示"].collectionViews.buttons[@"确定"] tap];
}

@end
