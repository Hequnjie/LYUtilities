//
//  LYMacros.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#ifndef LYMacros_h
#define LYMacros_h


#endif /* LYMacros_h */

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

#define isIOS7                  ( UIDevice.currentDevice.systemVersion.floatValue >= 7.0 )
#define isIOS8                  ( UIDevice.currentDevice.systemVersion.floatValue >= 8.0 )
#define isIOS9                  ( UIDevice.currentDevice.systemVersion.floatValue >= 9.0 )
#define isIOS10                 ( UIDevice.currentDevice.systemVersion.floatValue >= 10.0 )
#define isPad                   ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )

#pragma mark -

