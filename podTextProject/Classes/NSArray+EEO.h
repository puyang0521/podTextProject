//
//  NSArray+EEO.h
//  EEOCommon
//
//  Created by 蒋敏 on 2019/5/24.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (EEO)

/**
 Convert object to json string. return nil if an error occurs.
 NSString/NSNumber/NSDictionary/NSArray
 */
- (nullable NSString *)jsonStringEncoded;

/**
 Convert object to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)jsonPrettyStringEncoded;

- (id)objectAtIndexCheck:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
