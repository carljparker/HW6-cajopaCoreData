//
//  ViewController.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 2/26/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "ViewController.h"
#import "ConfigurableCoreDataStack.h"
#import "ItemList.h"
#import "Item.h"
#import "location.h"
#import "Tag.h"
#import "PropertiesVC.h"

@interface ViewController ()

@property (nonatomic, readwrite) NSManagedObjectContext * moc;
@property (nonatomic, readwrite) ItemList * carlsList;

@property (nonatomic, readwrite) Item * selectedItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
   
    self.itemListTable.delegate = self;
    self.itemListTable.dataSource = self;
        
    CoreDataStackConfiguration *config = [CoreDataStackConfiguration new];
    config.storeType = NSSQLiteStoreType;
    config.modelName = @"cajopaCoreData";
    config.appIdentifier = @"com.hbo.parker.carl.inventory";  // or whatever this should be
    config.dataFileNameWithExtension = @"InventoryDB.sqlite";
    config.searchPathDirectory = NSApplicationSupportDirectory;
    
    ConfigurableCoreDataStack *stack = [[ConfigurableCoreDataStack alloc] initWithConfiguration:config];
    
    self.moc = stack.managedObjectContext;

    // add a tag
    NSArray *tags = @[ @"Lego", @"Star Wars" ];
    NSArray *itemNames = @[ @"Death Star", @"Millennium Falcon" ];

    for (NSString *itemName in itemNames) {
        
        Item *item = [Item itemWithTitle:itemName managedObjectContext:self.moc];

        // add tags
        [item addTags:[Tag tagsWithNames:tags managedObjectContext:self.moc]];

        // add a location
        item.location = [Location locationWithHBO:self.moc];
        
    }

    // save the moc to persistent storage
    NSError *saveError = nil;
    
    [self updateUI];
    
    BOOL success = [self.moc save:&saveError];
    
    if (!success){
        [[NSApplication sharedApplication] presentError:saveError];
    }
    
    [stack killCoreDataStack];

}

- (IBAction)addNewItem:(id)sender {
    
}

- (IBAction)removeSelectedItems:(id)sender {
    
}



- (void) updateUI {
    // fetch all the items we have so far
    NSError *fetchError = nil;
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    NSArray *allitems = [self.moc executeFetchRequest:fr error:&fetchError];
    
    self.carlsList = [ItemList itemListWithTitle:@"Carl's List" itemArray:allitems];
    
    // do some logging here
    NSLog(@"ViewDidLoad: %@", [self.carlsList itemTitles]);
    
    for (Item * item in self.carlsList.allItems) {
        NSLog(@"ViewDidLoad: %@", item.title );
        for ( Tag *tag in item.tags ) {
            NSLog(@"ViewDidLoad: %@", tag.name );
        }
    }
    
    // tell the table to redraw itself
    [self.itemListTable reloadData];
    
}

- (IBAction)clickEditProperties:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    NSViewController *vc = [sb instantiateControllerWithIdentifier:@"PropertiesVC"];
    
    ((PropertiesVC *)vc).displayedItem = self.selectedItem;
     
    [self presentViewControllerAsModalWindow:vc];
    
    // hide
    // [self dismissController:vc];
    
}

- (void) tableViewSelectionDidChange:(NSNotification *)notification {
    
    NSIndexSet * idxSet = [self.itemListTable selectedRowIndexes];
    
    if ( idxSet.count == 0 ) {
        NSLog(@"Rows selected: Zero");
        
        
        [self updateUI];
    }
    else if ( idxSet.count == 1 ) {
        NSLog(@"Rows selected: One");
        NSLog(@"%@", [self.carlsList itemTitles][idxSet.firstIndex]);
        
        self.selectedItem = [self.carlsList allItems][idxSet.firstIndex];
        
        self.itemTitleText.stringValue = [self.carlsList itemTitles][idxSet.firstIndex];
        self.addTextAsItem.enabled = NO;
        self.removeItemWithText.enabled = YES;
        
        self.itemProperties.enabled = YES;
        
    }
    else {
        NSLog(@"Rows selected: Multiple");
        
        [idxSet enumerateIndexesUsingBlock: ^(NSUInteger idx, BOOL *stop) {
            NSLog(@"%@", [self.carlsList itemTitles][idx]);
        }];
        
        // in multiselect state,
        // not much is allowed
        self.itemTitleText.stringValue = @"";
        self.addTextAsItem.enabled = NO;
        self.removeItemWithText.enabled = NO;
        
        self.itemProperties.enabled = NO;
        
    }
    
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    // For this to work, Table Cell View in Main.storyboard
    // must have Identity | Identifier set to "Cell"
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"Cell" owner:nil];
    
    NSLog(@"%@", [self.carlsList itemTitles][row]);
    
    cell.textField.stringValue = [self.carlsList itemTitles][row];
    return cell;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.carlsList itemCount];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
