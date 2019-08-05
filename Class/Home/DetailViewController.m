//
//  DetailViewController.m
//  ProjectFrameDemo
//
//  Created by scj on 2019/7/27.
//  Copyright © 2019 scj. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRandomColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 300, 50);
    [btn setBackgroundColor:kRandomColor];
    [btn setTitle:@"返回并切换到我的模块" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self setupRightIcon];
}

- (void)setupRightIcon {
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 44)];
    UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 32, 32)];
    [iconBtn setImage:[UIImage imageNamed:@"common_fenxiang"] forState:UIControlStateNormal];
    iconBtn.layer.cornerRadius = 16;
    [iconView addSubview:iconBtn];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iconView];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    CGRect frameInNaviView = [self.navigationController.view convertRect:iconView.frame fromView:iconView.superview];
    CGFloat delta = kScreenWidth - 52 - frameInNaviView.origin.x;
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = -delta;
    self.navigationItem.rightBarButtonItems = @[fixedItem,rightBarButtonItem];
    
    [iconBtn clickAction:^(UIButton *sender) {
        NSLog(@"btn点击");
    }];
}

- (void)aaa {
    __weak __typeof(&*self)weakSelf = self;
    [self.rt_navigationController popToRootViewControllerAnimated:NO complete:^(BOOL finished) {
        [UIViewController.rootTabBarController setSelectedIndex:1];
    }];
}

@end
