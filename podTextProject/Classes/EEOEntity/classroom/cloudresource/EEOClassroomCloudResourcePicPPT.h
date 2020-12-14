//
//  EEOClassroomCloudResourcePicPPT.h
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

@interface EEOClassroomCloudResourcePicPPT : EEOClassroomCloudResource

@property (atomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger totalPage;
@property (atomic,copy) NSString *pptStyle;

@end
