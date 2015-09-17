//
//  UIAlertView+Block.m
//  UIAlertViewBlocks
//
//  Created by Ryan Maxwell on 29/08/13.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Ryan Maxwell
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

static const void *UIAlertViewOriginalDelegateKey                   = &UIAlertViewOriginalDelegateKey;

static const void *UIAlertViewTapBlockKey                           = &UIAlertViewTapBlockKey;
static const void *UIAlertViewWillPresentBlockKey                   = &UIAlertViewWillPresentBlockKey;
static const void *UIAlertViewDidPresentBlockKey                    = &UIAlertViewDidPresentBlockKey;
static const void *UIAlertViewWillDismissBlockKey                   = &UIAlertViewWillDismissBlockKey;
static const void *UIAlertViewDidDismissBlockKey                    = &UIAlertViewDidDismissBlockKey;
static const void *UIAlertViewCancelBlockKey                        = &UIAlertViewCancelBlockKey;
static const void *UIAlertViewShouldEnableFirstOtherButtonBlockKey  = &UIAlertViewShouldEnableFirstOtherButtonBlockKey;

@implementation UIAlertView (Block)

#define ALERT_BLOCK_APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey]

#pragma mark - Add more by ThuyDao
// Have not Style
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(UIAlertViewCompletionBlock)tapBlock
{
    return [self showAlertViewWithTitle:title message:message style:UIAlertViewStyleDefault cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles tapBlock:tapBlock];
}

// Have not Style - title
+ (instancetype)showAlertViewWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(UIAlertViewCompletionBlock)tapBlock
{
    return [self showAlertViewWithTitle:ALERT_BLOCK_APP_NAME message:message style:UIAlertViewStyleDefault cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles tapBlock:tapBlock];
}

// Have not Style - title - other button
+ (instancetype)showAlertViewWithMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle tapBlock:(UIAlertViewCompletionBlock)tapBlock
{
    return [self showAlertViewWithTitle:ALERT_BLOCK_APP_NAME message:message style:UIAlertViewStyleDefault cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil tapBlock:tapBlock];
}

// Have not Style - other button
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle tapBlock:(UIAlertViewCompletionBlock)tapBlock
{
    return [self showAlertViewWithTitle:title message:message style:UIAlertViewStyleDefault cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil tapBlock:tapBlock];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#pragma mark - Origin Ryan Maxwell
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertViewStyle)style cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles tapBlock:(UIAlertViewCompletionBlock)tapBlock {
    NSString *firstObject = otherButtonTitles.count ? otherButtonTitles[0] : nil;
    
    UIAlertView *alertView;
    if (firstObject) {
        alertView = [[self alloc] initWithTitle:NSLocalizedString(title, @"")
                                        message:NSLocalizedString(message, @"")
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(cancelButtonTitle, @"")
                              otherButtonTitles:NSLocalizedString(firstObject, @""), nil];
    }
    else {
        alertView = [[self alloc] initWithTitle:NSLocalizedString(title, @"")
                                        message:NSLocalizedString(message, @"")
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(cancelButtonTitle, @"")
                              otherButtonTitles:nil];
    }
    
    alertView.alertViewStyle = style;
    
    if (otherButtonTitles) {
        if (otherButtonTitles.count > 1) {
            for (NSString *buttonTitle in[otherButtonTitles subarrayWithRange:NSMakeRange(1, otherButtonTitles.count - 1)]) {
                [alertView addButtonWithTitle:NSLocalizedString(buttonTitle, @"")];
            }
        }
    }
    
    if (tapBlock) {
        alertView.tapBlock = tapBlock;
    }
    
    [alertView show];
    
#if !__has_feature(objc_arc)
    return [alertView autorelease];
#else
    return alertView;
#endif
}

#pragma mark -
- (void)_checkAlertViewDelegate {
    if (self.delegate != (id <UIAlertViewDelegate> )self) {
        objc_setAssociatedObject(self, UIAlertViewOriginalDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id <UIAlertViewDelegate> )self;
    }
}

- (UIAlertViewCompletionBlock)tapBlock {
    return objc_getAssociatedObject(self, UIAlertViewTapBlockKey);
}

