//
//  NextViewController.m
//  AllFunctionText
//
//  Created by sakura on 2020/3/2.
//  Copyright © 2020 sakura. All rights reserved.
//

#import "NextViewController.h"
#import "JXScrollView.h"

@interface NextViewController ()<JXScrollViewDelegate,JXScrollViewDataSource>

@property (nonatomic , strong)UIView *bgView;
@property (nonatomic , strong)JXScrollView *scrollView;

@property (nonatomic , strong)NSArray *imageArr;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二页";
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgView];
    self.imageArr = [NSArray arrayWithObjects:@"http://pic1.win4000.com/wallpaper/2018-01-22/5a657f660f615.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/a2cc7cd98d1001e9b230cf71ba0e7bec54e79744.jpg",@"http://img2.91huo.cn/game/2012/cj2012/lyl/4.jpg", nil];
    [self setUpView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --视图
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, KNAVBAR_HEIGHT, KSCREEN_WIDTH, (KSCREEN_HEIGHT-KNAVBAR_HEIGHT)/2)];
        _bgView.backgroundColor = [UIColor redColor];
    }
    return _bgView;
}
//初始化视图
-(void)setUpView{
    JXScrollViewConfig *config = [JXScrollViewConfig defalutConfig];
    self.scrollView = [[JXScrollView alloc] initWithFrame:CGRectMake(0, 0, _bgView.bounds.size.width, _bgView.bounds.size.height) config:config dataSource:self delegate:self];
    [self.bgView addSubview:self.scrollView];
    [self.scrollView start];
}
#pragma mark - 加载网络图片
-(NSInteger)numberOfItemInScrollView:(JXScrollView *)scrollView{
    return self.imageArr.count;
}

-(NSURL*)scrollView:(JXScrollView *)scrollView urlForItemAtIndex:(NSInteger)index{
    return [NSURL URLWithString:self.imageArr[index]];
}
-(UIImage*)scrollView:(JXScrollView *)scrollView placeholderImageForIndex:(NSInteger)index{
    return [UIImage imageNamed:@"loading"];
}

-(void)scrollView:(JXScrollView *)scrollView didClickAtIndex:(NSInteger)index{
    NSLog(@"Click:%zd",index+1);
}


@end
