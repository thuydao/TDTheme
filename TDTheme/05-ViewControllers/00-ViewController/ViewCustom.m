//
//  ViewCustom.m
//  TDTheme
//
//  Created by Dao Duy Thuy on 9/17/15.
//  Copyright (c) 2015 Moboco. All rights reserved.
//

#import "ViewCustom.h"

@implementation ViewCustom

- (void)td_configureTheme
{
    if(td_isTheme(@"red"))
    {
        self.backgroundColor =[UIColor redColor];
    }
    else
    {
        self.backgroundColor =[UIColor greenColor];
    }
}

@end
