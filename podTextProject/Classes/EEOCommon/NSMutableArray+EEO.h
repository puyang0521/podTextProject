//
//  NSMutableArray+EEO.h
//  EEOCommon
//
//  Created by HeQian on 16/8/23.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableArray (EEO)

//CG
- (CGFloat)CGFloatWithIndex:(NSUInteger)index;
- (CGPoint)pointWithIndex:(NSUInteger)index;
- (CGSize)sizeWithIndex:(NSUInteger)index;
- (CGRect)rectWithIndex:(NSUInteger)index;

-(void)addFloat:(float)i;
-(void)addPoint:(CGPoint)o;
-(void)addSize:(CGSize)o;
-(void)addRect:(CGRect)o;

- (void)insertRect:(CGRect)o atIndex:(NSUInteger)index;

@end
