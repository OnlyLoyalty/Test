//
//  HYWebServiceAFNRequestMethod.h
//  Ios_HYCom_Demo
//
//  Created by yixiaoshan on 16/2/2.
//  Copyright © 2016年 BourneYao. All rights reserved.
//

////========================================================================
////===网络请求(WebService)
///**
// *  主机头
// */
//#define G_WEBSERVICE_URL  @"http://192.168.15.151:8100/"        //测试
////#define G_WEBSERVICE_URL  @"http://120.26.101.202:8001/"    //正式
//
///**
// *  后台登入信息接口
// */
//#define G_WEBSERVICE_LOGIN  [NSString stringWithFormat:@"%@%@",G_WEBSERVICE_URL,@"API/LoginInterface.asmx"]
//
///**
// *  后台接口
// */
//#define G_WEBSERVICE_INTERFACE  [NSString stringWithFormat:@"%@%@",G_WEBSERVICE_URL,@"API/W.asmx"]
//
///**
// *  命名空间
// */
//#define G_WEBSERVICE_NAMESPACES  @"http://LoginInterface_FineUI.org/v1/"
//
///**
// *  接口返回成功状态参数
// */
//#define G_REQUEST_STATUS  0
//
////========================================================================

#import <Foundation/Foundation.h>

@protocol HYWebServiceAFNRequestMethod <NSObject>

@optional
/**
 *  GetRequestWebServiceDictionary  请求接口返回Dictionary代理
 *
 *  @param dicData 返回的Dictionary
 *  @param strOpName  strOpName 用于区分同页面多个接口
 */
- (void)GetRequestWebServiceDictionary:(NSDictionary *)dicData OpName:(NSString *)strOpName;

//
///**
// *  WebService
// *
// *  @param dicData   返回网络字典
// *  @param strOpName 请求接口的OP参数
// */
//- (void)GetRequestWebServiceDictionary:(NSDictionary *)dicData OpName:(NSString *)strOpName
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
//        if ([strOpName isEqualToString:@"GetIndexData"])//获取配置信息
//        {
//            
//        }
//    }
//    else
//    {
//        NSString *strResult = [NSString stringWithFormat:@"%@",[dicData objectForKey:@"result"]];
//        if (strResult&&![strResult isEqualToString:@"(null)"])
//        {
//            [SVProgressHUD showErrorWithStatus:strResult];
//        }
//    }
//}
@end

@interface HYWebServiceAFNRequestMethod : NSObject
@property (nonatomic, retain) id<HYWebServiceAFNRequestMethod>delegate;
@property (nonatomic) BOOL bNotNeedSVProgressHUD; //设置加载提示是否不需要（默认为NO：需要）
@property (nonatomic) BOOL bNotNeedShowWhenFailure; //设置失败提示是否不需要（默认为NO：需要）
@property (nonatomic) BOOL bNotRemoveHTML;//不需要过滤
@property (nonatomic) BOOL bNeedAllResult;//需要全部数据
/**
 *  WebService网络请求
 *
 *  @param strUrl         接口地址
 *  @param namespaces     命名空间
 *  @param strOpName      接口OP
 *  @param dicKeyAndValue XML格式的请求参数
 */
- (void)GetDictionaryByWebServiceURL:(NSString *)strUrl  Namespaces:(NSString *)namespaces Op:(NSString *)strOpName KeyAndValue:(NSDictionary *)dicKeyAndValue;

///**
// *  WebService获取网络数据
// *
// *  @param strop 请求接口的OP参数
// */
//-(void)requestWebServiceData:(NSString *)strop
//{
//    NSDictionary *dicKeyAndValue = @{@"loginname":@"321",@"loginpwd":@"123456",@"token":@"321",@"terminal":@"1"};
//    
//    HYWebServiceAFNRequestMethod *reqHY = [[HYWebServiceAFNRequestMethod alloc]init];
//    reqHY.delegate = self;
//    [reqHY GetDictionaryByWebServiceURL:G_WEBSERVICE_INTERFACE Namespaces:G_WEBSERVICE_NAMESPACES Op:strop KeyAndValue:dicKeyAndValue];
//}

///**
// *  WebService获取网络数据 上传文件（包括图片）
// *
// *  @param strop 请求接口的OP参数
// */
//-(void)requestWebServiceData:(NSString *)strop
//{
//    HYWebServiceAFNRequestMethod *reqHY = [[HYWebServiceAFNRequestMethod alloc]init];
//    reqHY.delegate = self;
//    NSDictionary *dicKeyAndValue;
//    if ([strop isEqualToString:@"UploadLogo"])
//    {
//        UIImage *Image = [UIImage imageNamed:@"bg_guanggao_3"];
//        dataImage = UIImageJPEGRepresentation(Image,0);
//        NSString *_encodedImageStr = [dataImage base64Encoding];
//        dicKeyAndValue = @{@"userid":@"1",@"file":_encodedImageStr,@"fileExtension":@".png"};
//    }
//    [reqHY GetDictionaryByWebServiceURL:G_WEBSERVICE_LOGIN Namespaces:G_WEBSERVICE_NAMESPACES Op:strop KeyAndValue:dicKeyAndValue];
//}

///**
// *  WebService获取网络数据（签名验证）项目英文名+接口名称+日期(yyyy-MM-dd)+请求体 生成签名
// *
// *  @param strop 请求接口的OP参数
// */
//
///**
// *  项目名称
// */
//#define G_WEBSERVICE_PROJECTNAME  @"FineUI"
//
//-(void)requestWebServiceData:(NSString *)strop
//{
//    HYWebServiceAFNRequestMethod *reqHY = [[HYWebServiceAFNRequestMethod alloc]init];
//    reqHY.delegate = self;
//    NSDictionary *dicKeyAndValue;
//    if ([strop isEqualToString:@"GetLocation"])
//    {
//        NSDictionary *dic = @{@"longitude":@"120",@"latitude":@"30"};
//        NSString *strbody = [HYUnit jsonFromDictionary:dic];
//        NSString *strSignature = [HYUnit MD5SignatureFromProjectNameAndOP:strop dateAndJsonBody:strbody];
//        dicKeyAndValue = @{@"body":strbody,@"signature":strSignature};
//    }
//    [reqHY GetDictionaryByWebServiceURL:G_WEBSERVICE_LOGIN Namespaces:G_WEBSERVICE_NAMESPACES Op:strop KeyAndValue:dicKeyAndValue];
//}

/**
 *  XML格式的请求参数拼接
 *
 *  @param dicKeyAndValue XML格式的请求参数
 *  @param namespaces     命名空间
 *  @param strOpName      接口OP
 *
 *  @return
 */
+ (NSString *)DictionaryToWebServiceXML:(NSDictionary *)dicKeyAndValue Namespaces:(NSString *)namespaces Op:(NSString *)strOpName;

/**
 *  webService请求接口
 *
 *  @param url               接口地址
 *  @param soapBody          XML格式的请求参数
 *  @param bNotRemoveHTML    //不需要过滤（默认为NO：需要）
 *  @param webServiceSuccess 请求成功
 *  @param webServiceFailure 请求失败
 */
+ (void)SOAPData:(NSString *)url soapBody:(NSString *)soapBody bNotRemoveHTML:(BOOL)bNotRemoveHTML webServiceSuccess:(void (^)(id responseObject))webServiceSuccess webServiceFailure:(void(^)(NSError *error))webServiceFailure;

@end
