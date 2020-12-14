//
//  EEOAccountInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/20.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEOAccountInfo : NSObject<NSCopying>

@property (nonatomic,copy) NSString *areaCode;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSData *avatarData;
@property (nonatomic,copy) NSNumber *uid;

- (BOOL)isAvailable;

- (NSString *)finalAccount;

+ (NSString *)areaCode:(NSString *)areaCode appendTelephone:(NSString *)telephone;

@end
