//
//  LYReachability.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/15.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYReachability : NSObject

+ (instancetype)reachabilityForInternetConnection;

- (BOOL)isReachable;
- (BOOL)isReachableViaWWAN;
- (BOOL)isReachableViaWiFi;

@end
