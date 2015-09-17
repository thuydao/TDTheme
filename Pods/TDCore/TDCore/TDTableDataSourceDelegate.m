//
//  TDTableDataSourceDelegate.m
//  mPos
//
//  Created by Dao Duy Thuy on 6/1/15.
//  Copyright (c) 2015 ThuyDao. All rights reserved.
//

#import "TDTableDataSourceDelegate.h"

@implementation TDTableDataSourceDelegate

#pragma mark - Setter & getter

- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [_tableView reloadData];
}

- (void)setIdentifier:(NSString *)identifier
{
    _identifier = identifier;
}

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)setSearchBar:(UISearchBar *)searchBar
{
    _searchBar = searchBar;
    _searchBar.delegate = self;
}

- (void)setTd_selectedRow:(td_selectedRow)td_selectedRow
{
    _td_selectedRow = td_selectedRow;
}

#pragma mark - public funtion

- (void)addRefresh:(td_refresh)refresh loadmore:(td_loadMore)loadmore
{
    [_tableView setDragDelegate:(id)self refreshDatePermanentKey:@"tblistinvoces"];
    _tableView.showRefreshView = YES;
    self.td_refresh = refresh;
    self.td_loadMore = loadmore;
}

- (void)finishRefresh
{
    self.td_refresh();
}

- (void)finishLoadMore
{
    self.td_loadMore();
}

- (void)addSearchBar:(UISearchBar *)sb search:(td_search)td_search
{
    _searchBar = sb;
    _searchBar.delegate = self;
    self.isShowKeyboard = NO;
    _td_search = td_search;
}

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!cell)
    {
        // create new cell
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSObject *obj = self.dataSource[indexPath.row];
    SEL selector = @selector(fetchData:);
    
    
    if (obj && [obj respondsToSelector:selector]) {
        SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([obj performSelector:selector withObject:cell];);
        
    }
#pragma clang diagnostic pop
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.searchBar) {
        [self selectedRowAtIndexPath:indexPath];
    }
    else
    {
        if (self.isShowKeyboard) {
            [self.searchBar resignFirstResponder];
        }
        else
        {
           [self selectedRowAtIndexPath:indexPath];
        }
    }
    self.isShowKeyboard = NO;
}


- (void)selectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.td_selectedRow) {
        self.td_selectedRow(_dataSource[indexPath.row]);
    }
}

#pragma mark - Drag delegate methods

- (void)dragTableDidTriggerRefresh:(UITableView *)tableView
{
    //send refresh request(generally network request) here
    
    [self performSelector:@selector(finishRefresh) withObject:nil afterDelay:2];
}

- (void)dragTableRefreshCanceled:(UITableView *)tableView
{
    //cancel refresh request(generally network request) here
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishRefresh) object:nil];
}

- (void)dragTableDidTriggerLoadMore:(UITableView *)tableView
{
    //send load more request(generally network request) here
    
    [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:2];
}

- (void)dragTableLoadMoreCanceled:(UITableView *)tableView
{
    //cancel load more request(generally network request) here
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishLoadMore) object:nil];
}

#pragma mark - SearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.isShowKeyboard = YES;
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.isShowKeyboard = NO;
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    if (self.td_search) {
        self.td_search(searchText);
    }
}

@end
