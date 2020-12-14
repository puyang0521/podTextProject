//
//  EEOClassroomCloudResourceCourseware.h
//  EEOEntity
//
//  Created by HeQian on 2016/10/25.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"
#import <UIKit/UIKit.h>

@interface EEOClassroomCloudResourceCourseware : EEOClassroomCloudResource

@property (nonatomic,copy) NSString *appUrl;
@property (nonatomic,copy) NSString *fileUrl;
@property (atomic,copy) NSString *appStatus;
@property (nonatomic,copy) NSString *fileContent;
@property (nonatomic, copy) NSString *widgetSize;

@property (nonatomic, assign) BOOL isTeacherFisrtPrepare;

- (CGSize)recommendedSize;
- (CGSize)minimumSize;

@end
