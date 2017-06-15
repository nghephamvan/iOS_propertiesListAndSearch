//
//  NamesTableViewController.h
//  propertiesListSearch
//
//  Created by TMA103 on 4/24/17.
//  Copyright © 2017 TMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NamesTableViewController : UITableViewController <UISearchBarDelegate>
@property (nonatomic, copy) NSDictionary *names;
@property (nonatomic, copy) NSArray *keys;
@property (nonatomic, copy) NSMutableArray *filteredNames;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end
