//
//  EEOTeacherToolClock.h
//  EEOEntity
//
//  Created by HeQian on 16/5/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidget.h"

typedef NS_ENUM(NSUInteger,ClockMode) {
    ClockMode_Unknown,
    ClockMode_Settings,
    ClockMode_Timer,
};

extern NSString * const TEACHERWIDGET_CLOCK;

@interface EEOClassroomTeacherWidgetClock : EEOClassroomTeacherWidget

/**
 设置定时器时起始显示的时间,单位:ms
 */
@property (class) NSUInteger initialTime;

@property (nonatomic,copy) NSNumber *targetTime;

@property (nonatomic,assign) ClockMode mode;

@end
