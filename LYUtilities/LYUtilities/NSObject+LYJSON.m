//
//  NSObject+LYJSON.m
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import "NSObject+LYJSON.h"

@implementation NSObject (LYJSON)

- (id)ly_JSONObject {
    __weak NSData *data = nil;
    
    if ([self isKindOfClass:[NSData class]]) {
        data = (NSData *)self;
    } else if ([self isKindOfClass:[NSString class]]){
        data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
    }
    if (data) {
        NSError *error = nil;
        id dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if(error != nil){
            return nil;
        }
        return dataDic;
    }
    return nil;
}

- (NSData *)ly_JSONData {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *parameterData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
        if(error != nil){
            return nil;
        }
        return parameterData;
    }
    return nil;
}

- (NSString *)ly_JSONString {
    NSData *data = [self ly_JSONData];
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

@end
