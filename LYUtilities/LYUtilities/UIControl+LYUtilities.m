//
//  UIControl+LYUtilities.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/12.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "UIControl+LYUtilities.h"
#import <objc/runtime.h>

static char kLY_UIControlTargetHandlersKeyIdentifier;

@interface LY_UIControlTarget : NSObject

@property (nonatomic, copy, nullable) void (^handler)(id __nonnull sender);

@end

@implementation LY_UIControlTarget

- (instancetype)initWithHandler:(void (^)(id sender))handler {
    self = [super init];
    if (self) {
        self.handler = handler;
    }
    return self;
}

- (void)invoke:(id)sender {
    self.handler(sender);
}

@end


@implementation UIControl (LYUtilities)

- (NSMutableDictionary *)ly_events {
    
    NSMutableDictionary *events = objc_getAssociatedObject(self, &kLY_UIControlTargetHandlersKeyIdentifier);
    if (!events) {
        events = NSMutableDictionary.new;
        objc_setAssociatedObject(self, &kLY_UIControlTargetHandlersKeyIdentifier, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return events;
}

- (void)ly_addEventHandler:(void (^ __nullable)(id __nonnull sender))handler forControlEvents:(UIControlEvents)controlEvents {
    NSMutableDictionary *events = self.ly_events;
    NSMutableSet *handlers = events[@(controlEvents)];
    
    if (!handlers) {
        handlers = NSMutableSet.set;
        events[@(controlEvents)] = handlers;
    }
    
    LY_UIControlTarget *target = [[LY_UIControlTarget alloc] initWithHandler:handler];
    [handlers addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
}

- (void)ly_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents {
    NSMutableDictionary *events = self.ly_events;
    NSSet *handlers = events[@(controlEvents)];
    
    if (!handlers) {
        return;
    }
    
    [handlers enumerateObjectsUsingBlock:^(id sender, BOOL *stop) {
        [self removeTarget:sender action:NULL forControlEvents:controlEvents];
    }];
    
    [events removeObjectForKey:@(controlEvents)];
}

@end
