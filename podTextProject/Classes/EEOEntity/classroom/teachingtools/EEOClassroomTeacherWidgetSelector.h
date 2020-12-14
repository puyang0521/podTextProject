//
//  EEOClassroomTeacherWidgetSelector.h
//  EEOEntity
//
//  Created by wangpengfei on 2019/8/24.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidget.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const TEACHERWIDGET_SELECTOR;

@interface EEOClassroomTeacherWidgetSelector : EEOClassroomTeacherWidget

@property (nonatomic, copy) NSNumber *startTime;
@property (nonatomic, copy) NSNumber *selectedUid1;
@property (nonatomic, copy) NSNumber *selectedUid2;
@property (nonatomic, copy) NSNumber *selectedUid3;
@property (nonatomic, assign) int selectorMode;

@end

NS_ASSUME_NONNULL_END
