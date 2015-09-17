//
//  QSBaseViewController.m
//  mPos
//
//  Created by thuydd on 1/29/15.
//  Copyright (c) 2015 SmartOSC. All rights reserved.
//

#import "TDBaseViewController.h"

@interface TDBaseViewController()
{
    BOOL isFirstWillAppear, isFirstDidAppear; // Appear
    BOOL isFirstWillDisappear, isFirstDidDisappear; // Disappear
}

@end

@implementation TDBaseViewController

#pragma mark - View lifecyl


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self performSelector:@selector(initView)];
    
    [[TDThemeManagement td_sharedInstance] td_addDelegate:(id)self];
    
    isFirstWillAppear = YES;
    isFirstDidAppear = YES;
    isFirstWillDisappear = YES;
    isFirstDidDisappear = YES;
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ( isFirstWillAppear )
    {
        isFirstWillAppear = NO;
        
        [self firstWillAppear];
    }
}

// Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ( isFirstDidAppear )
    {
        isFirstDidAppear = NO;
        
        [self firstDidAppear];
    }
}

// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (isFirstWillDisappear)
    {
        isFirstWillDisappear = NO;
        [self firstWillDisappear];
    }
}

// Called after the view was dismissed, covered or otherwise hidden. Default does nothing
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ( isFirstDidDisappear )
    {
        isFirstDidDisappear = NO;
        [self firstDidDisappear];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    TDLOG(@"%@ dealloc", NSStringFromClass([self class]));
}

#pragma mark - initView
/**
 *  initView
 */
- (void)initView
{
    
}

#pragma mark - Focus Field
/**
 *  focusField
 */
- (void)focusField
{
    
}

#pragma mark - Appear More
/**
 *  firstWillAppear
 */
- (void)firstWillAppear
{
    TDLOG(@"");
    [self td_useThemeManage];
}

/**
 *  firstDidAppear
 */
- (void)firstDidAppear
{
    TDLOG(@"");
    
    [self focusField];
}

/**
 *  firstWillDisappear
 */
- (void)firstWillDisappear
{
    TDLOG(@"");
}

/**
 *  firstDidDisappear
 */
- (void)firstDidDisappear
{
    TDLOG(@"");
}

#pragma mark - Orientation
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ( toInterfaceOrientation == UIDeviceOrientationPortrait )
    {
        [self layoutForPortrait];
    }
    else if ( toInterfaceOrientation == UIDeviceOrientationLandscapeLeft || toInterfaceOrientation == UIDeviceOrientationLandscapeRight )
    {
        [self layoutForLandscape];
    }
}

/**
 *  layoutForPortrait
 */
- (void)layoutForPortrait
{
    // Begin code here
}

/**
 *  layoutForLandscape
 */
- (void)layoutForLandscape
{
    // Begin code here
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Category NavigationController
@implementation TDBaseViewController (NavigationController)

/**
 *  td_getViewControllerWithClass
 *
 *  @param aClass Class
 *
 *  @return UIViewController
 */
- (id)td_getViewControllerWithClass:(Class)aClass
{
    @try
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(aClass)];
        return vc;
    }
    @catch (NSException *exception)
    {
        return [[UIViewController alloc] init];
        TDLOG(@"cant found viewcontroller from storyboard file")
    }
}

/**
 *  td_pushViewControllerWithClass
 *
 *  Default animation = yes
 *  @param aClass Class
 */
- (void)td_pushViewControllerWithClass:(Class )aClass
{
    [self td_pushViewControllerWithClass:aClass animated:YES];
}

/**
 *  td_pushViewControllerWithClass
 *
 *  @param aClass      Class
 *  @param isAnimation BOOL
 */
- (void)td_pushViewControllerWithClass:(Class )aClass animated:(BOOL )animated
{
    @try
    {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(aClass)];
        
        [self td_pushViewControllerWithObject:vc animated:animated];
    }
    @catch (NSException *exception)
    {
        TDLOG(@"cant found viewcontroller from storyboard file")
    }
}


/**
 *  td_pushViewControllerWithObject
 *
 *  default animated = yes;
 *  @param aObject id
 */
- (void)td_pushViewControllerWithObject:(id )aObject
{
    @try
    {
        [self.navigationController pushViewController:aObject animated:YES];
    }
    @catch (NSException *exception)
    {
        TDLOG(@"object = nil")
    }
}

/**
 *  td_pushViewControllerWithObject
 *
 *  @param aObject     id
 *  @param isAnimation BOOL
 */
- (void)td_pushViewControllerWithObject:(id )aObject animated:(BOOL )animated
{
    @try
    {
        [self.navigationController pushViewController:aObject animated:animated];
    }
    @catch (NSException *exception)
    {
        TDLOG(@"object = nil")
    }
}

/**
 *  td_popViewControllerWithObject
 *
 *  @param aObject id
 */
- (void)td_popViewControllerWithObject:(id)aObject
{
    @try
    {
        [self.navigationController popToViewController:aObject animated:YES];
    }
    @catch (NSException *exception)
    {
        TDLOG(@"object = nil")
    }
}

/**
 *  td_popViewController
 */
- (void)td_popViewController
{
    [self td_popViewControllerWithAnimation:YES];
}

/**
 *  td_popViewControllerWithAnimation
 *
 *  @param animated BOOL
 */
- (void)td_popViewControllerWithAnimation:(BOOL )animated
{
    [self.navigationController popViewControllerAnimated:animated];
}

/**
 *  td_popToRootViewControllerWithAnimation
 */
- (void)td_popToRootViewController
{
    [self td_popToRootViewControllerWithAnimation:YES];
}

/**
 *  td_popToRootViewControllerWithAnimation
 *
 *  @param animated BOOL
 */
- (void)td_popToRootViewControllerWithAnimation:(BOOL )animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
}

/**
 *  td_hideBackbutton
 */
- (void)td_hideBackbutton
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
}

- (void)td_hideNavigationBar:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:animated];
}

- (void)td_showNavigationBar:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:animated];
}

@end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Category Util
@implementation TDBaseViewController (Util)

- (void)td_delay:(CGFloat)secs completed:(void (^) ())completed
{
    double delayInSeconds = secs;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        completed();
    });
}

- (UIView *)td_getViewFromXib:(NSString *)nameXib index:(NSInteger )index
{
    return [[[NSBundle mainBundle] loadNibNamed:nameXib owner:self options:nil] objectAtIndex:index];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Category threads
@implementation TDBaseViewController (threads)

- (void)td_main_thread:(void(^)())block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

- (void)td_background_thread:(void(^)())block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block();
    });
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - TDTheme
@implementation TDBaseViewController (TDTheme)

- (void)td_useThemeManage
{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([self respondsToSelector:@selector(td_configureTheme)])
    {
        [self performSelector:@selector(td_configureTheme)];
    }
    else
    {
        TDLOG(@"THIS CLASS(%@) DONT IMPLEMENT MULTI-THEME ON METHOD: td_configureTheme", NSStringFromClass([self class]));
    }
#pragma clang diagnostic pop
    
}


@end
