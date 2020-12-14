//
//  EEOClassroomTeacherWidgetAwardList.m
//  EEOEntity
//
//  Created by wangpengfei on 2019/3/26.
//  Copyright © 2019年 jiangmin. All rights reserved.
//

#import "EEOClassroomTeacherWidgetAwardList.h"

NSString * const TEACHERWIDGET_AWARDLIST = @"AwardList";

@implementation EEOClassroomTeacherWidgetAwardList

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomTeacherWidgetAwardList *copyObj = [super copyWithZone:zone];
    copyObj.offset = self.offset;
    return copyObj;
}

- (BOOL)isEqualToTeacherWidget:(EEOClassroomTeacherWidget *)info {
    if(![super isEqualToTeacherWidget:info]){
        return NO;
    }
    EEOClassroomTeacherWidgetAwardList *awardInfo = (EEOClassroomTeacherWidgetAwardList *)info;
    if (awardInfo.offset != self.offset) {
        return NO;
    }
    return YES;
}

- (void)cloneWitgetInfo:(EEOClassroomTeacherWidget *)widgetInfo {
    [super cloneWitgetInfo:widgetInfo];
    
    self.offset = [(EEOClassroomTeacherWidgetAwardList *)widgetInfo offset];
}

- (NSString*)toolName {
    return TEACHERWIDGET_AWARDLIST;
}

@end
