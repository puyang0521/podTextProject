//
//  NSObject+EEO.h
//  EEOCommon
//
//  Created by eeo开发-东哥 on 2019/7/29.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (EEO)

- (void)safePerformSelector:(SEL)selector;

- (void)safePerformSelector:(SEL)selector withObject:(id)object;

- (void)safePerformSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2;

- (id)safeValuePerformSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
