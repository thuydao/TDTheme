//
//  TDTableDataSourceDelegate.h
//  mPos
//
//  Created by Dao Duy Thuy on 6/1/15.
//  Copyright (c) 2015 ThuyDao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableView+DragLoad.h"

#define SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")                                         \



typedef void (^td_selectedRow)(NSObject *object);
typedef void (^td_refresh)();
typedef void (^td_loadMore)();
typedef void (^td_search)(NSString *searchText);

@interface TDTableDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, copy) td_selectedRow td_selectedRow;
@property (nonatomic, copy) td_refresh td_refresh;
@property (nonatomic, copy) td_loadMore td_loadMore;
@property (nonatomic, copy) td_search td_search;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) BOOL isShowKeyboard;
@property (nonatomic, strong) NSPredicate *predicate;


#pragma mark - public funtion

- (void)addRefresh:(td_refresh)refresh loadmore:(td_loadMore)loadmore;
- (void)addSearchBar:(UISearchBar *)sb search:(td_search)td_search;
@end
