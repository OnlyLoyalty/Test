//
//  FirstViewController.m
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#import "FirstViewController.h"
#import "YingSiViewController.h"

@interface FirstViewController ()

@property (nonatomic , strong)UIButton *yingSiButton;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第一页";
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.yingSiButton];
}
#pragma mark - buttonmessage
- (void)yingClick{
    YingSiViewController *vc = [[YingSiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - lazyload
- (UIButton *)yingSiButton{
    if (!_yingSiButton) {
        _yingSiButton = [[UIButton alloc]initWithFrame:CGRectMake(30, KNAVBAR_HEIGHT+50, KSCREEN_WIDTH-60, 40)];
        _yingSiButton.backgroundColor = [UIColor whiteColor];
        _yingSiButton.layer.cornerRadius = 20.0;
        [_yingSiButton setTitle:@"隐私政策" forState:UIControlStateNormal];
        _yingSiButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_yingSiButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_yingSiButton addTarget:self action:@selector(yingClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yingSiButton;
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
