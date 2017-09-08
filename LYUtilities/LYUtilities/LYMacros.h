//
//  LYMacros.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#ifndef LYMacros_h
#define LYMacros_h


#pragma mark - weakify and strongify

#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
    _Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
    _Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    try{} @finally{} __typeof__(x) x = __weak_##x##__; \
    _Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    try{} @finally{} __typeof__(x) x = __block_##x##__; \
    _Pragma("clang diagnostic pop")

#endif
#endif


#pragma mark - iOS Version

#define IS_IOS7                  ( UIDevice.currentDevice.systemVersion.floatValue >= 7.0 )
#define IS_IOS8                  ( UIDevice.currentDevice.systemVersion.floatValue >= 8.0 )
#define IS_IOS9                  ( UIDevice.currentDevice.systemVersion.floatValue >= 9.0 )
#define IS_IOS10                 ( UIDevice.currentDevice.systemVersion.floatValue >= 10.0 )
#define IS_Pad                   ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )


#pragma mark - mainScreen height and width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


#pragma mark - NSUserDefaults

//obj
#define LYUserDefaultsSetObj(obj,key) \
do { \
[[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; \
} while (0)

#define LYUserDefaultsObjForKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define LYUserDefaultsRemoveObjForKey(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]

//Integer
#define LYUserDefaultsSetInteger(intNum,key) \
do { \
[[NSUserDefaults standardUserDefaults] setInteger:intNum forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; \
} while (0)
#define LYUserDefaultsIntegerForKey(key) [[NSUserDefaults standardUserDefaults] integerForKey:key]

//Float
#define LYUserDefaultsSetFloat(floatNum,key) \
do { \
[[NSUserDefaults standardUserDefaults] setFloat:floatNum forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; \
} while (0)
#define LYUserDefaultsFloatForKey(key) [[NSUserDefaults standardUserDefaults] floatForKey:key]

//Double
#define LYUserDefaultsSetDouble(doubleNum,key) \
do { \
[[NSUserDefaults standardUserDefaults] setDouble:doubleNum forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; \
} while (0)
#define LYUserDefaultsDoubleForKey(key) [[NSUserDefaults standardUserDefaults] doubleForKey:key]

//Bool
#define LYUserDefaultsSetBool(yesOrNo,key) \
do { \
[[NSUserDefaults standardUserDefaults] setBool:yesOrNo forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; \
} while (0)
#define LYUserDefaultsBoolForKey(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]

//URL
#define LYUserDefaultsSetURL(url,key) \
do { \
[[NSUserDefaults standardUserDefaults] setURL:url forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; \
} while (0)
#define LYUserDefaultsURLForKey(key) [[NSUserDefaults standardUserDefaults] URLForKey:key]


#pragma mark - Colors

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define HexCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexACOLOR(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


#pragma mark - UIImages

#define IMGStretchable(img,w,h) [[UIImage imageNamed:(img)] stretchableImageWithLeftCapWidth:(w) topCapHeight:(h)]


#pragma mark - Notification

#define LYPostNotification(name,obj,uinfo)         ([[NSNotificationCenter defaultCenter] \
                                                            postNotificationName:name \
                                                            object:obj \
                                                            userInfo:uinfo])

#pragma mark - Device type

#define DEVICE_IS_IPHONE4S          ([[UIScreen mainScreen] bounds].size.height == 480)
#define DEVICE_IS_IPHONE5           ([[UIScreen mainScreen] bounds].size.height == 568)
#define DEVICE_IS_IPHONE6           ([[UIScreen mainScreen] bounds].size.height == 667)
#define DEVICE_IS_IPHONE6_Plus      ([[UIScreen mainScreen] bounds].size.height == 736)


#pragma mark - name and version

#define APP_DISPLAY_NAME    [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APP_VERSION     	[NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APP_BUILD_NUMBER    [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"]


#pragma mark - paths

#define kPathDocument       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define kPathLibrary        [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]
#define kPathCache          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define kPathTemp           NSTemporaryDirectory()


#pragma mark - object key path

#define LYKeyPath(objc,keyPath)   (((void)objc.keyPath, #keyPath))



#endif /* LYMacros_h */

