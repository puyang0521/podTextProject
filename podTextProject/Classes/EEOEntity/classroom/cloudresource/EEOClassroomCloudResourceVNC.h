//
//  EEOClassroomCloudResourceVNC.h
//  EEOEntity
//
//  Created by 蒋敏 on 2019/3/18.
//  Copyright © 2019 jiangmin. All rights reserved.
//

#import "EEOClassroomCloudResource.h"

@interface EEOClassroomCloudResourceVNC : EEOClassroomCloudResource

@property (nonatomic,copy) NSString *jsonContent;
// 待实现
@property (nonatomic, assign) BOOL viewOnly;

- (NSString *)serverAddress;
- (NSUInteger)serverPort;
- (NSString *)password;

@end
