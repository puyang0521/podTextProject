//
//  EEOClassroomScreenSharing.h
//  EEOEntity
//
//  Created by HeQian on 16/6/25.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEOClassroomScreenSharing : NSObject<NSCopying>

@property (nonatomic,assign) NSUInteger actionType;
@property (nonatomic,copy) NSNumber *uid;
@property (nonatomic,assign) NSUInteger width;
@property (nonatomic,assign) NSUInteger height;

@end

@class EEOClassroomScreenBlockDescriptionTable;
@interface EEOClassroomMultiplayerScreenSharing : NSObject<NSCopying>

@property (nonatomic,assign) BOOL isFollowHostView;
@property (nonatomic,copy) NSNumber *currentUID;

/// 0:不允许学生控制，1:允许学生控制画板，2:允许学生控制电脑
@property (nonatomic,assign) NSUInteger currentControlOption;

- (void)cloneMSSInfo:(EEOClassroomMultiplayerScreenSharing *)mssInfo;

@end

@interface EEOClassroomScreenBlockHead : NSObject<NSCopying>

@property (nonatomic,assign) NSUInteger screenID;
@property (nonatomic,assign) NSUInteger screenVersion;
@property (nonatomic,assign) NSUInteger screenWidth;
@property (nonatomic,assign) NSUInteger screenHeight;
@property (nonatomic,assign) NSUInteger blockWidth;
@property (nonatomic,assign) NSUInteger blockHeight;
@property (nonatomic,assign) NSUInteger totalBlockNum;

- (instancetype)initWithScreenVersion:(NSUInteger)screenVersion screenWidth:(NSUInteger)screenWidth screenHeight:(NSUInteger)screenHeight blockWidth:(NSUInteger)blockWidth blockHeight:(NSUInteger)blockHeight totalBlockNum:(NSUInteger)totalBlockNum;
- (instancetype)initWithScreenID:(NSUInteger)screenID screenVersion:(NSUInteger)screenVersion screenInfoData:(NSData *)screenInfoData totalBlockNum:(NSUInteger)totalBlockNum;

- (void)cloneHeadInfo:(EEOClassroomScreenBlockHead *)headInfo;

- (BOOL)haveScreenInfo;

- (NSData *)generateScreenInfoData;

@end
@interface EEOClassroomScreenBlockDTItem : NSObject

@property (nonatomic,assign) NSUInteger blockOffset;
@property (nonatomic,assign) NSUInteger blockVersion;
@property (nonatomic,assign) NSUInteger totalPacketNum;
@property (nonatomic,copy) NSArray *packetOffsetList;

@end
@class EEOClassroomScreenBlockData;
@class EEOClassroomScreenBlockPacketData;
@interface EEOClassroomScreenBlockDescriptionTable : NSObject

@property (nonatomic,strong) EEOClassroomScreenBlockHead *head;

@property (nonatomic,strong) NSMutableArray *blockDataList;

- (instancetype)initWithHeadInfo:(EEOClassroomScreenBlockHead *)headInfo blockItemList:(NSArray *)blockItemList;

- (void)changeHeadInfo:(EEOClassroomScreenBlockHead *)headInfo blockItemList:(NSArray *)blockItemList;
- (void)buildBlockDataListWithItemList:(NSArray *)itemList;
- (void)updateBlockDataListWithItemList:(NSArray *)itemList;

- (EEOClassroomScreenBlockData *)blockDataInfoWithOffset:(NSUInteger)blockOffset;

@end
@interface EEOClassroomScreenBlockPacketData : NSObject

@property (nonatomic,assign) NSUInteger packetOffset;
@property (nonatomic,copy) NSData *packetData;

@property (nonatomic,assign) BOOL isSkipReq;

@property (nonatomic,assign) NSTimeInterval sendTime;
@property (nonatomic,assign) BOOL isSendComplete;

- (instancetype)initWithOffset:(NSUInteger)offset data:(NSData *)data;

@end
@interface EEOClassroomScreenBlockData : NSObject

@property (nonatomic,assign) NSUInteger blockOffset;
@property (nonatomic,assign) NSUInteger blockVersion;
@property (nonatomic,assign) NSUInteger totalPacketNum;

@property (nonatomic,strong) NSMutableArray *packetDataList;

- (void)onBlockVersionChangedWithVersion:(NSUInteger)nowVersion totalPacketNum:(NSUInteger)totalPacketNum;
- (void)updatePacketData:(EEOClassroomScreenBlockPacketData *)packetDataInfo;

- (BOOL)isReady;
- (NSData *)imageData;

- (EEOClassroomScreenBlockPacketData *)packetDataWithOffset:(NSUInteger)packetOffset;
- (BOOL)isSendComplete;

@end
@interface EEOClassroomScreenBlockDataControl : NSObject

@property (nonatomic,assign) NSUInteger screenID;
@property (nonatomic,assign) NSUInteger screenVersion;
@property (nonatomic,assign) NSUInteger controlOption;//0:停止,2:心跳

@end
