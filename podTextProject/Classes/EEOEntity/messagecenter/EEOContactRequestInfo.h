//
//  EEOContactRequestInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOMessageCenterInfo.h"

#import "EEOUserInfo.h"

typedef NS_ENUM(NSUInteger,ReplyFlag) {
    ReplyFlag_NonReply,//未回复
    ReplyFlag_Agree,//自己同意
    ReplyFlag_Rejected,//自己拒绝
    ReplyFlag_BeAgree,//被对方同意
    ReplyFlag_BeRejected,//被对方拒绝
};
@interface EEOContactRequestInfo : EEOMessageCenterInfo

@property (nonatomic,copy) NSString *requestContent;
@property (nonatomic,assign) ReplyFlag replyFlag;

/**
 YES:接收到好友请求 NO:自己发出的好友请求
 */
@property (nonatomic,assign) BOOL isReceived;
/**
 这条请求发起的总次数
 */
@property (nonatomic,assign) NSUInteger requestCount;

@property (nonatomic,strong) EEOUserInfo *requestUserInfo;

+ (NSString *)buildRequestContentWithNowTime:(NSUInteger)nowTime message:(NSString *)message;
+ (NSString *)buildReplyContentWithNowTime:(NSUInteger)nowTime message:(NSString *)message;

- (instancetype)initWithUID:(NSNumber *)uid;

- (void)fillRequestContentWithNowTime:(NSUInteger)nowTime message:(NSString *)message;

- (NSString *)requestMessage;

- (BOOL)isExpiredWithNowTime:(NSTimeInterval)nowTime;

- (NSNumber *)uid;
- (NSString *)displayName;
/*
- (EEOUserBasicInfo *)basicInfo;
- (EEOUserDeepInfo *)deepInfo;
- (EEOUserAvatarInfo *)avatarInfo;
*/

@end
