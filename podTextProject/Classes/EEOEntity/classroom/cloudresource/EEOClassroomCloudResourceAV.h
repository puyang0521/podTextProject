//
//  EEOClassroomCloudResourceAV.h
//  EEOEntity
//
//  Created by HeQian on 16/6/3.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

typedef NS_ENUM(NSUInteger,AVPlaybackStatus) {
    AVPlaybackStatus_Stop,
    AVPlaybackStatus_Play,
    AVPlaybackStatus_Pause,
};

@interface EEOClassroomCloudResourceAV : EEOClassroomCloudResource

@property (nonatomic,assign) NSInteger playbackStatus;
@property (nonatomic,assign) int64_t playPosition;
@property (nonatomic,copy) NSString *fileUrl;
@property (nonatomic,assign) int64_t duration;
@property (nonatomic,copy) NSString *thumbnailUrl;

@end
