//
//  BaseTabBarViewController.m
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "HomeViewController.h"
#import "BaseNavigationViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    //底部导航栏
    [super viewDidLoad];
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BaseNavigationViewController  *navC1 = [[BaseNavigationViewController alloc]initWithRootViewController:homeVC];
    navC1.tabBarItem.title = @"首页";
    navC1.tabBarItem.image = [[UIImage imageNamed:@"home-after"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navC1.tabBarItem.selectedImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.viewControllers = [NSArray arrayWithObjects:navC1, nil];
    
    //设置选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:KHEXCOLOR(@"#B18A6A"),
                                                       UITextAttributeTextColor,
                                                       
                                                       nil]
     
                                             forState:UIControlStateSelected];
    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    BaseNavigationController  *navC1 = [[BaseNavigationController alloc]initWithRootViewController:homeVC];
//    navC1.tabBarItem.title = @"首页";
//    navC1.tabBarItem.image = [[UIImage imageNamed:@"home-after"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    navC1.tabBarItem.selectedImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    MessageViewController *toolVC = [[MessageViewController alloc] init];
//    BaseNavigationController *navC2 = [[BaseNavigationController alloc]initWithRootViewController:toolVC];
//    navC2.tabBarItem.title = @"消息";
//    navC2.tabBarItem.image = [[UIImage imageNamed:@"icon_mes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    navC2.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_selected_mes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    MineViewController *shopingVC = [[MineViewController alloc] init];
//    BaseNavigationController *navC3 = [[BaseNavigationController alloc]initWithRootViewController:shopingVC];
//    navC3.tabBarItem.title = @"我的";
//    navC3.tabBarItem.image = [[UIImage imageNamed:@"icon_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    navC3.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_selected_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    self.viewControllers = [NSArray arrayWithObjects:navC1, navC2, navC3, nil];
//
//    //设置选中字体颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:KHEXCOLOR(@"#B18A6A"),
//                                                       UITextAttributeTextColor,
//
//                                                       nil]
//
//                                             forState:UIControlStateSelected];
//    self.tabBar.translucent = NO;
}

@end
