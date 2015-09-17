//
//  QSBaseViewController.h
//  mPos
//
//  Created by thuydd on 1/29/15.
//  Copyright (c) 2015 SmartOSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDEngineLog.h"
#import "TDThemeManagement.h"

@interface TDBaseViewController : UIViewController

#pragma mark - Focus Field
/**
 *  focusField
 */
- (void)focusField;

#pragma mark - Appear More
/**
 *  firstWillAppear
 */
- (void)firstWillAppear;

/**
 *  firstDidAppear
 */
- (void)firstDidAppear;

/**
 *  firstWillDisappear
 */
- (void)firstWillDisappear;

/**
 *  firstDidDisappear
 */
- (void)firstDidDisappear;


#pragma mark - Orientation

/**
 *  layoutForPortrait
 */
- (void)layoutForPortrait;

/**
 *  layoutForLandscape
 */
- (void)layoutForLandscape;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Category NavigationController
@interface TDBaseViewController (NavigationController)

/**
 *  td_getViewControllerWithClass
 *
 *  @param aClass Class
 *
 *  @return UIViewController
 */
- (id)td_getViewControllerWithClass:(Class)aClass;

/**
 *  td_pushViewControllerWithClass
 *
 *  Default animation = yes
 *  @param aClass Class
 */
- (void)td_pushViewControllerWithClass:(Class )aClass;

/**
 *  td_pushViewControllerWithClass
 *
 *  @param aClass      Class
 *  @param isAnimation BOOL
 */
- (void)td_pushViewControllerWithClass:(Class )aClass animated:(BOOL )animated;

/**
 *  td_pushViewControllerWithObject
 *
 *  default animated = yes;
 *  @param aObject id
 */
- (void)td_pushViewControllerWithObject:(id )aObject;

/**
 *  td_pushViewControllerWithObject
 *
 *  @param aObject     id
 *  @param isAnimation BOOL
 */
- (void)td_pushViewControllerWithObject:(id )aObject animated:(BOOL )animated;

/**
 *  td_popViewControllerWithObject
 *
 *  @param aObject id
 */
- (void)td_popViewControllerWithObject:(id)aObject;

/**
 *  td_popViewController
 */
- (void)td_popViewController;

/**
 *  td_popViewControllerWithAnimation
 *
 *  @param animated BOOL
 */
- (void)td_popViewControllerWithAnimation:(BOOL )animated;

/**
 *  td_popToRootViewControllerWithAnimation
 */
- (void)td_popToRootViewController;

/**
 *  td_popToRootViewControllerWithAnimation
 *
 *  @param animated BOOL
 */
- (void)td_popToRootViewControllerWithAnimation:(BOOL )animated;


/**
 *  td_hideBackbutton
 */
- (void)td_hideBackbutton;

- (void)td_hideNavigationBar:(BOOL)animated;
- (void)td_showNavigationBar:(BOOL)animated;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Category Util
@interface TDBaseViewController (Util)

- (void)td_delay:(CGFloat)secs completed:(void (^) ())completed;
- (UIView *)td_getViewFromXib:(NSString *)nameXib index:(NSInteger )index;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Category threads
@interface TDBaseViewController (threads)

- (void)td_main_thread:(void(^)())block;
- (void)td_background_thread:(void(^)())block;

@end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - TDTheme
@interface TDBaseViewController (TDTheme)

- (void)td_useThemeManage;

@end
