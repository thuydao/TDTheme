//
//  TDPlist.h
//  Pods
//
//  Created by Dao Duy Thuy on 8/12/15.
//
//

#import "TDBaseObject.h"

@interface TDPlist : TDBaseObject

//reader
+ (NSArray *)td_arrayFromMainBundlePlistFile:(NSString *)namefile;
+ (NSDictionary *)td_dictionaryFromMainBundlePlistFile:(NSString *)namefile;

+ (NSArray *)td_arrayFromPlistFile:(NSString *)namefile;
+ (NSDictionary *)td_dictionaryFromPlistFile:(NSString *)namefile;


//writer
+ (void)td_saveArray:(NSArray *)arr toMainBundlePlistFile:(NSString *)namefile;
+ (void)td_saveDictionary:(NSDictionary *)dictionary toMainBundlePlistFile:(NSString *)namefile;

+ (void)td_saveArray:(NSArray *)arr toPlistFile:(NSString *)namefile;
+ (void)td_saveDictionary:(NSDictionary *)dictionary toPlistFile:(NSString *)namefile;

@end
