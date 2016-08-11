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

@interface LY_UIAlertViewDelegate : NSObject <UIAlertViewDelegate>

@property (nonatomic, copy, nullable) void (^ly_clickedButtonAtIndexBlock)(NSInteger buttonIndex);

@end

@implementation LY_UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.ly_clickedButtonAtIndexBlock) {
        self.ly_clickedButtonAtIndexBlock(buttonIndex);
    }
}

@end


@implementation UIAlertView (LYUtilities)

+ (nonnull UIAlertView *)ly_showRemingAlertMessage:(nonnull NSString *)message buttonTitle:(nonnull NSString *)buttonTitle {
    return [self ly_showRemingAlertTitle:nil message:message buttonTitle:buttonTitle];
}

+ (nonnull UIAlertView *)ly_showRemingAlertTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitle:(nonnull NSString *)buttonTitle {
    return [self ly_showAlertWithTitle:title message:message cancelButtonTitle:nil otherButtonTitles:@[buttonTitle]];
}

+ (nonnull UIAlertView *)ly_showAlertWithTitle:(nullable NSString *)title message:(nonnull NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSArray<NSString *> *)otherButtonTitles {
    UIAlertView *alertView = [[[self class] alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *button, NSUInteger idx, BOOL *stop) {
        [alertView addButtonWithTitle:button];
    }];
    [alertView show];
    return alertView;
}

- (void)setLy_clickedButtonAtIndexBlock:(void (^)(NSInteger))ly_clickedButtonAtIndexBlock {
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

- (void (^)(NSInteger))ly_clickedButtonAtIndexBlock {
    return objc_getAssociatedObject(self, &kLY_ClickedButtonAtIndexBlockKeyIdentifier);
}

@end

UIAlertView * _Nonnull ly_showAlertMessage (NSString * _Nonnull message) {
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [al show];
    return al;
}

UIAlertView * _Nonnull ly_showAlert (NSString * _Nullable title,
                                     NSString * _Nonnull message,
                                     id /*<UIAlertViewDelegate>*/ _Nullable delegate,
                                     NSString * _Nullable cancelButtonTitle,
                                     NSArray<NSString *> * _Nullable otherButtonTitles) {
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:title
                                                 message:message
                                                delegate:delegate
                                       cancelButtonTitle:cancelButtonTitle
                                       otherButtonTitles:nil];
    [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *button, NSUInteger idx, BOOL *stop) {
        [al addButtonWithTitle:button];
    }];
    [al show];
    return al;
}