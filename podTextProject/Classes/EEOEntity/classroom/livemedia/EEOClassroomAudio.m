//
//  EEOClassroomAudio.m
//  EEOEntity
//
//  Created by 蒋敏 on 16/6/22.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomAudio.h"

@implementation EEOClassroomAudioSlice

- (instancetype)init {
    self = [super init];
    if (self) {
        self.count = 1;
        self.index = 0;
    }
    return self;
}

@end
@implementation EEOClassroomAudio

- (void)insertSlice:(EEOClassroomAVSlice *)slice {
    [self.sliceList addObject:slice];
}

@end
