//
//  MyTabBarController.m
//  ProjectFrameDemo
//
//  Created by scj on 2019/7/27.
//  Copyright © 2019 scj. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyTabBarItem.h"
#import <objc/runtime.h>

NSString * const MyTabBarClickSelectedTabNotification = @"tabbar.click.selectedtab.notification";

@interface MyTabBarController () <MyTabBarDelegate>

@property (nonatomic, readwrite) MyTabBar *my_tabBar;

@end

@implementation MyTabBarController
@synthesize my_tabBar = _my_tabBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar addSubview:[self my_tabBar]];
    
    [self.tabBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.my_tabBar setFrame:self.tabBar.bounds];
}

- (BOOL)prefersStatusBarHidden
{
    return self.selectedViewController.prefersStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return self.selectedViewController.preferredStatusBarUpdateAnimation;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.selectedViewController.preferredStatusBarStyle;
}

- (void)dealloc
{
    [self.tabBar removeObserver:self forKeyPath:@"frame"];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(__unused id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        [self.my_tabBar setFrame:self.tabBar.bounds];
    }
}

- (MyTabBar *)my_tabBar
{
    if (!_my_tabBar) {
        _my_tabBar = [[MyTabBar alloc] init];
        [_my_tabBar setBackgroundColor:[UIColor clearColor]];
        [_my_tabBar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                         UIViewAutoresizingFlexibleTopMargin|
                                         UIViewAutoresizingFlexibleLeftMargin|
                                         UIViewAutoresizingFlexibleRightMargin|
                                         UIViewAutoresizingFlexibleBottomMargin)];
        [_my_tabBar setDelegate:self];
    }
    return _my_tabBar;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [[self my_tabBar] setSelectedItem:[[self my_tabBar] items][selectedIndex]];
}

- (void)my_setViewController:(NSArray<__kindof UIViewController *> * __nullable)viewControllers
{
    [self setViewControllers:viewControllers];
    
    NSUInteger count = [viewControllers count];
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
        MyTabBarItem *tabBarItem = [[MyTabBarItem alloc] init];
        tabBarItem.badgeTextColor = [UIColor redColor];
        [tabBarItems addObject:tabBarItem];
    }
    [[self my_tabBar] setItems:tabBarItems];
    
    [[self.tabBar items] enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setEnabled:NO];
    }];
    
    [self setSelectedIndex:0];
}

- (NSInteger)indexForViewController:(UIViewController *)viewController {
    UIViewController *searchedController = viewController;
    if ([searchedController navigationController]) {
        searchedController = [searchedController navigationController];
    }
    return [[self viewControllers] indexOfObject:searchedController];
}

- (void)showBadgeWithSelectedIndex:(NSUInteger)selectedIndex badge:(NSString *)badgeValue
{
    if (selectedIndex < [[[self my_tabBar] items] count]) {
        MyTabBarItem *barItem = [[self my_tabBar] items][selectedIndex];
        if (badgeValue) {
            barItem.badgeValue = badgeValue;
        }else {
            barItem.onlyShowBadgeCircle = YES;
        }
    }
}

- (void)removeBadgeWithSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex < [[[self my_tabBar] items] count]) {
        MyTabBarItem *barItem = [[self my_tabBar] items][selectedIndex];
        barItem.badgeValue = nil;
        barItem.onlyShowBadgeCircle = NO;
    }
}

- (BOOL)isShowBadge:(NSUInteger)selectedIndex
{
    if (selectedIndex < [[[self my_tabBar] items] count]) {
        MyTabBarItem *barItem = [[self my_tabBar] items][selectedIndex];
        if ([barItem.badgeValue length] ||
            barItem.onlyShowBadgeCircle) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - RDVTabBarDelegate

- (BOOL)tabBar:(MyTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index
{
    //如果想点击tabBar进行拦截 在此处 if(){return;}
    
    if ([[self delegate] respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        if (![[self delegate] tabBarController:self shouldSelectViewController:[self viewControllers][index]]) {
            return NO;
        }
    }
    
    if ([self selectedViewController] == [self viewControllers][index]) {
        if ([[self selectedViewController] isKindOfClass:[UINavigationController class]]) {
            UINavigationController *selectedController = (UINavigationController *)[self selectedViewController];
            
            if ([selectedController topViewController] != [selectedController viewControllers][0]) {
                [selectedController popToRootViewControllerAnimated:YES];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:MyTabBarClickSelectedTabNotification
                                                            object:[NSString stringWithFormat:@"%zd", index]];
        
        return NO;
    }
    
    return YES;
}

- (void)tabBar:(MyTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index
{
    if (index < 0 || index >= [[self viewControllers] count]) {
        return;
    }
    
    [self setSelectedIndex:index];
    
    if ([[self delegate] respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [[self delegate] tabBarController:self didSelectViewController:[self viewControllers][index]];
    }
    
    // UIViewController not set title, should set self.navigationItem.title
    //    [self performSelector:@selector(clearTabBar) withObject:self afterDelay:0.0];
}

- (void)clearTabBar
{
    [[self.tabBar items] enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:nil];
        [obj setEnabled:NO];
    }];
}

@end

#pragma mark - UIViewController+MyTabBarControllerItem

@implementation UIViewController (MyTabBarControllerItem)

- (MyTabBarItem *)my_tabBarItem {
    MyTabBarController *my_tabBarController = (MyTabBarController *)self.tabBarController;
    NSInteger index = [my_tabBarController indexForViewController:self];
    return [[[my_tabBarController my_tabBar] items] objectAtIndex:index];
}

- (void)my_setTabBarItem:(MyTabBarItem *)tabBarItem {
    if (!self.tabBarController) {
        return;
    }
    
    MyTabBarController *my_tabBarController = (MyTabBarController *)self.tabBarController;
    MyTabBar *tabBar = [my_tabBarController my_tabBar];
    NSInteger index = [my_tabBarController indexForViewController:self];
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithArray:[tabBar items]];
    [tabBarItems replaceObjectAtIndex:index withObject:tabBarItem];
    [tabBar setItems:tabBarItems];
}

@end
