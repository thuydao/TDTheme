//
//  TBBaseObject.m
//  mPos
//
//  Created by thuydd on 1/30/15.
//  Copyright (c) 2015 SmartOSCVietNam. All rights reserved.
//

#import "TDBaseObject.h"

static NSMutableDictionary *sharedInstance = nil;
@implementation TDBaseObject

#pragma mark - private

/**
 *  init
 *
 *  @return instancetype
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self td_initialize];
    }
    return(self);
}


/**
 *  initialize
 *  Overwrite to customize init object
 */
- (void)td_initialize
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - singleton

/**
 *  sharedInstance
 *
 *  @return v
 */
+ (instancetype)td_sharedInstance
{
    TDBaseObject *obj = nil;
    @synchronized(self) {
        
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            
            sharedInstance = [NSMutableDictionary new];
        });
        
        NSString *className = NSStringFromClass([self class]);
        
        obj = [sharedInstance objectForKey:className];
        
        if ( !obj )
        {
            obj = [[[self class] alloc] init];
            [sharedInstance setValue:obj forKey:className];
        }
        
    }
    
    return obj;

}

@end
