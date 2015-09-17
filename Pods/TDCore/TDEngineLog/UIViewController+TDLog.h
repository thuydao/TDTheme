//
//  UIViewController+TDLog.h
//  BreweryExp
//
//  Created by Dao Duy Thuy on 10/22/14.
//  Copyright (c) 2014 ThuyDao All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "NSObject+File.h"

@interface UIViewController (TDLog)

/**
 *  twoFingerTapGesture
 */
@property (nonatomic, retain) UITapGestureRecognizer *twoFingerTapGesture;

/**
 *  btnSendLog
 */
@property (nonatomic, retain) UIButton *btnSendLog;

/**
 *  activeLog
 */
- (void)activeLog;

/**
 *  deActiveLog
 */
- (void)deActiveLog;

@end
