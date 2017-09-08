//
//  UIAlertController+LYUtilities.m
//  LYUtilities
//
//  Created by hqj on 2017/9/8.
//  Copyright © 2017年 Hequnjie. All rights reserved.
//

#import "UIAlertController+LYUtilities.h"
#import "LYMacros.h"
#import <objc/runtime.h>

static char kLY_ClickedButtonAtIndexBlockKeyIdentifier;

static NSString *ly_defaultButtonTitle = @"ok";

@implementation UIAlertController (LYUtilities)

+ (void)setDefaultButtonTitle:(nonnull NSString *)title {
    ly_defaultButtonTitle = title;
}

+ (nonnull UIAlertController *)ly_showMessage:(nonnull NSString *)message {
    return [self ly_showMessage:message buttonTitle:ly_defaultButtonTitle];
}
+ (nonnull UIAlertController *)ly_showMessage:(nonnull NSString *)message handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block {
    return [self ly_showMessage:message buttonTitle:ly_defaultButtonTitle handler:block];
}

+ (nonnull UIAlertController *)ly_showMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle {
    return [self ly_showTitle:nil message:message buttonTitle:buttonTitle];
}
+ (nonnull UIAlertController *)ly_showMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block {
    return [self ly_showTitle:nil message:message buttonTitle:buttonTitle handler:block];
}

+ (nonnull UIAlertController *)ly_showTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle {
    return [self ly_showTitle:title message:message cancelButtonTitle:nil otherButtonTitles:@[buttonTitle] handler:nil];
}
+ (nonnull UIAlertController *)ly_showTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block {
    return [self ly_showTitle:title message:message cancelButtonTitle:nil otherButtonTitles:@[buttonTitle] handler:block];
}

+ (nonnull UIAlertController *)ly_showTitle:(nullable NSString *)title message:(nonnull NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block {
    return [self ly_showTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles preferredStyle:UIAlertControllerStyleAlert handler:block];
}

+ (nonnull UIAlertController *)ly_showTitle:(nullable NSString *)title message:(nonnull NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void (^__nullable)(UIAlertAction * __nonnull action, NSInteger buttonIndex))block {
    
    UIAlertController *alertController = [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    alertController.ly_clickedButtonAtIndexBlock = block;
    
    if (cancelButtonTitle.length > 0) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(action, 0);
            }
        }];
        [alertController addAction:cancelAction];
    }
    
    if (otherButtonTitles.count > 0) {
        for (NSInteger index = 0; index < otherButtonTitles.count; index++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonTitles[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (block) {
                    block(action, cancelButtonTitle.length > 0 ? index+1 : index);
                }
            }];
            [alertController addAction:action];
        }
    }
    
    [UIApplication.sharedApplication.delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

- (void)setLy_clickedButtonAtIndexBlock:(void (^)(UIAlertAction *, NSInteger))ly_clickedButtonAtIndexBlock {
    [self willChangeValueForKey:@LYKeyPath(self, ly_clickedButtonAtIndexBlock)];
    objc_setAssociatedObject(self, &kLY_ClickedButtonAtIndexBlockKeyIdentifier, ly_clickedButtonAtIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@LYKeyPath(self, ly_clickedButtonAtIndexBlock)];
}

- (void (^)(UIAlertAction * _Nonnull, NSInteger))ly_clickedButtonAtIndexBlock {
    return objc_getAssociatedObject(self, &kLY_ClickedButtonAtIndexBlockKeyIdentifier);
}

@end
