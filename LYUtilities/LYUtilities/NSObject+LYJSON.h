//
//  NSObject+LYJSON.h
//  LYUtilities
//
//  Created by Hequnjie on 16/8/1.
//  Copyright © 2016年 Hequnjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LYJSON)

/**
 *	@brief	json data or json string ->dictionary or array
 *
 *	@return	dictionary or array
 */
- (nullable id)ly_JSONObject;

/**
 *	@brief	dictionary or array -> json data
 *
 *	@return	json data
 */
- (nullable NSData *)ly_JSONData;

/**
 *	@brief	dictionary or array -> json string
 *
 *	@return	json string
 */
- (nullable NSString *)ly_JSONString;

@end
