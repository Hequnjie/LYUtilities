//
//  UIAlertView+LYUtilities.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/11.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (LYUtilities)

+ (void)setDefaultButtonTitle:(nonnull NSString *)title;

+ (nonnull UIAlertView *)ly_showMessage:(nonnull NSString *)message;
+ (nonnull UIAlertView *)ly_showMessage:(nonnull NSString *)message handler:(void (^__nullable)(UIAlertView * __nonnull alertView, NSInteger buttonIndex))block;

+ (nonnull UIAlertView *)ly_showMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle;
+ (nonnull UIAlertView *)ly_showMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle handler:(void (^__nullable)(UIAlertView * __nonnull alertView, NSInteger buttonIndex))block;

+ (nonnull UIAlertView *)ly_showTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle;
+ (nonnull UIAlertView *)ly_showTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle handler:(void (^__nullable)(UIAlertView * __nonnull alertView, NSInteger buttonIndex))block;

+ (nonnull UIAlertView *)ly_showTitle:(nullable NSString *)title message:(nonnull NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles handler:(void (^__nullable)(UIAlertView * __nonnull alertView, NSInteger buttonIndex))block;

@property (nonatomic, copy, nullable) void (^ly_clickedButtonAtIndexBlock)(UIAlertView * __nonnull alertView, NSInteger buttonIndex);

@end
