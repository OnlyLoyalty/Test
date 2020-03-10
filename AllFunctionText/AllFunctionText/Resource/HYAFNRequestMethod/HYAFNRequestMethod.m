//
//  AFNRequestMethod.m
//  Ios_HYCom_Demo
//
//  Created by yixiaoshan on 15/9/22.
//  Copyright (c) 2015年 SwiftHorse. All rights reserved.
//

//网络数据请求（get、post、post图片）

#import "HYAFNRequestMethod.h"
#import "HYUnit.h"

@implementation HYAFNRequestMethod

/**
 *  请求接口get
 *
 *  @param strUrl          G_SERVER_URL  http://100.40.86.51:8012/API/Interface.aspx?
 *  @param strOpName       Op参数
 *  @param dicKeyAndValue  NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];  //等待界面
    //url拼接
    NSString *str = [NSString stringWithFormat:@"%@",strUrl];
    if (dicKeyAndValue[@"op"] == nil&&strOpName != nil)
    {
        str = [str stringByAppendingFormat:@"op=%@",strOpName];
    }
    
    for (NSString *key in dicKeyAndValue)
    {
        str = [str stringByAppendingFormat:@"&%@=%@",key,dicKeyAndValue[key]];
    }
    
    //打印URL
    NSLog(@"RequestURL===========\n%@",str);
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];//限制请求网络时间
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: strUrl]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) //成功
     {
         [SVProgressHUD dismiss];//关闭等待界面
//         NSLog(@"operation.responseString = %@",operation.responseString);
         responseObject = [HYUnit removeHTML:operation.responseString];
         
//         NSString *strResult = [HYUnit removeHTML:responseObject];
         NSData *strData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         
         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:strData options:kNilOptions error:nil];
         
         NSLog(@"dicData == %@",dicData);
         id temp = [dicData objectForKey:@"status"];
         
         int iStatus = -1; //初始化为-1;
         
         if (temp)
         {
             iStatus = [temp intValue];
         }
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             if (iStatus == G_REQUEST_STATUS) //通讯成功
             {
                 if ([[dicData objectForKey:@"result"] isKindOfClass:[NSDictionary class]])
                 {
                     [_delegate GetRequestDictionary:[dicData objectForKey:@"result"]  OpName:strOpName];
                 }
                 else if ([[dicData objectForKey:@"result"] isKindOfClass:[NSArray class]])
                 {
                     [_delegate GetRequestArray:[dicData objectForKey:@"result"] OpName:strOpName];
                 }
                 else
                 {
                     [_delegate GetRequestString:[dicData objectForKey:@"result"] OpName:strOpName];
                 }
             }
             else
             {
                 NSString *strResult = [NSString stringWithFormat:@"status=%@",[dicData objectForKey:@"status"]];
                 [SVProgressHUD showErrorWithStatus:strResult];
                 if (_bNeedReturnFailure)
                 {
                     [_delegate GetRequestFailureString:[dicData objectForKey:@"status"] OpName:strOpName];
                 }
             }
         });
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         [SVProgressHUD dismiss];//关闭等待界面
         NSLog(@"Failure == %@", error);
         [SVProgressHUD showErrorWithStatus:@"网络连接超时\n请确认网络后重试!"];
     }];
    [operation start];
}

/**
 *  请求接口post
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];  //等待界面
    //url拼接
    NSString *str = [NSString stringWithFormat:@"%@",strUrl];
    if (dicKeyAndValue[@"op"] == nil&&dicPostKeyAndValue[@"op"] == nil&&strOpName != nil)
    {
        str = [str stringByAppendingFormat:@"op=%@",strOpName];
    }
    
    for (NSString *key in dicKeyAndValue)
    {
        str = [str stringByAppendingFormat:@"&%@=%@",key,dicKeyAndValue[key]];
    }
    
    //打印URL
    NSLog(@"RequestURL===========\n%@",str);
    NSLog(@"RequestdicPostKeyAndValue===========\n%@",dicPostKeyAndValue);
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:str parameters:dicPostKeyAndValue success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [SVProgressHUD dismiss];//关闭等待界面
         NSLog(@"JSON: %@", responseObject);
         
         id temp = [responseObject objectForKey:@"status"];
         int iStatus = -1; //初始化为-1;
         if (temp)
         {
             iStatus = [temp intValue];
         }
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             if (iStatus == G_REQUEST_STATUS) //通讯成功
             {
                 if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSDictionary class]])
                 {
                     [_delegate GetRequestDictionary:[responseObject objectForKey:@"result"]  OpName:strOpName];
                 }
                 else if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSArray class]])
                 {
                     [_delegate GetRequestArray:[responseObject objectForKey:@"result"] OpName:strOpName];
                 }
                 else
                 {
                     [_delegate GetRequestString:[responseObject objectForKey:@"result"] OpName:strOpName];
                 }
             }
             else
             {
                 NSString *strResult = [NSString stringWithFormat:@"status=%@",[responseObject objectForKey:@"status"]];
                 [SVProgressHUD showErrorWithStatus:strResult];
                 if (_bNeedReturnFailure)
                 {
                     [_delegate GetRequestFailureString:[responseObject objectForKey:@"status"] OpName:strOpName];
                 }
             }
         });
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         [SVProgressHUD dismiss];//关闭等待界面
         NSLog(@"Failure == %@", error);
         [SVProgressHUD showErrorWithStatus:@"网络连接超时\n请确认网络后重试!"];
     }];
}

/**
 *  请求接口post上传图片
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 *  @param dataImage           NSData *dataImage = UIImageJPEGRepresentation(image,0);(0-1)数字越大压缩越清晰，图片数据(不拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSData *)dataImage;
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];  //等待界面
    //url拼接
    NSString *str = [NSString stringWithFormat:@"%@",strUrl];
    if (dicKeyAndValue[@"op"] == nil&&dicPostKeyAndValue[@"op"] == nil&&strOpName != nil)
    {
        str = [str stringByAppendingFormat:@"op=%@",strOpName];
    }
    
    for (NSString *key in dicKeyAndValue)
    {
        str = [str stringByAppendingFormat:@"&%@=%@",key,dicKeyAndValue[key]];
    }
    
    //打印URL
    NSLog(@"RequestURL===========\n%@",str);
    NSLog(@"RequestdicPostKeyAndValue===========\n%@",dicPostKeyAndValue);
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:str parameters:dicPostKeyAndValue constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData :dataImage name:@"img" fileName:@"img.png" mimeType:@"png"];
     }success:^(AFHTTPRequestOperation *operation,id responseObject) {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];//关闭等待界面
         
         id temp = [responseObject objectForKey:@"status"];
         int iStatus = -1; //初始化为-1;
         if (temp)
         {
             iStatus = [temp intValue];
         }
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             if (iStatus == G_REQUEST_STATUS) //通讯成功
             {
                 if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSDictionary class]])
                 {
                     [_delegate GetRequestDictionary:[responseObject objectForKey:@"result"]  OpName:strOpName];
                 }
                 else if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSArray class]])
                 {
                     [_delegate GetRequestArray:[responseObject objectForKey:@"result"] OpName:strOpName];
                 }
                 else
                 {
                     [_delegate GetRequestString:[responseObject objectForKey:@"result"] OpName:strOpName];
                 }
             }
             else
             {
                 NSString *strResult = [NSString stringWithFormat:@"status=%@",[responseObject objectForKey:@"status"]];
                 [SVProgressHUD showErrorWithStatus:strResult];
                 if (_bNeedReturnFailure)
                 {
                     [_delegate GetRequestFailureString:[responseObject objectForKey:@"status"] OpName:strOpName];
                 }
             }
         });
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         NSLog(@"Failure == %@", error);
         [SVProgressHUD dismiss];//关闭等待界面
         [SVProgressHUD showErrorWithStatus:@"网络连接超时\n请确认网络后重试!"];
     }];
}

@end

