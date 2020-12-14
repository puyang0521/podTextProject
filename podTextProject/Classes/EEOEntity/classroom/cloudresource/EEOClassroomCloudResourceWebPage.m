//
//  EEOClassroomCloudResourceWebPage.m
//  EEOEntity
//
//  Created by 蒋敏 on 2018/4/18.
//  Copyright © 2018年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceWebPage.h"

#import "NSDictionary+EEO.h"

static NSString * const kWebPageSchoolIdKey = @"schoolId";
static NSString * const kWebPageCourseIdKey = @"courseId";
static NSString * const kWebPageClassIdKey = @"classId";
static NSString * const kWebPageURLKey = @"url";
static NSString * const kWebPageUIDKey = @"uid";
static NSString * const kWebPageNickNameKey = @"nickname";
static NSString * const kWebPageIdentityKey = @"identity";
static NSString * const kWebPageTitleKey = @"title";
static NSString * const kWebPageSizeKey = @"size";
static NSString * const kWebPageAuthorityKey = @"classin_authority";

@interface EEOClassroomCloudResourceWebPage(){
    NSDictionary * _jsonContentDic;
    
    CGSize _recommendedSize;
    CGSize _minimumSize;
}
@end

@implementation EEOClassroomCloudResourceWebPage

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_WebPageWidget;
        
        _recommendedSize = CGSizeMake(600.0, 400.0);
        _minimumSize = CGSizeMake(300.0, 200.0);
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceWebPage *result = [super copyWithZone:zone];
    result.jsonContent = self.jsonContent;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceWebPage *target = (EEOClassroomCloudResourceWebPage *)info;
    if(![self.jsonContent isEqualToString:target.jsonContent]){
        return NO;
    }
    
    return YES;
}

- (void)setJsonContent:(NSString *)jsonContent {
    if([_jsonContent isEqualToString:jsonContent]){
        return;
    }
    
    _jsonContent = [jsonContent copy];
    
    if(_jsonContent.length > 0){
        _jsonContentDic = [NSDictionary dictionaryWithJsonString:jsonContent];
    }else{
        _jsonContentDic = nil;
    }
    
    if(_jsonContentDic && _jsonContentDic[kWebPageSizeKey]){
        NSString *sizeInfo = _jsonContentDic[kWebPageSizeKey];
        [self p_parseSizeInfo:sizeInfo];
    }
}
- (void)p_parseSizeInfo:(NSString *)sizeInfo {
    NSArray *sizeStrList = [sizeInfo componentsSeparatedByString:@","];
    for (int i=0; i<sizeStrList.count; i++) {
        NSString *sizeStr = sizeStrList[i];
        NSArray *sizeWHStr = [sizeStr componentsSeparatedByString:@"x"];
        if(sizeWHStr.count == 2){
            float w = [sizeWHStr[0] floatValue];
            float h = [sizeWHStr[1] floatValue];
            if(!isnan(w) && !isnan(h)){
                if(i == 0){//推荐size
                    _recommendedSize = CGSizeMake(w,h);
                }else if(i == 1){//最小size
                    _minimumSize = CGSizeMake(w,h);
                }else{
                    //暂时不用
                }
            }
        }
    }
}

- (NSString *)displayName {
    if([self isExistCustomTitle]){
        return _jsonContentDic[kWebPageTitleKey];
    }else{
        return [super displayName];
    }
}

#pragma mark - Public Methods
- (NSString *)webPageURLStr {
    NSString *result = [_jsonContentDic safeStringObjectForKey:kWebPageURLKey];
    return result;
}

- (CGSize)recommendedSize {
    return _recommendedSize;
}
- (CGSize)minimumSize {
    return _minimumSize;
}

- (BOOL)isNeedUID {
    NSNumber *result = [_jsonContentDic safeNumberObjectForKey:kWebPageUIDKey];
    return [result boolValue];
}
- (BOOL)isNeedNickName {
    NSNumber *result = [_jsonContentDic safeNumberObjectForKey:kWebPageNickNameKey];
    return [result boolValue];
}
- (BOOL)isNeedIdentity {
    NSNumber *result = [_jsonContentDic safeNumberObjectForKey:kWebPageIdentityKey];
    return [result boolValue];
}
- (BOOL)isExistCustomTitle {
    NSNumber *result = [_jsonContentDic safeNumberObjectForKey:kWebPageTitleKey];
    return [result boolValue];
}
- (BOOL)isNeedAuthority {
    NSNumber *result = [_jsonContentDic safeNumberObjectForKey:kWebPageAuthorityKey];
    return [result boolValue];
}

@end
