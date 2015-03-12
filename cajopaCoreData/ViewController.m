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
#import "Tag.h"

@interface ViewController ()

@property (nonatomic, readwrite) NSManagedObjectContext *moc;
@property (nonatomic, readwrite) ItemList *carlsList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    // Create our list to manage the items
    self.carlsList = [ItemList itemListWithTitle:@"Carl's List"];
    
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
    
    // Create an NSManagedObject . . .
    Item *item = [Item itemWithTitle:@"cool toy" managedObjectContext:self.moc];
    
    Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.moc];
    tag.name = @"lego";
    
    NSArray * tagArray = @[ tag ];
    
    [item addTags:[NSSet setWithArray:tagArray]];
    
    [self.carlsList addItem:item];
    
    NSLog(@"%@", [self.carlsList itemTitles]);
    
    // save the moc to persistent storage
    NSError *saveError = nil;
    
    BOOL success = [self.moc save:&saveError];
    
    if (!success){
        [[NSApplication sharedApplication] presentError:saveError];
    }
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    NSError *fetchError = nil;
    
    NSArray *allitems = [self.moc executeFetchRequest:fr error:&fetchError];
    
    for (Item *singleItem in allitems) {
        NSLog(@"%@", singleItem.title);
        for (Tag *singleTag in singleItem.tags) {
            NSLog( @"%@", singleTag.name);
        }
        [self.moc deleteObject:singleItem];
    }
    
    [self.moc save:nil];
    
    [stack killCoreDataStack];

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
