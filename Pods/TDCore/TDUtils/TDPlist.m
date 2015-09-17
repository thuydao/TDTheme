//
//  TDPlist.m
//  Pods
//
//  Created by Dao Duy Thuy on 8/12/15.
//
//

#import "TDPlist.h"

@implementation TDPlist

//reader

+ (NSArray *)td_arrayFromMainBundlePlistFile:(NSString *)namefile
{
    namefile = [namefile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:namefile ofType:@"plist"]];
}

+ (NSDictionary *)td_dictionaryFromMainBundlePlistFile:(NSString *)namefile
{
    namefile = [namefile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:namefile ofType:@"plist"]];
}

+ (NSArray *)td_arrayFromPlistFile:(NSString *)namefile
{
    namefile = [namefile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    return [NSArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@.plist",namefile]];
}

+ (NSDictionary *)td_dictionaryFromPlistFile:(NSString *)namefile
{
    namefile = [namefile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    return [NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@.plist",namefile]];
}

//Writer
+ (void)td_saveArray:(NSArray *)arr toMainBundlePlistFile:(NSString *)namefile
{
    namefile = [namefile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    [arr writeToFile:[[NSBundle mainBundle] pathForResource:namefile ofType:@"plist"] atomically:YES];
}

+ (void)td_saveDictionary:(NSDictionary *)dictionary toMainBundlePlistFile:(NSString *)namefile
{
    namefile = [namefile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    [dictionary writeToFile:[[NSBundle mainBundle] pathForResource:namefile ofType:@"plist"] atomically:YES];
}

+ (void)td_saveArray:(NSArray *)arr toPlistFile:(NSString *)namefile
{
    namefile = [namefile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    [arr writeToFile:[NSString stringWithFormat:@"%@.plist",namefile] atomically:YES];
}

+ (void)td_saveDictionary:(NSDictionary *)dictionary toPlistFile:(NSString *)namefile
{
    namefile = [namefile stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    [dictionary writeToFile:[NSString stringWithFormat:@"%@.plist",namefile] atomically:YES];
}

@end
