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


#pragma mark - URL Encoding

- (nullable NSString *)ly_addingPercentEncoding {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    /*
     [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
     */
}

- (nullable NSString *)ly_removingPercentEncoding {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    /*
     self.stringByRemovingPercentEncoding
     */
}

#pragma mark - URL Query Components

- (nullable NSDictionary *)ly_urlQueryComponents {
    
    NSArray *pairs = [self.ly_removingPercentEncoding componentsSeparatedByString:@"&"];
    if (pairs.count == 0) {
        return nil;
    }
    
    NSMutableDictionary *decoded = NSMutableDictionary.new;
    
    for (NSString *queryString in pairs) {
        NSArray<NSString *> *parts = [queryString componentsSeparatedByString:@"="];
        if (parts.count == 1) {
            decoded[parts[0]] = @"";
        } else if (parts.count == 2) {
            decoded[parts[0]] = parts[1];
        } else if (parts.count > 2) {
            NSRange range = [queryString rangeOfString:@"="];
            if (range.location != NSNotFound) {
                decoded[parts[0]] = [queryString substringFromIndex:range.location + 1] ?: @"";
            }
        }
    }
    
    return decoded;
}


@end
