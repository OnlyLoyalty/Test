


//头文件
#import <Foundation/Foundation.h>


@interface iOSMD5 : NSObject
{
    
}

/**
 *  MD5 32位小写加密
 *
 *  @param inPutText 加密字符串
 *
 *  @return 密文
 */
+(NSString *) md5: (NSString *) inPutText ;

/**
 *  MD5 32位大写加密
 *
 *  @param str 加密字符串
 *
 *  @return 密文
 */
+ (NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5 16位大写加密
 *
 *  @param str 加密字符串
 *
 *  @return 密文
 */
+ (NSString *)MD5ForUpper16Bate:(NSString *)str;

@end
