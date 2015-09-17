//
//  ViewController.m
//  TDTheme
//
//  Created by Dao Duy Thuy on 8/15/15.
//  Copyright (c) 2015 Moboco. All rights reserved.
//

#import "ViewController.h"
#import "ViewCustom.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewCustom *newview = (ViewCustom *)[self td_getViewFromXib:@"ViewCustom" index:0];
    [newview td_configureTheme];
    [[TDThemeManagement td_sharedInstance] td_addDelegate:(id)newview];
    newview.frame = CGRectMake(0, 0, newview.size.width, newview.size.height);
    [self.view addSubview:newview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)td_configureTheme
{
    
    
    
    if(td_isTheme(@"red"))
    {
        [self.view viewWithTag:1].backgroundColor =[UIColor redColor];
    }
    else
    {
        [self.view viewWithTag:1].backgroundColor =[UIColor greenColor];
    }
}

#pragma mark - IBAction
- (IBAction)clickRed:(id)sender {
    td_setTheme(@"red");
}

- (IBAction)clickGreen:(id)sender {
    td_setTheme(@"green");
}

@end
