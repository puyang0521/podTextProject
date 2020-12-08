//
//  EEOTimer.m
//  EEOCommon
//
//  Created by 侯嘉晖 on 2020/11/16.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOTimer.h"

@interface EEOTimer()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) EEOTimerBlock timerBlock;

@end

@implementation EEOTimer

- (void)startTimer:(NSTimeInterval)time WithBlock:(EEOTimerBlock)timerBlock {
    _timerBlock = timerBlock;
    if (self.timerBlock) {
        self.timerBlock();
    }
    [self stopTimer];//重置
    self.timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(_timerAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)startTimerWithBlock:(EEOTimerBlock)timerBlock {
    _timerBlock = timerBlock;
    [self stopTimer];//重置
    self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(_timerAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)startSeqNumTimer:(NSTimeInterval)time WithBlock:(EEOTimerBlock)timerBlock {
    _timerBlock = timerBlock;
    [self stopTimer];//重置
    self.timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(_timerAction) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)startNormalTimer:(NSTimeInterval)time WithBlock:(EEOTimerBlock)timerBlock {
    _timerBlock = timerBlock;
    [self stopTimer];//重置
    self.timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(_timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)_timerAction {
    if (self.timerBlock) {
        self.timerBlock();
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

@end
