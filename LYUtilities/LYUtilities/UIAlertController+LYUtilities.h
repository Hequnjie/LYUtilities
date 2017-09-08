//
//  UIAlertController+LYUtilities.h
//  LYUtilities
//
//  Created by hqj on 2017/9/8.
//  Copyright © 2017年 Hequnjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (LYUtilities)

+ (nonnull UIAlertController *)ly_showMessage:(nonnull NSString *)message;
+ (nonnull UIAlertController *)ly_showMessage:(nonnull NSString *)message handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block;

+ (nonnull UIAlertController *)ly_showMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle;
+ (nonnull UIAlertController *)ly_showMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block;

+ (nonnull UIAlertController *)ly_showTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle;
+ (nonnull UIAlertController *)ly_showTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block;

+ (nonnull UIAlertController *)ly_showTitle:(nullable NSString *)title message:(nonnull NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block;

+ (nonnull UIAlertController *)ly_showTitle:(nullable NSString *)title message:(nonnull NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block;

@property (nonatomic, copy, nullable) void (^ly_clickedButtonAtIndexBlock)(UIAlertAction * __nonnull action, NSInteger buttonIndex);

@end
