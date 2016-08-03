//
//  UIView+LYUtilities.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/3.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYUtilities)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)ly_verticalAlignTo:(nonnull UIView *)view;
- (void)ly_horizontalAlignTo:(nonnull UIView *)view;


#pragma mark - calculate size

- (CGSize)ly_measure:(CGSize)constrainedSize;
- (CGSize)ly_calculatedSize;


#pragma mark - corner radius

- (void)ly_setCornerRadius:(NSUInteger)radius;
- (void)ly_setCornerRadius:(NSUInteger)radius withBackgroundColor:(nullable UIColor *)backgroundColor;
- (void)ly_setCornerRadius:(NSUInteger)radius withBorderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
- (void)ly_setCornerRadius:(NSUInteger)radius withBackgroundColor:(nullable UIColor *)backgroundColor borderColor:(nullable UIColor *)borderColor borderWidth:(CGFloat)borderWidth;


@end
