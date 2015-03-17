//
//  PropertiesVC.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/15/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "PropertiesVC.h"

@interface PropertiesVC ()

@end

@implementation PropertiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.tagListTable.delegate = self;
    self.tagListTable.dataSource = self;
    
    self.itemTitleText.stringValue = self.displayedItem.title;

}

- (void) updateUI {
    // fetch all the tags we have so far
    NSError *fetchError = nil;
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSArray *allTags; //= [self.moc executeFetchRequest:fr error:&fetchError];
    
    // do some logging here
    NSLog(@"ViewDidLoad: %@", allTags);
    
    for (Tag * tag in allTags) {
        NSLog(@"ViewDidLoad: %@", tag.name );
    }
    
    // tell the table to redraw itself
    [self.tagListTable reloadData];
    
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification {
    
    NSIndexSet * idxSet = [self.tagListTable selectedRowIndexes];
    
    if ( idxSet.count == 0 ) {
        NSLog(@"Rows selected: Zero");
        
        
        [self updateUI];
    }
    else if ( idxSet.count == 1 ) {
        NSLog(@"Rows selected: One");
        NSLog(@"%@", ((Tag *)self.allTags[idxSet.firstIndex]).name);
        
        self.itemTitleText.stringValue = ((Tag *)self.allTags[idxSet.firstIndex]).name;
        self.tagNameText.enabled = NO;
    }
    else {
        NSLog(@"Rows selected: Multiple");
        
        [idxSet enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
            NSLog(@"%@", ((Tag *)self.allTags[idx]).name);
        }];
        
        // in multiselect state,
        // not much is allowed
        self.tagNameText.stringValue = @"";
        self.tagNameText.enabled = NO;
    }
    
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    // fetch all the tags we have so far
    NSError *fetchError = nil;
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSArray *allTags; // = [self.moc executeFetchRequest:fr error:&fetchError];

    
    // For this to work, Table Cell View in Main.storyboard
    // must have Identity | Identifier set to "Cell"
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"Cell" owner:nil];
    
    cell.textField.stringValue = allTags[row];
    return cell;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.allTags.count;
}


@end
