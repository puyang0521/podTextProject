//
//  NSDictionary+EEO.h
//  EEOCommon
//
//  Created by HeQian on 2017/3/8.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (EEO)

+ (instancetype)dictionaryWithJsonString:(NSString *)jsonString;
+(NSString*)dataTOjsonString:(id)object;

//这些函数可以在value为nil或NSNull类型的值时返回对应类型的默认值
- (NSString *)safeStringObjectForKey:(id<NSCopying>)key;
- (NSNumber *)safeNumberObjectForKey:(id<NSCopying>)key;
- (NSInteger)safeIntObjectForKey:(id<NSCopying>)key;
- (double_t)safeDoubleObjectForKey:(id<NSCopying>)key;

- (BOOL)hasKeyAndValueEffective:(id<NSCopying>)key;

@end
