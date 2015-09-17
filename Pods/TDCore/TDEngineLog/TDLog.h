//
//  TDLog.h
//  EngineLog
//
//  Created by Dao Duy Thuy on 10/22/14.
//  Copyright (c) 2014 ThuyDao All rights reserved.
//

#import "NSObject+File.h"

#ifdef TD_DEBUG
    #define TDLOG(fmt, ...) {\
        NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);\
        NSString *logtext = [NSString stringWithFormat:(@"%@ %s [Line %d] " fmt),[NSDate date], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__];\
        [NSObject writeFile:logtext fileName:@"log.txt"];\
    }
#else
    #define TDLOG(...)
//    #define TDLOG(fmt, ...) {\
//        NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);\
//        [NSObject writeFile:[NSString stringWithFormat:(@""fmt,##__VA_ARGS__)] fileName:@"log.txt"];\
//    }
#endif

// ALog will always output like NSLog

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

// ULog will show the UIAlertView only when the DEBUG variable is set

#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif