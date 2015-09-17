//
//  NSObject+File.h
//  EngineLog
//
//  Created by Dao Duy Thuy on 10/22/14.
//  Copyright (c) 2014 ThuyDao All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (File)

/**
 *  getDataPath
 *
 *  @return NSString
 */
+ (NSString *)getDataPath;

/**
 *  writeFile
 *
 *  @param content  NSString
 *  @param fileName NSString
 */
+ (void)writeFile:(NSString*)content fileName:(NSString *)fileName;

/**
 *  getPathLog
 *
 *  @return NSString
 */
+ (NSString *)getPathLog;


/**
 *  clearFile
 *
 *  @param fileName NSString
 */
+ (void)clearFile:(NSString *)fileName;

@end
