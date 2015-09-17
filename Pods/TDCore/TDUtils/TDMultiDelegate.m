//
//  TDMultiDelegate.m
//  Pods
//
//  Created by Dao Duy Thuy on 8/11/15.
//
//

#import <Foundation/Foundation.h>
#import "TDMultiDelegate.h"

@implementation TDMultiDelegate {
    NSPointerArray* _td_delegates;
}

- (id)init {
    return [self td_initWithDelegates:nil];
}

- (id)td_initWithDelegates:(NSArray*)delegates {
    if(self == [super init])
    {
        if (!self)
            return nil;
        
        _td_delegates = [NSPointerArray weakObjectsPointerArray];
        for (id delegate in delegates)
            [_td_delegates addPointer:(__bridge void*)delegate];
    }
    
    return self;
}

- (void)td_addDelegate:(id)delegate {
    [_td_delegates addPointer:(__bridge void *)(delegate)];
}

- (NSUInteger)indexOfDelegate:(id)delegate {
    for (NSUInteger i = 0; i < _td_delegates.count; i += 1) {
        if ([_td_delegates pointerAtIndex:i] == (__bridge void*)delegate) {
            return i;
        }
    }
    return NSNotFound;
}

- (void)td_addDelegate:(id)delegate beforeDelegate:(id)otherDelegate {
    NSUInteger index = [self indexOfDelegate:otherDelegate];
    if (index == NSNotFound)
        index = _td_delegates.count;
    [_td_delegates insertPointer:(__bridge void*)delegate atIndex:index];
}

- (void)td_addDelegate:(id)delegate afterDelegate:(id)otherDelegate {
    NSUInteger index = [self indexOfDelegate:otherDelegate];
    if (index == NSNotFound)
        index = 0;
    else
        index += 1;
    [_td_delegates insertPointer:(__bridge void *)(delegate) atIndex:index];
}

- (void)td_removeDelegate:(id)delegate {
    NSUInteger index = [self indexOfDelegate:delegate];
    if (index != NSNotFound)
        [_td_delegates removePointerAtIndex:index];
    [_td_delegates compact];
}

- (void)td_removeAllDelegates {
    for (NSUInteger i = _td_delegates.count; i > 0; i -= 1)
        [_td_delegates removePointerAtIndex:i - 1];
}

- (BOOL)respondsToSelector:(SEL)selector {
    if ([super respondsToSelector:selector])
        return YES;
    
    for (id delegate in _td_delegates) {
        if (delegate && [delegate respondsToSelector:selector])
            return YES;
    }
    
    return NO;
}

- (void)td_respondsToSelector:(SEL)selector
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    for (id delegate in _td_delegates) {
        if (delegate && [delegate respondsToSelector:selector])
            [delegate performSelector:selector];
    }
#pragma clang diagnostic pop
}

@end
