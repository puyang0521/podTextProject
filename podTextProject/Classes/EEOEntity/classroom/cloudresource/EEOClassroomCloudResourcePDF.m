//
//  EEOClassroomCloudResourcePDF.m
//  EEOEntity
//
//  Created by HeQian on 16/5/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourcePDF.h"

@implementation EEOClassroomCloudResourcePDF

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_PdfWidget;
        self.syncScroll = YES;
        
        _fileUrl = @"";
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourcePDF *result = [super copyWithZone:zone];
    result.fileUrl = self.fileUrl;
    result.position = self.position;
    result.currentPage = self.currentPage;
    result.syncScroll = self.syncScroll;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourcePDF *target = (EEOClassroomCloudResourcePDF *)info;
    if(![self.fileUrl isEqualToString:target.fileUrl]){
        return NO;
    }
    if(self.currentPage != target.currentPage){
        return NO;
    }
    if(self.position != target.position){
        return NO;
    }
    if (self.syncScroll != target.syncScroll) {
        return NO;
    }
    
    return YES;
}

/*
- (NSInteger)currentPage {
    NSInteger result = 1;
    if(_pdfStatus && _pdfStatus.length > 0){
        NSArray *strList = [_pdfStatus componentsSeparatedByString:@"&"];
        if(strList && strList.count > 0){
            NSString *temp = strList[0];
            NSString *currentPageStr = [temp componentsSeparatedByString:@"="][1];
            result = [currentPageStr intValue];
        }
    }
    return result;
}
*/

@end
