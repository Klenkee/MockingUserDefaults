//
//  MockingUserDefaultsTests.m
//  MockingUserDefaults
//
//  Created by Eike on 06/08/15.
//  Copyright (c) 2015 Eike Klenk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
// Import class to test
#import "MockingUserDefaults.h"

@interface MockingUserDefaultsTests : XCTestCase

/// The mockingUserDefaults to test with
@property (nonatomic, strong) MockingUserDefaults *mockingUserDefaults;

@end

@implementation MockingUserDefaultsTests

- (void)setUp {
    [super setUp];
    // initialize the mockingUserDefaults property
    self.mockingUserDefaults = [[MockingUserDefaults alloc] init];
}

- (void)tearDown {
    self.mockingUserDefaults = nil;
    [super tearDown];
}

#pragma mark - Category Methods

- (void)testNSUserDefaultsCategoryMocking
{
    NSUserDefaults *userDefaults = [NSUserDefaults mockingDefaults];
    XCTAssertNotNil(userDefaults);
    XCTAssertTrue([userDefaults isKindOfClass:[MockingUserDefaults class]]);
}

#pragma mark - Test Writing Methods

- (void)testObjectForKeyWithNSString
{
    NSString* testObject = @"stringToTest";
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults objectForKey:@"keyToTest"], testObject);
}

- (void)testObjectForKeyWithNSData
{
    NSData* testObject = [NSKeyedArchiver archivedDataWithRootObject:@"dataObjectToTest"];
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    NSData *returnedObjectData = [self.mockingUserDefaults objectForKey:@"keyToTest"];
    XCTAssertEqualObjects(returnedObjectData, testObject);
    XCTAssertEqualObjects([NSKeyedUnarchiver unarchiveObjectWithData:returnedObjectData], @"dataObjectToTest");
}

- (void)testObjectForKeyWithNSDictionary
{
    NSDictionary* testObject = @{@"keyToTest": @"objectToTest"};
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    NSDictionary *returnedDictionary = [self.mockingUserDefaults objectForKey:@"keyToTest"];
    XCTAssertEqualObjects(returnedDictionary, testObject);
    XCTAssertEqualObjects(returnedDictionary[@"keyToTest"], @"objectToTest");
}

- (void)testObjectForKeyWithNil
{
    [self.mockingUserDefaults setObject:nil forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults objectForKey:@"keyToTest"]);
}

- (void)testObjectForKeyWithUnsupportedObject
{
    UIView *testObject = [UIView new];
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults objectForKey:@"keyToTest"]);
}

- (void)testObjectForKeyWithUnsupportedObjectInArray
{
    NSArray *testObject = @[[UIView new]];
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults objectForKey:@"keyToTest"]);
}

- (void)testObjectForKeyWithUnsupportedObjectInDictionary
{
    NSDictionary *testObject = @{@"dictionaryKeyToTest": [UIView new]};
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults objectForKey:@"keyToTest"]);
}

- (void)testObjectForKeyWithUnsupportedObjectAsKeyInDictionary
{
    NSDictionary *testObject = @{[NSSet new]: @"objectToTest"};
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults objectForKey:@"keyToTest"]);
}

- (void)testStringForKeyEmptyString
{
    NSString *testObject = @"";
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults stringForKey:@"keyToTest"], testObject);
}

- (void)testStringForKeyValidValue
{
    NSString *testObject = @"objectToTest";
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults stringForKey:@"keyToTest"], testObject);
}

- (void)testStringForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:@[@"objectToTest"] forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults stringForKey:@"keyToTest"]);
}

- (void)testIntegerForKeyPositiveValue
{
    [self.mockingUserDefaults setInteger:42 forKey:@"keyToTest"];
    XCTAssertEqual([self.mockingUserDefaults integerForKey:@"keyToTest"], 42);
}

- (void)testIntegerForKeyNegativeValue
{
    [self.mockingUserDefaults setInteger:-42 forKey:@"keyToTest"];
    XCTAssertEqual([self.mockingUserDefaults integerForKey:@"keyToTest"], -42);
}

