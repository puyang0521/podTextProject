//
//  EEOClassroomAV.m
//  EEOEntity
//
//  Created by HeQian on 16/6/25.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomAV.h"

@implementation EEOClassroomAVSlice

- (NSUInteger)fps {
    NSUInteger result = 0;
    if(_index == 0 && _avData.length > 1){
        uint8_t fps;
        [_avData getBytes:&fps length:sizeof(uint8_t)];
        result = fps;
    }
    return result;
}

@end

@interface EEOClassroomAV (){
    NSInteger _sequence;
}

@end
@implementation EEOClassroomAV

- (instancetype)init {
    self = [super init];
    if(self){
        _sequence = -1;
        
        _sliceCount = 1;
        _sliceList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)firstSliceMsgFrameSequence {
    NSInteger result = -1;
    EEOClassroomAVSlice *slice = [_sliceList firstObject];
    if(slice){
        result = slice.msgFrameSequence;
    }
    return result;
}
- (NSInteger)lastSliceMsgFrameSequence {
    NSInteger result = -1;
    EEOClassroomAVSlice *slice = [_sliceList lastObject];
    if(slice){
        result = slice.msgFrameSequence;
    }
    return result;
}

- (NSInteger)sequence {
    if(_sequence > 0){
        return _sequence;
    }else{
        EEOClassroomAVSlice *slice = [_sliceList firstObject];
        if(slice){
            _sequence = slice.sequence;
        }
        return _sequence;
    }
}
- (BOOL)isReady {
    return _sliceCount == _sliceList.count;
}

- (BOOL)containsSlice:(NSUInteger)sliceMsgSeq {
    BOOL result = NO;
    for (EEOClassroomAVSlice *sliceInfo in _sliceList) {
        if(sliceInfo.msgFrameSequence == sliceMsgSeq){
            result = YES;
            break;
        }
    }
    return result;
}

- (void)insertSlice:(EEOClassroomAVSlice *)slice {
    //子类实现
}

@end
