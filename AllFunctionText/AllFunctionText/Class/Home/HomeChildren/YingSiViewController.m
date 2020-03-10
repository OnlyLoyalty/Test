//
//  YingSiViewController.m
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#import "YingSiViewController.h"

@interface YingSiViewController ()

@end

@implementation YingSiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    if (@available(iOS 10.0, *)) {
//        [[UIApplication sharedApplication]openURL:@"www.baidu.com" options:@{} completionHandler:^(BOOL success) {
//
//        }];
//    } else {
//        // Fallback on earlier versions
//    }
    UIWebView *a = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [a loadRequest:request];
    [self.view addSubview:a];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
