//
//  EEOClassroomCloudResourceH5Excel.h
//  EEOEntity
//
//  Created by 侯嘉晖 on 2020/8/20.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

NS_ASSUME_NONNULL_BEGIN

@interface EEOClassroomCloudResourceH5Excel : EEOClassroomCloudResource

@property (nonatomic, copy) NSString *fileUrl;

@property (nonatomic, copy) NSString *htmlStatusMsg;

@property (nonatomic, assign, readonly) CGSize recommendedSize;
@property (nonatomic, assign, readonly) CGSize minimumSize;

@end

NS_ASSUME_NONNULL_END
