//
//  JXScrollViewConfig.h
//  JXScrollView
//
//  Created by 许伟杰 on 2019/5/15.
//  Copyright © 2019 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JXScrollViewPageControlPosition){
    JXScrollViewPageControlPositionLeft,
    JXScrollViewPageControlPositionCenter,
    JXScrollViewPageControlPositionRight
};

@interface JXScrollViewConfig : NSObject

+(instancetype)defalutConfig;

@property (nonatomic, assign) BOOL jx_hideIndicator;
@property (nonatomic, assign) double jx_timeInterval;
@property (nonatomic, strong) UIColor *jx_pageControlTintColor;
@property (nonatomic, strong) UIColor *jx_pageIndicatorSelectedTintColor;
@property (nonatomic, assign) JXScrollViewPageControlPosition jx_pageControlPosition;

/**
 pageControl的颜色
 */
@property (nonatomic, copy, readonly) JXScrollViewConfig *(^pageControlTintColor)(UIColor *color);

/**
 pageControl选中颜色
 */
@property (nonatomic, copy, readonly) JXScrollViewConfig *(^pageIndicatorSelectedTintColor)(UIColor *color);

/**
 pageControl的位置
 */
@property (nonatomic, copy, readonly) JXScrollViewConfig* (^pageControlPosition)(JXScrollViewPageControlPosition position);

/**
 设置隐藏加载菊花，默认显示
 */
@property (nonatomic, copy, readonly) JXScrollViewConfig* (^hideIndicator)(BOOL hide);

/**
 设置播放时间间隔,默认3s
 */
@property (nonatomic, copy, readonly) JXScrollViewConfig* (^timeInterval)(double sencond);

@end
