//
//  MockingUserDefaults.h
//  MockingUserDefaults
//
//  Created by Eike on 05/08/15.
//  Copyright (c) 2015 Eike Klenk. All rights reserved.
//

@import Foundation;

@interface NSUserDefaults (Mocking)

+ (NSUserDefaults *)mockingDefaults;

@end

@interface MockingUserDefaults : NSObject

#pragma mark - Writing Methods

- (void)setObject:(id)value forKey:(NSString *)defaultName;
- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)setFloat:(float)value forKey:(NSString *)defaultName;
- (void)setDouble:(double)value forKey:(NSString *)defaultName;
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
- (void)setURL:(NSURL *)url forKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);

#pragma mark - Reading Methods

- (id)objectForKey:(NSString *)defaultName;
- (NSString *)stringForKey:(NSString *)defaultName;
- (NSArray *)arrayForKey:(NSString *)defaultName;
- (NSDictionary *)dictionaryForKey:(NSString *)defaultName;
- (NSData *)dataForKey:(NSString *)defaultName;
- (NSArray *)stringArrayForKey:(NSString *)defaultName;
- (NSInteger)integerForKey:(NSString *)defaultName;
- (float)floatForKey:(NSString *)defaultName;
- (double)doubleForKey:(NSString *)defaultName;
- (BOOL)boolForKey:(NSString *)defaultName;
- (NSURL *)URLForKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);

#pragma mark - Deletion Methods

- (void)removeObjectForKey:(NSString *)defaultName;

#pragma mark - Additional Methods

- (BOOL)synchronize;

@end
