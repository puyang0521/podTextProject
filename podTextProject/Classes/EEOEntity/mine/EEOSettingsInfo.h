//
//  EEOSettingsInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ReminderType) {
    ReminderType_Unknown = 0,
    ReminderType_Sound,//声音
    ReminderType_Vibrations,//震动
};
@interface EEOSettingsInfo : NSObject

@property (nonatomic,assign) BOOL isReminderMessage;
@property (nonatomic,assign) ReminderType reminderType;
@property (nonatomic,copy) NSString *clientLanguage;
@property (nonatomic,copy) NSString *cacheSize;

@end
