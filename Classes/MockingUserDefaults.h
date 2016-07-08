//
//  MockingUserDefaults.h
//  MockingUserDefaults
//
//  Created by Eike on 05/08/15.
//  Copyright (c) 2015 Eike Klenk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Mocking)

/**
 NSUserDefaults category class method to return a MockingUserDefaults instance masked as NSUserDefaults instance.
 @return MockingUserDefaults instance masked as NSUserDefaults instance
 */
+ (NSUserDefaults *)mockingDefaults;

@end

/**
 MockingUserDefaults is a NSUserDefaults replacement for unit tests. The idea is to be independent from the system I/O operations used in NSUserDefaults. Its easy to use and offers the possibility to test code which changes values within NSUserDefaults.
 */
@interface MockingUserDefaults : NSObject

#pragma mark - Writing Methods
/**
 Override the setObject:forKey: method from NSUserDefaults.
 */
- (void)setObject:(id)value forKey:(NSString *)defaultName;

/**
 Override the setInteger:forKey: method from NSUserDefaults.
 */
- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;

/**
 Override the setFloat:forKey: method from NSUserDefaults.
 */
- (void)setFloat:(float)value forKey:(NSString *)defaultName;

/**
 Override the setDouble:forKey: method from NSUserDefaults.
 */
- (void)setDouble:(double)value forKey:(NSString *)defaultName;

/**
 Override the setBool:forKey: method from NSUserDefaults.
 */
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

/**
 Override the setURL:forKey: method from NSUserDefaults.
 */
- (void)setURL:(NSURL *)url forKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);

#pragma mark - Reading Methods

/**
 Override the objectForKey: method from NSUserDefaults.
 */
- (id)objectForKey:(NSString *)defaultName;

/**
 Override the stringForKey: method from NSUserDefaults.
 */
- (NSString *)stringForKey:(NSString *)defaultName;

/**
 Override the arrayForKey: method from NSUserDefaults.
 */
- (NSArray *)arrayForKey:(NSString *)defaultName;

/**
 Override the dictionaryForKey: method from NSUserDefaults.
 */
- (NSDictionary *)dictionaryForKey:(NSString *)defaultName;

/**
 Override the dataForKey: method from NSUserDefaults.
 */
- (NSData *)dataForKey:(NSString *)defaultName;

/**
 Override the stringArrayForKey: method from NSUserDefaults.
 */
- (NSArray *)stringArrayForKey:(NSString *)defaultName;

/**
 Override the integerForKey: method from NSUserDefaults.
 */
- (NSInteger)integerForKey:(NSString *)defaultName;

/**
 Override the floatForKey: method from NSUserDefaults.
 */
- (float)floatForKey:(NSString *)defaultName;

/**
 Override the doubleForKey: method from NSUserDefaults.
 */
- (double)doubleForKey:(NSString *)defaultName;

/**
 Override the boolForKey: method from NSUserDefaults.
 */
- (BOOL)boolForKey:(NSString *)defaultName;

/**
 Override the URLForKey: method from NSUserDefaults.
 */
- (NSURL *)URLForKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);

#pragma mark - Deletion Methods

/**
 Override the removeObjectForKey: method from NSUserDefaults.
 */
- (void)removeObjectForKey:(NSString *)defaultName;

#pragma mark - Additional Methods

/**
 Override the synchronize method from NSUserDefaults.
 */
- (BOOL)synchronize;

/**
 Override the dictionaryRepresentation method from NSUserDefaults.
 */
- (NSDictionary<NSString *,id> *)dictionaryRepresentation;


@end
