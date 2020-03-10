//
//  NSString+HYAES128.m
//  AESDemo
//
//  Created by Macmini2015 on 16/8/5.
//  Copyright © 2016年 Macmini2015. All rights reserved.
//

#import "NSString+HYAES128.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptoError.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (HYAES128)

- (NSString *)HYAES128EncryptWithKey:(NSString *)key;
{
    //将密钥转码为utf-8 data
    //    NSData *dataKey = [GTMBase64 decodeString:key];
    NSData *dataKey = [[NSData alloc]initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    Byte *byteKey = (Byte *)[dataKey bytes];
    
    //内容转为data
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    Byte *byteData = (Byte *)[data bytes];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    //    CCCryptorStatus CCCrypt(
    //                            CCOperation op,         /* kCCEncrypt, etc. */
    //                            CCAlgorithm alg,        /* kCCAlgorithmAES128, etc. */
    //                            CCOptions options,      /* kCCOptionPKCS7Padding, etc. */
    //                            const void *key,
    //                            size_t keyLength,
    //                            const void *iv,         /* optional initialization vector */
    //                            const void *dataIn,     /* optional per op and alg */
    //                            size_t dataInLength,
    //                            void *dataOut,          /* data RETURNED here */
    //                            size_t dataOutAvailable,
    //                            size_t *dataOutMoved)
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          byteKey,//key
                                          kCCKeySizeAES128,//keyLength
                                          NULL,//iv
                                          byteData,//dataIn
                                          dataLength,
                                          buffer,//dataOut
                                          bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        //        char charBuffer[] = buffer;
        //        for (int i = 0 ; i < charBuffer.length; i ++)
        //        {
        //            <#statements#>
        //        }
        NSData *dataOutput = [NSData dataWithBytesNoCopy:buffer
                                                  length:numBytesEncrypted];
        //        Byte *byte = (Byte *)[data bytes];
        //        for (int i = 0 ; i < data.length; i ++)
        //        {
        //            printf("%d\n",byte[i]);
        //        }
        //        data = [GTMBase64 encodeBytes:byte length:data.length];
        //        NSString *strOutput = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSString *strOutput = [dataOutput base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        return strOutput;
    }
    free(buffer); //free the buffer;
    return @"";
}

- (NSString *)HYAES128DecryptWithKey:(NSString *)key;
{
    //转码
    //    NSData *dataKey = [GTMBase64 decodeString:key];
    NSData *dataKey = [[NSData alloc]initWithBase64EncodedString:key options:NSDataBase64DecodingIgnoreUnknownCharacters];
    Byte *byteKey = (Byte *)[dataKey bytes];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = [data length];
    Byte *byteData = (Byte *)[data bytes];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          byteKey,//key
                                          kCCKeySizeAES128,//keyLength
                                          NULL,//iv
                                          byteData,//dataIn
                                          dataLength,
                                          buffer,//dataOut
                                          bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        //        char charBuffer[] = buffer;
        //        for (int i = 0 ; i < charBuffer.length; i ++)
        //        {
        //            <#statements#>
        //        }
        NSData *dataOutput = [NSData dataWithBytesNoCopy:buffer
                                                  length:numBytesEncrypted];
        NSString *strOutput = [[NSString alloc]initWithData:dataOutput encoding:NSUTF8StringEncoding];
        return strOutput;
    }
    free(buffer); //free the buffer;
    return @"";
    
}

@end
