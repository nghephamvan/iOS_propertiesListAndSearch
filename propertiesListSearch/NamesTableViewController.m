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

@synthesize names, keys, filteredNames, searchBar, searchController;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView setTag:1];
    filteredNames = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle]pathForResource:NAME_DATA ofType:TYPE_FILE];
    names = [NSDictionary dictionaryWithContentsOfFile:path];
    keys = [[names allKeys] sortedArrayUsingSelector: @selector(compare:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 1) {
        return [keys count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        NSString *key = keys[section];
        NSArray *arrayNames = names[key];
        
        return [arrayNames count];
    }
    
    return [filteredNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *key = keys[indexPath.section];
    NSArray *keyValues = names[key];
    
    cell.textLabel.text = keyValues[indexPath.row];
    
    return cell;
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView.tag == 1) {
        return keys;
    }
    
    return nil;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return keys[section];
    }
    
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
