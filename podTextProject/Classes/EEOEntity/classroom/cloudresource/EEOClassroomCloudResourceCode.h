//
//  EEOClassroomCloudResourceCode.h
//  EEOEntity
//
//  Created by HeQian on 16/6/20.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

@interface EEOClassroomCloudResourceCode : EEOClassroomCloudResource

@property (nonatomic,copy) NSString *fileUrl;
@property (nonatomic,copy) NSString *paletteStatus;
@property (nonatomic,assign) BOOL isSyncScroll;
@property (nonatomic,copy) NSString *fileContent;

- (BOOL)isNativeTextFile;

@end
