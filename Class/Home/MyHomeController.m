//
//  MyHomeController.m
//  ProjectFrameDemo
//
//  Created by scj on 2019/7/27.
//  Copyright © 2019 scj. All rights reserved.
//

#import "MyHomeController.h"
#import "DetailViewController.h"

#import "LoginController.h"

@interface MyHomeController ()

@end

static BOOL isLogin = NO;

@implementation MyHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = kRandomColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setBackgroundColor:kRandomColor];
    [btn setTitle:@"跳转按钮" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)aaa {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.rt_navigationController pushViewController:detailVC animated:YES complete:nil];
}

@end
