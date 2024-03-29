//
//  MyTabBar.h
//  ProjectFrameDemo
//
//  Created by scj on 2019/7/27.
//  Copyright © 2019 scj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyTabBar, MyTabBarItem;

@protocol MyTabBarDelegate <NSObject>

/**
 * Asks the delegate if the specified tab bar item should be selected.
 */
- (BOOL)tabBar:(MyTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index;

/**
 * Tells the delegate that the specified tab bar item is now selected.
 */
- (void)tabBar:(MyTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;

@end

@interface MyTabBar : UIView

/**
 * The tab bar’s delegate object.
 */
@property (nonatomic, weak) id <MyTabBarDelegate> delegate;

/**
 * The items displayed on the tab bar.
 */
@property (nonatomic, copy) NSArray *items;

/**
 * The currently selected item on the tab bar.
 */
@property (nonatomic, weak) MyTabBarItem *selectedItem;

/**
 * backgroundView stays behind tabBar's items. If you want to add additional views,
 * add them as subviews of backgroundView.
 */
@property (nonatomic, strong) UIView *backgroundView;

/*
 * contentEdgeInsets can be used to center the items in the middle of the tabBar.
 */
@property UIEdgeInsets contentEdgeInsets;

/**
 * Sets the height of tab bar.
 */
- (void)setHeight:(CGFloat)height;

/**
 * Returns the minimum height of tab bar's items.
 */
- (CGFloat)minimumContentHeight;

/*
 * Enable or disable tabBar translucency. Default is NO.
 */
@property (nonatomic, getter=isTranslucent) BOOL translucent;

@end

NS_ASSUME_NONNULL_END
