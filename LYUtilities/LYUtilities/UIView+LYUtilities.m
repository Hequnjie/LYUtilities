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

- (CGFloat)left{
    return CGRectGetMinX(self.frame);
}
- (void)setLeft:(CGFloat)left{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.x = left;
        frame;
    });
}

- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}
- (void)setRight:(CGFloat)right{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.x += right - self.right;
        frame;
    });
}

- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}
- (void)setBottom:(CGFloat)bottom{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.y += bottom - self.bottom;
        frame;
    });
}

- (CGFloat)top{
    return CGRectGetMinY(self.frame);
}
- (void)setTop:(CGFloat)top{
    self.frame = ({
        CGRect frame = self.frame;
        frame.origin.y = top;
        frame;
    });
}

- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}
- (void)setWidth:(CGFloat)width{
    self.frame = ({
        CGRect frame = self.frame;
        frame.size.width = width;
        frame;
    });
}

- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height{
    self.frame = ({
        CGRect frame = self.frame;
        frame.size.height = height;
        frame;
    });
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)ly_verticalAlignTo:(nonnull UIView *)view {
    self.center = ({
        CGPoint center = self.center;
        center.x =  view.center.x;
        center;
    });
}

- (void)ly_horizontalAlignTo:(nonnull UIView *)view {
    self.center = ({
        CGPoint center = self.center;
        center.y =  view.center.y;
        center;
    });
}

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


#pragma mark - corner radius

- (void)ly_setCornerRadius:(NSUInteger)radius {
    [self ly_setCornerRadius:radius withBackgroundColor:self.backgroundColor];
}

- (void)ly_setCornerRadius:(NSUInteger)radius withBackgroundColor:(nullable UIColor *)backgroundColor {
    [self ly_setCornerRadius:radius withBackgroundColor:backgroundColor borderColor:nil borderWidth:0];
}

- (void)ly_setCornerRadius:(NSUInteger)radius withBorderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    [self ly_setCornerRadius:radius withBackgroundColor:nil borderColor:borderColor borderWidth:borderWidth];
}

- (void)ly_setCornerRadius:(NSUInteger)radius withBackgroundColor:(nullable UIColor *)backgroundColor borderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.cornerRadius = radius;
    self.layer.backgroundColor = [backgroundColor CGColor];
    self.layer.borderColor = [borderColor CGColor];
    self.layer.borderWidth = borderWidth;
    
    self.layer.masksToBounds = YES;
}


@end
