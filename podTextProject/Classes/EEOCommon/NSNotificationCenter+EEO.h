//
//  NSNotificationCenter+EEO.h
//  EEOCommon
//
//  Created by HeQian on 16/4/21.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (EEO)

+ (instancetype)liveAVCenter;

- (void)postNotificationUseMainQueue:(NSString *)aName object:(id)anObject;

@end
