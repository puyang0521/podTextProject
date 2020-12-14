//
//  NSData.h
//  EEOBusinessLogic
//
//  Created by HeQian on 16/3/14.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (EEO)

- (int8_t)readInt8:(int*)offset;
- (uint8_t)readUint8:(int*)offset;
- (uint16_t)readUint16:(int*)offset;
- (uint16_t)readUint16ByBig:(int*)offset;
- (int)readInt:(int*)offset;
- (int)readIntByBig:(int*)offset;
- (int)readIntByLittle:(int*)offset;
- (uint32_t)readUint32:(int*)offset;
- (uint32_t)readUint32ByBig:(int*)offset;
- (int64_t)readInt64:(int *)offset;
- (NSNumber*)readInt64ToNumber:(int*)offset;
- (uint64_t)readUint64:(int*)offset;
- (uint64_t)readUint64ByBig:(int*)offset;
- (NSNumber*)readUint64ToNumber:(int*)offset;
- (NSNumber*)readUint64ByBigToNumber:(int*)offset;

- (float_t)readFloat:(int*)offset;
- (float_t)readFloatByBig:(int*)offset;
- (double_t)readDouble:(int*)offset;
- (double_t)readDoubleByBig:(int*)offset;

- (NSString*)readUTF8String:(int *)offset;
- (NSString*)readUTF8String:(int *)offset stringLength:(int)length;

- (NSData *)readData:(int *)offset;
- (NSData *)readData:(int *)offset dataLength:(int)length;

- (NSUInteger)lengthContainsHead;

- (NSString *)hexString;

@end
