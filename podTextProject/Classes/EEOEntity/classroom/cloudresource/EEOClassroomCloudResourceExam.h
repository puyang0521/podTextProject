//
//  EEOClassroomCloudResourceExam.h
//  EEOEntity
//
//  Created by eeo开发-东哥 on 2020/9/21.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

NS_ASSUME_NONNULL_BEGIN

@interface EEOClassroomCloudResourceExplainExam : EEOClassroomCloudResource

@end

@interface EEOClassroomCloudResourceCloudExam : EEOClassroomCloudResource
/**
 试题url
 */
@property (nonatomic, copy) NSString *examUrl;

@end

typedef NS_ENUM(NSInteger, CloudResourceExamStage) {
    CloudResourceExamStage_CreateExam = 0,//创建考试
    CloudResourceExamStage_InExam = 1,//考试中
    CloudResourceExamStage_WaitingExplain = 2,//考试结束,等待讲解
    CloudResourceExamStage_Explain = 3,//考试结束,开始讲解
};

@interface EEOClassroomCloudResourceExam : EEOClassroomCloudResource

/**
 打开方式
 0 开始考试    1 讲解考试
 */
@property (nonatomic, assign) NSInteger openIndex;
/**
 当前考试阶段
 */
@property (nonatomic, assign) CloudResourceExamStage examStage;
/**
 考试id
 */
@property (nonatomic, copy) NSString *examID;
/**
 试题url
 */
@property (nonatomic, copy) NSString *examUrl;

@end

NS_ASSUME_NONNULL_END
