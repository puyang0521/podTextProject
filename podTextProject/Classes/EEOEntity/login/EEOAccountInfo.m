//
//  EEOAccountInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/20.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEOAccountInfo.h"

@implementation EEOAccountInfo

- (instancetype)copyWithZone:(NSZone *)zone {
    EEOAccountInfo *copyObj = [[self class] allocWithZone:zone];
    copyObj.areaCode = self.areaCode;
    copyObj.account = self.account;
    copyObj.password = self.password;
    copyObj.avatarData = self.avatarData;
    copyObj.uid = self.uid;
    return copyObj;
}

- (BOOL)isAvailable {
    return _account.length > 0 && _password.length > 0;
}

- (NSString *)finalAccount {
    return [[self class] areaCode:_areaCode appendTelephone:_account];
}

+ (NSString *)areaCode:(NSString *)areaCode appendTelephone:(NSString *)telephone {
    NSString *result = telephone;
    if(areaCode && areaCode.length > 0){
        //带区号的格式:00852-15300240402
        result = [areaCode stringByAppendingString:[NSString stringWithFormat:@"-%@",result]];
    }
    return result;
}

@end
