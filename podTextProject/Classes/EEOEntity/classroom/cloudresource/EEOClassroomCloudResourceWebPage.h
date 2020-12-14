//
//  EEOClassroomCloudResourceWebPage.h
//  EEOEntity
//
//  Created by 蒋敏 on 2018/4/18.
//  Copyright © 2018年 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

#import <CoreGraphics/CGGeometry.h>

@interface EEOClassroomCloudResourceWebPage : EEOClassroomCloudResource

@property (nonatomic,copy) NSString *jsonContent;

- (NSString *)webPageURLStr;

- (CGSize)recommendedSize;
- (CGSize)minimumSize;

- (BOOL)isNeedUID;
- (BOOL)isNeedNickName;
- (BOOL)isNeedIdentity;
- (BOOL)isExistCustomTitle;
- (BOOL)isNeedAuthority;

@end
