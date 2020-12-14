//
//  EEORegisterInfo.h
//  EEOEntity
//
//  Created by HeQian on 2016/12/21.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEORegisterInfo : NSObject

@property (nonatomic,copy) NSString *areaCode;
@property (nonatomic,copy) NSString *telephoneNum;
@property (nonatomic,copy) NSString *prov;
@property (nonatomic,copy) NSString *password;

- (NSString *)finalTelephoneNum;

@end
