//
//  EEOClassroomCloudResourceH5Excel.m
//  EEOEntity
//
//  Created by 侯嘉晖 on 2020/8/20.
//  Copyright © 2020 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceH5Excel.h"
#import "NSString+EEO.h"
#import "NSDictionary+EEO.h"

static NSString * const kHtmlExcelUrlKey = @"fileUrl";
static NSString * const kHtmlExcelStatusKey = @"statusMsg";

@interface EEOClassroomCloudResourceH5Excel()

@property (nonatomic, strong) NSMutableDictionary *contentInfo;
@property (nonatomic, assign) CGSize recommendedSize;
@property (nonatomic, assign) CGSize minimumSize;

@end

@implementation EEOClassroomCloudResourceH5Excel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = CloudResourceType_htmlExcelWidget;
        self.contentInfo = [NSMutableDictionary new];
        
        _recommendedSize = CGSizeMake(600.0, 360.0);
        _minimumSize = CGSizeMake(300.0, 180.0);
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceH5Excel *result = [super copyWithZone:zone];
    result.fileUrl = self.fileUrl;
    result.htmlStatusMsg = self.htmlStatusMsg;
    result.recommendedSize = self.recommendedSize;
    result.minimumSize = self.minimumSize;
    return result;
}

- (void)setFileUrl:(NSString *)fileUrl {
    _fileUrl = fileUrl;
    if (fileUrl) {
        [self.contentInfo setObject:fileUrl forKey:kHtmlExcelUrlKey];
    }
}

- (void)setHtmlStatusMsg:(NSString *)htmlStatusMsg {
    _htmlStatusMsg = htmlStatusMsg;
    if (htmlStatusMsg) {
        [self.contentInfo setObject:htmlStatusMsg forKey:kHtmlExcelStatusKey];
    }
}

@end