- (void)testIntegerForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:[UIView new] forKey:@"keyToTest"];
    XCTAssertEqual([self.mockingUserDefaults integerForKey:@"keyToTest"], 0);
}

- (void)testIntegerForKeyInvalidValueForInteger
{
    [self.mockingUserDefaults setObject:[NSArray new] forKey:@"keyToTest"];
    XCTAssertEqual([self.mockingUserDefaults integerForKey:@"keyToTest"], 0);
}

- (void)testBoolForKeyPositiveValue
{
    [self.mockingUserDefaults setBool:YES forKey:@"keyToTest"];
    XCTAssertTrue([self.mockingUserDefaults boolForKey:@"keyToTest"]);
}

- (void)testBoolForKeyNegativeValue
{
    [self.mockingUserDefaults setBool:NO forKey:@"keyToTest"];
    XCTAssertFalse([self.mockingUserDefaults boolForKey:@"keyToTest"]);
}

- (void)testBoolForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:[UIView new] forKey:@"keyToTest"];
    XCTAssertFalse([self.mockingUserDefaults boolForKey:@"keyToTest"]);
}

- (void)testBoolForKeyInvalidValueForBool
{
    [self.mockingUserDefaults setObject:[NSArray new] forKey:@"keyToTest"];
    XCTAssertFalse([self.mockingUserDefaults boolForKey:@"keyToTest"]);
}

- (void)testDoubleForKeyPositiveValue
{
    [self.mockingUserDefaults setDouble:1.23 forKey:@"keyToTest"];
    XCTAssertEqualWithAccuracy([self.mockingUserDefaults doubleForKey:@"keyToTest"], 1.23, 0.01);
}

- (void)testDoubleForKeyNegativeValue
{
    [self.mockingUserDefaults setDouble:-1.23 forKey:@"keyToTest"];
    XCTAssertEqualWithAccuracy([self.mockingUserDefaults doubleForKey:@"keyToTest"], -1.23, 0.01);
}

- (void)testDoubleForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:[UIView new] forKey:@"keyToTest"];
    XCTAssertEqual([self.mockingUserDefaults doubleForKey:@"keyToTest"], 0);
}

- (void)testDoubleForKeyInvalidValueForDouble
{
    [self.mockingUserDefaults setObject:[NSArray new] forKey:@"keyToTest"];
    XCTAssertEqual([self.mockingUserDefaults doubleForKey:@"keyToTest"], 0);
}

- (void)testFloatForKeyPositiveValue
{
    [self.mockingUserDefaults setFloat:2.10 forKey:@"keyToTest"];
    XCTAssertEqualWithAccuracy([self.mockingUserDefaults floatForKey:@"keyToTest"], 2.10, 0.01);
}

- (void)testFloatForKeyNegativeValue
{
    [self.mockingUserDefaults setFloat:-2.10 forKey:@"keyToTest"];
    XCTAssertEqualWithAccuracy([self.mockingUserDefaults floatForKey:@"keyToTest"], -2.10, 0.01);
}

- (void)testFloatForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:[UIView new] forKey:@"keyToTest"];
    XCTAssertEqual([self.mockingUserDefaults floatForKey:@"keyToTest"], 0);
}

- (void)testFloatForKeyInvalidValueForFloat
{
    [self.mockingUserDefaults setObject:[NSArray new] forKey:@"keyToTest"];
    XCTAssertEqual([self.mockingUserDefaults floatForKey:@"keyToTest"], 0);
}

- (void)testArrayForKeyEmptyArray
{
    NSArray *testObject = @[];
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults arrayForKey:@"keyToTest"], testObject);
}

- (void)testArrayForKeyValidValue
{
    NSArray *testObject = @[@"objectToTest"];
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults arrayForKey:@"keyToTest"], testObject);
}

- (void)testArrayForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:@"objectToTest" forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults arrayForKey:@"keyToTest"]);
}

- (void)testDictionaryForKeyEmptyDictionary
{
    NSDictionary *testObject = @{};
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults dictionaryForKey:@"keyToTest"], testObject);
}

