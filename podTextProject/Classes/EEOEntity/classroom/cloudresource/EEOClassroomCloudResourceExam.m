//
//  EEOClassroomCloudResourceExam.m
//  EEOEntity
//
//  Created by eeo开发-东哥 on 2020/9/21.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceExam.h"

@implementation EEOClassroomCloudResourceExplainExam

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_ExplainExam;
    }
    return self;
}

@end

@implementation EEOClassroomCloudResourceCloudExam

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_CloudExam;
        self.examUrl = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceCloudExam *result = [super copyWithZone:zone];
    result.examUrl = self.examUrl;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    EEOClassroomCloudResourceCloudExam *target = (EEOClassroomCloudResourceCloudExam *)info;
    if (![self.examUrl isEqualToString:target.examUrl]) {
        return NO;
    }
    
    return YES;
}

@end

@implementation EEOClassroomCloudResourceExam

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_Exam;
        self.examID = @"";
        self.examUrl = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceExam *result = [super copyWithZone:zone];
    result.openIndex = self.openIndex;
    result.examStage = self.examStage;
    result.examID = self.examID;
    result.examUrl = self.examUrl;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceExam *target = (EEOClassroomCloudResourceExam *)info;
    if (self.openIndex != target.openIndex) {
        return NO;
    }
    if (self.examStage != target.examStage) {
        return NO;
    }
    if(![self.examID isEqualToString:target.examID]){
        return NO;
    }
    if (![self.examUrl isEqualToString:target.examUrl]) {
        return NO;
    }
    
    return YES;
}

@end
