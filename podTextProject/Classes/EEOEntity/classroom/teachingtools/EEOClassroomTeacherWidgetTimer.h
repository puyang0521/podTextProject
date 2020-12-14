//
//  EEOClassroomTeacherWidgetTimer.h
//  EEOEntity
//
//  Created by wangpengfei on 2019/8/19.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidget.h"

typedef NS_ENUM(NSInteger, TimerStatus) {
    TimerStatusPrepare,
    TimerStatusRockon,
    TimerStatusPause,
    TimerStatusRecover
};

extern NSString * const TEACHERWIDGET_TIMER;

@interface EEOClassroomTeacherWidgetTimer : EEOClassroomTeacherWidget

@property (nonatomic, assign) TimerStatus currentStatus;
@property (nonatomic, copy) NSNumber *startTime;
@property (nonatomic, assign) NSUInteger pauseTime;
@property (nonatomic, assign) NSUInteger currentTime;

@end


