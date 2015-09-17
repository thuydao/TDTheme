//
//  TDCore.h
//  Pods
//
//  Created by Dao Duy Thuy on 6/15/15.
//
//


#import "TDBaseViewController.h"
#import "TDTableDataSourceDelegate.h"

#pragma mark - TDCategory
#import "NSArray+TDCore.h"
#import "NSDictionary+TDCore.h"
#import "NSString+TDCore.h"
#import "UIColor+TDCore.h"
#import "UIColor+HexColor.h"
#import "UIScrollView+TDCore.h"
#import "UIView+TDCore.h"
#import "UIView+TDRecognizer.h"
#import "NSObject+TDDocument.h"
#import "UIRefreshControl+UITableView.h"

#pragma mark - TDEngineLog
#import "TDLog.h"

#pragma mark - TDEvent
#import "UIAlertView+Block.h"
#import "UIButton+TDEvent.h"
#import "UIView+TDEvent.h"

#pragma mark - TDPopup
#import "UIViewController+Popup.h"

#pragma mark - TDUtils
#import "TDAlert.h"

#pragma mark - TableViewDragLoad
#import "UITableView+DragLoad.h"

#pragma mark - APN
#import "UIResponder+TDPush.h"

#pragma mark - THEME
#import "TDThemeManagement.h"

#pragma mark - Threads
#define TD_MAIN_THREAD(code)\
dispatch_async(dispatch_get_main_queue(), ^{\
code;\
});

#define TD_BACKGROUND_THREAD(code)\
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{\
code;\
});

#pragma mark - Colors
#define TD_COLOR_RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define TD_COLOR_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define TD_COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define TD_COLOR_HEXA(rgbValue, alpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha]

#define TD_RADIANS(degrees) ((degrees * M_PI) / 180.0);

#pragma mark - APP INFO
#define TD_APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
#define TD_APP_NAME [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];



