//
//  NSFileManager+EEO.m
//  EEOCommon
//
//  Created by HeQian on 16/6/22.
//  Copyright © 2016年 jiangmin. All rights reserved.
//

#import "NSFileManager+EEO.h"

#import <CommonCrypto/CommonDigest.h>

#define FileHashDefaultChunkSizeForReadingData 1024*8

@implementation NSFileManager (EEO)

+ (void)copyHtmlToTempDir {
    NSError *error = nil;
    NSString *mainBundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *path = [mainBundleDirectory  stringByAppendingPathComponent:@"/html"];
    NSURL *htmlURL = [NSURL fileURLWithPath:path];
    if (!htmlURL.fileURL || ![htmlURL checkResourceIsReachableAndReturnError:&error]) {
        return;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [self defaultManager];
    NSURL *temDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory()];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:htmlURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:htmlURL toURL:dstURL error:&error];
}

+ (NSString *)getFileMD5WithPath:(NSString *)path {
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FileHashDefaultChunkSizeForReadingData);
}
CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData) {
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;

    // Get the file URL
    CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault,(CFStringRef)filePath,kCFURLPOSIXPathStyle,(Boolean)false);
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,(CFURLRef)fileURL);
    if (!readStream) goto done;
    
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        
        if (readBytesCount == -1) break;
        
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    
    if (fileURL) {
        CFRelease(fileURL);
    }
    
    return result;
}

- (void)moveOrCreateCacheDirWithOldPath1:(NSString *)oldPath1 oldPath2:(NSString *)oldPath2 finalPath:(NSString *)finalPath {
    if([self fileExistsAtPath:finalPath]){
        return;
    }
    
    NSError *error = nil;
    if([self fileExistsAtPath:oldPath1]){
        [self moveItemAtPath:oldPath1 toPath:finalPath error:&error];
        NSLog(@"1.CacheDir %@ Move,Error:%@",oldPath1,error);
    }else if([self fileExistsAtPath:oldPath2]){
        [self moveItemAtPath:oldPath2 toPath:finalPath error:&error];
        NSLog(@"2.CacheDir %@ Move,Error:%@",oldPath2,error);
    }else{
        [self createDirectoryAtPath:finalPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(error){
            NSLog(@"createFile Error:%@==%@",finalPath,error);
        }
    }
}

@end
