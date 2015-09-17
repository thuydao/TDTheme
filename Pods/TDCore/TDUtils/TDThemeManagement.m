//
//  TDThemeManagement.m
//  TDCore
//
//  Created by Dao Duy Thuy on 8/12/15.
//  Copyright (c) 2015 Thuỷ Đào. All rights reserved.
//

#import "TDThemeManagement.h"

@implementation TDThemeManagement

- (void)setCurrentThemeKey:(NSString *)currentThemeKey
{
     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![[self currentThemeKey] isEqualToString:@"currentThemeKey"])
    {
        [ud setObject:currentThemeKey forKey:@"td_currentThemekey"];
        [ud synchronize];
        
        [self td_respondsToSelector:@selector(td_configureTheme)];
    }
    else
    {
        NSLog(@"dont change theme");
    }
}


- (NSString *)currentThemeKey
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud stringForKey:@"td_currentThemekey"])
    {
        //return default current theme
        return @"";
    }
    else
        return [ud stringForKey:@"td_currentThemekey"];
}

+ (BOOL)isTheme:(NSString *)themeName
{
    return [[[[TDThemeManagement td_sharedInstance] currentThemeKey] uppercaseString] isEqualToString:[themeName uppercaseString]];
}

@end
