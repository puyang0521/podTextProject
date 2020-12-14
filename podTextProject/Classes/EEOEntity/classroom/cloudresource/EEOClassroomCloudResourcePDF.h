//
//  EEOClassroomCloudResourcePDF.h
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

@interface EEOClassroomCloudResourcePDF : EEOClassroomCloudResource

@property (atomic,copy) NSString *pdfStatus;
@property (nonatomic,copy) NSString *fileUrl;
@property (nonatomic,assign) NSUInteger totalContentWidth;
@property (nonatomic,assign) NSUInteger totalContentHeight;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger position;
@property (nonatomic,assign) BOOL syncScroll;

//- (NSInteger)currentPage;

@end
