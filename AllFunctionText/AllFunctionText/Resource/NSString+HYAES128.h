//
//  NSString+HYAES128.h
//  AESDemo
//
//  Created by Macmini2015 on 16/8/5.
//  Copyright © 2016年 Macmini2015. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HYAES128)

/**
 *  加密方法
 *
 *  @param key          密钥（base64格式）
 *
 *  @return 加密内容
 */
- (NSString *)HYAES128EncryptWithKey:(NSString *)key;

/**
 *  解密方法
 *
 *  @param key            密钥（base64格式）
 *
 *  @return 解密内容
 */
- (NSString *)HYAES128DecryptWithKey:(NSString *)key;

@end
