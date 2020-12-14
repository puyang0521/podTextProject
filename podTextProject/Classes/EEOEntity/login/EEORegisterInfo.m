//
//  EEORegisterInfo.m
//  EEOEntity
//
//  Created by HeQian on 2016/12/21.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "EEORegisterInfo.h"

@implementation EEORegisterInfo

- (NSString *)finalTelephoneNum {
    NSString *result = _telephoneNum;
    if(_areaCode && _areaCode.length > 0){
        //带区号的格式:00852-15300240402
        result = [_areaCode stringByAppendingString:[NSString stringWithFormat:@"-%@",result]];
    }
    return result;
}

@end
