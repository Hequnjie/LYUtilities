//
//  LYLogger.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LYLogInfo(fmt, ...) [LYLogger.sharedInstance logMessageFormat:(fmt), ## __VA_ARGS__]


@interface LYLogger : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *filePath;

+ (nonnull instancetype)sharedInstance;

- (void)logMessage:(nonnull NSString *)message;

- (void)logMessageFormat:(nullable NSString *)format, ...;

@end
