//
//  NSData+LYUtilities.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LYUtilities)

#pragma mark - MD5

- (nullable NSString *)ly_md5;

#pragma mark - Base64

- (nullable NSData *)ly_base64EncodedData;
- (nullable NSString *)ly_base64EncodedString;
- (nullable NSData *)ly_base64DecodedData;
- (nullable NSString *)ly_base64DecodedString;

#pragma mark - String Value

- (nullable NSString *)ly_utf8StringValue;

@end
