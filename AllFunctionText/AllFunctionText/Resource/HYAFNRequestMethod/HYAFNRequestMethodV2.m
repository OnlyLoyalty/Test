//
//  AFNRequestMethodV2.m
//  Ios_HYCom_Demo
//
//  edit by Zhoux on 15/12/29.
//  Copyright (c) 2015年 SwiftHorse. All rights reserved.
//

//网络数据请求（get、post、post图片）

#import "HYAFNRequestMethodV2.h"
#import "HYUnit.h"
#import "NSString+HYAES128.h"
@interface HYAFNRequestMethodV2 ()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger validCount;//数组有效个数
@property (nonatomic, strong) NSMutableArray *marrImageURLs;

@end

@implementation HYAFNRequestMethodV2

/**
 *  请求接口get
 *
 *  @param strUrl          G_SERVER_URL  http://100.40.86.51:8012/API/Interface.aspx?
 *  @param strOpName       Op参数
 *  @param dicKeyAndValue  NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue successBlocker:(HY_V2_SUCCESS_BLOCK)successBlocker;
{
    NSString *str = [self UrlJointByUrl:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:nil];
    
    NSURLRequest *request;
    if(_timeoutInterval == 0)
    {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString: str]];
    }
    else
    {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:str] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:_timeoutInterval];//限制请求网络时间
    }
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) //成功
     {
         if (!self.bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
//         responseObject = [HYUnit removeHTML:operation.responseString];
//         
//         NSData *strData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
//         
//         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:strData options:kNilOptions error:nil];
         
         NSString *strResponseObject;
         if (!self.bNotRemoveHTML)
         {
             strResponseObject = [HYUnit removeHTML:operation.responseString];
             responseObject = [strResponseObject dataUsingEncoding:NSUTF8StringEncoding];
         }
         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         
         if (!dicData)
         {
             NSLog(@"operation.responseString = %@",responseObject);
         }
         NSLog(@"dicData == op == %@ ==%@",strOpName,dicData);
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             successBlocker(dicData); // block
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
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue successBlocker:(HY_V2_SUCCESS_BLOCK)successBlocker
{
    NSString *str = [self UrlJointByUrl:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = self.setContentType?self.setContentType:[NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", @"charset=utf-8",nil];//ContentTypes
    
    [manager POST:str parameters:dicPostKeyAndValue success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
//         NSLog(@"JSON: == op == %@ ==%@\n%@",strOpName,responseObject,operation.responseString);
         
         responseObject = [HYUnit removeHTML:operation.responseString];
//         responseObject = [responseObject HYAES128DecryptWithKey:@"Y2i200Aoj2vy7PKhZa0rWg=="];
         NSArray * strAry = @[@"\f", @"\n", @"\r", @"\t", @"\v", @"\0", @"\r\t",@"\t\r"];
         for (NSString * onj in strAry)
         {
             [responseObject stringByReplacingOccurrencesOfString:onj withString:@""];
         }
         [responseObject stringByReplacingOccurrencesOfString:@"/\n/g" withString:@""];
         [responseObject stringByReplacingOccurrencesOfString:@"/\r/g" withString:@""];
//         [responseObject stringByReplacingOccurrencesOfString:@"" withString:@""];
//         [responseObject stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
//         [responseObject stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
//         [responseObject stringByReplacingOccurrencesOfString:@"<br/> " withString:@""];
//         [responseObject stringByReplacingOccurrencesOfString:@" <br/> " withString:@""];
         NSData *strData = [responseObject dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
         
         if(strData){
             NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:strData options:kNilOptions error:nil];
             
             if (!dicData)
             {
                 NSLog(@"operation.responseString = %@",responseObject);
             }
             NSLog(@"dicData == op == %@ == %@",strUrl,dicData);
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 successBlocker(dicData); // block
             });
         }
        
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
         NSLog(@"Failure == %@", error);
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [SVProgressHUD showErrorWithStatus:@"网络连接超时\n请确认网络后重试!"];
         });
     }];
}

/**
 *  请求支付接口post
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 */
- (void)payGetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue successBlocker:(HY_V2_SUCCESS_BLOCK)successBlocker {
    NSString *str = [self UrlJointByUrl:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = self.setContentType?self.setContentType:[NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];//ContentTypes
    
    [manager POST:str parameters:dicPostKeyAndValue success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
     if (!_bNotNeedSVProgressHUD)
         {
         [SVProgressHUD dismiss];//关闭等待界面
         }
     
     //         NSLog(@"JSON: == op == %@ ==%@\n%@",strOpName,responseObject,operation.responseString);
     
     responseObject = [HYUnit removeHTML:operation.responseString];
     responseObject = [responseObject HYAES128DecryptWithKey:@"Y2i200Aoj2vy7PKhZa0rWg=="];
     NSArray * strAry = @[@"\f", @"\n", @"\r", @"\t", @"\v", @"\0", @"\r\t",@"\t\r"];
     for (NSString * onj in strAry)
         {
         [responseObject stringByReplacingOccurrencesOfString:onj withString:@""];
         }
     [responseObject stringByReplacingOccurrencesOfString:@"/\n/g" withString:@""];
     [responseObject stringByReplacingOccurrencesOfString:@"/\r/g" withString:@""];
     //         [responseObject stringByReplacingOccurrencesOfString:@"" withString:@""];
     //         [responseObject stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
     //         [responseObject stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
     //         [responseObject stringByReplacingOccurrencesOfString:@"<br/> " withString:@""];
     //         [responseObject stringByReplacingOccurrencesOfString:@" <br/> " withString:@""];
     NSData *strData = [responseObject dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
     
     NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:strData options:kNilOptions error:nil];
     
     if (!dicData)
         {
         NSLog(@"operation.responseString = %@",responseObject);
         }
     NSLog(@"dicData == op == %@ == %@",strUrl,dicData);
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         successBlocker(dicData); // block
         
         NSLog(@"-----------%@",dicData);
     });
     
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) //失败
     {
     if (!_bNotNeedSVProgressHUD)
         {
         [SVProgressHUD dismiss];//关闭等待界面
         }
     
     NSLog(@"Failure == %@", error);
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [SVProgressHUD showErrorWithStatus:@"网络连接超时\n请确认网络后重试!"];
     });
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
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSData *)dataImage successBlocker:(HY_V2_SUCCESS_BLOCK)successBlocker;
{
    NSString *str = [self UrlJointByUrl:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回类型设置
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"charset=utf-8", @"application/json", nil];
    
    [manager POST:str parameters:dicPostKeyAndValue constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData :dataImage name:@"file" fileName:@"file.png" mimeType:@"png"];
     }success:^(AFHTTPRequestOperation *operation,id responseObject) {
         
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
         NSLog(@"JSON: == op == %@ ==%@",strOpName,responseObject);
         responseObject = [HYUnit removeHTML:operation.responseString];

         NSData *strData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         
         NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:strData options:kNilOptions error:nil];
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             successBlocker(dicData);
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
 *  请求接口post上传图片（循环上传图片返回上传顺序）
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 *  @param dataImage           NSData *dataImage = UIImageJPEGRepresentation(image,0);(0-1)数字越大压缩越清晰，图片数据(不拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSData *)dataImage ImageNumber:(NSInteger)iImageNumber successBlocker:(SUCCESS_BLOCK_ADDNUMBER)successBlocker
{
    NSString *str = [self UrlJointByUrl:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:str parameters:dicPostKeyAndValue constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData :dataImage name:@"img" fileName:@"img.png" mimeType:@"png"];
     }success:^(AFHTTPRequestOperation *operation,id responseObject) {
         
         if (!_bNotNeedSVProgressHUD)
         {
             [SVProgressHUD dismiss];//关闭等待界面
         }
         
         NSLog(@"JSON: == op == %@ ==%@",strOpName,responseObject);
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             successBlocker(responseObject,iImageNumber);
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


//测试地址  str = @"http://121.40.86.51:8041/API/LoginInterface.aspx?op=UploadImage";
- (void)uploadImagesByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSArray *)arrImages successBlocker:(HY_SUCCESS_BLOCK)successBlocker
{
    NSString *str = [self UrlJointByUrl:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue];
    
    //初始化数据
    if (!_marrImageURLs)_marrImageURLs = [NSMutableArray array];
    //modify
    NSData *dataImage;
    if (_index < arrImages.count)
    {
        id obj = arrImages[_index];
        if ([obj isKindOfClass:[UIImage class]])
        {
            dataImage = UIImagePNGRepresentation(obj);
        }
        else if ([obj isKindOfClass:[NSData class]])
        {
            dataImage = obj;
        }
        else if ([obj isKindOfClass:[NSString class]])
        {
            UIImage *image = [UIImage imageWithContentsOfFile:obj];
            if (image)
            {
                dataImage = UIImagePNGRepresentation(image);
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
                return;
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
            return;
        }
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:str parameters:dicPostKeyAndValue constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData :dataImage name:@"img" fileName:@"img.png" mimeType:@"png"];
     }success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
//         NSLog(@"JSON: == op == %@ ==%@",strOpName,responseObject);
         
         //        NSData *strData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
         //
         //        NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:strData options:kNilOptions error:nil];
         
         NSDictionary *dicData = responseObject;
         
//         NSLog(@"dicData == %@",dicData);
         id temp = [dicData objectForKey:@"status"];
         
         int iStatus = -1; //初始化为-1;
         
         if (temp)
         {
             iStatus = [temp intValue];
         }
         
         if (iStatus == G_REQUEST_STATUS) //通讯成功
         {
             [_marrImageURLs addObject:dicData];

             if (++_index < arrImages.count)
             {
                 [self uploadImagesByURL:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue dataImage:arrImages successBlocker:successBlocker];
             }
             else
             {
                 successBlocker([NSArray arrayWithArray:_marrImageURLs]);
                 // successBlocker = nil;
                 if (!_bNotNeedSVProgressHUD)
                 {
                     [SVProgressHUD dismiss];//关闭等待界面
                 }
             }
         }
         else
         {
             NSString *strResult = [dicData objectForKey:@"result"];
             [SVProgressHUD showErrorWithStatus:strResult];
         }
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


- (void)requestData:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue successBlocker:(HY_SUCCESS_BLOCK)successBlocker
{
    if (dicPostKeyAndValue.count > 0)
    {
        
    }
    else
    {
//        self
    }
}


- (void)uploadImagesByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSArray *)arrImages successBlocker:(HY_SUCCESS_BLOCK)successBlocker progressBlocker:(HY_PROGRESS_BLOCK)progressBlocker
{
    NSString *str = [self UrlJointByUrl:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue];
    
    //初始化数据
    if (_index == 0)
    {
        self.validCount = [self validObjWhitArray:arrImages andIndex:-1];
    }
    if (!_marrImageURLs)_marrImageURLs = [NSMutableArray array];
    //modify
    NSData *dataImage;
    if (_index < arrImages.count)
    {
        id obj = arrImages[_index];
        if ([obj isKindOfClass:[UIImage class]])
        {
            dataImage = UIImagePNGRepresentation(obj);
        }
        else if ([obj isKindOfClass:[NSData class]])
        {
            dataImage = obj;
        }
        else if ([obj isKindOfClass:[NSString class]])
        {
            UIImage *image = [UIImage imageWithContentsOfFile:obj];
            if (!image)
            {
                image = [UIImage imageNamed:obj];
            }
            if (image)
            {
                dataImage = UIImagePNGRepresentation(image);
            }
            else
            {
                [_marrImageURLs addObject:@""];
                
                if (++_index < arrImages.count)
                {
                    [self uploadImagesByURL:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue dataImage:arrImages successBlocker:successBlocker progressBlocker:progressBlocker];
                }
                else
                {
                    progressBlocker(1,0);
                    successBlocker([NSArray arrayWithArray:_marrImageURLs]);
                    // successBlocker = nil;
                    if (!_bNotNeedSVProgressHUD)
                    {
                        [SVProgressHUD dismiss];//关闭等待界面
                    }
                }
//                [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
                return;
            }
        }
        else
        {
            if (++_index < arrImages.count)
            {
                [self uploadImagesByURL:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue dataImage:arrImages successBlocker:successBlocker progressBlocker:progressBlocker];
            }
            else
            {
                progressBlocker(1,0);
                successBlocker([NSArray arrayWithArray:_marrImageURLs]);
                // successBlocker = nil;
                if (!_bNotNeedSVProgressHUD)
                {
                    [SVProgressHUD dismiss];//关闭等待界面
                }
            }
//            [SVProgressHUD showErrorWithStatus:@"图片上传失败"];
            return;
        }
    }
    
    //进度回调
    void(^progress)(NSUInteger bytesWritten,long long totalBytesWritten,long long totalBytesExpectedToWrite) = ^(NSUInteger bytesWritten,long long totalBytesWritten,long long totalBytesExpectedToWrite)
    {
//        CGFloat percent = ((totalBytesWritten/(float)totalBytesExpectedToWrite) + (float)_index) * (1.f/(float)arrImages.count);
        NSInteger validIndex = [self validObjWhitArray:arrImages andIndex:_index];
        CGFloat percent = ((totalBytesWritten/(float)totalBytesExpectedToWrite) + (float)validIndex) * (1.f/(float)self.validCount);
        
        if (progressBlocker)
        {
            progressBlocker(percent,totalBytesWritten);
        }
    };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回类型设置
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];//请求类型设置
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    AFHTTPRequestOperation *operation = [manager POST:str parameters:dicPostKeyAndValue constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                         {
                                             [formData appendPartWithFileData :dataImage name:@"file" fileName:@"img.png" mimeType:@"image/png"];
                                             
                                         }success:^(AFHTTPRequestOperation *operation,id responseObject)
                                         {
                                             //         NSLog(@"JSON: == op == %@ ==%@",strOpName,responseObject);
                                             
                                             //        NSData *strData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
                                             //
                                             //        NSDictionary *dicData = [NSJSONSerialization JSONObjectWithData:strData options:kNilOptions error:nil];
                                             
                                             NSDictionary *dicData = responseObject;
                                             
                                             //         NSLog(@"dicData == %@",dicData);
                                             id temp = [dicData objectForKey:@"code"];
                                             
                                             int iStatus = -1; //初始化为-1;
                                             
                                             if (temp)
                                             {
                                                 iStatus = [temp intValue];
                                             }
                                             
                                             if (iStatus == G_REQUEST_STATUS) //通讯成功
                                             {
                                                 [_marrImageURLs addObject:dicData];
                                                 
                                                 if (++_index < arrImages.count)
                                                 {
                                                     [self uploadImagesByURL:strUrl Op:strOpName KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue dataImage:arrImages successBlocker:successBlocker progressBlocker:progressBlocker];
                                                 }
                                                 else
                                                 {
                                                     progressBlocker(1,0);
                                                     successBlocker([NSArray arrayWithArray:_marrImageURLs]);
                                                     // successBlocker = nil;
                                                     if (!_bNotNeedSVProgressHUD)
                                                     {
                                                         [SVProgressHUD dismiss];//关闭等待界面
                                                     }
                                                 }
                                             }
                                             else
                                             {
                                                 NSString *strResult = [dicData objectForKey:@"msg"];
                                                 [SVProgressHUD showErrorWithStatus:strResult];
                                             }
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                         {
                                             if (!_bNotNeedSVProgressHUD)
                                             {
                                                 [SVProgressHUD dismiss];//关闭等待界面
                                             }
                                             
                                             NSLog(@"Failure == %@", error);
                                             [SVProgressHUD showErrorWithStatus:@"网络连接超时\n请确认网络后重试!"];
                                         }];
    
    [operation setUploadProgressBlock:progress];
}


