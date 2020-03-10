//
//  HYUnit.h
//  DaJiaZhuan
//
//  Created by Bibo on 15/1/15.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HYUnit : NSObject

/**
 * UITextField实现左侧空出一定的边距
 */
+ (UITextField *)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;

/**
 *  Unicode转成汉字
 *
 *  @param aUnicodeString
 *
 *  @return 汉字
 */
+ (NSString*)replaceUnicode:(NSString*)aUnicodeString;

/**
 *  获取验证码
 *
 *  @return 验证码
 */
+ (NSString *)getVerifCode;

/**
 *  计算文本高度
 *
 *  @param value    文本内容
 *  @param fontSize 字体大小
 *  @param width    文本框宽度
 *
 *  @return 高度
 */
+ (float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

/**
 *  获取当前版本号
 *
 *  @return 版本号
 */
+ (NSString *)getCurrentVersion;

/**
 *  获取城市ID
 *
 *  @param strRegionID 地区ID
 */
+ (NSString *)getCityID:(NSString *)strRegionID;

/**
 *  过滤html标签
 *
 *  @param html
 *
 *  @return
 */
+ (NSString *)removeHTML:(NSString *)html;


/*! @brief 计算文本高度
 *
 *@param text 文本内容
 *@param textWith 文本框宽度
 *@result float 返回文本高度
 */
+ (float)heightForText:(NSString *)text fontSize:(float)fontSize textWith:(float)textWith;
//返回size
+ (CGSize)sizeForText:(NSString *)text fontSize:(UIFont *)font textWith:(float)textWith;

/**
 *  计算文本长度
 *
 *  @param value    文本内容
 *  @param fontSize 字体大小
 *  @param width    文本框宽度
 *
 *  @return 长度
 */
+ (float)widthForString:(NSString *)value fontSize:(float)fontSize andMaxWidth:(float)Maxwidth;

/**
 *  拼接通讯URL
 *
 *  @param strUrl   通讯URL
 *  @param strOp    方法
 *  @param arrKey   参数名
 *  @param arrValue 参数值
 *
 *  @return URL
 */
+ (NSString *)StrpageUrlByURL:(NSString *)strUrl Op:(NSString *)strOp Key:(NSArray *)arrKey Value:(NSArray *)arrValue;

/*! @brief 获取此app版本号
 */
+ (NSString *)getAppVersion;


/*! @brief 获取系统语言
 */
+ (NSString *)getSysLanguage;

/**
 *  信息按拼音A-Z排序
 *
 *  @param arrAllData      排序数据
 *  @param strShortPYKey   排序依据拼音的Key值
 *
 *  @return URL
 */
+ (NSDictionary *)divideDictionaryInMutableArray:(NSArray *)arrAllData shortPYKey:(NSString *)strShortPYKey;

/**
 *  字典、数组 转Json
 *
 *  @param obj 要转换的内容
 *
 *  @return Json格式字符串
 */
+ (NSString *)jsonFromDictionary:(id)obj;
+ (NSString *)jsonFromObj:(id)obj;
//
///**
// *  项目名称
// */
//#define G_WEBSERVICE_PROJECTNAME  @"FineUI"
//
/**
 *  项目英文名+接口名称+日期(yyyy-MM-dd)+请求体 生成签名
 *
 *  @param strOp   接口名称
 *  @param strbody 请求体（Json格式）
 *
 *  @return 签名
 */
+ (NSString *)MD5SignatureFromProjectNameAndOP:(NSString *)strOp dateAndJsonBody:(NSString *)strbody;

@end
