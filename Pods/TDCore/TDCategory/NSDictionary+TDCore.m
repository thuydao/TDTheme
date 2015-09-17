//
//  NSDictionary+TDCore.m
//  tdUtils
//
//  Created by thuydd on 1/27/15.
//  Copyright (c) 2015 SmartOSC. All rights reserved.
//

#import "NSDictionary+TDCore.h"

@implementation NSDictionary (TDCore)

@end

#pragma mark - Accessors
@implementation NSDictionary (Accessors)

- (id)td_objectForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    
    if ( !object || object == NULL || object == [NSNull null] )
    {
        return nil;
    }
    
    return object;
}

- (BOOL)td_containsObjectForKey:(id )key
{
    if (!self )
    {
        return NO;
    }
    
    return [self.allKeys containsObject:key];
}

- (NSDictionary *)td_dictionaryForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( object && [object isKindOfClass:[NSDictionary class]] )
    {
        return object;
    }
    
    return [NSDictionary new];
}


- (NSMutableDictionary *)td_mutableDictionaryForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( object && [object isKindOfClass:[NSDictionary class]] )
    {
        return [[NSMutableDictionary alloc] initWithDictionary:object];
    }
    
    return [NSMutableDictionary new];
}

- (NSArray *)td_arrayForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( object && [object isKindOfClass:[NSArray class]] )
    {
        return object;
    }
    
    return [NSArray new];
}

- (NSMutableArray *)td_mutableArrayForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( object && [object isKindOfClass:[NSArray class]] )
    {
        return [[NSMutableArray alloc] initWithArray:object];
    }
    
    return [NSMutableArray new];
}


- (NSString *)td_stringForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( [object isKindOfClass:[NSString class]] )
    {
        return object;
    }
    else if ( object )
    {
        return [NSString stringWithFormat:@"%@", object];
    }
    
    return @"";
}


- (NSInteger)td_intForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( !object )
    {
        return 0;
    }
    
    return [object intValue];
}


- (float)td_floatForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( !object )
    {
        return 0.0f;
    }
    
    return [object floatValue];
}

- (double)td_doubleForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( !object )
    {
        return 0.0f;
    }
    
    return [object doubleValue];
}

- (BOOL)td_boolForKey:(NSString *)key
{
    id object = [self td_objectForKey:key];
    
    if ( !object )
    {
        return NO;
    }
    
    return [object boolValue];
}

@end
