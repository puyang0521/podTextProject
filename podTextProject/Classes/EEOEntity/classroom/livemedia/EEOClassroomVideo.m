//
//  EEOClassroomVideo.m
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/22.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomVideo.h"

@implementation EEOClassroomVideoSlice

@end
@implementation EEOClassroomVideo

/*
- (BOOL)isReady {
    BOOL result = [super isReady];
    if(result){
        __block BOOL isSequentially = YES;
        [self.sliceList enumerateObjectsUsingBlock:^(EEOClassroomAVSlice * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSUInteger videoSliceIdx = [(EEOClassroomVideoSlice *)obj index];
            isSequentially = videoSliceIdx == idx;
            if(!isSequentially){
                *stop = YES;
            }
        }];
        
        result = isSequentially;
    }
    return result;
}
*/

- (void)insertSlice:(EEOClassroomAVSlice *)slice {
    __block NSInteger finalIndex = self.sliceList.count;
    [self.sliceList enumerateObjectsUsingBlock:^(EEOClassroomAVSlice * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger videoSliceIdx = [(EEOClassroomVideoSlice *)obj index];
        if(((EEOClassroomVideoSlice *)slice).index == videoSliceIdx){//表示已经存在该slice
            finalIndex = NSNotFound;
            *stop = YES;
        }else if(((EEOClassroomVideoSlice *)slice).index < videoSliceIdx){//找到了合适位置
            finalIndex = idx;
            *stop = YES;
        }else{//要插入的sliceIndex比这个大,无需处理...
        }
    }];
    if(finalIndex != NSNotFound){
        [self.sliceList insertObject:slice atIndex:finalIndex];
    }
}

@end
