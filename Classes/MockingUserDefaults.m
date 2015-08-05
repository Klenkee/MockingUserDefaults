//
//  MockingUserDefaults.m
//  MockingUserDefaults
//
//  Created by Eike Klenk on 05/08/15.
//  Copyright (c) 2015 Eike Klenk. All rights reserved.
//

#import "MockingUserDefaults.h"

#pragma mark - NSUserDefaults Category

@implementation NSUserDefaults (Mocking)

+ (NSUserDefaults *)mockingDefaults
{
    return (id)[[MockingUserDefaults alloc] init];
}

@end

/// Inline method to check if the object has a valid type for NSUserDefaults
static inline BOOL IsPlistType(NSObject *object)
{
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]] ||
        [object isKindOfClass:[NSDate class]] ||
        [object isKindOfClass:[NSData class]])
    {
        return YES;
    }
    else if ([object isKindOfClass:[NSArray class]])
    {
        for (id item in (NSArray *)object)
        {
            if (!IsPlistType(item))
            {
                return NO;
            }
        }
        return YES;
    }
    else if ([object isKindOfClass:[NSDictionary class]])
    {
        for (id key in (NSDictionary *)object)
        {
            if (!IsPlistType(key))
            {
                return NO;
            }
            if (!IsPlistType([(NSDictionary *)object objectForKey:key]))
            {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

@interface MockingUserDefaults ()

@property (nonatomic, strong) NSMutableDictionary* mockingData;

@end

@implementation MockingUserDefaults

#pragma mark - Initializers

- (id)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    self.mockingData = [NSMutableDictionary dictionary];
    return self;
}

#pragma mark - Writing Methods

- (void)setObject:(id)value forKey:(NSString *)defaultName
{
    if (value == nil) {
        return;
    }
    
    if (value != NULL && !IsPlistType(value))
    {
        NSLog(@"%@ is not a valid type to set in NSUserDefaults", value);
        return;
    }
    
    self.mockingData[defaultName] = value;
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
     [self setObject:[NSNumber numberWithInteger:value] forKey:defaultName];
}

- (void)setFloat:(float)value forKey:(NSString *)defaultName
{
    [self setObject:[NSNumber numberWithFloat:value] forKey:defaultName];
}

- (void)setDouble:(double)value forKey:(NSString *)defaultName
{
    [self setObject:[NSNumber numberWithDouble:value] forKey:defaultName];
}

- (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [self setObject:[NSNumber numberWithBool:value] forKey:defaultName];
}

- (void)setURL:(NSURL *)url forKey:(NSString *)defaultName
{
    if ([url isFileURL] || [url isFileReferenceURL])
    {
        [self setObject:[[url absoluteURL] path] forKey:defaultName];
    }
    else
    {
        [self setObject:[NSKeyedArchiver archivedDataWithRootObject:url] forKey:defaultName];
    }
}

#pragma mark - Reading Methods

- (id)objectForKey:(NSString *)defaultName
{
    return self.mockingData[defaultName];
}

- (NSString *)stringForKey:(NSString *)defaultName
{
    id stringObject = self.mockingData[defaultName];
    
    if (![stringObject isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return stringObject;
}

- (NSArray *)arrayForKey:(NSString *)defaultName
{
    id arrayObject = self.mockingData[defaultName];
    
    if (![arrayObject isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    return arrayObject;
}

- (NSDictionary *)dictionaryForKey:(NSString *)defaultName
{
    id dictionaryObject = self.mockingData[defaultName];
    
    if (![dictionaryObject isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    return dictionaryObject;
}

- (NSData *)dataForKey:(NSString *)defaultName
{
    id dataObject = self.mockingData[defaultName];
    
    if (![dataObject isKindOfClass:[NSData class]]) {
        return nil;
    }
    
    return dataObject;
}

- (NSArray *)stringArrayForKey:(NSString *)defaultName
{
    NSArray* arrayObject = [self arrayForKey:defaultName];
    
    if (arrayObject == nil) {
        return nil;
    }
    
    for (id stringObject in arrayObject) {
        if (![stringObject isKindOfClass:[NSString class]]) {
            return nil;
        }
    }
    
    return arrayObject;
}

- (NSInteger)integerForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    
    if (object == nil) {
        return 0;
    }
    
    if (![object respondsToSelector:@selector(integerValue)]) {
        return 0;
    }
    
    return [object integerValue];
}

- (float)floatForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    
    if (object == nil) {
        return 0;
    }
    
    if (![object respondsToSelector:@selector(floatValue)]) {
        return 0;
    }
    
    return [object floatValue];
}

- (double)doubleForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    
    if (object == nil) {
        return 0;
    }
    
    if (![object respondsToSelector:@selector(doubleValue)]) {
        return 0;
    }
    
    return [object doubleValue];
}

- (BOOL)boolForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    
    if (object == nil) {
        return NO;
    }
    
    if (![object respondsToSelector:@selector(boolValue)]) {
        return NO;
    }
    
    return [object boolValue];
}

- (NSURL *)URLForKey:(NSString *)defaultName
{
    id object = [self objectForKey:defaultName];
    
    if ([object isKindOfClass:[NSString class]])
    {
        return [NSURL fileURLWithPath:[object stringByExpandingTildeInPath]];
    }
    else if ([object isKindOfClass:[NSData class]])
    {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:object];
        if ([object isKindOfClass:[NSURL class]])
        {
            return object;
        }
    }
    return nil;
}

#pragma mark - Deletion Methods

- (void)removeObjectForKey:(NSString *)defaultName
{
    [self.mockingData removeObjectForKey:defaultName];
}

#pragma mark - Additional Methods

- (BOOL)synchronize
{
    // No need to synchronize anything while mocking
    return YES;
}


@end
