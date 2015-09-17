//
//  TDThemeManagement.h
//  TDCore
//
//  Created by Dao Duy Thuy on 8/12/15.
//  Copyright (c) 2015 Thuỷ Đào. All rights reserved.
//

#import "TDMultiDelegate.h"

#define td_isTheme(themeName) [TDThemeManagement isTheme:themeName]
#define td_setTheme(themeName) [[TDThemeManagement td_sharedInstance] setCurrentThemeKey:themeName];

@protocol TDThemeManagementProtocol <NSObject>

@required
- (void)td_configureTheme;

@end

@interface TDThemeManagement : TDMultiDelegate

- (void)setCurrentThemeKey:(NSString *)currentThemeKey;
- (NSString *)currentThemeKey;

+ (BOOL)isTheme:(NSString *)themeName;

@end
