//
//  BaseViewController.h
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HY_UPLOADSUCCESS_BLOCK)(NSString *fileId);

@interface BaseViewController : UIViewController

//导航栏控件
@property (nonatomic , strong)UIButton *navLeftButton; //导航左按钮（默认返回图标@"nav_back"）
@property (nonatomic , strong)UIButton *navRightButton; //导航右按钮（默认无内容）
@property (nonatomic , copy)NSString *navTitle; //标题（默认无内容）
@property (nonatomic , strong)UILabel *navLabelTitle; //导航栏标题

@property (nonatomic, assign)  BOOL bNotShowMsg;
@property (nonatomic, assign)  BOOL bNotResult;//数据全部返回

/**
 *  数据请求
 */

typedef void(^HY_V2_FAILED_BLOCK)(NSDictionary *dicData);
typedef void(^HY_V2_SS_BLOCK)(NSDictionary *dicData);

+ (id)l_labelWithText:(NSString *)text
             textFont:(UIFont *)font
            textColor:(UIColor *)color
        textAlignment:(NSTextAlignment)textAlignment;

+ (id)l_buttonlWithTitle:(NSString *)text
               titleFont:(UIFont *)font
              titleColor:(UIColor *)color
         backgroundColor:(UIColor *)backgroundColor;

/**
 * 请求接口
 */
- (void)requestDataWithUrl:(NSString *)strUrl
                 isNeedSVP:(BOOL)isNeed
                andPostDic:(NSDictionary *)dicPost
              successBlock:(HY_V2_SS_BLOCK)successBlocker
               failedBlock:(HY_V2_FAILED_BLOCK)failedBlock;

//修改头像接口
- (void)requestDataUploadImageOne:(NSData *)dataImage
                       andPicType:(NSString *)strType
                 withSuccessBlock:(HY_UPLOADSUCCESS_BLOCK)success;
/**
 弹窗提醒
 
 @param msg 标题
 */
- (void)showMessage:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
