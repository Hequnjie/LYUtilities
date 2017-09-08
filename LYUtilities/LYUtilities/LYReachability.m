//
//  LYReachability.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/15.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "LYReachability.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <sys/socket.h>

NSString *kLYReachabilityChangedNotification = @"kNetworkLYReachabilityChangedNotification";

@interface LYReachability ()

@property (nonatomic, assign) SCNetworkReachabilityRef  reachabilityRef;

@end

@implementation LYReachability

+ (instancetype)reachabilityForInternetConnection {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    return [self reachabilityWithAddress:&zeroAddress];
}

+ (instancetype)reachabilityWithAddress:(void *)hostAddress {
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)hostAddress);
    if (ref) {
        return [[self alloc] initWithReachabilityRef:ref];
    }
    return nil;
}

- (instancetype)initWithReachabilityRef:(SCNetworkReachabilityRef)ref {
    self = [super init];
    if (self != nil) {
        self.reachabilityRef = ref;
    }
    return self;
}

#pragma mark - reachability tests

#define testcase (kSCNetworkReachabilityFlagsConnectionRequired | kSCNetworkReachabilityFlagsTransientConnection)

- (BOOL)isReachableWithFlags:(SCNetworkReachabilityFlags)flags {
    if (!(flags & kSCNetworkReachabilityFlagsReachable))
        return NO;
    
    if ( (flags & testcase) == testcase )
        return NO;
    
#if	TARGET_OS_IPHONE
    if (flags & kSCNetworkReachabilityFlagsIsWWAN)
        return YES;
#endif
    
    return YES;
}

- (BOOL)isReachable {
    SCNetworkReachabilityFlags flags;
    
    if (!SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags))
        return NO;
    
    return [self isReachableWithFlags:flags];
}

- (BOOL)isReachableViaWWAN {
#if	TARGET_OS_IPHONE
    SCNetworkReachabilityFlags flags = 0;
    if (SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags)) {
        // Check we're REACHABLE
        if (flags & kSCNetworkReachabilityFlagsReachable) {
            // Now, check we're on WWAN
            if (flags & kSCNetworkReachabilityFlagsIsWWAN) {
                return YES;
            }
        }
    }
#endif
    
    return NO;
}

- (BOOL)isReachableViaWiFi {
    SCNetworkReachabilityFlags flags = 0;
    if (SCNetworkReachabilityGetFlags(self.reachabilityRef, &flags)) {
        // Check we're reachable
        if ((flags & kSCNetworkReachabilityFlagsReachable)) {
#if	TARGET_OS_IPHONE
            // Check we're NOT on WWAN
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN)) {
                return NO;
            }
#endif
            return YES;
        }
    }
    
    return NO;
}

static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info) {
#pragma unused (target, flags)
    NSCAssert(info != NULL, @"info was NULL in ReachabilityCallback");
    NSCAssert([(__bridge NSObject*) info isKindOfClass: [LYReachability class]], @"info was wrong class in ReachabilityCallback");
    
    LYReachability* noteObject = (__bridge LYReachability *)info;
    // Post a notification to notify the client that the network reachability changed.
    [[NSNotificationCenter defaultCenter] postNotificationName: kLYReachabilityChangedNotification object: noteObject];
}

- (BOOL)startNotifier {
    BOOL returnValue = NO;
    SCNetworkReachabilityContext    context = { 0, NULL, NULL, NULL, NULL };
    context.info = (__bridge void *)self;
    
    if (SCNetworkReachabilitySetCallback(_reachabilityRef, ReachabilityCallback, &context))
    {
        if (SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
        {
            returnValue = YES;
        }
    }
    
    return returnValue;
}

- (void)stopNotifier
{
    if (_reachabilityRef != NULL)
    {
        SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    }
}


@end
