//
//  AppDelegate.h
//  ProjectFrameDemo
//
//  Created by scj on 2019/7/27.
//  Copyright © 2019 scj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MyTabBarController *tabbarController;
@property (nonatomic, strong) RTRootNavigationController *rootNavigationController;

- (void)setupRootViewControllers;

- (void)selectIndexTabbar;

@end

