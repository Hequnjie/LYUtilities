//
//  NSString+LYUtilities.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "NSString+LYUtilities.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonCryptor.h>
#import "NSData+LYUtilities.h"

@implementation NSString (LYUtilities)

- (nullable NSString *)ly_md5 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return data.ly_md5;
}

#pragma mark - Base64

- (nullable NSData *)ly_base64EncodedData {
    return [self dataUsingEncoding:NSUTF8StringEncoding].ly_base64EncodedData;
}

- (nullable NSString *)ly_base64EncodedString {
    return [self dataUsingEncoding:NSUTF8StringEncoding].ly_base64EncodedString;
}

- (nullable NSData *)ly_base64DecodedData {
    return [self dataUsingEncoding:NSUTF8StringEncoding].ly_base64DecodedData;
}

- (nullable NSString *)ly_base64DecodedString {
    return [self dataUsingEncoding:NSUTF8StringEncoding].ly_base64DecodedString;
}

@end
