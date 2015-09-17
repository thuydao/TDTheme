//
//  UIViewController+TDLog.m
//  BreweryExp
//
//  Created by Dao Duy Thuy on 10/22/14.
//  Copyright (c) 2014 ThuyDao All rights reserved.
//

#import "UIViewController+TDLog.h"
#import "TDEngineLog.h"
#define LOGCRASH @"nslogsample.log"

static const void *twoFingerTapGestureVoid             = &twoFingerTapGestureVoid;
static const void *btnSendQLogVoid                     = &btnSendQLogVoid;

@implementation UIViewController (TDLog)

#pragma mark - seter & geter

- (void)setTwoFingerTapGesture:(UITapGestureRecognizer *)twoFingerTapGesture
{
    objc_setAssociatedObject(self, twoFingerTapGestureVoid, twoFingerTapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITapGestureRecognizer*)twoFingerTapGesture
{
    return objc_getAssociatedObject(self, twoFingerTapGestureVoid);
}

- (void)setBtnSendLog:(UIButton *)btnSendLog
{
    objc_setAssociatedObject(self, btnSendQLogVoid, btnSendLog, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)btnSendLog
{
    return objc_getAssociatedObject(self, btnSendQLogVoid);
}

#pragma mark - Utils
/**
 *  activeLog
 */
- (void)activeLog
{
    if (!self.twoFingerTapGesture) {
        self.twoFingerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addLogFuntion)];
        self.twoFingerTapGesture.numberOfTapsRequired = 2;
        self.twoFingerTapGesture.numberOfTouchesRequired = 1;
        [self.view addGestureRecognizer:self.twoFingerTapGesture];
    }
}

/**
 *  deActiveLog
 */
- (void)deActiveLog
{
    [self.view removeGestureRecognizer:self.twoFingerTapGesture];
    self.twoFingerTapGesture = nil;
}


#pragma mark - Target
/**
 *  addLogFuntion
 */
- (void)addLogFuntion
{
    if (!self.btnSendLog) {
        self.btnSendLog = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width -150)/2, (self.view.frame.size.height -45)/2, 150, 45)];
        [self.btnSendLog setBackgroundColor:[UIColor grayColor]];
        [self.btnSendLog setTitle:@"Error Report" forState:UIControlStateNormal];
        [self.btnSendLog addTarget:self action:@selector(sendMailLog:) forControlEvents:UIControlEventTouchUpInside];
        self.btnSendLog.hidden = NO;
    }
    [self.view addSubview:self.btnSendLog];
}


/**
 *  sendMailLog
 *
 *  @param sender id
 */
- (void)sendMailLog:(id)sender
{
    [self.btnSendLog removeFromSuperview];
    
    //    Internal error reporting
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = (id)self;
    [mailComposer setSubject:[NSString stringWithFormat:@"ReportLog %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]]];
    
    NSString *email = EMAIL_DEVELOPMENT;//[[NSBundle mainBundle] objectForInfoDictionaryKey:@"EmailDevelopment"];
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObjects:email, nil];
    [mailComposer setToRecipients:toRecipients];
    
    // Attach the Crash Log..
    NSString *logPath = [NSObject getPathLog];
    NSData *myData = [NSData dataWithContentsOfFile:logPath];
    [mailComposer addAttachmentData:myData mimeType:@"Text/XML" fileName:@"Console.log"];
    
    // Fill out the email body text
    NSString *emailBody = @"My Application Log";
    [mailComposer setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:mailComposer animated:YES completion:nil];
}

/**
 *  mailComposeController
 *
 *  @param controller MFMailComposeViewController
 *  @param result     MFMailComposeResult
 *  @param error      NSError
 */
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
