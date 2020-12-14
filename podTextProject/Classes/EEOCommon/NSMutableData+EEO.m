//
//  NSMutableData+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/6/29.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSMutableData+EEO.h"

@implementation NSMutableData (EEO)

- (void)writeInt8:(int8_t)value {
    [self appendBytes:&value length:sizeof(int8_t)];
}
- (void)writeUint8:(uint8_t)value {
    [self appendBytes:&value length:sizeof(uint8_t)];
}
- (void)writeBoolean:(BOOL)value {
    [self appendBytes:&value length:sizeof(BOOL)];
}
- (void)writeUint16:(uint16_t)value {
    [self appendBytes:&value length:sizeof(uint16_t)];
}
- (void)writeUint16ByBig:(uint16_t)value {
    uint16_t bigValue = CFSwapInt16HostToBig(value);
    [self appendBytes:&bigValue length:sizeof(uint16_t)];
}
- (void)writeUshort:(ushort)value {
    [self appendBytes:&value length:sizeof(ushort)];
}
- (void)writeInt:(int)value {
    [self appendBytes:&value length:sizeof(int)];
}
- (void)writeIntByBig:(int)value {
    uint32_t bigValue = CFSwapInt32HostToBig(value);
    [self appendBytes:&bigValue length:sizeof(int)];
}
- (void)writeUint32:(uint32_t)value {
    [self appendBytes:&value length:sizeof(uint32_t)];
}
- (void)writeUint32ByBig:(uint32_t)value {
    uint32_t bigValue = CFSwapInt32HostToBig(value);
    [self appendBytes:&bigValue length:sizeof(uint32_t)];
}
- (void)writeInt64:(int64_t)value {
    [self appendBytes:&value length:sizeof(int64_t)];
}
- (void)writeUint64:(uint64_t)value {
    [self appendBytes:&value length:sizeof(uint64_t)];
}
- (void)writeUint64ByBig:(uint64_t)value {
    uint64_t bigValue = CFSwapInt64HostToBig(value);
    [self appendBytes:&bigValue length:sizeof(uint64_t)];
}
- (void)writeFloat:(float_t)value {
    [self appendBytes:&value length:sizeof(float_t)];
}
- (void)writeFloatByBig:(float_t)value {
    int32_t littleBytes;
    NSData *littleData = [NSData dataWithBytes:&value length:sizeof(littleBytes)];
    [littleData getBytes:&littleBytes length:sizeof(littleBytes)];
    
    int32_t bigBytes = CFSwapInt32HostToBig(littleBytes);
    [self appendBytes:&bigBytes length:sizeof(bigBytes)];
}
- (void)writeDouble:(double_t)value {
    [self appendBytes:&value length:sizeof(double_t)];
}
- (void)writeDoubleByBig:(double_t)value {
    int64_t littleBytes;
    NSData *littleData = [NSData dataWithBytes:&value length:sizeof(littleBytes)];
    [littleData getBytes:&littleBytes length:sizeof(littleBytes)];
    
    int64_t bigBytes = CFSwapInt64HostToBig(littleBytes);
    [self appendBytes:&bigBytes length:sizeof(bigBytes)];
}
- (void)writeStringByUTF8:(NSString *)value {
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [self appendData:valueData];
    char strTail = '\0';
    [self appendBytes:&strTail length:sizeof(strTail)];
}
- (void)writeStringByUTF8:(NSString*)value length:(NSUInteger)length {
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    if(valueData.length >= length){
        valueData = [valueData subdataWithRange:NSMakeRange(0, length)];
    }
    [self appendData:valueData];
    char strTail = '\0';
    [self appendBytes:&strTail length:sizeof(strTail)];
}
- (void)writeStringByUTF16:(NSString*)value {
    NSData *valueData = [value dataUsingEncoding:NSUTF16StringEncoding];
    [self appendData:valueData];
}

- (void)writeData:(NSData *)data {
    [self writeUint32ByBig:(uint32_t)data.length];
    [self appendData:data];
}

@end
