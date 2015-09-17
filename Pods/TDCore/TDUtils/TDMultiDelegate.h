//
//  TDMultiDelegate.h
//  Pods
//
//  Created by Dao Duy Thuy on 8/11/15.
//
//


#import "TDBaseObject.h"

@interface TDMultiDelegate : TDBaseObject

/**
 The array of registered delegates.
 */
@property (readonly, nonatomic) NSPointerArray* td_delegates;

- (id)td_initWithDelegates:(NSArray*)delegates;

- (void)td_addDelegate:(id)delegate;
- (void)td_addDelegate:(id)delegate beforeDelegate:(id)otherDelegate;
- (void)td_addDelegate:(id)delegate afterDelegate:(id)otherDelegate;

- (void)td_removeDelegate:(id)delegate;
- (void)td_removeAllDelegates;
- (void)td_respondsToSelector:(SEL)selector;

@end
