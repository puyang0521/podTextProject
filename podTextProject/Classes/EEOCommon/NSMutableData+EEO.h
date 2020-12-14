//
//  NSMutableData+EEO.h
//  EEOCommon
//
//  Created by HeQian on 16/6/29.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (EEO)

- (void)writeInt8:(int8_t)value;
- (void)writeUint8:(uint8_t)value;
- (void)writeBoolean:(BOOL)value;
- (void)writeUint16:(uint16_t)value;
- (void)writeUint16ByBig:(uint16_t)value;
- (void)writeUshort:(ushort)value;
- (void)writeInt:(int)value;
- (void)writeIntByBig:(int)value;
- (void)writeUint32:(uint32_t)value;
- (void)writeUint32ByBig:(uint32_t)value;
- (void)writeInt64:(int64_t)value;
- (void)writeUint64:(uint64_t)value;
- (void)writeUint64ByBig:(uint64_t)value;
- (void)writeFloat:(float_t)value;
- (void)writeFloatByBig:(float_t)value;
- (void)writeDouble:(double_t)value;
- (void)writeDoubleByBig:(double_t)value;
- (void)writeStringByUTF8:(NSString*)value;
- (void)writeStringByUTF8:(NSString*)value length:(NSUInteger)length;
- (void)writeStringByUTF16:(NSString*)value;

- (void)writeData:(NSData *)data;

@end
