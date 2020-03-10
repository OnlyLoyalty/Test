//
//  AFNRequestMethod.m
//  Ios_HYCom_Demo
//
//  Created by yixiaoshan on 15/9/22.
//  Copyright (c) 2015年 SwiftHorse. All rights reserved.
//

//网络数据请求（get、post、post图片）

#import "HYAFNRequestMethodV1.h"
#import "HYUnit.h"

@implementation HYAFNRequestMethodV1

/**
 *  请求接口get
 *
 *  @param strUrl          G_SERVER_URL  http://100.40.86.51:8012/API/Interface.aspx?
 *  @param strOpName       Op参数
 *  @param dicKeyAndValue  NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue
{
    if (!_bNotNeedSVProgressHUD)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];  //等待界面
    }
    
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
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];//限制请求网络时间
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: str]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) //成功
     {
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
         NSString *strResponseObject;
         if (!_bNotRemoveHTML)
         {
             strResponseObject = [HYUnit removeHTML:operation.responseString];
             responseObject = [strResponseObject dataUsingEncoding:NSUTF8StringEncoding];
         }
         
         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         
         if (!dicData)
         {
             NSLog(@"operation.responseString ================= %@",strResponseObject);
             return;
//             responseObject = [responseObject substringFromIndex:100];
         }
         NSLog(@"dicData == op == %@ ==%@",strOpName,dicData);
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [_delegate GetRequestDictionary:dicData  OpName:strOpName];
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         NSLog(@"Failure == %@", error);
         if (!_bNotNeedShowWhenFailure)
         {
             [SVProgressHUD showErrorWithStatus:@"网络连接超时\n请确认网络后重试!"];
         }
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
    if (!_bNotNeedSVProgressHUD)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];  //等待界面
    }
    
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
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",nil];
    
    [manager POST:str parameters:dicPostKeyAndValue success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (!self->_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
         NSString *strResponseObject;
         if (!self->_bNotRemoveHTML)
         {
             strResponseObject = [HYUnit removeHTML:operation.responseString];
             responseObject = [strResponseObject dataUsingEncoding:NSUTF8StringEncoding];
         }
         
         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         
         if (!dicData)
         {
             NSLog(@"operation.responseString ================= %@",strResponseObject);
             return;
         }
         
         NSLog(@"JSON: == op == %@ ==%@",strOpName,dicData);
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             if (self.delegate && [self.delegate respondsToSelector:@selector(GetRequestDictionary:OpName:)])
             {
                 [_delegate GetRequestDictionary:dicData  OpName:strOpName];
             }
         });
        
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
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
    [self GetDictionaryByURL:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue dataImage:dataImage ImageNumber:-1000];
}

/**
 *  请求接口post上传图片（循环上传图片返回上传顺序）
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 *  @param dataImage           NSData *dataImage = UIImageJPEGRepresentation(image,0);(0-1)数字越大压缩越清晰，图片数据(不拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSData *)dataImage ImageNumber:(NSInteger)iImageNumber
{
    if (!_bNotNeedSVProgressHUD)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];  //等待界面
    }
    
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
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",nil];
    
    [manager POST:str parameters:dicPostKeyAndValue constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData :dataImage name:@"img" fileName:@"img.png" mimeType:@"png"];
     }success:^(AFHTTPRequestOperation *operation,id responseObject) {
         
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         
         NSLog(@"JSON: == op == %@ ==%@",strOpName,dicData);
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             
             if (iImageNumber == -1000)
             {
                 if (self.delegate && [self.delegate respondsToSelector:@selector(GetRequestDictionary:OpName:)])
                 {
                     [_delegate GetRequestDictionary:dicData  OpName:strOpName];
                 }
             }
             else
             {
                 if (self.delegate && [self.delegate respondsToSelector:@selector(GetRequestDictionary:OpName:ImageNumber:)])
                 {
                     [_delegate GetRequestDictionary:dicData  OpName:strOpName ImageNumber:iImageNumber];
                 }
             }
         });
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
         NSLog(@"Failure == %@", error);
         [SVProgressHUD showErrorWithStatus:@"网络连接超时\n请确认网络后重试!"];
     }];
}

@end

