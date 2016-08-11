//
//  UIAlertView+LYUtilities.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/11.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (LYUtilities)

+ (nonnull UIAlertView *)ly_showRemingAlertMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle;
+ (nonnull UIAlertView *)ly_showRemingAlertTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle;

+ (nonnull UIAlertView *)ly_showAlertWithTitle:(nullable NSString *)title message:(nonnull NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles;

@property (nonatomic, copy, nullable) void (^ly_clickedButtonAtIndexBlock)(NSInteger buttonIndex);

@end


UIAlertView * _Nonnull ly_showAlertMessage (NSString * _Nonnull message);
UIAlertView * _Nonnull ly_showAlert (NSString * _Nullable title,
                                     NSString * _Nonnull message,
                                     id /*<UIAlertViewDelegate>*/ _Nullable delegate,
                                     NSString * _Nullable cancelButtonTitle,
                                     NSArray<NSString *> * _Nullable otherButtonTitles);