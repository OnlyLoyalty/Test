//
//  AFNRequestMethodV2.h
//  Ios_HYCom_Demo
//
//  edit by Zhoux on 15/12/29.
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
//#import "UpYun.h"

/**
 *  请求接口返回NSDictionary Block
 *
 *  @param dicData 返回的Dictionary （整个）
 */
//#ifndef SUCCESS_BLOCK
typedef void(^HY_V2_SUCCESS_BLOCK)(NSDictionary *dicData);
//#endif
/**
 *  请求接口上传图片 NSDictionary Block
 *
 *  @param dicData      返回的Dictionary
 *  @param iImageNumber 照片上传顺序
 */
typedef void(^SUCCESS_BLOCK_ADDNUMBER)(NSDictionary *dicData,NSInteger iImageNumber);

typedef void(^HY_SUCCESS_BLOCK)(id obj);
typedef void(^HY_PROGRESS_BLOCK)(CGFloat percent,long long requestDidSendBytes);

@interface HYAFNRequestMethodV2 : NSObject
@property (nonatomic) BOOL bNotNeedSVProgressHUD; //设置加载提示是否不需要（默认为NO：需要）
@property (nonatomic,assign) int timeoutInterval; //网络超时时间  默认不设置 单位秒
/**
 *  不需要过滤（默认为NO：需要）
 */
@property (nonatomic) BOOL bNotRemoveHTML;
@property (nonatomic, strong) NSSet *setContentType;//ContentType

//拼接数据方法
- (NSString *)UrlJointByUrl:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue;
/* 
 
 初始化方法（以get为例）
 
 HYAFNRequestMethodV2 *rqd = [[HYAFNRequestMethodV2 alloc]init];
 [rqd GetDictionaryByURL:<#URL#>
 Op:<#OpName#>
 KeyAndValue:@{<#key#>:<#value#>,<#key#>:<#value#>}
 successBlocker:^(NSDictionary *dicData)
 {
 id temp = [dicData objectForKey:@"status"];
 
 int iStatus = -1; //初始化为-1;
 
 if (temp)
 {
 iStatus = [temp intValue];
 }
 
 if (iStatus == 0) //通讯成功
 {
    <#TODO#>
 }
 else
 {
 NSString *strResult = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"result"]];
 [SVProgressHUD showErrorWithStatus:strResult];
 }
 
 }];

 */


/**
 *  请求接口get
 *
 *  @param strUrl          G_SERVER_URL  http://100.40.86.51:8012/API/Interface.aspx?
 *  @param strOpName       Op参数
 *  @param dicKeyAndValue  NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue successBlocker:(HY_V2_SUCCESS_BLOCK)successBlocker;

/**
 *  请求接口post
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue successBlocker:(HY_V2_SUCCESS_BLOCK)successBlocker;

/**
 *  请求支付接口post
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 */
- (void)payGetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue successBlocker:(HY_V2_SUCCESS_BLOCK)successBlocker;

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


/**
 *  请求接口post上传图片（循环上传图片返回上传顺序）
 *
 *  @param strUrl              G_SERVER_URL
 *  @param strOpName           Op参数
 *  @param dicKeyAndValue      NSDictionary *dicKeyAndValue = @{Key1:Value1,Key2:Value2};（拼接在url上）
 *  @param dicPostKeyAndValue  NSDictionary *dicPostKeyAndValue = @{Key1:Value1,Key2:Value2};（不拼接在url上）
 *  @param dataImage           NSData *dataImage = UIImageJPEGRepresentation(image,0);(0-1)数字越大压缩越清晰，图片数据(不拼接在url上）
 */
- (void)GetDictionaryByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSData *)dataImage ImageNumber:(NSInteger)iImageNumber successBlocker:(SUCCESS_BLOCK_ADDNUMBER)successBlocker;

/**
 *  多图上传方法
 *
 *  @param strUrl             header
 *  @param strOpName          op
 *  @param dicKeyAndValue     get参数
 *  @param dicPostKeyAndValue post参数
 *  @param arrImages          图片数组
 *  @param successBlocker     回调block
 */
//- (void)uploadImagesByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSArray *)arrImages successBlocker:(HY_SUCCESS_BLOCK)successBlocker;

/**
 *  多图上传with进度
 *
 *  @param strUrl             header
 *  @param strOpName          op
 *  @param dicKeyAndValue     get参数
 *  @param dicPostKeyAndValue post参数
 *  @param arrImages          图片数组
 *  @param successBlocker     成功回调block
 *  @param progressBlocker    进度回调block
 */
- (void)uploadImagesByURL:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue dataImage:(NSArray *)arrImages successBlocker:(HY_SUCCESS_BLOCK)successBlocker progressBlocker:(HY_PROGRESS_BLOCK)progressBlocker;

//- (void)requestData:(NSString *)strUrl Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue PostKeyAndValue:(NSDictionary *)dicPostKeyAndValue successBlocker:(HY_SUCCESS_BLOCK)successBlocker;

@end
