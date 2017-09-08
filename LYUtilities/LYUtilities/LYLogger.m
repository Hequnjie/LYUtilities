//
//  LYLogger.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "LYLogger.h"

@interface LYLogger ()

@property (nonatomic, strong) dispatch_queue_t workQueue;
@property (nonatomic, strong) NSString *logsDirectory;
@property (nonatomic, copy) NSString *currentFilePath;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSFileHandle *currentFileHandle;

@end


@implementation LYLogger

+ (nonnull instancetype)sharedInstance {
    static dispatch_once_t __singletonToken;
    static id __singleton__;
    dispatch_once( &__singletonToken, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _filePath = [self _defaultLogsDirectory];
        self.logsDirectory = [self _defaultLogsDirectory];
        
        self.workQueue = dispatch_queue_create([@"LYLogger work queue" UTF8String], DISPATCH_QUEUE_SERIAL);
        
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4]; // 10.4+ style
        [_dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
    }
    return self;
}

#pragma mark - save logs

- (void)logMessage:(nonnull NSString *)message {
    dispatch_async(self.workQueue, ^{
        [self _logMessage:message];
    });
}

- (void)logMessageFormat:(nullable NSString *)format, ... {
    va_list args;
    
    if (format) {
        va_start(args, format);
        
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        dispatch_async(self.workQueue, ^{
            [self _logMessage:message];
        });
        
        va_end(args);
    }
}

- (void)_logMessage:(nonnull NSString *)message {
    //must work in self.workQueue
    
    NSString *_nowLogFilePath = [self _nowLogFilePath];
    if (_currentFilePath == nil || ![_currentFilePath isEqualToString:_nowLogFilePath]) {
        _currentFileHandle = nil;
        _currentFilePath = _nowLogFilePath;
    }
    
    if (![message hasSuffix:@"\n"]) {
        message = [message stringByAppendingString:@"\n"];
    }
    
    if (self.dateFormatter) {
        NSString *dateAndTime = [_dateFormatter stringFromDate:[NSDate date]];
        message = [NSString stringWithFormat:@"%@  %@", dateAndTime, message];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:_currentFilePath]) {
        [[NSFileManager defaultManager] createFileAtPath:_currentFilePath contents:nil attributes:nil];
    }
    
    NSData *logData = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.currentFileHandle writeData:logData];
}

#pragma mark - others

- (NSFileHandle *)currentFileHandle {
    if (!_currentFileHandle && _currentFilePath) {
        _currentFileHandle = [NSFileHandle fileHandleForWritingAtPath:_currentFilePath];
        [_currentFileHandle seekToEndOfFile];
    }
    
    return _currentFileHandle;
}

- (NSString *)_defaultLogsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *baseDir = paths.firstObject;
    NSString *logsDirectory = [baseDir stringByAppendingPathComponent:@"LYLogs"];
    return logsDirectory;
}

- (NSString *)_nowLogFilePath {
    return [NSString stringWithFormat:@"%@/%@", self.logsDirectory, self._nowLogFileName];
}

- (NSString *)logsDirectory {
    if (![[NSFileManager defaultManager] fileExistsAtPath:_logsDirectory]) {
        NSError *err = nil;
        
        if (![[NSFileManager defaultManager] createDirectoryAtPath:_logsDirectory
                                       withIntermediateDirectories:YES
                                                        attributes:nil
                                                             error:&err]) {
        }
    }
    
    return _logsDirectory;
}

- (NSString *)_nowLogFileName {
    NSDateFormatter *dateFormatter = self._logFileDateFormatter;
    NSString *formattedDate = [dateFormatter stringFromDate:NSDate.date];
    
    return [NSString stringWithFormat:@"%@.log", formattedDate];
}

- (NSDateFormatter *)_logFileDateFormatter {
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSString *dateFormat = @"yyyy'-'MM'-'dd'";
    NSString *key = [NSString stringWithFormat:@"_logFileDateFormatter.%@", dateFormat];
    NSDateFormatter *dateFormatter = dictionary[key];
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        dictionary[key] = dateFormatter;
    }
    
    return dateFormatter;
}

@end
