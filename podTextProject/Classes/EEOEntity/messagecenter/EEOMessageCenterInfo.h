//
//  EEOMessageCenterInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/27.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,MessageCenterReadStatus) {
    MessageCenterReadStatus_Unread,
    MessageCenterReadStatus_Read,
};
@interface EEOMessageCenterInfo : NSObject<NSCopying>

@property (nonatomic,assign) NSUInteger messageId;
@property (nonatomic,assign) NSTimeInterval messageTime;
@property (nonatomic,assign) MessageCenterReadStatus readStatus;

@end
