//
//  JXScrollView.h
//  JXScrollView
//
//  Created by JackXu on 16/4/17.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXScrollViewConfig.h"

@class JXScrollView;

@protocol JXScrollViewDataSource <NSObject>

@required

-(NSInteger)numberOfItemInScrollView:(JXScrollView *)scrollView;

@optional

-(NSURL*)scrollView:(JXScrollView *)scrollView urlForItemAtIndex:(NSInteger)index;
-(UIImage*)scrollView:(JXScrollView *)scrollView imageForItemAtIndex:(NSInteger)index;
-(UIImage*)scrollView:(JXScrollView *)scrollView placeholderImageForIndex:(NSInteger)index;

@end

@protocol JXScrollViewDelegate <NSObject>

@optional

-(void)scrollView:(JXScrollView *)scrollView didClickAtIndex:(NSInteger)index;

@end

@interface JXScrollView : UIView

-(instancetype)initWithFrame:(CGRect)frame config:(JXScrollViewConfig*)config dataSource:(id<JXScrollViewDataSource>)dataSource delegate:(id<JXScrollViewDelegate>)delegate;

@property (nonatomic, weak) id<JXScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<JXScrollViewDelegate> delegate;
@property (nonatomic,strong) JXScrollViewConfig *config;

-(void)start;

@end
