//
//  EEOClassroomScreenSharing.m
//  EEOEntity
//
//  Created by HeQian on 16/6/25.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOClassroomScreenSharing.h"

#import "NSData+EEO.h"
#import "NSMutableData+EEO.h"

@implementation EEOClassroomScreenSharing

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomScreenSharing *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.actionType = self.actionType;
    copyObj.uid = self.uid;
    copyObj.width = self.width;
    copyObj.height = self.height;
    return copyObj;
}

@end

@interface EEOClassroomMultiplayerScreenSharing (){
}

@end
@implementation EEOClassroomMultiplayerScreenSharing

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomMultiplayerScreenSharing *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.isFollowHostView = self.isFollowHostView;
    copyObj.currentUID = self.currentUID;
    copyObj.currentControlOption = self.currentControlOption;
    return copyObj;
}

- (void)cloneMSSInfo:(EEOClassroomMultiplayerScreenSharing *)mssInfo {
    self.isFollowHostView = mssInfo.isFollowHostView;
    self.currentUID = mssInfo.currentUID;
    self.currentControlOption = mssInfo.currentControlOption;
}

@end

@implementation EEOClassroomScreenBlockHead

- (instancetype)initWithScreenVersion:(NSUInteger)screenVersion screenWidth:(NSUInteger)screenWidth screenHeight:(NSUInteger)screenHeight blockWidth:(NSUInteger)blockWidth blockHeight:(NSUInteger)blockHeight totalBlockNum:(NSUInteger)totalBlockNum {
    self = [super init];
    if(self){
        self.screenVersion = screenVersion;
        self.screenWidth = screenWidth;
        self.screenHeight = screenHeight;
        self.blockWidth = blockWidth;
        self.blockHeight = blockHeight;
        self.totalBlockNum = totalBlockNum;
    }
    return self;
}
- (instancetype)initWithScreenID:(NSUInteger)screenID screenVersion:(NSUInteger)screenVersion screenInfoData:(NSData *)screenInfoData totalBlockNum:(NSUInteger)totalBlockNum {
    self = [super init];
    if(self){
        self.screenID = screenID;
        self.screenVersion = screenVersion;
        
        if(screenInfoData.length > 0){
            int offset = 0;
            self.blockWidth = [screenInfoData readUint16ByBig:&offset];
            self.blockHeight = [screenInfoData readUint16ByBig:&offset];
            self.screenWidth = [screenInfoData readUint16ByBig:&offset];
            self.screenHeight = [screenInfoData readUint16ByBig:&offset];
        }
        
        self.totalBlockNum = totalBlockNum;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOClassroomScreenBlockHead *copyObj = [[[self class] allocWithZone:zone] init];
    copyObj.screenID = self.screenID;
    copyObj.screenVersion = self.screenVersion;
    copyObj.screenWidth = self.screenWidth;
    copyObj.screenHeight = self.screenHeight;
    copyObj.blockWidth = self.blockWidth;
    copyObj.blockHeight = self.blockHeight;
    copyObj.totalBlockNum = self.totalBlockNum;
    return copyObj;
}

- (void)cloneHeadInfo:(EEOClassroomScreenBlockHead *)headInfo {
    self.screenID = headInfo.screenID;
    self.screenVersion = headInfo.screenVersion;
    self.screenWidth = headInfo.screenWidth;
    self.screenHeight = headInfo.screenHeight;
    self.blockWidth = headInfo.blockWidth;
    self.blockHeight = headInfo.blockHeight;
    self.totalBlockNum = headInfo.totalBlockNum;
}

- (BOOL)haveScreenInfo {
    return _blockWidth != 0 && _blockHeight != 0 && _screenWidth != 0 && _screenHeight != 0;
}

- (NSData *)generateScreenInfoData {
    NSMutableData *result = [NSMutableData data];
    [result writeUint16ByBig:_blockWidth];
    [result writeUint16ByBig:_blockHeight];
    [result writeUint16ByBig:_screenWidth];
    [result writeUint16ByBig:_screenHeight];
    return [result copy];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"EEOClassroomScreenBlockHead::screenID=%zi,screenVersion=%zi,screenWidth=%zi,screenHeight=%zi,blockWidth=%zi,blockHeight=%zi,totalBlockNum=%zi", _screenID,_screenVersion,_screenWidth,_screenHeight,_blockWidth,_blockHeight,_totalBlockNum];
}

