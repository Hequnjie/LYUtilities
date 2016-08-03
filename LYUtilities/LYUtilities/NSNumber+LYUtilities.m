//
//  NSNumber+LYUtilities.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/3.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "NSNumber+LYUtilities.h"

static NSString *_unitTable[] = {
    @"B",
    @"KB",
    @"MB",
    @"GB"
};

@implementation NSNumber (LYUtilities)

- (nullable NSString *)ly_bytesString {
    double x = self.doubleValue;
    int unit = 0;
    while (x >= 1024) {
        x /= 1024.0;
        unit++;
    }
    
    NSString *formatStr;
    // > KB
    if (unit > 1) {
        formatStr = @"%.2f%@";
    } else {
        formatStr = @"%.0f%@";
    }
    
    return [NSString stringWithFormat:formatStr, x, _unitTable[unit]];
}

@end
