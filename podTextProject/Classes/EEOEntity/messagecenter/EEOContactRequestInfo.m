//
//  EEOContactRequestInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOContactRequestInfo.h"

#import "NSString+EEO.h"
#import "NSDictionary+EEO.h"
#import "NSDate+EEO.h"

@implementation EEOContactRequestInfo

+ (NSString *)buildRequestContentWithNowTime:(NSUInteger)nowTime message:(NSString *)message {
    NSString *result = @"";
    NSDictionary *jsonObj = @{@"date":@(nowTime),@"msg":message};
    result = [NSString jsonStringWithDictionary:jsonObj];
    return result;
}
+ (NSString *)buildReplyContentWithNowTime:(NSUInteger)nowTime message:(NSString *)message {
    NSString *result = @"";
    NSDictionary *jsonObj = @{@"date":@(nowTime),@"msg":message};
    result = [NSString jsonStringWithDictionary:jsonObj];
    return result;
}

- (instancetype)init {
    return [self initWithUID:@(0)];
}

- (instancetype)initWithUID:(NSNumber *)uid {
    self = [super init];
    if(self){
        _requestUserInfo = [[EEOUserInfo alloc] initWithUID:uid];
        _requestContent = @"";
        _isReceived = YES;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOContactRequestInfo *copyObj = [super copyWithZone:zone];
    copyObj.requestContent = self.requestContent;
    copyObj.replyFlag = self.replyFlag;
    copyObj.isReceived = self.isReceived;
    copyObj.requestCount = self.requestCount;
    copyObj.requestUserInfo = self.requestUserInfo;
    return copyObj;
}

- (void)fillRequestContentWithNowTime:(NSUInteger)nowTime message:(NSString *)message {
    NSDictionary *jsonObj = @{@"date":@(nowTime),@"msg":message};
    _requestContent = [NSString jsonStringWithDictionary:jsonObj];
}

//- (NSTimeInterval)messageTime {
//    NSTimeInterval result = 0;
//    if(_requestContent && _requestContent.length > 0){
//        NSDictionary *jsonObj = [NSDictionary dictionaryWithJsonString:_requestContent];
//        result = [jsonObj[@"date"] integerValue];
//    }
//    return result;
//}
- (NSString *)requestMessage {
//    NSString *result = @"";
//    if(_requestContent && _requestContent.length > 0){
//        NSDictionary *jsonObj = [NSDictionary dictionaryWithJsonString:_requestContent];
//        result = jsonObj[@"msg"];
//    }
//    return result;
    
    return _requestContent;
}

- (BOOL)isExpiredWithNowTime:(NSTimeInterval)nowTime {
    BOOL result = NO;
    NSTimeInterval messageTime = self.messageTime;
    if(nowTime > messageTime){
        result = nowTime - messageTime >= D_WEEK;
//        result = nowTime - messageTime >= 120;//TEST...
    }
    return  result;
}

- (NSNumber *)uid {
    return _requestUserInfo.uid;
}
- (NSString *)displayName {
    return _requestUserInfo.displayName;
}
/*
- (EEOUserBasicInfo *)basicInfo {
    return _requestUserInfo.basicInfo;
}
- (EEOUserDeepInfo *)deepInfo {
    return _requestUserInfo.deepInfo;
}
- (EEOUserAvatarInfo *)avatarInfo {
    return _requestUserInfo.avatarInfo;
}
*/

@end
