//
//  AFNRequestMethod.h
//  Ios_HYCom_Demo
//
//  Created by yixiaoshan on 15/9/22.
//  Copyright (c) 2015年 SwiftHorse. All rights reserved.
//

//
///**
// *  接口返回成功状态参数
// */
//#define G_REQUEST_STATUS  0
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "SVProgressHUD.h"

@protocol HYAFNDelegateV1 <NSObject>

@optional
/**
 *  GetRequestDictionary  请求接口返回Dictionary代理
 *
 *  @param dicData 返回的Dictionary
 *  @param strOpName  strOpName 用于区分同页面多个接口
 */
- (void)GetRequestDictionary:(NSDictionary *)dicData OpName:(NSString *)strOpName;

/**
 *  GetRequestDictionary  请求接口返回Dictionary代理(返回照片上传顺序)
 *
 *  @param dicData      返回的Dictionary
 *  @param strOpName    strOpName 用于区分同页面多个接口
 *  @param iImageNumber 照片上传顺序
 */
- (void)GetRequestDictionary:(NSDictionary *)dicData OpName:(NSString *)strOpName ImageNumber:(NSInteger)iImageNumber;

/**
 *  网络请求回调
 *
 *  @param dicData   返回网络字典
 *  @param strOpName 请求接口的OP参数
 */
//- (void)GetRequestDictionary:(NSDictionary *)dicData OpName:(NSString *)strOpName;
//{
//    id temp = [dicData objectForKey:@"status"];
//    
//    int iStatus = -1; //初始化为-1;
//    
//    if (temp)
//    {
//        iStatus = [temp intValue];
//    }
//    
//    if (iStatus == G_REQUEST_STATUS) //通讯成功
//    {
//        if ([strOpName isEqualToString:@"GetIndexData"])
//        {
//            
//        }
//    }
//    else
//    {
//        NSString *strResult = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"result"]];
//        [SVProgressHUD showErrorWithStatus:strResult];
//    }
//}
//

@end

@interface HYAFNRequestMethodV1 : NSObject

@property (nonatomic, retain) id<HYAFNDelegateV1>delegate;
/**
 *  设置加载提示是否不需要（默认为NO：需要）
 */
@property (nonatomic) BOOL bNotNeedSVProgressHUD;

/**
 *  设置失败提示是否不需要（默认为NO：需要）
 */
@property (nonatomic) BOOL bNotNeedShowWhenFailure; 

/**
 *  不需要过滤（默认为NO：需要）
 */
@property (nonatomic) BOOL bNotRemoveHTML;

/**
 *  请求接口get
 *
 *  @param strUrl          G_SERVER_URL  http://100.40.86.51:8012/API/Interface.aspx?
 *  @param strOpName       Op参数
 *  @param dicKeyAndValue  NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue;

//NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
//NSString *strUserID = [config objectForKey:G_USER_SHIPPERID];
//NSDictionary *dicKeyAndValue = @{@"userid":strUserID};
//HYAFNRequestMethodV1 *reqHY = [[HYAFNRequestMethodV1 alloc]init];
//reqHY.delegate = self;
//[reqHY GetDictionaryByURL:G_SERVER_URL Op:@"GetIndexData" KeyAndValue:dicKeyAndValue];


/**
 *  请求接口post
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue;

//NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
//NSString *strUserID = [config objectForKey:G_USER_SHIPPERID];
//NSDictionary *dicKeyAndValue =@{};
//NSDictionary *dicPostKeyAndValue = @{@"op":@"GetPhoneData",@"userid":strUserID,@"phonearr":_strPhoneArr};
//HYAFNRequestMethodV1 *reqHY = [[HYAFNRequestMethodV1 alloc]init];
//reqHY.delegate = self;
//[reqHY GetDictionaryByURL:G_SERVER_URL Op:@"GetPhoneData" KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue];

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

//NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
//NSString *strUserID = [config objectForKey:G_USER_SHIPPERID];
//NSDictionary *dicKeyAndValue = @{@"op":@"UploadUserLogo",@"&userid":strUserID};
//NSDictionary *dicPostKeyAndValue = @{};
//HYAFNRequestMethodV1 *reqHY = [[HYAFNRequestMethodV1 alloc]init];
//reqHY.delegate = self;
//[reqHY GetDictionaryByURL:G_SERVER_URL Op:@"UploadUserLogo" KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue dataImage:_dataImg];

/**
 *  请求接口post上传图片（循环上传图片返回上传顺序）
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 *  @param dataImage           NSData *dataImage = UIImageJPEGRepresentation(image,0);(0-1)数字越大压缩越清晰，图片数据(不拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSData *)dataImage ImageNumber:(NSInteger)iImageNumber;

@end