@end
@implementation EEOClassroomScreenBlockDTItem

- (NSString *)description {
    return [NSString stringWithFormat:@"ScreenBlockDTItem:blockVersion=%zi,blockOffset=%zi,packetOffsetList=%@", _blockVersion,_blockOffset,_packetOffsetList];
}

@end
@interface EEOClassroomScreenBlockDescriptionTable (){
    NSDictionary *_blockDataDic;
}

@end
@implementation EEOClassroomScreenBlockDescriptionTable

- (instancetype)initWithHeadInfo:(EEOClassroomScreenBlockHead *)headInfo blockItemList:(NSArray *)blockItemList {
    self = [super init];
    if(self){
        self.head = [headInfo copy];
        self.blockDataList = [NSMutableArray arrayWithCapacity:headInfo.totalBlockNum];
        [self buildBlockDataListWithItemList:blockItemList];
    }
    return self;
}

- (void)changeHeadInfo:(EEOClassroomScreenBlockHead *)headInfo blockItemList:(NSArray *)blockItemList {
    [self.head cloneHeadInfo:headInfo];
    self.blockDataList = [NSMutableArray arrayWithCapacity:headInfo.totalBlockNum];
    [self buildBlockDataListWithItemList:blockItemList];
}

- (void)buildBlockDataListWithItemList:(NSArray *)itemList {
    for (EEOClassroomScreenBlockDTItem *item in itemList) {
        [self p_addBlockDataInfoWithItem:item];
    }
}
- (void)updateBlockDataListWithItemList:(NSArray *)itemList {
    NSMutableArray *addItemList = [NSMutableArray array];
    for (EEOClassroomScreenBlockDTItem *item in itemList) {
        NSUInteger blockOffset = item.blockOffset;
        NSUInteger nowVersion = item.blockVersion;
        BOOL isAdd = YES;
        for (EEOClassroomScreenBlockData *blockDataInfo in _blockDataList) {
            if(blockOffset == blockDataInfo.blockOffset){
                if(nowVersion >= blockDataInfo.blockVersion){
                    if(nowVersion > blockDataInfo.blockVersion){
                        [blockDataInfo.packetDataList removeAllObjects];
                        for (int i=0; i<item.totalPacketNum; i++) {
                            [blockDataInfo.packetDataList addObject:[NSNull null]];
                        }
                    }
                    blockDataInfo.blockVersion = nowVersion;
                    blockDataInfo.totalPacketNum = item.totalPacketNum;
                    for (NSNumber *pktOffsetObj in item.packetOffsetList) {
                        EEOClassroomScreenBlockPacketData *pktDataInfo = [[EEOClassroomScreenBlockPacketData alloc] initWithOffset:[pktOffsetObj unsignedIntegerValue] data:nil];
                        NSUInteger index = [pktOffsetObj unsignedIntegerValue];
                        if(index < blockDataInfo.packetDataList.count){
                            blockDataInfo.packetDataList[index] = pktDataInfo;
                        }
                    }
                }
                isAdd = NO;
                break;
            }
        }
        if(isAdd){
            [addItemList addObject:item];
        }
    }
    for (EEOClassroomScreenBlockDTItem *addItem in addItemList) {
        [self p_addBlockDataInfoWithItem:addItem];
    }
}

- (EEOClassroomScreenBlockData *)blockDataInfoWithOffset:(NSUInteger)blockOffset {
    EEOClassroomScreenBlockData *result = nil;
    for (EEOClassroomScreenBlockData *blockDataInfo in _blockDataList) {
        if(blockDataInfo.blockOffset == blockOffset){
            result = blockDataInfo;
            break;
        }
    }
    return result;
}

