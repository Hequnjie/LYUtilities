//
//  NSString+LYUtilities.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LYUtilities)

#pragma mark - MD5

- (nullable NSString *)ly_md5;


#pragma mark - Base64

- (nullable NSData *)ly_base64EncodedData;
- (nullable NSString *)ly_base64EncodedString;
- (nullable NSData *)ly_base64DecodedData;
- (nullable NSString *)ly_base64DecodedString;


#pragma mark - URL Encoding

- (nullable NSString *)ly_addingPercentEncoding;
- (nullable NSString *)ly_removingPercentEncoding;


#pragma mark - URL Query Components

- (nullable NSDictionary *)ly_urlQueryComponents;


#pragma mark - Predicate evaluate

- (BOOL)ly_isMailBox;
- (BOOL)ly_isMobilePhoneNumber;


@end
