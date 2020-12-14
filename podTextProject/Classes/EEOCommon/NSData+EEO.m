//
//  NSData.m
//  EEOBusinessLogic
//
//  Created by HeQian on 16/3/14.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSData+EEO.h"

@implementation NSData (EEO)

- (int8_t)readInt8:(int *)offset {
    int8_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}
- (uint8_t)readUint8:(int *)offset {
    uint8_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}

- (uint16_t)readUint16:(int *)offset {
    uint16_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}
- (uint16_t)readUint16ByBig:(int *)offset {
    uint16_t result = [self readUint16:offset];
    result = CFSwapInt16HostToBig(result);
    return result;
}

- (int)readInt:(int *)offset {
    int result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}
- (int)readIntByBig:(int*)offset {
    int result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    result = CFSwapInt32HostToBig(result);
    *offset += sizeof(result);
    return result;
}
- (int)readIntByLittle:(int*)offset {
    int result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    result = CFSwapInt32LittleToHost(result);
    *offset += sizeof(result);
    return result;
}

- (uint32_t)readUint32:(int*)offset {
    uint32_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}
- (uint32_t)readUint32ByBig:(int*)offset {
    uint32_t result = [self readUint32:offset];
    result = CFSwapInt32HostToBig(result);
    return result;
}

- (int64_t)readInt64:(int *)offset {
    int64_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}
- (NSNumber*)readInt64ToNumber:(int *)offset {
    int64_t result = [self readInt64:offset];
    return @(result);
}

- (uint64_t)readUint64:(int *)offset {
    uint64_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}
- (uint64_t)readUint64ByBig:(int *)offset {
    uint64_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    result = CFSwapInt64HostToBig(result);
    *offset += sizeof(result);
    return result;
}
- (NSNumber*)readUint64ToNumber:(int*)offset {
    uint64_t result = [self readUint64:offset];
    return @(result);
}
- (NSNumber*)readUint64ByBigToNumber:(int*)offset {
    uint64_t result = [self readUint64ByBig:offset];
    return @(result);
}

- (float_t)readFloat:(int*)offset {
    float_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}
- (float_t)readFloatByBig:(int*)offset {
    int32_t littleBytes;
    [self getBytes:&littleBytes range:NSMakeRange(*offset, sizeof(littleBytes))];
    int32_t bigBytes = CFSwapInt32HostToBig(littleBytes);
    NSData *numData = [NSData dataWithBytes:&bigBytes length:sizeof(bigBytes)];
    
    float_t result;
    [numData getBytes:&result length:sizeof(result)];
    *offset += sizeof(result);
    return result;
}
- (double_t)readDouble:(int*)offset {
    double_t result;
    [self getBytes:&result range:NSMakeRange(*offset, sizeof(result))];
    *offset += sizeof(result);
    return result;
}
- (double_t)readDoubleByBig:(int*)offset {
    int64_t littleBytes;
    [self getBytes:&littleBytes range:NSMakeRange(*offset, sizeof(littleBytes))];
    int64_t bigBytes = CFSwapInt64HostToBig(littleBytes);
    NSData *numData = [NSData dataWithBytes:&bigBytes length:sizeof(bigBytes)];
    
    double_t result;
    [numData getBytes:&result length:sizeof(result)];
    *offset += sizeof(result);
    return result;
}

- (NSString*)readUTF8String:(int *)offset {
    NSString *result = nil;
    NSData *laterData = [self subdataWithRange:NSMakeRange(*offset, self.length-*offset)];
    __block NSUInteger strTerminatorIndex = 0;
    [laterData enumerateByteRangesUsingBlock:^(const void * _Nonnull bytes, NSRange byteRange, BOOL * _Nonnull stop) {
        for (NSInteger i=0; i<byteRange.length; i++) {
            if(((char*)bytes)[i] == '\0'){
                *stop = YES;
                break;
            }
            strTerminatorIndex ++;
        }
    }];
    result = [[NSString alloc] initWithData:[laterData subdataWithRange:NSMakeRange(0, strTerminatorIndex)] encoding:NSUTF8StringEncoding];
    *offset += strTerminatorIndex + 1;//跳过结尾符占用的一个字节
    return result;
}
- (NSString*)readUTF8String:(int *)offset stringLength:(int)length {
    NSString *result = nil;
    NSData *laterData = [self subdataWithRange:NSMakeRange(*offset, length)];
    result = [[NSString alloc] initWithData:laterData encoding:NSUTF8StringEncoding];
    *offset += length;
    return result;
}

- (NSData *)readData:(int *)offset {
    NSData *result = nil;
    NSUInteger dataLength = [self readUint32ByBig:offset];
    result = [self subdataWithRange:NSMakeRange(*offset, dataLength)];
    *offset += dataLength;
    return result;
}
- (NSData *)readData:(int *)offset dataLength:(int)length {
    NSData *result = nil;
    result = [self subdataWithRange:NSMakeRange(*offset, length)];
    *offset += length;
    return result;
}

- (NSUInteger)lengthContainsHead {
    return sizeof(uint32_t) + self.length;
}

- (NSString *)hexString {
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

@end
