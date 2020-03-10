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
#define G_REQUEST_STATUS  0
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "SVProgressHUD.h"

@protocol HYAFNDelegate <NSObject>

@optional
/**
 *  GetRequestDictionary  请求接口返回Dictionary代理
 *
 *  @param dicData 返回的Dictionary
 *  @param strOpName  strOpName 用于区分同页面多个接口
 */
- (void)GetRequestDictionary:(NSDictionary *)dicData OpName:(NSString *)strOpName;

//- (void)GetRequestDictionary:(NSDictionary *)dicData OpName:(NSString *)strOpName;
//{
//    if ([strOpName isEqualToString:@"GetIndexData"])
//    {
//        
//    }
//}

/**
 *  GetRequestArray  请求接口返回Array代理
 *
 *  @param arrData 返回的Array
 *  @param strOpName  strOpName 用于区分同页面多个接口
 */
- (void)GetRequestArray:(NSArray *)arrData OpName:(NSString *)strOpName;

//- (void)GetRequestArray:(NSArray *)marrData OpName:(NSString *)strOpName;
//{
//    if ([strOpName isEqualToString:@"GetPhoneData"])
//    {
//        
//    }
//}

/**
 *  GetRequestString  请求接口返回String代理
 *
 *  @param strData 返回的String
 *  @param strOpName  strOpName 用于区分同页面多个接口
 */
- (void)GetRequestString:(NSString *)strData OpName:(NSString *)strOpName;

//- (void)GetRequestString:(NSString *)strData OpName:(NSString *)strOpName
//{
//    if ([strOpName isEqualToString:@"UploadUserLogo"])
//    {
//        
//    }
//}

/**
 *  GetRequestFailureString  请求接口返回错误String代理
 *
 *  @param strStatus 返回的错误状态
 *  @param strOpName 用于区分同页面多个接口
 */
- (void)GetRequestFailureString:(NSString *)strStatus OpName:(NSString *)strOpName;

//- (void)GetRequestFailureString:(NSString *)strStatus OpName:(NSString *)strOpName;
//{
//    if ([strOpName isEqualToString:@"UploadUserLogo"])
//    {
//
//    }
//}


@end

@interface HYAFNRequestMethod : NSObject

@property (nonatomic, retain) id<HYAFNDelegate>delegate;
@property (nonatomic) BOOL bNeedReturnFailure; //设置G_REQUEST_STATUS不等于iStatus时需要代理

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
//HYAFNRequestMethod *reqHY = [[HYAFNRequestMethod alloc]init];
//reqHY.delegate = self;
//reqHY.bNeedReturnFailure = YES;(需要返回错误代理)（bNeedReturnFailure默认为NO）
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
//HYAFNRequestMethod *reqHY = [[HYAFNRequestMethod alloc]init];
//reqHY.delegate = self;
//reqHY.bNeedReturnFailure = YES;(需要返回错误代理)（bNeedReturnFailure默认为NO）
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
//HYAFNRequestMethod *reqHY = [[HYAFNRequestMethod alloc]init];
//reqHY.delegate = self;
//reqHY.bNeedReturnFailure = YES;(需要返回错误代理)（bNeedReturnFailure默认为NO）
//[reqHY GetDictionaryByURL:G_SERVER_URL Op:@"UploadUserLogo" KeyAndValue:dicKeyAndValue PostKeyAndValue:dicPostKeyAndValue dataImage:_dataImg];

@end
