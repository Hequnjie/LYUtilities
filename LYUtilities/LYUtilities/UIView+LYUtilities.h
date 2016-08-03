//
//  UIView+LYUtilities.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/3.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LYUtilities)

#pragma mark - calculate size

- (CGSize)ly_measure:(CGSize)constrainedSize;
- (CGSize)ly_calculatedSize;

@end