- (void)setTapBlock:(UIAlertViewCompletionBlock)tapBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewTapBlockKey, tapBlock, OBJC_ASSOCIATION_COPY);
}

- (UIAlertViewCompletionBlock)willDismissBlock {
    return objc_getAssociatedObject(self, UIAlertViewWillDismissBlockKey);
}

- (void)setWillDismissBlock:(UIAlertViewCompletionBlock)willDismissBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewWillDismissBlockKey, willDismissBlock, OBJC_ASSOCIATION_COPY);
}

- (UIAlertViewCompletionBlock)didDismissBlock {
    return objc_getAssociatedObject(self, UIAlertViewDidDismissBlockKey);
}

- (void)setDidDismissBlock:(UIAlertViewCompletionBlock)didDismissBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewDidDismissBlockKey, didDismissBlock, OBJC_ASSOCIATION_COPY);
}

- (UIAlertViewBlock)willPresentBlock {
    return objc_getAssociatedObject(self, UIAlertViewWillPresentBlockKey);
}

- (void)setWillPresentBlock:(UIAlertViewBlock)willPresentBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewWillPresentBlockKey, willPresentBlock, OBJC_ASSOCIATION_COPY);
}

- (UIAlertViewBlock)didPresentBlock {
    return objc_getAssociatedObject(self, UIAlertViewDidPresentBlockKey);
}

- (void)setDidPresentBlock:(UIAlertViewBlock)didPresentBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewDidPresentBlockKey, didPresentBlock, OBJC_ASSOCIATION_COPY);
}

- (UIAlertViewBlock)cancelBlock {
    return objc_getAssociatedObject(self, UIAlertViewCancelBlockKey);
}

- (void)setCancelBlock:(UIAlertViewBlock)cancelBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewCancelBlockKey, cancelBlock, OBJC_ASSOCIATION_COPY);
}

- (void)setShouldEnableFirstOtherButtonBlock:(BOOL (^)(UIAlertView *alertView))shouldEnableFirstOtherButtonBlock {
    [self _checkAlertViewDelegate];
    objc_setAssociatedObject(self, UIAlertViewShouldEnableFirstOtherButtonBlockKey, shouldEnableFirstOtherButtonBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UIAlertView *alertView))shouldEnableFirstOtherButtonBlock {
    return objc_getAssociatedObject(self, UIAlertViewShouldEnableFirstOtherButtonBlockKey);
}

#pragma mark - UIAlertViewDelegate
- (void)willPresentAlertView:(UIAlertView *)alertView {
    UIAlertViewBlock block = alertView.willPresentBlock;
    
    if (block) {
        block(alertView);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(willPresentAlertView:)]) {
        [originalDelegate willPresentAlertView:alertView];
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    UIAlertViewBlock block = alertView.didPresentBlock;
    
    if (block) {
        block(alertView);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(didPresentAlertView:)]) {
        [originalDelegate didPresentAlertView:alertView];
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView {
    UIAlertViewBlock block = alertView.cancelBlock;
    
    if (block) {
        block(alertView);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(alertViewCancel:)]) {
        [originalDelegate alertViewCancel:alertView];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIAlertViewCompletionBlock completion = alertView.tapBlock;
    
    if (completion) {
        completion(alertView, buttonIndex);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [originalDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIAlertViewCompletionBlock completion = alertView.willDismissBlock;
    
    if (completion) {
        completion(alertView, buttonIndex);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [originalDelegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIAlertViewCompletionBlock completion = alertView.didDismissBlock;
    
    if (completion) {
        completion(alertView, buttonIndex);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
        [originalDelegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    BOOL (^shouldEnableFirstOtherButtonBlock)(UIAlertView *alertView) = alertView.shouldEnableFirstOtherButtonBlock;
    
    if (shouldEnableFirstOtherButtonBlock) {
        return shouldEnableFirstOtherButtonBlock(alertView);
    }
    
    id originalDelegate = objc_getAssociatedObject(self, UIAlertViewOriginalDelegateKey);
    if (originalDelegate && [originalDelegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)]) {
        return [originalDelegate alertViewShouldEnableFirstOtherButton:alertView];
    }
    
    return YES;
}

@end
