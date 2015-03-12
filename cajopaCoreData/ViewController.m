//
//  ViewController.m
//  cajopaCoreData
//
//  Created by Parker, Carl (HBO) on 2/26/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "ViewController.h"
#import "ConfigurableCoreDataStack.h"
#import "Item.h"
#import "Tag.h"

@interface ViewController ()

@property (nonatomic, readwrite) NSManagedObjectContext *moc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
        
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
//    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.moc];
    
//    item.title = @"cool toy";
    
    Tag *tag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:self.moc];
    tag.name = @"lego";
    
    NSArray * tagArray = @[ tag ];
    
    [item addTags:[NSSet setWithArray:tagArray]];
    
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

//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//{
//    // For this to work, Table Cell View in Main.storyboard
//    // must have Identity | Identifier set to "Cell"
//    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"Cell" owner:nil];
//    
//    NSLog(@"%@", [self.toDoList itemTitles][row]);
//    
//    cell.textField.stringValue = [self.toDoList itemTitles][row];
//    return cell;
//}
//
//- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
//{
//    return [self.toDoList itemCount];
//}
//
//- (void)setRepresentedObject:(id)representedObject {
//    [super setRepresentedObject:representedObject];
//
//    // Update the view, if already loaded.
//}

@end
