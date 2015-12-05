//
//  LZTableViewController.m
//  LZTableViewFun
//
//  Created by comst on 15/12/4.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZTableViewController.h"

@interface LZTableViewController ()<UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, copy) NSDictionary *dic;
@property (nonatomic, copy) NSArray *sectionArray;
@property (nonatomic, copy) NSArray *filterArray;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation LZTableViewController



- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.sectionArray = [[self.dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    self.tableView.sectionIndexBackgroundColor = [UIColor blackColor];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexColor = [UIColor whiteColor];
    [self initSearchDisplay];
}

- (void)initSearchDisplay{
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchBar.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, 60);
    self.tableView.tableHeaderView = searchController.searchBar;
    searchController.searchBar.delegate = self;
    self.searchController = searchController;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    self.searchController.active = NO;
    [self.tableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *text = searchController.searchBar.text;
    if ([text length] == 0) {
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", text];
    NSMutableArray *filterArray = [NSMutableArray array];
    
    for (NSString *key in self.sectionArray) {
        
        NSArray *resArray = [self.dic[key] filteredArrayUsingPredicate:predicate];
        [filterArray addObjectsFromArray:resArray];
    }
    
    self.filterArray = filterArray;
    [self.tableView reloadData];
    
}

- (NSDictionary *)dic{
    
    if (!_dic) {
        _dic = [[NSDictionary alloc] initWithContentsOfFile:[self dictPath]];
    }
    
    return _dic;
}

- (NSString *)dictPath{
    
    return [[NSBundle mainBundle] pathForResource:@"sortednames.plist" ofType:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.searchController.active) {
        
        return 1;
        
    }
    
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchController.active) {
        
        return self.filterArray.count;
        
    }
    NSString *keyString = self.sectionArray[section];
    return [self.dic[keyString] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCell"];
    
   
    if (self.searchController.active) {
        
        cell.textLabel.text = self.filterArray[indexPath.row];
        return cell;
        
    }
    
    NSArray *array = self.dic[self.sectionArray[indexPath.section]];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.searchController.active) {
        return nil;
    }
    return self.sectionArray[section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (self.searchController.active) {
        return nil;
    }
    return self.sectionArray;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

- (void)didPresentSearchController:(UISearchController *)searchController{
    
    NSLog(@"-----");
    
}
@end
