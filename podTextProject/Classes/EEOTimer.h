//
//  EEOTimer.h
//  EEOCommon
//
//  Created by 侯嘉晖 on 2020/11/16.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^EEOTimerBlock)(void);

@interface EEOTimer : NSObject

- (void)startTimer:(NSTimeInterval)time WithBlock:(EEOTimerBlock)timerBlock;

- (void)startTimerWithBlock:(EEOTimerBlock)timerBlock;

- (void)startSeqNumTimer:(NSTimeInterval)time WithBlock:(EEOTimerBlock)timerBlock;

- (void)startNormalTimer:(NSTimeInterval)time WithBlock:(EEOTimerBlock)timerBlock;

- (void)stopTimer;

@end

NS_ASSUME_NONNULL_END
