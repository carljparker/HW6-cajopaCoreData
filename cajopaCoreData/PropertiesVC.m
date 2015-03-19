//
//  PropertiesVC.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 3/15/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "PropertiesVC.h"

@interface PropertiesVC ()

@property (nonatomic, readwrite) NSManagedObjectContext * moc;
@property (nonatomic, readwrite) NSMutableArray * allTags;

@end

@implementation PropertiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.tagListTable.delegate = self;
    self.tagListTable.dataSource = self;
    
    self.itemTitleText.stringValue = self.displayedItem.title;
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    self.latText.stringValue = [formatter stringFromNumber:[NSNumber numberWithDouble:self.displayedItem.location.latitude]];
    self.longText.stringValue = [formatter stringFromNumber:[NSNumber numberWithDouble:self.displayedItem.location.longitude]];
    self.moc = self.displayedItem.managedObjectContext;
    
    [self updateUI];

}

- (IBAction)addTag:(id)sender {
    NSSet *newTags = [Tag tagsWithNames:@[ self.tagNameText.stringValue ]
                   managedObjectContext:self.moc];
    [self.displayedItem addTags:newTags];
    [self updateUI];
}

- (IBAction)closePropVC:(id)sender {
    [self dismissController:self];
}

- (IBAction)updateLatLong:(id)sender {
    self.displayedItem.location.latitude = [self.latText.stringValue doubleValue];
    self.displayedItem.location.longitude = [self.longText.stringValue doubleValue];
}

- (IBAction)showLocation:(id)sender {
    NSLog(@"showLocation: Entering . . . ");
    
    // We will show whatever is stored in the item's location.
    // This might not be what is shown in the property sheet if
    // the user has changed the values, but not yet clicked
    // the update button.
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;

    NSString *lat = [formatter stringFromNumber:[NSNumber numberWithDouble:self.displayedItem.location.latitude]];
    NSString *lon = [formatter stringFromNumber:[NSNumber numberWithDouble:self.displayedItem.location.longitude]];
    
    NSMutableString *coord = [NSMutableString new];
    
    [coord appendString:@"http://maps.google.com/?q="];
    [coord appendString:lat];
    [coord appendString:@","];
    [coord appendString:lon];
    
    NSLog(@"showLocation: %@", coord);
    
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:coord]];
    
    NSLog(@"showLocation: Entering . . . ");
}

- (void) updateUI {
    
    NSLog(@"updateUI: Entering . . .");
    
    if( [self.latText.stringValue isEqualToString:@""] || [self.longText.stringValue isEqualToString:@""] ) {
        self.updateLatLongBtn.enabled = NO;
        self.showLocationBtn.enabled = NO;
    };
    
    // fetch all the tags we have so far
    NSError *fetchError = nil;
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    
    self.allTags = [self.moc executeFetchRequest:fr error:&fetchError];
    
    self.allTags = [NSMutableArray new];
    
    for (Tag * tag in self.displayedItem.tags) {
        NSLog(@"updateUI: %@", tag.name );
        [(NSMutableArray *) self.allTags addObject:tag];
    }
    
    // tell the table to redraw itself
    [self.tagListTable reloadData];

    NSLog(@"updateUI: Leaving . . .");    
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification {
    
    NSIndexSet * idxSet = [self.tagListTable selectedRowIndexes];
    
    if ( idxSet.count == 0 ) {
        NSLog(@"PropertiesVC: Rows selected: Zero");
        
        [self updateUI];
    }
    else if ( idxSet.count == 1 ) {
        NSLog(@"PropertiesVC: Rows selected: One");
        NSLog(@"%@", ((Tag *)self.allTags[idxSet.firstIndex]).name);
        
        self.itemTitleText.stringValue = ((Tag *)self.allTags[idxSet.firstIndex]).name;
        self.tagNameText.enabled = NO;
    }
    else {
        NSLog(@"PropertiesVC: Rows selected: Multiple");
        
        [idxSet enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
            NSLog(@"PropertiesVC: %@", ((Tag *)self.allTags[idx]).name);
        }];
        
        // in multiselect state,
        // not much is allowed
        self.tagNameText.stringValue = @"";
        self.tagNameText.enabled = NO;
    }
    
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{    
    // For this to work, Table Cell View in Main.storyboard
    // must have Identity | Identifier set to "Cell"
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"Cell" owner:nil];
    
    cell.textField.stringValue = ((Tag *)self.allTags[row]).name;
    return cell;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.allTags.count;
}


@end
