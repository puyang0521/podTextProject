//
//  EEOClassroomTheme.m
//  EEOEntity
//
//  Created by 蒋敏 on 2017/12/28.
//  Copyright © 2017年 jiangmin. All rights reserved.
//

#import "EEOClassroomThemeInfo.h"
#import "EEOClassroomGroupInfo.h"

@implementation EEOClassroomSkinInfo

- (instancetype)initWithinfoDic:(NSDictionary *)infoDic {
    self = [super init];
    if(self){
        [self p_fillInfosFromDic:infoDic];
    }
    return self;
}

- (void)cloneSkinInfo:(EEOClassroomSkinInfo *)info {
    self.alpha = info.alpha;
    self.colorStr = info.colorStr;
    self.imageUrl = info.imageUrl;
    self.imageBase64Str = info.imageBase64Str;
    self.name = info.name;
}

- (BOOL)existImage {
//    return _imageUrl.length > 0 || _imageBase64Str.length > 0 || _imageData.length > 0;
    return _imageData.length > 0;
}
- (BOOL)existBGColor {
    return _colorStr.length > 0;
}

#pragma mark - Private Methods
- (void)p_fillInfosFromDic:(NSDictionary *)infoDic {
    if(infoDic[@"alpha"]){
        self.alpha = [infoDic[@"alpha"] floatValue];
    }
    self.colorStr = infoDic[@"color"];
    
    //    self.imageUrl = infoDic[@"img"];
    NSString *imgInfo = infoDic[@"img"];
    if(imgInfo.length > 0){
        NSArray *imgInfoList = [imgInfo componentsSeparatedByString:@","];
        if(imgInfoList.count >= 2){
            self.imageBase64Str = imgInfoList[1];
            if(_imageBase64Str.length > 0){
                self.imageData = [[NSData alloc] initWithBase64EncodedString:_imageBase64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
            }
        }else{//TODO...
            self.imageUrl = imgInfo;
        }
    }
    
    self.name = infoDic[@"name"];
}

@end

@interface EEOClassRoomHeadToolbarInfo()

@property (nonatomic, strong) NSArray<NSNumber *> *teacherActions;
@property (nonatomic, strong) NSArray<NSNumber *> *studentActions;

@end

@implementation EEOClassRoomHeadToolbarInfo

- (instancetype)initWithInfoDic:(NSDictionary *)infoDic {
    self = [super init];
    if (self) {
        [self loadTeacherInfo:[infoDic objectForKey:@"teacher"]];
        [self loadStudentInfo:[infoDic objectForKey:@"student"]];
    }
    return self;
}

- (void)loadTeacherInfo:(NSDictionary *)dict {
    NSMutableArray *tempArray = [NSMutableArray new];
    if (dict == nil || ![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if ([dict.allKeys containsObject:@"ResetAll"] && [[dict objectForKey:@"ResetAll"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeResetAll)];
    }
    if ([dict.allKeys containsObject:@"MuteAll"] && [[dict objectForKey:@"MuteAll"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeMuteAll)];
        [tempArray addObject:@(ClassroomHeadActionTypeUnmuteAll)];
    }
    if ([dict.allKeys containsObject:@"DownStageAll"] && [[dict objectForKey:@"DownStageAll"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeDownStageAll)];
    }
    if ([dict.allKeys containsObject:@"RewardAll"] && [[dict objectForKey:@"RewardAll"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeSendRewardAll)];
    }
    if ([dict.allKeys containsObject:@"ReplaceAll"] && [[dict objectForKey:@"ReplaceAll"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeReplaceAll)];
    }
    if ([dict.allKeys containsObject:@"AuthorityAll"] && [[dict objectForKey:@"AuthorityAll"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeAuthorizeAll)];
        [tempArray addObject:@(ClassroomHeadActionTypeUnauthorizeAll)];
    }
    if ([dict.allKeys containsObject:@"AllStudentsToFreeRegion"] && [[dict objectForKey:@"AllStudentsToFreeRegion"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeFreeRegionAll)];
    }
    
    self.teacherActions = [NSArray arrayWithArray:tempArray];
}

- (void)loadStudentInfo:(NSDictionary *)dict {
    NSMutableArray *tempArray = [NSMutableArray new];
    if (dict == nil || ![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if ([dict.allKeys containsObject:@"authority"] && [[dict objectForKey:@"authority"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeAuthorize)];
        [tempArray addObject:@(ClassroomHeadActionTypeUnauthorize)];
    }
    if ([dict.allKeys containsObject:@"Mute"] && [[dict objectForKey:@"Mute"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeMute)];
        [tempArray addObject:@(ClassroomHeadActionTypeUnmute)];
    }
    if ([dict.allKeys containsObject:@"reward"] && [[dict objectForKey:@"reward"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeSendReward)];
    }
    if ([dict.allKeys containsObject:@"Stage"] && [[dict objectForKey:@"Stage"] boolValue]) {
        [tempArray addObject:@(ClassroomHeadActionTypeDownStage)];
    }
    self.studentActions = [NSArray arrayWithArray:tempArray];
}

#pragma -mark -Lazy load,作为默认值
- (NSArray<NSNumber *> *)teacherActions {
    if (!_teacherActions) {
        _teacherActions = @[@(ClassroomHeadActionTypeResetAll),
                            @(ClassroomHeadActionTypeMuteAll),
                            @(ClassroomHeadActionTypeUnmuteAll),
                            @(ClassroomHeadActionTypeDownStageAll)];
    }
    return _teacherActions;
}

- (NSArray<NSNumber *> *)studentActions {
    if (!_studentActions) {
        _studentActions = @[@(ClassroomHeadActionTypeAuthorize),
                            @(ClassroomHeadActionTypeUnauthorize),
                            @(ClassroomHeadActionTypeMute),
                            @(ClassroomHeadActionTypeUnmute),
                            @(ClassroomHeadActionTypeSendReward),
                            @(ClassroomHeadActionTypeDownStage),];
    }
    return _studentActions;
}

@end
@implementation EEOClassroomThemeInfo

- (EEOClassRoomHeadToolbarInfo *)headImageToolbarInfo {
    if (!_headImageToolbarInfo) {
        _headImageToolbarInfo = [EEOClassRoomHeadToolbarInfo new];
    }
    return _headImageToolbarInfo;
}

- (BOOL)existEdt {
    return _edtFileName.length > 0 && _edtImageData.length > 0;
}

- (NSData *)bgImageData {
    NSData *result = nil;
    if(_edtImageData.length > 0){
        result = _edtImageData;
    }else if(_bgSkinInfo.imageData.length > 0){
        result = _bgSkinInfo.imageData;
    }
    return result;
}
- (NSString *)bgColorStr {
    NSString *result = nil;
    if(_bgSkinInfo && [_bgSkinInfo existBGColor]){
        result = _bgSkinInfo.colorStr;
    }
    return result;
}

- (BOOL)isCommentVisible {
    BOOL result = YES;
    if(_commentWindowInfo){
        id commentVisibleObj = _commentWindowInfo[@"CommentVisible"];
        if(commentVisibleObj){
            result = [commentVisibleObj boolValue];
        }
    }
    return result;
}

- (BOOL)canSendChatImage {
    BOOL result = YES;
    if(_chatWindowInfo){
        id enableSnapshotObj = _chatWindowInfo[@"EnableSnapshot"];
        if(enableSnapshotObj){
            result = [enableSnapshotObj boolValue];
        }
    }
    return result;
}
- (NSUInteger)minSendChatMessageTimeInterval {
    NSUInteger result = 0;
    if(_chatWindowInfo){
        id minTimespanObj = _chatWindowInfo[@"MinTimespan"];
        if(minTimespanObj && [minTimespanObj integerValue] >= 0){
            result = [minTimespanObj integerValue];
        }
    }
    return result;
}

- (BOOL)isRosterVisibleByStudent {
    BOOL result = YES;
    if(_boardToolbarInfo){
        NSDictionary *studentConfigInfo = _boardToolbarInfo[@"student"];
        if(studentConfigInfo && [studentConfigInfo isKindOfClass:[NSDictionary class]]){
            id visible = studentConfigInfo[@"Roster"];
            if(visible){
                result = [visible boolValue];
            }
        }
    }
    return result;
}

- (BOOL)isToolboxVisibleByTeacher{
    BOOL result = YES;
    if(_boardToolbarInfo){
        NSDictionary *toolConfigInfo = _boardToolbarInfo[@"teacher"];
        if(toolConfigInfo && [toolConfigInfo isKindOfClass:[NSDictionary class]]){
            id visible = toolConfigInfo[@"MiniToolbox"];
            if(visible){
                result = [visible boolValue];
            }
        }
    }
    return result;
}

- (BOOL)isChatButtonVisibleByTeacher {
    BOOL result = YES;
    if(_boardToolbarInfo){
        NSDictionary *toolConfigInfo = _boardToolbarInfo[@"teacher"];
        if(toolConfigInfo && [toolConfigInfo isKindOfClass:[NSDictionary class]]){
            id visible = toolConfigInfo[@"Chat"];
            if(visible){
                result = [visible boolValue];
            }
        }
    }
    return result;
}

- (BOOL)isChatButtonVisibleByStudent {
    BOOL result = YES;
    if(_boardToolbarInfo){
        NSDictionary *toolConfigInfo = _boardToolbarInfo[@"student"];
        if(toolConfigInfo && [toolConfigInfo isKindOfClass:[NSDictionary class]]){
            id visible = toolConfigInfo[@"Chat"];
            if(visible){
                result = [visible boolValue];
            }
        }
    }
    return result;
}


- (BOOL)isQuestionListVisible {
    BOOL result = YES;
    if (_chatWindowInfo) {
        id visible = _chatWindowInfo[@"QuestionVisible"];
        if (visible) {
            result = [visible boolValue];
        }
    }
    return result;
}

- (BOOL)canScrollBigBlackboardByStudent {
    BOOL result = YES;
    if (_blackboardInfo) {
        id canScroll = _blackboardInfo[@"limitStudentsScroll"];
        if (canScroll) {
            result = ![canScroll boolValue];
        }
    }
    return result;
}

- (BOOL)canCloseCoursewareByStudent {
    BOOL result = YES;
    if (_clouddiskInfo) {
        id canClose = _clouddiskInfo[@"limitStudentsCloseCourseWare"];
        if (canClose) {
            result = ![canClose boolValue];
        }
    }
    return result;
}

- (BOOL)isHandsupVisible {
    BOOL result = YES;
    if (_handsupInfo) {
        id visible = _handsupInfo[@"visible"];
        if (visible) {
            result = [visible boolValue];
        }
    }
    return result;
}

- (BOOL)isLessonOverTime {
    BOOL result = NO;
    if (_classroomWindow) {
        id teacher = [_classroomWindow objectForKey:@"teacher"];
        if (teacher) {
            id option = teacher[@"ExtendClassTime"];
            if (option) {
                result = [option boolValue];
            }
        }
    }
    return result;
}

- (BOOL)isSyncCameraMirroring {
    BOOL result = NO;
    if (_classroomWindow) {
        id teacher = [_classroomWindow objectForKey:@"teacher"];
        if (teacher) {
            id option = teacher[@"CameraMirroring"];
            if (option) {
                result = [option boolValue];
            }
        }
    }
    return result;
}

- (BOOL)isShowMoveStudentOut{
    BOOL result = YES;
    if (_classroomWindow) {
        id teacher = [_classroomWindow objectForKey:@"teacher"];
        if (teacher) {
            id option = teacher[@"MoveStudentOut"];
            if (option) {
                result = [option boolValue];
            }
        }
    }
    return result;
}

- (BOOL)isMarqueeVisible {
    BOOL result = NO;
    if (_classroomWindow) {
        id student = [_classroomWindow objectForKey:@"student"];
        if (student) {
            id option = student[@"ScreenMark"];
            if (option) {
                result = [option boolValue];
            }
        }
    }
    return result;
}
- (BOOL)isStudentFrontLock {
    BOOL result = NO;
    if (_classroomWindow) {
        id student = [_classroomWindow objectForKey:@"student"];
        if (student) {
            id option = student[@"FrontLock"];
            if (option) {
                result = [option boolValue];
            }
        }
    }
    return result;
}

- (BOOL)canOpenScreenShare {
    return [[self teacherToolboxListWithUnsupportTools:@[]] containsObject:@(TeacherToolBoxWidget_ScreenShare)];
}

- (NSArray *)teacherToolboxListWithUnsupportTools:(NSArray *)unsupportTools{
    if ([EEOClassroomGroupInfo currentGroup]) {
        NSMutableArray *tools = [NSMutableArray arrayWithObjects:@(TeacherToolBoxWidget_SaveEdbFile), @(TeacherToolBoxWidget_Clock), @(TeacherToolBoxWidget_Dice),@(TeacherToolBoxWidget_Timer), nil];
        return tools;
    }
    NSMutableArray *tempTools = [NSMutableArray arrayWithObjects:@(TeacherToolBoxWidget_SaveEdbFile),@(TeacherToolBoxWidget_ScreenShare),@(TeacherToolBoxWidget_Clock),@(TeacherToolBoxWidget_Dice),@(TeacherToolBoxWidget_SmallBlackboard),@(TeacherToolBoxWidget_Responder),@(TeacherToolBoxWidget_AnswerDevice),@(TeacherToolBoxWidget_TextCollaboration),@(TeacherToolBoxWidget_Selector),@(TeacherToolBoxWidget_Homework), nil];

    BOOL addGroupFlag = YES;
    if(_boardToolbarInfo){
        NSDictionary *toolConfigInfo = _boardToolbarInfo[@"teacher"];
        if(toolConfigInfo && [toolConfigInfo isKindOfClass:[NSDictionary class]]){
            NSDictionary *toolsInfo = toolConfigInfo[@"MiniTools"];
            if (toolsInfo && [toolsInfo isKindOfClass:[NSDictionary class]]) {
                if (toolsInfo[@"Clock"] && ![toolsInfo[@"Clock"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_Clock)];
                }
                if (toolsInfo[@"Dice"] && ![toolsInfo[@"Dice"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_Dice)];
                }
                if (toolsInfo[@"SmallBlackboard"] && ![toolsInfo[@"SmallBlackboard"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_SmallBlackboard)];
                }
                if (toolsInfo[@"Responder"] && ![toolsInfo[@"Responder"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_Responder)];
                }
                if(toolsInfo[@"AnswerDevice"] && ![toolsInfo[@"AnswerDevice"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_AnswerDevice)];
                }
                if (toolsInfo[@"TextCollaboration"] && ![toolsInfo[@"TextCollaboration"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_TextCollaboration)];
                }
                if (toolsInfo[@"SaveBoardFile"] && ![toolsInfo[@"SaveBoardFile"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_SaveEdbFile)];
                }
                if (toolsInfo[@"DesktopShare"] && ![toolsInfo[@"DesktopShare"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_ScreenShare)];
                }
                if (toolsInfo[@"RandomSelection"] && ![toolsInfo[@"RandomSelection"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_Selector)];
                }
                if (toolsInfo[@"WebShare"] && [toolsInfo[@"WebShare"] boolValue]) {
                    [tempTools addObject:@(TeacherToolBoxWidget_Browser)];
                }
                if (toolsInfo[@"RewardRankingList"] && [toolsInfo[@"RewardRankingList"] boolValue]) {
                    [tempTools addObject:@(TeacherToolBoxWidget_AwardLeaderboard)];
                }
                if (toolsInfo[@"HomeworkShare"] && ![toolsInfo[@"HomeworkShare"] boolValue]) {
                    [tempTools removeObject:@(TeacherToolBoxWidget_Homework)];
                }
                if (toolsInfo[@"GoSmallBlackboard"] && [toolsInfo[@"GoSmallBlackboard"] boolValue]) {
                    [tempTools addObject:@(TeacherToolBoxWidget_GoSmallBoard)];
                }
                if (toolsInfo[@"Timer"] && [toolsInfo[@"Timer"] boolValue]) {
                    [tempTools addObject:@(TeacherToolBoxWidget_Timer)];
                }
                if (toolsInfo[@"Group"] && ![toolsInfo[@"Group"] boolValue]) {
                    addGroupFlag = NO;
                }
            }
        }
    }
    if (addGroupFlag) {
        [tempTools addObject:@(TeacherToolBoxWidget_Group)];
    }
    
    [tempTools addObject:@(TeacherToolBoxWidget_Examination)];
    
    for (NSNumber *unsupportTool in unsupportTools) {
        if ([tempTools containsObject:unsupportTool]) {
            [tempTools removeObject:unsupportTool];
        }
    }
    
    NSArray *result = [NSArray arrayWithArray:tempTools];
    return result;
}

- (ClassroomCloudDefaultList)classroomDefaultList {
    ClassroomCloudDefaultList defaultList = ClassroomCloudDefaultList_Authod;
    if (_clouddiskInfo) {
        NSString *defaultCloud = _clouddiskInfo[@"teacherDefaultTab"];
        if ([defaultCloud isEqualToString:@"AuthorizedResources"]) {
            
        } else if ([defaultCloud isEqualToString:@"MyCloudDisk"]) {
            defaultList = ClassroomCloudDefaultList_MyCloud;
        } else {
            
        }
    }
    if (defaultList == ClassroomCloudDefaultList_Authod && _authoredCloudIsEmpty) {
        defaultList = ClassroomCloudDefaultList_MyCloud;
    }
    return defaultList;
}

- (NSUInteger)recordTimeInterval{
    NSUInteger result = 10 * 60;
    if(_recordInfo){
        id duration = _recordInfo[@"duration"];
        if(duration && [duration integerValue] >= 0){
            result = [duration integerValue];
        }
    }
    return result;
}

- (NSUInteger)tabBBMemberLimit {
    NSUInteger result = 35;
    if (_tabBBMemberLimitInfo) {
        result = [_tabBBMemberLimitInfo integerValue];
    }
    return result;
}

- (BOOL)isStudentHelpVisible {
    BOOL result = NO;
    if(_skinHelpInfo){
        id commentVisibleObj = _skinHelpInfo[@"studentsShow"];
        if(commentVisibleObj){
            result = [commentVisibleObj boolValue];
        }
    }
    return result;
}
@end
