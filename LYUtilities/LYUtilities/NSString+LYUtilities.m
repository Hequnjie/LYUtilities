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


#pragma mark - filter emoji

/*
+ (NSString *)regularExpressionFilterEmoji:(NSString *)string {
    NSString *str = @"";
    str = @"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\ufeef]";
    str = @"[\\ud800\\udc00-\\udbff\\udfff\\ud800-\\udfff]|[\\u0000-\\u27B0]";
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:str
                                                                                       options:0
                                                                                         error:nil];
    return [regularExpression stringByReplacingMatchesInString:string
                                                       options:0
                                                         range:NSMakeRange(0, string.length)
                                                  withTemplate:@""];
}
 */

/*
 
 1. Emoticons ( 1F601 - 1F64F )
 D83D DE01
 D83D DE4F
 
 2. Dingbats ( 2702 - 27B0 )
 2702
 27B0
 
 3. Transport and map symbols ( 1F680 - 1F6C0 )
 D83D DE80
 D83D DEC0
 
 4. Enclosed characters ( 24C2 - 1F251 )
 24C2
 D83C DD70
 D83C DE51
 
 5. Uncategorized
 0001 20E3
 00A9
 2049
 
 D83C DC04
 D83D DDFF
 
 6a. Additional emoticons ( 1F600 - 1F636 )
 D83D DE00
 D83D DE36
 
 6b. Additional transport and map symbols ( 1F681 - 1F6C5 )
 D83D DE81
 D83D DEC5
 
 6c. Other additional symbols ( 1F30D - 1F567 )
 D83C DF0D
 D83D DD67
 */

- (nullable NSString *)ly_filterEmojiString {
    NSUInteger len = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [self UTF8String];
    char *newUTF8 = malloc(sizeof(char) * len + 1);
    int j = 0;
    
    for (int i = 0; i < len; i++) {
        unsigned int c = *(utf8 + i);
        
        BOOL isControlChar = NO;
        if (c == 0xFFFFFFF0 ||
            (c >= 0xFFFFFF30 && c <= 0xFFFFFF39)) {
            i = i + 3;
            isControlChar = YES;
        }
        
        if (c == 0xFFFFFFE2 || c == 0xFFFFFFE3) {
            i = i + 2;
            isControlChar = YES;
        }
        
        if (c == 0xFFFFFFC2) {
            i = i + 1;
            isControlChar = YES;
        }
        
        if (!isControlChar) {
            newUTF8[j++] = *(utf8 + i);
        }
    }
    newUTF8[j] = '\0';
    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8 encoding:NSUTF8StringEncoding];
    free(newUTF8);
    return encrypted;
}



@end
