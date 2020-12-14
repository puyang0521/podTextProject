//
//  EEOClassReminderInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassReminderInfo.h"

#import "NSString+EEO.h"

@implementation EEOClassReminderInfo

+ (NSString *)classNameChangedContentFromOldName:(NSString *)oldName newName:(NSString *)newName {
    NSString *result = @"";
    NSDictionary *contentDic = @{@"oldName":oldName,@"newName":newName};
    result = [NSString jsonStringWithDictionary:contentDic];
    return result;
}
+ (NSString *)memberJoinClassContentFromMemberInfoList:(NSArray *)memberInfoList {
    NSString *result = @"";
    NSDictionary *contentDic = @{@"memberInfoList":memberInfoList};
    result = [NSString jsonStringWithDictionary:contentDic];
    return result;
}
+ (NSString *)memberKickoutClassContentFromMemberInfoList:(NSArray *)memberInfoList {
    NSString *result = @"";
    NSDictionary *contentDic = @{@"memberInfoList":memberInfoList};
    result = [NSString jsonStringWithDictionary:contentDic];
    return result;
}

- (instancetype)init {
    self = [super init];
    if(self){
        self.classID = @(0);
        self.reminderContent = @"";
    }
    return self;
}

- (NSString *)className {
    NSString *result = @"";
    if(_classInfo && _classInfo.displayName){
        result = _classInfo.displayName;
    }
    return result;
}
- (NSData *)avatarData {
    return nil;
//    return _classInfo.avatarData;
}

@end
