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


#pragma mark - Predicate evaluate

- (BOOL)ly_isMailBox {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)ly_isMobilePhoneNumber {
    NSString *mobileRegex = @"^[0-9]{3,4}-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^([0-9]{3,4})[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    return [emailTest evaluateWithObject:self];
}
@end