- (void)testDictionaryForKeyValidValue
{
    NSDictionary *testObject = @{@"dictionaryKeyToTest": @"objectToTest"};
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    NSDictionary *returnedDictionary = [self.mockingUserDefaults dictionaryForKey:@"keyToTest"];
    XCTAssertEqualObjects(returnedDictionary, testObject);
    XCTAssertEqualObjects(returnedDictionary[@"dictionaryKeyToTest"], @"objectToTest");
}

- (void)testDictionaryForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:@"objectToTest" forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults dictionaryForKey:@"keyToTest"]);
}

- (void)testStringArrayForKeyEmptyArray
{
    [self.mockingUserDefaults setObject:@[] forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults stringArrayForKey:@"keyToTest"], @[]);
}

- (void)testStringArrayForKeyValidValue
{
    NSArray *testObject = @[@"stringToTest"];
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    NSArray *returnedObject = [self.mockingUserDefaults stringArrayForKey:@"keyToTest"];
    XCTAssertEqualObjects(returnedObject, testObject);
    XCTAssertEqualObjects(returnedObject.firstObject, @"stringToTest");
}

- (void)testStringArrayForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:@(42) forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults stringArrayForKey:@"keyToTest"]);
}

- (void)testStringArrayForKeyInvalidValueInArray
{
    [self.mockingUserDefaults setObject:@[@(42)] forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults stringArrayForKey:@"keyToTest"]);
}

- (void)testStringArrayForKeyMixedValues
{
    [self.mockingUserDefaults setObject:@[@"stringToTest", @(42)] forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults stringArrayForKey:@"keyToTest"]);
}

- (void)testDataForKeyEmptyData
{
    NSData *testObject = [NSData data];
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults dataForKey:@"keyToTest"], testObject);
}

- (void)testDataForKeyValidValue
{
    NSData *testObject = [NSKeyedArchiver archivedDataWithRootObject:@"stringToTest"];
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    NSData *returnedData = [self.mockingUserDefaults dataForKey:@"keyToTest"];
    XCTAssertEqualObjects(returnedData, testObject);
    XCTAssertEqualObjects([NSKeyedUnarchiver unarchiveObjectWithData:returnedData], @"stringToTest");
}

- (void)testDataForKeyInvalidValue
{
    [self.mockingUserDefaults setObject:@"objectToTest" forKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults dataForKey:@"keyToTest"]);
}

- (void)testURLForKeyValidString
{
    NSString* testObject = @"/foo/bar";
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults URLForKey:@"keyToTest"], [NSURL fileURLWithPath:testObject]);
}

- (void)testURLForKeyValidValue
{
    NSURL *testURL = [NSURL URLWithString:@"http://testurl.com"];
    [self.mockingUserDefaults setURL:testURL forKey:@"keyToTest"];
    NSURL *returnedURL = [self.mockingUserDefaults URLForKey:@"keyToTest"];
    XCTAssertEqualObjects(returnedURL, testURL);
}

- (void)testURLForKeyValidFileUrl
{
    NSURL *testURL = [NSURL URLWithString:@"file:///testFile"];
    [self.mockingUserDefaults setURL:testURL forKey:@"keyToTest"];
    NSURL *returnedURL = [self.mockingUserDefaults URLForKey:@"keyToTest"];
    XCTAssertEqualObjects(returnedURL, testURL);
}

- (void)testURLForKeyNonAvaiableKey
{
    XCTAssertNil([self.mockingUserDefaults URLForKey:@"keyToTest"]);
}

- (void)testRemoveObjectForKey
{
    NSString* testObject = @"stringToTest";
    [self.mockingUserDefaults setObject:testObject forKey:@"keyToTest"];
    XCTAssertEqualObjects([self.mockingUserDefaults objectForKey:@"keyToTest"], testObject);
    [self.mockingUserDefaults removeObjectForKey:@"keyToTest"];
    XCTAssertNil([self.mockingUserDefaults objectForKey:@"keyToTest"]);
}

- (void)testSynchronize
{
    XCTAssertTrue([self.mockingUserDefaults synchronize]);
}


@end