#pragma mark - Private Methods
- (void)p_addBlockDataInfoWithItem:(EEOClassroomScreenBlockDTItem *)item {
    EEOClassroomScreenBlockData *dataInfo = [[EEOClassroomScreenBlockData alloc] init];
    dataInfo.blockOffset = item.blockOffset;
    dataInfo.blockVersion = item.blockVersion;
    dataInfo.totalPacketNum = item.totalPacketNum;
    for (int i=0; i<item.totalPacketNum; i++) {
        [dataInfo.packetDataList addObject:[NSNull null]];
    }
    for (NSNumber *pktOffsetObj in item.packetOffsetList) {
        EEOClassroomScreenBlockPacketData *pktDataInfo = [[EEOClassroomScreenBlockPacketData alloc] initWithOffset:[pktOffsetObj unsignedIntegerValue] data:nil];
        NSUInteger index = [pktOffsetObj unsignedIntegerValue];
        if(index < dataInfo.packetDataList.count){
            dataInfo.packetDataList[index] = pktDataInfo;
        }
    }
    [_blockDataList addObject:dataInfo];
}

@end
@implementation EEOClassroomScreenBlockPacketData

- (instancetype)initWithOffset:(NSUInteger)offset data:(NSData *)data {
    self = [super init];
    if(self){
        self.packetOffset = offset;
        self.packetData = data;
    }
    return self;
}

@end
@implementation EEOClassroomScreenBlockData

- (instancetype)init {
    self = [super init];
    if (self) {
        self.packetDataList = [NSMutableArray array];
    }
    return self;
}

- (void)onBlockVersionChangedWithVersion:(NSUInteger)nowVersion totalPacketNum:(NSUInteger)totalPacketNum {
    self.blockVersion = nowVersion;
    self.totalPacketNum = totalPacketNum;
    [_packetDataList removeAllObjects];
    _packetDataList = nil;
}
- (void)updatePacketData:(EEOClassroomScreenBlockPacketData *)packetDataInfo {
    for (EEOClassroomScreenBlockPacketData *item in _packetDataList) {
        if(![item isKindOfClass:[EEOClassroomScreenBlockPacketData class]]){
            continue;
        }
        if(packetDataInfo.packetOffset == item.packetOffset){
            item.packetData = packetDataInfo.packetData;
            break;
        }
    }
}

- (BOOL)isReady {
    BOOL result = _packetDataList.count == _totalPacketNum;
    if(result){
        for (EEOClassroomScreenBlockPacketData *item in _packetDataList) {
            if([item isKindOfClass:[NSNull class]] || item.packetData.length <= 0){
                result = NO;
                break;
            }
        }
    }
    return result;
}
- (NSData *)imageData {
    NSData *result = nil;
    NSArray *sortedList = [_packetDataList sortedArrayUsingComparator:^NSComparisonResult(EEOClassroomScreenBlockPacketData * _Nonnull obj1, EEOClassroomScreenBlockPacketData * _Nonnull obj2) {
        if(obj1.packetOffset < obj2.packetOffset){
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
    NSMutableData *imageData = [NSMutableData data];
    for (EEOClassroomScreenBlockPacketData *item in sortedList) {
        [imageData appendData:item.packetData];
    }
    result = [NSData dataWithData:imageData];
    return result;
}

- (EEOClassroomScreenBlockPacketData *)packetDataWithOffset:(NSUInteger)packetOffset {
    EEOClassroomScreenBlockPacketData *result = nil;
    NSArray *tempList = [_packetDataList copy];
    for (EEOClassroomScreenBlockPacketData *item in tempList) {
        if(item.packetOffset == packetOffset){
            result = item;
            break;
        }
    }
    return result;
}
- (BOOL)isSendComplete {
    BOOL result = YES;
    for (EEOClassroomScreenBlockPacketData *item in _packetDataList) {
        if(!item.isSendComplete){
            result = NO;
            break;
        }
    }
    return result;
}

@end
@implementation EEOClassroomScreenBlockDataControl

@end
