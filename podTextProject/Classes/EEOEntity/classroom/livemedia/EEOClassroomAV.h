//
//  EEOClassroomAV.h
//  EEOEntity
//
//  Created by HeQian on 16/6/25.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEOClassroomAVSlice : NSObject

@property (nonatomic,assign) NSUInteger msgFrameSequence;//与服务端通信消息帧的sequence(每个slice都有唯一的序列)
@property (nonatomic,assign) NSUInteger sequence;//媒体数据整组的sequence(每个slice共用一个序列)

@property (nonatomic,assign) NSUInteger count;
@property (nonatomic,assign) NSUInteger index;

@property (nonatomic,copy) NSData *avData;

- (NSUInteger)fps;

@end

@interface EEOClassroomAV : NSObject

@property (nonatomic,assign) NSUInteger sliceCount;
@property (nonatomic,strong) NSMutableArray<EEOClassroomAVSlice*> *sliceList;

@property (nonatomic,assign) NSUInteger typeFlag;

- (NSInteger)firstSliceMsgFrameSequence;
- (NSInteger)lastSliceMsgFrameSequence;

- (NSInteger)sequence;
- (BOOL)isReady;

- (BOOL)containsSlice:(NSUInteger)sliceMsgSeq;

- (void)insertSlice:(EEOClassroomAVSlice *)slice;

@end
