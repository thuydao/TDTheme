//
//  UIViewController+Popup.h
//  All
//
//  Created by Dao Duy Thuy on 7/5/14.
//  Copyright (c) 2014 ThuyDao. All rights reserved.
//

#define PopUpHandleTap(view, delegate, selector) do { \
    view.userInteractionEnabled = YES; \
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:delegate action:selector]]; \
} while(0)

typedef void (^UITapGestureRecognizerBlock) (UITapGestureRecognizer *sender);

@interface UIViewController (Popup)

@property (strong, nonatomic) UIView *popupView;
@property (assign, nonatomic) BOOL isShowPopup;
@property (strong, nonatomic) UIView *transView;

@property (copy, nonatomic) UITapGestureRecognizerBlock tapGestureRecognizerBlock;

- (void)showPopupTapBackground:(UITapGestureRecognizerBlock)tapBackground;
- (void)showPopup:(CGRect)frame tapBackground:(UITapGestureRecognizerBlock)tapBackground;

- (void)hidePopup;

#pragma mark - 
- (void)resetFrameWhenRotato:(CGRect )frameShow;

@end
