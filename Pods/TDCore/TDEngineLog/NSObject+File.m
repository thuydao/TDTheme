//
//  NSObject+File.m
//  EngineLog
//
//  Created by Dao Duy Thuy on 10/22/14.
//  Copyright (c) 2014 ThuyDao All rights reserved.
//

#import "NSObject+File.h"
#import "TDEngineLog.h"

@implementation NSObject (File)

/**
 *  getDataPath
 *
 *  @return NSString
 */
+ (NSString *)getDataPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/EngineLog"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
    return dataPath;
}


/**
 *  getPathLog
 *
 *  @return NSString
 */
+ (NSString *)getPathLog
{
    NSString *documentsDirectory = [self  getDataPath];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"log.txt"];
    return appFile;
}

/**
 *  writeFile
 *
 *  @param content  NSString
 *  @param fileName NSString
 */
+ (void)writeFile:(NSString*)content fileName:(NSString *)fileName
{
    NSString *documentsDirectory = [self  getDataPath];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSString *contents = [NSString stringWithContentsOfFile:appFile encoding:NSUTF8StringEncoding error:nil];
    if (!contents) {
        contents = @"";
    }
    contents = [contents stringByAppendingString:[NSString stringWithFormat:@"\n\n %@",content]];
    
    if (contents.length > FILE_LENGTH) {
        contents = [contents substringToIndex:contents.length - FILE_LENGTH];
    }
    
    BOOL didWrite = [contents writeToFile:appFile
                              atomically:YES
                                encoding:NSUTF8StringEncoding
                                   error:nil];
    if (didWrite) {
       // NSLog(@"writed : %@",appFile);
    }
    else
    {
        //NSLog(@"cant write : %@",appFile);
    }
}

/**
 *  clearFile
 *
 *  @param fileName NSString
 */
+ (void)clearFile:(NSString *)fileName
{
    NSString *documentsDirectory = [self  getDataPath];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSString *contents = @"";
    BOOL didWrite = [contents writeToFile:appFile
                               atomically:YES
                                 encoding:NSUTF8StringEncoding
                                    error:nil];
    if (didWrite) {
       // NSLog(@"writed : %@",appFile);
    }
    else
    {
        //NSLog(@"cant write : %@",appFile);
    }

}

@end
