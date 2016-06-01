# MockingUserDefaults

[![Build Status](https://travis-ci.org/Klenkee/MockingUserDefaults.svg)](https://travis-ci.org/Klenkee/MockingUserDefaults)
[![Coverage Status](https://coveralls.io/repos/Klenkee/MockingUserDefaults/badge.svg?ts=1&branch=master&service=github)](https://coveralls.io/github/Klenkee/MockingUserDefaults?branch=master)

`MockingUserDefaults` is a NSUserDefaults replacement for unit tests. The idea is to be independent from the system I/O operations used in NSUserDefaults. Its easy to use and offers the possibility to test code which changes values within NSUserDefaults.

##Installation

###CocoaPods

`MockingUserDefaults` is available through [CocoaPods](https://cocoapods.org/pods/MockingUserDefaults). To install
it, simply add the following line to your Podfile:

```
pod 'MockingUserDefaults'
```

And then just do a

```
pod install
```

in the project directory.0

###Alternative

You may alternatively just copy the contents of the `MockingUserDefaults` folder into your project.

## Use MockingUserDefaults

To start using MockingUserDefaults you have to import the MockingUserDefaults.h:

```
#import <MockingUserDefaults.h>
```
Now you can simply create the mockingDefaults with the NSUserDefaults category method included in the project:

```
NSUserDefaults *userDefaultsMock = [NSUserDefaults mockingDefaults];
```
On this MockingUserDefaults object you can perform most of the methods from NSUserDefaults. See the supported methods list to check out which methods are supported right now.

Example Usage:

```
[userDefaultsMock setObject:@"testString" forKey:@"testKey"];
NSString *testString = [userDefaultsMock stringForKey:@"testKey"];

[userDefaultsMock setInteger:42 forKey:@"anotherTestKey"];
NSInteger theOneAndOnlyNumber = [userDefaultsMock integerForKey:@"anotherTestKey"];
```

## Supported NSUserDefaults Methods
All currently supported NSUserDefaults methods:

###Writing Methods

- (void)setObject:(id)value forKey:(NSString *)defaultName;
- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)setFloat:(float)value forKey:(NSString *)defaultName;
- (void)setDouble:(double)value forKey:(NSString *)defaultName;
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
- (void)setURL:(NSURL *)url forKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);

###Reading Methods

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

###Deletion Methods

- (void)removeObjectForKey:(NSString *)defaultName;

###Additional Methods

- (BOOL)synchronize;

## Notes

Any feedback or pull requests are welcome. If you have questions just write me.

## License

`MockingUserDefaults` is released under the MIT license. See the LICENSE file for more information.
