//
//  JXScrollViewConfig.m
//  JXScrollView
//
//  Created by 许伟杰 on 2019/5/15.
//  Copyright © 2019 BFMobile. All rights reserved.
//

#import "JXScrollViewConfig.h"

@implementation JXScrollViewConfig

+ (instancetype)defalutConfig{
    JXScrollViewConfig *config = [[JXScrollViewConfig alloc] init];
    config.jx_pageControlTintColor = [UIColor grayColor];
    config.jx_pageIndicatorSelectedTintColor = [UIColor redColor];
    config.jx_pageControlPosition = JXScrollViewPageControlPositionCenter;
    config.jx_timeInterval = 3.0;
    config.jx_hideIndicator = NO;
    return config;
}

-(JXScrollViewConfig* (^)(UIColor*))pageControlTintColor{
    return ^(UIColor *color){
        self.jx_pageControlTintColor = color;
        return self;
    };
}

-(JXScrollViewConfig* (^)(UIColor*))pageIndicatorSelectedTintColor{
    return ^(UIColor *color){
        self.jx_pageIndicatorSelectedTintColor = color;
        return self;
    };
}

-(JXScrollViewConfig* (^)(JXScrollViewPageControlPosition))pageControlPosition{
    return ^(JXScrollViewPageControlPosition pageControlPosition){
        self.jx_pageControlPosition = pageControlPosition;
        return self;
    };
}

-(JXScrollViewConfig* (^)(BOOL))hideIndicator{
    return ^(BOOL hide){
        self.jx_hideIndicator = hide;
        return self;
    };
}

-(JXScrollViewConfig* (^)(double sencond))timeInterval{
    return ^(double second){
        self.jx_timeInterval = second;
        return self;
    };
}

@end
