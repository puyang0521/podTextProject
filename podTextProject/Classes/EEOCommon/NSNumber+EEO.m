//
//  NSNumber+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/5/8.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSNumber+EEO.h"

@implementation NSNumber (EEO)

+ (NSNumber *)UUIDTimestamp {
    return [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]*1000];
}

@end
