//
//  UIAlertView+LYUtilities.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/11.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "UIAlertView+LYUtilities.h"
#import "LYMacros.h"
#import <objc/runtime.h>

static char kLY_ClickedButtonAtIndexBlockKeyIdentifier;
static char kLY_UIAlertViewDelegateKeyIdentifier;

static NSString *ly_defaultButtonTitle = @"ok";

@interface LY_UIAlertViewDelegate : NSObject <UIAlertViewDelegate>

@property (nonatomic, copy, nullable) void (^ly_clickedButtonAtIndexBlock)(UIAlertView * __nonnull alertView, NSInteger buttonIndex);

@end

@implementation LY_UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.ly_clickedButtonAtIndexBlock) {
        self.ly_clickedButtonAtIndexBlock(alertView, buttonIndex);
    }
}

@end


@implementation UIAlertView (LYUtilities)

+ (void)setDefaultButtonTitle:(nonnull NSString *)title {
    ly_defaultButtonTitle = title;
}

+ (nonnull UIAlertView *)ly_showMessage:(nonnull NSString *)message {
    return [self ly_showMessage:message buttonTitle:ly_defaultButtonTitle];
}
+ (nonnull UIAlertView *)ly_showMessage:(nonnull NSString *)message handler:(void (^__nullable)(UIAlertView * __nonnull alertView, NSInteger buttonIndex))block {
    return [self ly_showMessage:message buttonTitle:ly_defaultButtonTitle handler:block];
}

+ (nonnull UIAlertView *)ly_showMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle {
    return [self ly_showTitle:nil message:message buttonTitle:buttonTitle];
}
+ (nonnull UIAlertView *)ly_showMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle handler:(void (^__nullable)(UIAlertView * __nonnull alertView, NSInteger buttonIndex))block {
    return [self ly_showTitle:nil message:message buttonTitle:buttonTitle handler:block];
}

+ (nonnull UIAlertView *)ly_showTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle {
    return [self ly_showTitle:title message:message cancelButtonTitle:nil otherButtonTitles:@[buttonTitle] handler:nil];
}
+ (nonnull UIAlertView *)ly_showTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle handler:(void (^__nullable)(UIAlertView * __nonnull alertView, NSInteger buttonIndex))block {
    return [self ly_showTitle:title message:message cancelButtonTitle:nil otherButtonTitles:@[buttonTitle] handler:block];
}

+ (nonnull UIAlertView *)ly_showTitle:(nullable NSString *)title message:(nonnull NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles handler:(void (^__nullable)(UIAlertView * __nonnull alertView, NSInteger buttonIndex))block {
    UIAlertView *alertView = [[[self class] alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *button, NSUInteger idx, BOOL *stop) {
        [alertView addButtonWithTitle:button];
    }];
    alertView.ly_clickedButtonAtIndexBlock = block;
    
    [alertView show];
    return alertView;
}

- (void)setLy_clickedButtonAtIndexBlock:(void (^)(UIAlertView *, NSInteger))ly_clickedButtonAtIndexBlock {
    [self willChangeValueForKey:@LYKeyPath(self, ly_clickedButtonAtIndexBlock)];
    objc_setAssociatedObject(self, &kLY_ClickedButtonAtIndexBlockKeyIdentifier, ly_clickedButtonAtIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@LYKeyPath(self, ly_clickedButtonAtIndexBlock)];
    
    if (ly_clickedButtonAtIndexBlock) {
        LY_UIAlertViewDelegate *delegate = LY_UIAlertViewDelegate.new;
        delegate.ly_clickedButtonAtIndexBlock = ly_clickedButtonAtIndexBlock;
        
        objc_setAssociatedObject(self, &kLY_UIAlertViewDelegateKeyIdentifier, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        self.delegate = delegate;
    } else {
        self.delegate = nil;
    }
}

- (void (^)(UIAlertView * _Nonnull, NSInteger))ly_clickedButtonAtIndexBlock {
    return objc_getAssociatedObject(self, &kLY_ClickedButtonAtIndexBlockKeyIdentifier);
}

@end

