//
//  UIView+LYUtilities.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/3.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "UIView+LYUtilities.h"
#import "LYMacros.h"
#import <objc/runtime.h>

@implementation UIView (LYUtilities)


#pragma mark - calculate size

static void *kCalculatedSizeIdentifier = &kCalculatedSizeIdentifier;

- (void)setLy_calculatedSize:(CGSize)size {
    [self willChangeValueForKey:@LYKeyPath(self, ly_calculatedSize)];
    
    objc_setAssociatedObject(self, &kCalculatedSizeIdentifier, [NSValue valueWithCGSize:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@LYKeyPath(self, ly_calculatedSize)];
}

- (CGSize)ly_calculatedSize {
    NSValue *value = objc_getAssociatedObject(self, &kCalculatedSizeIdentifier);
    if (value) {
        return [value CGSizeValue];
    } else {
        return CGSizeZero;
    }
}

- (CGSize)ly_measure:(CGSize)constrainedSize {
    CGSize sizeThatFits = [self sizeThatFits:constrainedSize];
    self.ly_calculatedSize = sizeThatFits;
    return sizeThatFits;
}


@end
