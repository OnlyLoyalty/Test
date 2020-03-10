//
//  ThirldViewController.m
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "ThirldViewController.h"

@interface ThirldViewController ()

@property (nonatomic , strong)UIWebView *webView;
@property (nonatomic , copy)NSString *str;
@property (nonatomic , copy)NSString *urlStr;

@end

@implementation ThirldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第三页";
    // Do any additional setup after loading the view.
    self.str = @"47.96.92.123:8080/kuailv/gvrp.html";
       
    NSURL *url = [NSURL URLWithString:self.str];
       
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
       
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
//    [self setWebViewHeight];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setWebViewHeight {
    // 获取webView的高度
    [self.webView loadHTMLString:self.str baseURL:nil];
    //获取网页现有的frame
    CGRect webViewRect = self.webView.frame;
    //修改webView的高度
    webViewRect.size.height = [self.webView.scrollView contentSize].height;
    self.webView.frame = webViewRect;
    [self.view addSubview:self.webView];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    }
    return _webView;
}

@end
