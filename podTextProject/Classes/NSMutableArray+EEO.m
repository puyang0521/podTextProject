//
//  NSMutableArray+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/8/23.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSMutableArray+EEO.h"

@implementation NSMutableArray (EEO)

-(id)objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }else{
        return nil;
    }
}

- (CGFloat)CGFloatWithIndex:(NSUInteger)index
{
    id value = [self objectWithIndex:index];
    
    CGFloat f = [value doubleValue];
    
    return f;
}
- (CGPoint)pointWithIndex:(NSUInteger)index
{
    id value = [self objectWithIndex:index];
    
    CGPoint point = CGPointFromString(value);
    
    return point;
}
- (CGSize)sizeWithIndex:(NSUInteger)index
{
    id value = [self objectWithIndex:index];
    
    CGSize size = CGSizeFromString(value);
    
    return size;
}
- (CGRect)rectWithIndex:(NSUInteger)index
{
    id value = [self objectWithIndex:index];
    
    CGRect rect = CGRectFromString(value);
    
    return rect;
}

-(void)addFloat:(float)i
{
    [self addObject:@(i)];
}
-(void)addPoint:(CGPoint)o
{
    [self addObject:NSStringFromCGPoint(o)];
}
-(void)addSize:(CGSize)o
{
    [self addObject:NSStringFromCGSize(o)];
}
-(void)addRect:(CGRect)o
{
    [self addObject:NSStringFromCGRect(o)];
}

- (void)insertRect:(CGRect)o atIndex:(NSUInteger)index {
    [self insertObject:NSStringFromCGRect(o) atIndex:index];
}

@end
