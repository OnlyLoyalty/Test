//
//  Hong.h
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#ifndef Hong_h
#define Hong_h

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark - 网络
#define G_HTTP_URL @""

//随机颜色
#define KRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//颜色
#define TITLE_COLOR [UIColor blackColor]//标题颜色
#define TEXT_COLOR [UIColor grayColor]//正文颜色
#define TIPTEXT_COLOR UIColorFromRGB(0x888888)//提示语文本颜色
#define MAIN_GROUNDCOLOR UIColorFromRGB(0xF98B1B)//主题景色
#define BACKGROUNDCOLOR UIColorFromRGB(0xF7F7F7)//背景颜色
//字体大小
#define TITLEFONT [UIFont systemFontOfSize:18]
#define TEXTFONT [UIFont systemFontOfSize:16]
#define TIPTEXTFONT [UIFont systemFontOfSize:12]

#if DEVELOPMENT //***************开发版本*************
//****************测试环境***********
//app服务重构测试
//#define BaseURLString   @"http://www-test.baidu.com/rest/post"//beta
//#define BaseURLString @"http://docker-branch02-web-tomcat.baidu.com:8080/rest/post"//分之域名
//****************开发环境(个人服务器)************
//后台XXX
#define BaseURLString  @"http://192.168.1.175:8080/baidu/rest/post"
#else          //**************生产版本**************
#define BaseURLString @"https://www.baidu.com/rest/post"
#endif

//****************接口说明************
//获取用户信息
#define Request_type_getUserInfo @"getUserInfo"
//首页广告
#define Request_type_queryBannerByType @"queryBannerByType"
#pragma mark - 网络

#define Token      @"token"
#define Mobile     @"mobile"
#define PassWord   @"password"

#pragma mark-   系统版本和机型
// 系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS6_OR_UP (IOS_VERSION >= 6.0) ? YES : NO
#define IOS7_OR_UP (IOS_VERSION >= 7.0) ? YES : NO
#define IOS8_OR_UP (IOS_VERSION >= 8.0) ? YES : NO
#define IOS9_OR_UP (IOS_VERSION >= 9.0) ? YES : NO

//是否为iOS8及以上系统 （10.0+ 获得的是1）
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

//当前设备系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//weak strong self for retain cycle
#define WEAK_SELF __weak typeof(self)weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf


// 设备类型, 2 >> ipad, 1 >> iphone
#define Device_Type (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 1 : 2
#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? YES : NO
#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? YES : NO
#define IS_RETINA   ([[UIScreen mainScreen] scale] >= 2.0)

// 机型
#define IS_IPHONE4  (IS_IPHONE && Screen_Height == 480.0f) ? YES : NO
#define IS_IPHONE5  (IS_IPHONE && Screen_Height == 568.0f) ? YES : NO
#define IS_IPHONE6  (IS_IPHONE && Screen_Height == 667.0f) ? YES : NO
#define IS_IPHONE6P (IS_IPHONE && Screen_Height == 736.0f) ? YES : NO
#define IS_IPHONE7  (IS_IPHONE && Screen_Height == 667.0f) ? YES : NO
#define IS_IPHONE7P (IS_IPHONE && Screen_Height == 736.0f) ? YES : NO

#define TARGET_IPHONE_SIMULATOR     TARGET_OS_SIMULATOR /* deprecated */

//获取屏幕 宽度、高度
#define KSCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define KTABBAR_HEIGHT (KSCREEN_HEIGHT==812?68*SCALAE+49:49)
#define KNAVBAR_TOP_HEIGHT (KSCREEN_HEIGHT==812?88*SCALAE:20)
#define KTABBAR_BOTTOM_HEIGHT (KSCREEN_HEIGHT==812?68*SCALAE:0)

/**宽度比例*/
#define SCALAE KSCREEN_WIDTH/375.0/2.0

/**高度比例*/
#define SCALEH  [UIScreen mainScreen].bounds.size.height/667.f

// 常用系统的高度
#define Height_KeyBoard         216.0f
#define Height_TabBar           49.0f
#define Height_NavigationBar    44.0f
#define Height_StatusBar        20.0f
#define Height_TopBar   Height_NavigationBar + Height_StatusBar //64

#define KHEXCOLOR(c) [UIColor colorWithHexString:(c)]

//字体
#define KFONTSIZE(f) [UIFont systemFontOfSize:(f)]

#define APP_NAVI_BAR_FONT    [UIFont boldSystemFontOfSize:16]

#define APP_FONT(size) [UIFont systemFontOfSize:SCREEN_WIDTH_PER*size]

