//
//  NSObject+EEO.m
//  EEOCommon
//
//  Created by eeo开发-东哥 on 2019/7/29.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "NSObject+EEO.h"

@implementation NSObject (EEO)

- (void)safePerformSelector:(SEL)selector{
    if([self respondsToSelector:selector]){
        IMP imp = [self methodForSelector:selector];
        void (*func)(id,SEL) = (void *)imp;
        func(self,selector);
    }
}

- (void)safePerformSelector:(SEL)selector withObject:(id)object{
    if([self respondsToSelector:selector]){
        IMP imp = [self methodForSelector:selector];
        void (*func)(id,SEL,id) = (void *)imp;
        func(self,selector,object);
    }
}

- (void)safePerformSelector:(SEL)selector withObject:(id)object1 withObject:(id)object2{
    if([self respondsToSelector:selector]){
        IMP imp = [self methodForSelector:selector];
        void (*func)(id,SEL,id,id) = (void *)imp;
        func(self,selector,object1,object2);
    }
}

- (id)safeValuePerformSelector:(SEL)selector{
    if([self respondsToSelector:selector]){
        IMP imp = [self methodForSelector:selector];
        id (*func)(id,SEL) = (void *)imp;
        return func(self,selector);
    }
    return nil;
}

@end
