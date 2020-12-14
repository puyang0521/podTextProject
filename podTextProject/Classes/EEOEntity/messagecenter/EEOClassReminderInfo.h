//
//  EEOClassReminderInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/26.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOMessageCenterInfo.h"

#import "EEOClassInfo.h"

typedef NS_ENUM(NSUInteger,ClassReminderType){
    ClassReminderType_Unknown,
    ClassReminderType_ClassCreated,//你创建了班级
    ClassReminderType_AppointmentToClassTeacher,//你被任命为班主任了
    ClassReminderType_CancelledAppointmentFromClassTeacher,//你的班主任身份被取消了
    ClassReminderType_ClassNameChanged,//班级名称由 "XXX" 修改为了 "XXX"
    ClassReminderType_ClassDismissed,//班级已解散
    ClassReminderType_MembersJoinClass,//有人加入了班级
    ClassReminderType_MineJoinToClass,//我加入了班级
    ClassReminderType_MembersKickoutClass,//有人被移出了班级
    ClassReminderType_MineKickoutFromClass,//我被移出了班级
    ClassReminderType_MembersQuitClass,//有人主动退出了班级
    ClassReminderType_MineQuitFromClass,//我主动退出了班级
};

@interface EEOClassReminderInfo : EEOMessageCenterInfo

@property (nonatomic,copy) NSNumber *classID;
@property (nonatomic,strong) EEOClassInfo *classInfo;

@property (nonatomic,assign) NSUInteger reminderType;
@property (nonatomic,copy) NSString *reminderContent;

@property (nonatomic,copy,readonly) NSString *className;
@property (nonatomic,copy,readonly) NSData *avatarData;

@property (nonatomic,assign) BOOL isClassTeacher;//自己在班级中是否是班主任 TODO...

//ClassReminderType_ClassNameChanged
+ (NSString *)classNameChangedContentFromOldName:(NSString *)oldName newName:(NSString *)newName;
//ClassReminderType_MembersJoinClass
+ (NSString *)memberJoinClassContentFromMemberInfoList:(NSArray *)memberInfoList;
//ClassReminderType_MembersKickoutClass
+ (NSString *)memberKickoutClassContentFromMemberInfoList:(NSArray *)memberInfoList;

@end
