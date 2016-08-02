//
//  NSURL+LYUtilities.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/2.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "NSURL+LYUtilities.h"
#import "NSString+LYUtilities.h"

@implementation NSURL (LYUtilities)

- (nullable NSDictionary *)ly_QueryComponents {
    return self.query.ly_urlQueryComponents;
}

@end
