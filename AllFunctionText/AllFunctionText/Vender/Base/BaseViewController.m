//
//  BaseViewController.m
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#import "BaseViewController.h"
#import "NSString+HYAES128.h"
#import "HYUnit.h"
#import "BaseNavigationViewController.h"
#import "AppDelegate.h"
#import "CommonCrypto/CommonDigest.h"
#import "AFHTTPSessionManager.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavView];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
/**
 * 设置导航栏左右按钮
 */
- (void)initNavView {
    //左按钮
    _navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, KNAVBAR_BUTTON_Y, 60, 44)];
    
    [_navLeftButton setImage:[UIImage imageNamed:@"icon_back"] forState:(UIControlStateNormal)];
    [_navLeftButton setImageEdgeInsets:(UIEdgeInsetsMake(0, -25, 0, 0))];
    [_navLeftButton addTarget:self action:@selector(navLeftPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:_navLeftButton];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    //右按钮
    _navRightButton = [[UIButton alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH - 45, KNAVBAR_BUTTON_Y, 45, 44)];
    //    _cBtnRight.backgroundColor = [UIColor redColor];
    [_navRightButton setImageEdgeInsets:(UIEdgeInsetsMake(0, 25, 0, 0))];
    [_navRightButton addTarget:self action:@selector(navRightPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:_navRightButton];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

/**
 *  重写Title
 *
 *
 */
//- (void)setCSuperTitle:(NSString *)cSuperTitle {
//    _cSuperTitle = cSuperTitle ;
//    if (cSuperTitle.length > 0) {
//        _lblTitle.text = cSuperTitle;
//    }
//}
- (void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    if (navTitle.length > 0) {
        _navLabelTitle.text = navTitle;
    }
}

/**
 *  导航左按钮事件（默认返回上一页）
 *
 */
- (void)navLeftPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  导航右按钮事件（默认无内容）
 *
 */
- (void)navRightPressed:(id)sender
{
    NSLog(@"=> navRightPressed !");
}

+ (id)l_labelWithText:(NSString *)text
             textFont:(UIFont *)font
            textColor:(UIColor *)color
        textAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *label      = [[UILabel alloc] init];
    label.text          = text;
    label.font          = font;
    label.textColor     = color;
    label.textAlignment = textAlignment;
    return                label;
}

+ (id)l_buttonlWithTitle:(NSString *)text
               titleFont:(UIFont *)font
              titleColor:(UIColor *)color
         backgroundColor:(UIColor *)backgroundColor{
    
    UIButton *button      = [[UIButton alloc] init];
    [button setTitle:text forState:(UIControlStateNormal)];
    [button setTitleColor:color forState:(UIControlStateNormal)];
    button.backgroundColor = backgroundColor;
    button.titleLabel.font = font;
    return button;
}

//ADD
//字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)showMessage:(NSString *)msg{
    [self.view makeToast:msg duration:1.2 position:CSToastPositionCenter
                   title:nil image:nil style:nil completion:nil];
}
- (NSString *)jsonFromDictionary:(NSDictionary *)dic
{
    if ([NSJSONSerialization isValidJSONObject:dic])
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"不是JSON格式");
    return @"";
}

- (void)requestDataWithUrl:(NSString *)strUrl isNeedSVP:(BOOL)isNeed andPostDic:(NSDictionary *)dicPost successBlock:(HY_V2_SS_BLOCK)successBlocker failedBlock:(HY_V2_FAILED_BLOCK)failedBlock
{
    [self dealrequestDataWithUrl:strUrl isNeedSVP:isNeed andPostDic:dicPost successBlock:successBlocker failedBlock:failedBlock];
}
- (void)dealrequestDataWithUrl:(NSString *)strUrl
                     isNeedSVP:(BOOL)isNeed
                    andPostDic:(NSDictionary *)dicPost
                  successBlock:(HY_V2_SS_BLOCK)successBlocker
                   failedBlock:(HY_V2_FAILED_BLOCK)failedBlock
{
    
    //    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dicPost];
    //    [mdic setObject:@"1" forKey:@"terminal"];
    //    if ([DefaultsConfig objectForKey:G_USER_ID])
    //        {
    //        //加入用户ID参数
    //        [mdic setObject:[DefaultsConfig objectForKey:G_USER_ID] forKey:@"userid"];
    //        }
    //    NSString *strContent = [HYUnit jsonFromDictionary:[mdic copy]];
    //    strContent = [strContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    strContent = [strContent stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    strContent = [strContent stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    //    NSLog(@"%@",strContent);
    //    //数据加密
    //    NSString *strAES = [strContent HYAES128EncryptWithKey:@"Y2i200Aoj2vy7PKhZa0rWg=="];
    //
    //    NSLog(@"RequestURL Params====%@\n%@",strUrl,mdic);
    
    
    //封装请求
    HYAFNRequestMethodV2 *rqd = [[HYAFNRequestMethodV2 alloc]init];
    rqd.bNotNeedSVProgressHUD = !isNeed;
    __block BOOL bNotShowMsg = self.bNotShowMsg;
    [rqd GetDictionaryByURL:[NSString stringWithFormat:@"%@%@",G_HTTP_URL,strUrl] Op:nil KeyAndValue:nil PostKeyAndValue:dicPost successBlocker:^(NSDictionary *dicData)
     {
         NSInteger status = [dicData[@"code"] integerValue];
         if (status == 0)
         {
             successBlocker(dicData);
             
         }
         else
         {
             if (!bNotShowMsg && ![dicData[@"msg"] isEqualToString:@"目标不存在"])
             {
                 [SVProgressHUD showErrorWithStatus:dicData[@"msg"]];
             }
             //status == 1001（失效）重新登录
             if (status == 1001) {
                 //             [DefaultsConfig clearAllUserDefaultsData];
                 //             LoginVC *loginVC = [[LoginVC alloc] init];
                 //             BaseNavigationController *baseNavi = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
                 //             AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                 //             app.window.rootViewController = baseNavi;
             }
             failedBlock(dicData);
         }
         
         self.bNotResult = NO;
     }];
}


@end
