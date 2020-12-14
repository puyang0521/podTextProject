//
//  EEOClassroomCloudResourceVNC.m
//  EEOEntity
//
//  Created by 蒋敏 on 2019/3/18.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResourceVNC.h"

#import "NSDictionary+EEO.h"

@interface EEOClassroomCloudResourceVNC (){
    NSDictionary *_jsonContentDic;
}

@end

@implementation EEOClassroomCloudResourceVNC

- (instancetype)init {
    self = [super init];
    if(self){
        self.type = CloudResourceType_VNC;
        self.viewOnly = YES;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomCloudResourceVNC *result = [super copyWithZone:zone];
    result.jsonContent = self.jsonContent;
    return result;
}

- (BOOL)isEqualToCloudResource:(EEOClassroomCloudResource *)info {
    if(![super isEqualToCloudResource:info]){
        return NO;
    }
    
    EEOClassroomCloudResourceVNC *target = (EEOClassroomCloudResourceVNC *)info;
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
}

- (NSString *)serverAddress {
    return _jsonContentDic[@"server"];
}
- (NSUInteger)serverPort {
    NSUInteger result = 0;
    NSNumber *portObj = _jsonContentDic[@"port"];
    result = portObj == nil ? 0 : [portObj integerValue];
    return result;
}
- (NSString *)password {
    return _jsonContentDic[@"pwd"];
}

@end
