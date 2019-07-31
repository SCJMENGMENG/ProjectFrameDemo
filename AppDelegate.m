//
//  AppDelegate.m
//  ProjectFrameDemo
//
//  Created by scj on 2019/7/27.
//  Copyright © 2019 scj. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBar.h"
#import "MyTabBarItem.h"
#import "MyHomeController.h"
#import "MyMineController.h"
#import "LoginController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //导航title去除加粗
    //    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
    //                                 NSForegroundColorAttributeName:[UIColor yellowColor]};
    //    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    [self setupLogin];
    
    [self setupRootViewControllers];
    [self.window setRootViewController:self.rootNavigationController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupLogin {
    [self.window setRootViewController:[[LoginController alloc] init]];
}

- (void)setupRootViewControllers {
    MyHomeController *homeViewController = [MyHomeController new];
    RTContainerNavigationController *homeViewControllerNav =
    [[RTContainerNavigationController alloc] initWithRootViewController:homeViewController];
    
    MyMineController *mineViewController = [MyMineController new];
    RTContainerNavigationController *mineViewControllerNav =
    [[RTContainerNavigationController alloc] initWithRootViewController:mineViewController];
    
    NSArray *viewControllers = @[homeViewControllerNav, mineViewControllerNav];
    
    MyTabBarController *tabBarController = [[MyTabBarController alloc] init];
    [tabBarController my_setViewController:viewControllers];
    tabBarController.delegate = self;
    self.tabbarController = tabBarController;
    
    self.rootNavigationController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:self.tabbarController];
    [self.rootNavigationController setNavigationBarHidden:YES];
    [self customizeTabBarForController:tabBarController];
    
#pragma mark - 登录跳Tabbar
//        CATransition *transtition = [CATransition animation];
//        transtition.duration = 0.5;
//        transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        [UIApplication sharedApplication].keyWindow.rootViewController = self.rootNavigationController;
//        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];
//    self = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [[UIApplication sharedApplication].keyWindow setRootViewController:self.rootNavigationController];
//    self.window = [UIApplication sharedApplication].keyWindow;
//    [self.window setRootViewController:self.rootNavigationController];
}

- (void)selectIndexTabbar {
    NSLog(@"---%@",self);
    self.window = [UIApplication sharedApplication].keyWindow;
    [(MyTabBarController *)self.window.rootViewController.tabBarController setSelectedIndex:1];
}

- (void)customizeTabBarForController:(MyTabBarController *)tabBarController {
    MyTabBar *tabBar = [tabBarController my_tabBar];
    [[tabBar items] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MyTabBarItem *item   = (MyTabBarItem *)obj;
        NSString *title;
        UIImage *iconImage;
        UIImage *selectedIconImage;
        switch (idx) {
            case 0:
            {
                title = NSLocalizedString(@"首页", @"");
                iconImage = [UIImage imageNamed:@"shouye"];
                selectedIconImage = [UIImage imageNamed:@"shouye-2"];
            }
                break;
            case 1:
            {
                title = NSLocalizedString(@"我的", @"");
                iconImage = [UIImage imageNamed:@"wode"];
                selectedIconImage = [UIImage imageNamed:@"wode-2"];
            }
                break;
                
            default:
                break;
        }
        item.unselectedTitleAttributes  =
        @{NSFontAttributeName: [UIFont systemFontOfSize:10],
          NSForegroundColorAttributeName: [UIColor lightGrayColor]};
        item.selectedTitleAttributes  =
        @{NSFontAttributeName: [UIFont systemFontOfSize:10],
          NSForegroundColorAttributeName: [UIColor blueColor]};
        item.titlePositionAdjustment = UIOffsetMake(0, 2);
        
        [item setTitle:title];
        
        [item setFinishedSelectedImage:selectedIconImage withFinishedUnselectedImage:iconImage];
    }];
}

@end
