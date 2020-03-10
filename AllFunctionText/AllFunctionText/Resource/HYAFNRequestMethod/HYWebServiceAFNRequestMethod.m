//
//  HYWebServiceAFNRequestMethod.m
//  Ios_HYCom_Demo
//
//  Created by yixiaoshan on 16/2/2.
//  Copyright © 2016年 BourneYao. All rights reserved.
//

#import "HYWebServiceAFNRequestMethod.h"
#import "AFHTTPSessionManager.h"
#import "SVProgressHUD.h"
#import "HYUnit.h"

@implementation HYWebServiceAFNRequestMethod

/**
*  WebService网络请求
*
*  @param strUrl         接口地址
*  @param namespaces     命名空间
*  @param strOpName      接口OP
*  @param dicKeyAndValue XML格式的请求参数
*/
- (void)GetDictionaryByWebServiceURL:(NSString *)strUrl  Namespaces:(NSString *)strNamespaces Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue
{
    if (!_bNotNeedSVProgressHUD)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];  //等待界面
    }
    else
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    //url拼接
    NSString *soapStr = [HYWebServiceAFNRequestMethod DictionaryToWebServiceXML:dicKeyAndValue Namespaces:strNamespaces Op:strOpName];
    
    [HYWebServiceAFNRequestMethod SOAPData:strUrl soapBody:soapStr bNotRemoveHTML:_bNotRemoveHTML webServiceSuccess:^(id responseObject)
     {
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         else
         {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         }
         
         NSLog(@"dicData == op == %@ ==%@",strOpName,responseObject);
         
         if ([_delegate respondsToSelector:@selector(GetRequestWebServiceDictionary:OpName:)])
         {
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [_delegate GetRequestWebServiceDictionary:responseObject OpName:strOpName];
             });
         }
     }webServiceFailure:^(NSError *error)
     {
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         else
         {
             [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
         }
         NSLog(@"Failure == %@", error);
         if (!_bNotNeedShowWhenFailure)
         {
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [SVProgressHUD showErrorWithStatus:@"服务器繁忙\n请稍后重试!"];
             });
         }
     }];
}

/**
 *  XML格式的请求参数拼接
 *
 *  @param dicKeyAndValue XML格式的请求参数
 *  @param namespaces     命名空间
 *  @param strOpName      接口OP
 *
 *  @return <#return value description#>
 */
+ (NSString *)DictionaryToWebServiceXML:(NSDictionary *)dicKeyAndValue Namespaces:(NSString *)namespaces Op:(NSString *)strOpName
{
    NSString *strWebServiceXML = @"";
    
    for (NSString *key in dicKeyAndValue)
    {
        strWebServiceXML = [strWebServiceXML stringByAppendingFormat:@"<%@>%@</%@>",key,dicKeyAndValue[key],key];
    }
    
    strWebServiceXML = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                        <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                        <soap:Body>\
                        <%@ xmlns=\"%@\">\
                        %@\
                        </%@>\
                        </soap:Body>\
                        </soap:Envelope>",strOpName,namespaces,strWebServiceXML,strOpName];
    return strWebServiceXML;
}

/**
 *  webService请求接口
 *
 *  @param url               接口地址
 *  @param soapBody          XML格式的请求参数
 *  @param bNotRemoveHTML    //不需要过滤（默认为NO：需要）
 *  @param webServiceSuccess 请求成功
 *  @param webServiceFailure 请求失败
 */
+ (void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody bNotRemoveHTML:(BOOL)bNotRemoveHTML webServiceSuccess:(void (^)(id responseObject))webServiceSuccess webServiceFailure:(void(^)(NSError *error))webServiceFailure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 60;
    
    // 返回NSData
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置请求头，也可以不设置
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%zd", soapStr.length] forHTTPHeaderField:@"Content-Length"];
//    [manager.requestSerializer setValue:@"www.webxml.com.cn" forHTTPHeaderField:@"Host"];
//    [manager.requestSerializer setValue:@"http://WebXml.com.cn/qqCheckOnline" forHTTPHeaderField:@"SOAPAction"];
    
    // 设置HTTPBody
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error)
    {
        return soapBody;
    }];
    
    [manager POST:url parameters:soapBody success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject)
    {
        // 把返回的二进制数据转为字符串
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (!bNotRemoveHTML)
        {
            result = [HYUnit removeHTML:result];
        }
        
        // 利用正则表达式取出<return></return>之间的字符串
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"(?<=Result>)(.|\\n)*(?=</(.|\\n)*Result)" options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSDictionary *dict = [NSDictionary dictionary];
        for (NSTextCheckingResult *checkingResult in [regular matchesInString:result options:0 range:NSMakeRange(0, result.length)])
        {
            // 得到字典
            dict = [NSJSONSerialization JSONObjectWithData:[[result substringWithRange:checkingResult.range] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            if (!dict)
            {
                NSLog(@"operation.responseString ================= %@",[result substringWithRange:checkingResult.range]);
            }
        }
        // 请求成功并且结果有值把结果传出去
        if (webServiceSuccess && dict)
        {
            webServiceSuccess(dict);
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        if (webServiceFailure)
        {
            webServiceFailure(error);
        }
    }];
}

@end
