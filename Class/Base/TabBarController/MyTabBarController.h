//
//  MyTabBarController.h
//  ProjectFrameDemo
//
//  Created by scj on 2019/7/27.
//  Copyright © 2019 scj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTabBarController : UITabBarController

/**
 * The tab bar view associated with this controller. (read-only)
 */
@property (nonnull, nonatomic, readonly) MyTabBar *my_tabBar;


- (void)my_setViewController:(NSArray<__kindof UIViewController *> * __nullable)viewControllers;

- (void)showBadgeWithSelectedIndex:(NSUInteger)selectedIndex badge:(NSString *)badgeValue;

- (void)removeBadgeWithSelectedIndex:(NSUInteger)selectedIndex;

- (BOOL)isShowBadge:(NSUInteger)selectedIndex;

@end

@interface UIViewController (MyTabBarControllerItem)

/**
 * The tab bar item that represents the view controller when added to a tab bar controller.
 */
@property(nullable, nonatomic, setter = my_setTabBarItem:) MyTabBarItem *my_tabBarItem;


FOUNDATION_EXPORT NSString * _Nonnull const MyTabBarClickSelectedTabNotification;

@end

NS_ASSUME_NONNULL_END
