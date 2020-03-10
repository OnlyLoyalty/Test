//
//  HYUnit.m
//  DaJiaZhuan
//
//  Created by Bibo on 15/1/15.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "HYUnit.h"

@implementation HYUnit

/**
 * UITextField实现左侧空出一定的边距
 */
+ (UITextField *)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
    
    return textField;
}

/**
 *  Unicode转成汉字
 *
 *  @param aUnicodeString
 *
 *  @return 汉字
 */
+ (NSString*)replaceUnicode:(NSString*)aUnicodeString
{
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

/**
 *  获取验证码
 *
 *  @return 验证码
 */
+ (NSString *)getVerifCode
{
    NSString *strCode = [NSString stringWithFormat:@"%d%d%d%d",arc4random()%5 ,arc4random()%5,arc4random()%5,arc4random()%5];
    return strCode;
}

/**
 *  计算文本高度
 *
 *  @param value    文本内容
 *  @param fontSize 字体大小
 *  @param width    文本框宽度
 *
 *  @return 高度
 */
+ (float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    return deSize.height;
}

/**
 *  计算文本长度
 *
 *  @param value    文本内容
 *  @param fontSize 字体大小
 *  @param width    文本框宽度
 *
 *  @return 长度
 */
+ (float)widthForString:(NSString *)value fontSize:(float)fontSize andMaxWidth:(float)Maxwidth
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, Maxwidth, 0)];
    detailTextView.font = [UIFont systemFontOfSize:fontSize];
    detailTextView.text = value;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(Maxwidth,CGFLOAT_MAX)];
    return deSize.width;
}

/**
 *  获取当前版本号
 *
 *  @return 版本号
 */
+ (NSString *)getCurrentVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    return appVersion;
}


/**
 *  获取城市ID
 *
 *  @param strRegionID 地区IDparentid
 */
+ (NSString *)getCityID:(NSString *)strRegionID
{
    NSString *strCityPath = [[NSBundle mainBundle] pathForResource:@"region" ofType:@"plist"]; ;
    NSMutableArray *mutarrCity = [[NSMutableArray alloc] initWithContentsOfFile:strCityPath];
    
    NSString *strCityID;
    
    for (int i = 0; i < mutarrCity.count; i++)
    {
        NSDictionary *dicItem = mutarrCity[i];
        if ([[dicItem objectForKey:@"regionid"] isEqualToString:strRegionID])
        {
            strCityID = [dicItem objectForKey:@"parentid"];
            
            return strCityID;
        }
    }
    
    return strCityID;
}

/**
 *  过滤html标签
 *
 *  @param html
 *
 *  @return
 */
