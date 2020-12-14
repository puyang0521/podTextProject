//
//  NSNotificationCenter+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/4/21.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSNotificationCenter+EEO.h"

@implementation NSNotificationCenter (EEO)

+ (instancetype)liveAVCenter {
    static NSNotificationCenter *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [[self alloc] init];
    });
    return result;
}

- (void)postNotificationUseMainQueue:(NSString *)aName object:(id)anObject {
    if([[NSThread currentThread] isMainThread]){
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
        });
    }
}

@end
