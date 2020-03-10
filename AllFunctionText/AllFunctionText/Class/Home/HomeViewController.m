//
//  HomeViewController.m
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#import "HomeViewController.h"
#import "ThirldViewController.h"
#import "NextViewController.h"
#import "FirstViewController.h"


@interface HomeViewController ()

@property (nonatomic , strong)UIView *bgView;
@property (nonatomic , strong)UIButton *firstPageButton;
@property (nonatomic , strong)UIButton *nextPageButton;
@property (nonatomic , strong)UIButton *thirdPageButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"首页";
    self.hidesBottomBarWhenPushed=YES;
    //隐藏底部导航栏
    self.tabBarController.tabBar.hidden = YES;
    self.navLeftButton.hidden = YES;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.firstPageButton];
    [self.bgView addSubview:self.nextPageButton];
    [self.bgView addSubview:self.thirdPageButton];
}
#pragma mark - buttonmessage
- (void)pageClick:(UIButton *)sender{
    if (sender.tag == 0) {
        FirstViewController *vc = [[FirstViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }
    else if (sender.tag == 1){
        NextViewController *vc = [[NextViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }
    else{
        ThirldViewController *vc = [[ThirldViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
    }
}
#pragma mark - lazyload
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, KNAVBAR_HEIGHT, KSCREEN_WIDTH, KSCREEN_HEIGHT-KNAVBAR_HEIGHT)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIButton *)firstPageButton{
    if (!_firstPageButton) {
        _firstPageButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 30, KSCREEN_WIDTH-100, 40)];
        _firstPageButton.backgroundColor = [UIColor redColor];
        [_firstPageButton setTitle:@"第一页" forState:UIControlStateNormal];
        _firstPageButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _firstPageButton.tag = 0;
        [_firstPageButton addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _firstPageButton;
}

- (UIButton *)nextPageButton{
    if (!_nextPageButton) {
        _nextPageButton = [[UIButton alloc]initWithFrame:CGRectMake(50, _firstPageButton.frameBottom+40, KSCREEN_WIDTH-100, 40)];
        _nextPageButton.backgroundColor = [UIColor greenColor];
        [_nextPageButton setTitle:@"第二页" forState:UIControlStateNormal];
        _nextPageButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _nextPageButton.tag = 1;
        [_nextPageButton addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextPageButton;
}
- (UIButton *)thirdPageButton{
    if (!_thirdPageButton) {
        _thirdPageButton = [[UIButton alloc]initWithFrame:CGRectMake(50, _nextPageButton.frameBottom+40, KSCREEN_WIDTH-100, 40)];
        _thirdPageButton.backgroundColor = [UIColor blueColor];
        [_thirdPageButton setTitle:@"第三页" forState:UIControlStateNormal];
        _thirdPageButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _thirdPageButton.tag = 2;
        [_thirdPageButton addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _thirdPageButton;
}

@end
