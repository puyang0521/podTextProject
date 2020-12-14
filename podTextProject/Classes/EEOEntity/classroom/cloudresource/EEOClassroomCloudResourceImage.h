//
//  EEOClassroomCloudResourceImage.h
//  EEOEntity
//
//  Created by wangpengfei on 2020/4/8.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

NS_ASSUME_NONNULL_BEGIN

@interface EEOClassroomCloudResourceImage : EEOClassroomCloudResource

@property (nonatomic, copy) NSString *jsContent;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, assign) double imageX;
@property (nonatomic, assign) double imageY;
@property (nonatomic, assign) double imageW;
@property (nonatomic, assign) double imageH;

@end

NS_ASSUME_NONNULL_END