#define APP_BOLD_FONT(size) [UIFont boldSystemFontOfSize:SCREEN_WIDTH_PER*size]


#define APP_NAVI_BAR_COLOR    UIColorFromRGBA(244, 244, 244, 1.0)
#define APP_TAB_BARCOLOR      UIColorFromRGBA(236, 236, 239, 1.0)
#define APP_VIEW_BG_COLOR     UIColorFromRGBA(239, 238, 244, 1.0)


// 主题色
#define APP_BACK_COLOR       KHEXCOLOR(@"#B18A6A")
// 间隔 颜色
#define APP_PADDING_COLOR     UIColorFromRGBA(235, 235, 238, 1.0)

#define APP_TITLE_COLOR       UIColorFromRGBA(0, 0, 0, 1.0)
#define APP_SUBTITLE_COLOR    [UIColor colorWithRed:175.0/255 green:175.0/255 blue:175.0/255 alpha:1]
#define APP_INFO_COLOR        UIColorFromRGB(194, 194, 194)

//#define APP_LINE_COLOR        [UIColor colorWithRed:218.0/255 green:218.0/255 blue:221.0/255 alpha:1]
//气泡框色
#define APP_POP_COLOR         UIColorFromRGBA(52, 52, 52, 1.0)

//#define APP_BACK_COLOR        KHEXCOLOR(@"#1887C2")
#define APP_GARY_COLOR        RGBCOLOR(239, 239, 244)
#define APP_LINE_COLOR        RGBCOLOR(229,229,229)

///HY
#if G_SCREEN_WIDTH > 400
#define G_CELL_START_X 20
#else
#define G_CELL_START_X 15
#endif
#define G_VIEW_WIDTH (G_SCREEN_WIDTH - 2 * G_CELL_START_X)
//#define G_CELL_HEIGHT_NORMAL 45//普通cell高度
#define G_FONT_TEXT(a) [UIFont systemFontOfSize:a] //[UIFont systemFontOfSize:a] //MicrosoftYaHei msyh AppleGothic
#define FONT(a) [UIFont systemFontOfSize:a]
#define G_BOLD_TEXT(a) [UIFont boldSystemFontOfSize:a]
#define G_IMAGE_NAME(a) [UIImage imageNamed:a]
#define G_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define G_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define G_COLOR_NAV  APP_THEME_COLOR
#define RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define G_GET_SCALE_LENTH(a)  a/750.0f*[UIScreen mainScreen].bounds.size.width

//支付成功
#define G_NOTIFICATION_PAYSUCCESS @"G_NOTIFICATION_PAYSUCCESS"
//分享回调
#define G_NOTIFICATION_SHARECALLBACK @"G_NOTIFICATION_SHARECALLBACK"

/**
 *  判断是否为IOS7以上的系统
 */
#define IOS7_OR_LATER (([UIDevice currentDevice].systemVersion.intValue) >= 7)
/**
 *  IphoneX适配
 */
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/**
 *  tabBar高度
 */
#define TAB_BAR_HEIGHT ((KSCREEN_HEIGHT==812 || KSCREEN_HEIGHT==896) ? (49.f+34.f) : 49.f)

/**
 *  状态栏高度
 */
#define STATUS_BAR_HEIGHT ((KSCREEN_HEIGHT==812 || KSCREEN_HEIGHT==896) ? 44.f : 20.f)
/**
 *  导航栏高度
 */
#define KNAVBAR_HEIGHT ((KSCREEN_HEIGHT==812 || KSCREEN_HEIGHT==896)?88*SCALAE+44:64)
/**
 *  导航栏高度
 */
#define KNAVBAR_BUTTON_Y  (KSCREEN_HEIGHT==812 || KSCREEN_HEIGHT==896)?STATUS_BAR_HEIGHT-3:35/2.0f

/**
 *  加载图片
 */
#define L_GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

/**宽度比例*/
#define L_ScaleWidth(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375.f)*(__VA_ARGS__)

/**高度比例*/
#define L_ScaleHeight(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.height/667.f)*(__VA_ARGS__)

/**字体比例*/
#define L_ScaleFont(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375.f)*(__VA_ARGS__)
/**字体*/
#define L_FONT_TEXT(a) [UIFont fontWithName:@"PingFang-SC-Medium" size:L_ScaleFont(a)]
/** < TableView背景颜色 > */
#define G_TableView_BgColor RGBCOLOR(244,244,244)
/**字体颜色*/
#define L_TextColor RGBCOLOR(97,96,114)
//weak self
#define KWeakSelf __weak __typeof(self)weakSelf = self

#endif /* Hong_h */
