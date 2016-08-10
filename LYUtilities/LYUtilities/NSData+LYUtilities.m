//
//  NSData+LYUtilities.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "NSData+LYUtilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (LYUtilities)

#pragma mark - MD5

- (nullable NSString *)ly_md5 {
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(self.bytes,(CC_LONG)self.length, md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

#pragma mark - Base64

- (nullable NSData *)ly_base64EncodedData {
    return [self base64EncodedDataWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

- (nullable NSString *)ly_base64EncodedString {
    return [self base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

- (nullable NSData *)ly_base64DecodedData {
    return [[NSData alloc] initWithBase64EncodedData:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (nullable NSString *)ly_base64DecodedString {
    return [[NSString alloc] initWithData:self.ly_base64DecodedData encoding:NSUTF8StringEncoding];
}

#pragma mark - String Value

- (nullable NSString *)ly_utf8StringValue {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