+ (NSString *)removeHTML:(NSString *)html
{
    html = [html stringByReplacingOccurrencesOfString:@"<(.[^>]*)>" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"([\r\n])[\\s]+" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"../" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\n"];
    html = [html stringByReplacingOccurrencesOfString:@"<br />" withString:@"\\n"];
    html = [html stringByReplacingOccurrencesOfString:@"<br>" withString:@"\\n"];
    html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    html = [html stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<span>" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"\u00a0" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    return html;
}

/**
 *  unicode转汉字
 *
 *  @param unicodeStr
 *
 *  @return
 */
- (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

/*! @brief 计算文本高度
 *
 *@param text 文本内容
 *@param textWith 文本框宽度
 *@result float 返回文本高度
 */
+ (float)heightForText:(NSString *)text fontSize:(float)fontSize textWith:(float)textWith
{
    CGSize constraint = CGSizeMake(textWith, 20000.0f);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    return size.height;
}


+ (CGSize)sizeForText:(NSString *)text fontSize:(UIFont *)font textWith:(float)textWith
{
    CGSize constraint = CGSizeMake(textWith, 20000.0f);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    return size;
}


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
+ (NSString *)StrpageUrlByURL:(NSString *)strUrl Op:(NSString *)strOp Key:(NSArray *)arrKey Value:(NSArray *)arrValue
{
    NSString *str = [NSString stringWithFormat:@"%@%@",strUrl,strOp];
    
    for (int i = 0; i < arrKey.count; i ++)
    {
        if (i == 0)
        {
            str = [str stringByAppendingFormat:@"%@=%@",arrKey[i],arrValue[i]];
        }
        else
        {
            str = [str stringByAppendingFormat:@"&%@=%@",arrKey[i],arrValue[i]];
        }
        
    }
    
    str = [str stringByReplacingOccurrencesOfString:@"\r\n" withString:@"<br>"];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@"<br>"];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return str;
}

/*! @brief 获取此app版本号
 */
+ (NSString *)getAppVersion
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *strAppVersion = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
    return strAppVersion;
}

/*! @brief 获取系统语言
 */
+ (NSString *)getSysLanguage
{
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    
    return language;
}

/**
 *  信息按拼音A-Z排序
 *
 *  @param arrAllData      排序数据
 *  @param strShortPYKey   排序依据拼音的Key值
 *
 *  @return URL
 */
+ (NSDictionary *)divideDictionaryInMutableArray:(NSArray *)arrAllData shortPYKey:(NSString *)strShortPYKey
{
    //建立#组
    NSMutableArray *marrTitleFrist = [NSMutableArray new];
    for (int i = 0; i < arrAllData.count; i++)
    {
        NSDictionary *dic = arrAllData[i];
        if ([dic[strShortPYKey] length]==0)
        {
            [marrTitleFrist addObject:dic];
        }
        else
        {
            char cFrist = [dic[strShortPYKey] characterAtIndex:0];
            if (cFrist<'A'||cFrist>'Z')
            {
                [marrTitleFrist addObject:dic];
            }
            else
            {
                break;
            }
        }
    }
    
    NSMutableArray *marrTitle = [[NSMutableArray alloc]init];
    NSMutableArray *marrTempTitle = [[NSMutableArray alloc]init];
    char cLetter = 'A';
    NSString *strLetter = [NSString stringWithFormat:@"%c",cLetter];
    //根据首字母分组
    for (NSUInteger i = marrTitleFrist.count ; i < arrAllData.count;i++)
    {
        NSDictionary *dic = arrAllData[i];
        if ([dic[strShortPYKey] hasPrefix:strLetter])
        {
            [marrTempTitle addObject:dic];
        }
        else
        {
            cLetter = cLetter+1;
            strLetter = [NSString stringWithFormat:@"%c",cLetter];
            if (marrTempTitle.count != 0)
            {
                [marrTitle addObject:marrTempTitle];
                marrTempTitle = [[NSMutableArray alloc]init];
            }
            i--;
        }
    }
    
    //添加最后一组
    if (marrTempTitle.count > 0)
    {
        [marrTitle addObject:marrTempTitle];
        marrTempTitle = [[NSMutableArray alloc]init];
    }
    
    //建立索引数据
    NSMutableArray *marrSectionTitle = [[NSMutableArray alloc]init];
    for (int i = 0; i < marrTitle.count;i++)
    {
        NSString *strSectionTitle = [[marrTitle[i][0] objectForKey:strShortPYKey]substringToIndex:1];
        [marrSectionTitle addObject:strSectionTitle];
    }
    if (marrTitleFrist.count>0)
    {
        [marrSectionTitle insertObject:@"#" atIndex:0];
        [marrTitle insertObject:marrTitleFrist atIndex:0];
    }
    
    return @{@"marrIndexTitle":marrSectionTitle,@"marrDicData":marrTitle};
}

/**
 *  字典转Json
 *
 *  @param dic 要转换的字典
 *
 *  @return Json格式字符串
 */
+ (NSString *)jsonFromDictionary:(NSDictionary *)dic
{
    if ([NSJSONSerialization isValidJSONObject:dic])
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"不是JSON格式");
    return @"";
}

+ (NSString *)jsonFromObj:(id)obj
{
    if ([NSJSONSerialization isValidJSONObject:obj])
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"无法转换");
    return @"";
}


@end
