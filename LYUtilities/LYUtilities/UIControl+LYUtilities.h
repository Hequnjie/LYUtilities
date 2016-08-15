//
//  UIControl+LYUtilities.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/12.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (LYUtilities)

- (void)ly_addEventHandler:(void (^ __nullable)(id __nonnull sender))handler forControlEvents:(UIControlEvents)controlEvents;
- (void)ly_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end
