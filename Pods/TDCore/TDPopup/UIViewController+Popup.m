//
//  UIViewController+Popup.m
//  All
//
//  Created by Dao Duy Thuy on 7/5/14.
//  Copyright (c) 2014 ThuyDao. All rights reserved.
//

#import "UIViewController+Popup.h"
#import <objc/runtime.h>

static const void *K_POPUP_VIEW = &K_POPUP_VIEW;
static const void *K_IS_SHOW_POPUP = &K_IS_SHOW_POPUP;
static const void *K_TRANSPERENT_VIEW   = &K_TRANSPERENT_VIEW;
static const void *UITapGestureRecognizerBlockVoid = &UITapGestureRecognizerBlockVoid;

@implementation UIViewController (Popup)

- (UIView *)transView
{
    UIView *value = objc_getAssociatedObject(self, K_TRANSPERENT_VIEW);
    if (!value)
    {
        value = [[UIView alloc] init];
        objc_setAssociatedObject(self, K_TRANSPERENT_VIEW, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return value;
}

- (void)setTransView:(UIView *)transView
{
    objc_setAssociatedObject(self, K_TRANSPERENT_VIEW, transView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)popupView
{
    UIView *value = objc_getAssociatedObject(self, K_POPUP_VIEW);
    if (!value)
    {
        value = [[UIView alloc] init];
        objc_setAssociatedObject(self, K_POPUP_VIEW, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return value;
}

- (UITapGestureRecognizerBlock)tapGestureRecognizerBlock
{
    return objc_getAssociatedObject(self, UITapGestureRecognizerBlockVoid);
}

- (void)setTapGestureRecognizerBlock:(UITapGestureRecognizerBlock)tapGestureRecognizerBlock
{
    objc_setAssociatedObject(self, UITapGestureRecognizerBlockVoid, tapGestureRecognizerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setPopupView:(UIView *)popupView
{
    if ( self.popupView )
    {
        if ( ![NSStringFromClass([self.popupView class]) isEqualToString:NSStringFromClass([popupView class])] )
        {
            [self hidePopup];
        }
    }
    
    if ( [self.popupView isEqual:popupView] )
    {
        [self.view addSubview:self.transView];
        [self.view addSubview:self.popupView];
        
        return;
    }
    
    objc_setAssociatedObject(self, K_POPUP_VIEW, popupView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    popupView.frame = CGRectMake(0, self.view.frame.size.height, popupView.frame.size.width, popupView.frame.size.height);
    self.transView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.transView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    self.transView.alpha = 0.0;
    [self.view addSubview:self.transView];
    [self.view addSubview:popupView];
    self.isShowPopup = NO;
    
    PopUpHandleTap(self.transView, self, @selector(handleSingleTapPopup:));
}

- (BOOL)isShowPopup
{
    return [objc_getAssociatedObject(self, K_IS_SHOW_POPUP) boolValue];
}

- (void)setIsShowPopup:(BOOL)isShowPopup
{
     objc_setAssociatedObject(self, K_IS_SHOW_POPUP, [NSNumber numberWithBool:isShowPopup], OBJC_ASSOCIATION_ASSIGN);
}

- (void)showPopupTapBackground:(UITapGestureRecognizerBlock)tapBackground
{
    CGRect framePopup = CGRectMake(0, (self.view.frame.size.height - self.popupView.frame.size.height) / 2, self.popupView.frame.size.width, self.popupView.frame.size.height);
    
    [self showPopup:framePopup tapBackground:tapBackground];
}

- (void)showPopup:(CGRect)frame tapBackground:(UITapGestureRecognizerBlock)tapBackground
{
    if (self.isShowPopup)
    {
        return;
    }
    
    self.popupView.frame = CGRectMake(frame.origin.x, self.view.frame.size.height, self.popupView.frame.size.width, self.popupView.frame.size.height);
    self.transView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.tapGestureRecognizerBlock = tapBackground;
    self.isShowPopup = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.popupView.frame = frame;
    self.transView.alpha = 1.0;
    [UIView commitAnimations];
}

- (void)hidePopup
{
    self.isShowPopup = NO;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = self.popupView.frame;
    rect.origin.y = self.view.frame.size.height;
    self.popupView.frame = rect;
    self.transView.alpha = 0.0;
    [UIView commitAnimations];
}

- (void)handleSingleTapPopup:(UITapGestureRecognizer *)sender
{
    if (self.isShowPopup)
    {
        [self hidePopup];
        
        if (self.tapGestureRecognizerBlock)
        {
            self.tapGestureRecognizerBlock(sender);
        }
    }
}

#pragma mark - 
- (void)resetFrameWhenRotato:(CGRect )frameShow
{
    if ( self.isShowPopup )
    {
        self.popupView.frame = frameShow;
        self.transView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    }
    else
    {
        frameShow.origin.y = self.view.frame.size.height;
        self.popupView.frame = frameShow;
    }
}

@end
