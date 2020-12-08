//
//  NSDictionary+EEO.m
//  EEOCommon
//
//  Created by HeQian on 2017/3/8.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import "NSDictionary+EEO.h"

@implementation NSDictionary (EEO)

+ (instancetype)dictionaryWithJsonString:(NSString *)jsonString {
    if ([jsonString isKindOfClass:[NSString class]] && jsonString.length <= 0) {
        return nil;
    }

    if ([jsonString isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)jsonString;
    }
    
    if (![jsonString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err){
        NSLog(@"%s json解析失败：json:%@ err:%@",__func__,jsonString,err);
        return nil;
    }
    return dic;
}

+(NSString*)dataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSString *)safeStringObjectForKey:(id<NSCopying>)key {
    NSString *result = @"";
    id sourceObj = [self objectForKey:key];
    if(sourceObj && ![sourceObj isKindOfClass:[NSNull class]]){
        if(![sourceObj isKindOfClass:[NSString class]]){
            sourceObj = [sourceObj stringValue];
        }
        result = sourceObj;
    }
    return result;
}
- (NSNumber *)safeNumberObjectForKey:(id<NSCopying>)key {
    NSNumber *result = @(0);
    id sourceObj = [self objectForKey:key];
    if(sourceObj && ![sourceObj isKindOfClass:[NSNull class]]){
        if(![sourceObj isKindOfClass:[NSNumber class]]){
            sourceObj = @([sourceObj longLongValue]);
        }
        result = sourceObj;
    }
    return result;
}
- (NSInteger)safeIntObjectForKey:(id<NSCopying>)key {
    NSInteger result = 0;
    id sourceObj = [self objectForKey:key];
    if(sourceObj && ![sourceObj isKindOfClass:[NSNull class]]){
        if([sourceObj isKindOfClass:[NSNumber class]] || [sourceObj isKindOfClass:[NSString class]]){
            result = [sourceObj integerValue];
        }
    }
    return result;
}
- (double_t)safeDoubleObjectForKey:(id<NSCopying>)key {
    double_t result = 0.0;
    id sourceObj = [self objectForKey:key];
    if(sourceObj && ![sourceObj isKindOfClass:[NSNull class]]){
        if([sourceObj isKindOfClass:[NSNumber class]] || [sourceObj isKindOfClass:[NSString class]]){
            result = [sourceObj doubleValue];
        }
    }
    return result;
}

- (BOOL)hasKeyAndValueEffective:(id<NSCopying>)key {
    id sourceObj = [self objectForKey:key];
    BOOL result = sourceObj && ![sourceObj isKindOfClass:[NSNull class]];
    return result;
}

@end
