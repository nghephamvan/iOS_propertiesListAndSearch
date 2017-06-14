//
//  NamesTableViewController.m
//  propertiesListSearch
//
//  Created by TMA103 on 4/24/17.
//  Copyright © 2017 TMA. All rights reserved.
//

#import "NamesTableViewController.h"

static NSString *const NAME_DATA = @"names";
static NSString *const TYPE_FILE = @"plist";

@interface NamesTableViewController ()

@end

@implementation NamesTableViewController

@synthesize names, keys, filteredNames, searchBar, isFiltered;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    NSString *path = [[NSBundle mainBundle]pathForResource:NAME_DATA ofType:TYPE_FILE];
    names = [NSDictionary dictionaryWithContentsOfFile:path];
    keys = [[names allKeys] sortedArrayUsingSelector: @selector(compare:)];
    filteredNames = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    CGRect newBounds = self.tableView.bounds;
    if (self.tableView.bounds.origin.y < 44) {
        newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
        self.tableView.bounds = newBounds;
    }
    // new for iOS 7
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:0 animated:YES];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!isFiltered) {
        return [keys count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView.tag == 1) {
//        NSString *key = keys[section];
//        NSArray *arrayNames = names[key];
//        
//        return [arrayNames count];
//    }
    
    if (isFiltered) {
        return filteredNames.count;
    }
    
    NSString *key = keys[section];
    NSArray *arrayNames = names[key];
    return [arrayNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (isFiltered) {
        cell.textLabel.text = filteredNames[indexPath.row];
    } else {
        NSString *key = keys[indexPath.section];
        NSArray *keyValues = names[key];
        
        cell.textLabel.text = keyValues[indexPath.row];
    }
    return cell;
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!isFiltered) {
        return keys;
    }
    
    return nil;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!isFiltered) {
        return keys[section];
    }
    
    return nil;
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        isFiltered = NO;
    } else {
        isFiltered = YES;

        [filteredNames removeAllObjects];
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF contains [search] %@", searchText];
        
        for (NSString *key in keys) {
            NSArray *matches = [names[key] filteredArrayUsingPredicate:pre];
            [filteredNames addObjectsFromArray:matches];
        }
    }
    
    [self.tableView reloadData];
}

-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isFiltered = NO;
    [self.tableView reloadData];
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    [self.tableView resignFirstResponder];
}
@end
