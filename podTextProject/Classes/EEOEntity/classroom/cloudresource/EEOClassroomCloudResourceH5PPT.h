//
//  EEOClassroomCloudResourceH5PPT.h
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

@interface EEOClassroomCloudResourceH5PPT : EEOClassroomCloudResource

@property (nonatomic,assign) NSInteger totalPage;
@property (atomic, copy) NSString *statusMsg;
@property (nonatomic, copy) NSString *fileUrl;

@end