/**
 *  Url拼接方法
 *
 *  @param strUrl             strUrl description
 *  @param strOpName          strOpName description
 *  @param dicKeyAndValue     dicKeyAndValue description
 *  @param dicPostKeyAndValue dicPostKeyAndValue description
 *
 *  @return return 完整Url
 */

- (NSString *)UrlJointByUrl:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue
{
    if (!_bNotNeedSVProgressHUD)
    {
//        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];  //等待界面
        [SVProgressHUD show];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@",strUrl];
    
    if (dicPostKeyAndValue == nil) //get方法
    {
        //get url拼接
        if (dicKeyAndValue[@"op"] == nil && strOpName != nil)
        {
            str = [str stringByAppendingFormat:@"op=%@",strOpName];
        }
    }
    else
    {
        //post url拼接
//        NSString *str = [NSString stringWithFormat:@"%@",strUrl];
        if (dicKeyAndValue[@"op"] == nil && dicPostKeyAndValue[@"op"] == nil && strOpName != nil)
        {
            str = [str stringByAppendingFormat:@"op=%@",strOpName];
        }
    }
    
    for (NSString *key in dicKeyAndValue)
    {
        str = [str stringByAppendingFormat:@"&%@=%@",key,dicKeyAndValue[key]];
    }
    
    //打印URL
    NSLog(@"RequestURL===========\n%@",str);
    NSLog(@"RequestdicPostKeyAndValue===========\n%@",dicPostKeyAndValue);
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    
    return str;
}


#pragma mark - Getter

- (NSInteger)validCount
{
    if(_validCount == 0)return 1;
    return _validCount;
}

//整理数据
//1、遍历index=-1
//2、返回某一项有效index index≥0
- (NSInteger)validObjWhitArray:(NSArray *)arr andIndex:(NSInteger)index
{
//    有效index
    if (index >= 0 && index < arr.count)
    {
        NSInteger validCount = 0 ;
        for (int i = 0 ; i < index ; i++)
        {
            validCount ++;
            id obj = arr[i];
            if ([obj isKindOfClass:[UIImage class]])
            {
            }
            else if ([obj isKindOfClass:[NSData class]])
            {
            }
            else if ([obj isKindOfClass:[NSString class]])
            {
                UIImage *image = [UIImage imageWithContentsOfFile:obj];
                if (!image)
                {
                    image = [UIImage imageNamed:obj];
                }
                if (image)
                {
                }
                else
                {
                    validCount --;
                }
            }
            else
            {
                validCount -- ;
            }
        }
        return validCount;
        
        
//        id obj = arr[index];
//        if ([obj isKindOfClass:[UIImage class]])
//        {
//        }
//        else if ([obj isKindOfClass:[NSData class]])
//        {
//        }
//        else if ([obj isKindOfClass:[NSString class]])
//        {
//            UIImage *image = [UIImage imageWithContentsOfFile:obj];
//            if (image)
//            {
//            }
//            else
//            {
//                return 0;
//            }
//        }
//        else
//        {
//            return 0;
//        }
//        return 1;
    }
    else if (index == -1)
    {
        NSInteger validCount = 0 ;
        for (int i = 0 ; i < arr.count ; i++)
        {
            validCount ++;
            id obj = arr[i];
            if ([obj isKindOfClass:[UIImage class]])
            {
            }
            else if ([obj isKindOfClass:[NSData class]])
            {
            }
            else if ([obj isKindOfClass:[NSString class]])
            {
                UIImage *image = [UIImage imageWithContentsOfFile:obj];
                if (!image)
                {
                    image = [UIImage imageNamed:obj];
                }
                if (image)
                {
                }
                else
                {
                    validCount --;
                }
            }
            else
            {
                validCount -- ;
            }
        }
        return validCount;
//        }
//        else
//        {
//            return 0;
//        }
    }
    else
    {
        return 0;
    }
}

@end

